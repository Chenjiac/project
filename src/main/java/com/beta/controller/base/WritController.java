package com.beta.controller.base;

import com.beta.service.rolling.FileManager;
import com.beta.service.unrolling.PaperManager;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 陈cc on 2018/7/9.
 */
@Controller
@RequestMapping(value="/writ")
public class WritController extends BaseController {

    String menuUrl = "writ/list.do"; //菜单地址(权限用)
    @Resource(name="fileService")
    private FileManager fileService;
    @Resource(name="paperService")
    private PaperManager paperService;

    /**列表
     * @param page
     * @throws Exception
     */
    @RequestMapping(value="/list")
    public ModelAndView list(Page page) throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("NAME");				//关键词检索条件
        if(null != keywords && !"".equals(keywords)){
            StringBuffer sb1 = new StringBuffer();
            sb1.append("%");
            char[] chars = keywords.toCharArray();
            for (char c:chars){
                sb1.append(c);
                sb1.append("%");
            }
            String str = sb1.toString();
            pd.put("str",str);
        }
        String keyword = pd.getString("COMPANY_NAME");
        if (null != keyword && !"".equals(keyword)){
            StringBuffer sb2 = new StringBuffer();
            sb2.append("%");
            char[] chars = keyword.toCharArray();
            for (char c:chars){
                sb2.append(c);
                sb2.append("%");
            }
            String str1 = sb2.toString();
//			System.out.println(str2);
            pd.put("str1",str1);
        }
        page.setPd(pd);
        List<PageData> varList = fileService.listW(page);	//列出search列表

        //将关键字变红
        if (null != keywords && !"".equals(keywords)){
            for (PageData pageData:varList){
                String file_name = pageData.getString("NAME");
                file_name = this.stringToRed(keywords,file_name);
                pageData.put("NAME",file_name);
            }
        }

        mv.setViewName("beta/base/writ/writ_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }

    //关键字变红函数
    public String stringToRed (String key, String target){
        char[] chars = key.toCharArray();
        for (char c:chars){
            target = target.replaceAll("" + c,"<font color='red'>"+ c +"</font>");
        }
        return target;
    }

}
