package com.beta.controller.unrolling;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import com.beta.service.unrolling.PaperManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;


/** 
 * 说明：归档文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-07-06
 */
@Controller
@RequestMapping(value="/paper")
public class PaperController extends BaseController {
	
	String menuUrl = "paper/list.do"; //菜单地址(权限用)
	@Resource(name="paperService")
	private PaperManager paperService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Paper");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PAPER_ID", this.get32UUID());	//主键
		paperService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Paper");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		paperService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Paper");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		paperService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Paper");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
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
			pd.put("str1",str1);
		}
		page.setPd(pd);
		String currentPage = pd.getString("currentPage");
		if (currentPage != null){
			int curPage = Integer.parseInt(currentPage);
			page.setCurrentPage(curPage);
		}
		List<PageData>	varList = paperService.list(page);	//列出Paper列表

		//将关键字变红
		if (null != keywords && !"".equals(keywords)){
			for (PageData pageData:varList){
				String file_name = pageData.getString("NAME");
				file_name = this.stringToRed(keywords,file_name);
				pageData.put("NAME",file_name);
			}
		}

		mv.setViewName("beta/unrolling/paper/paper_list");
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
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("beta/unrolling/paper/paper_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = paperService.findById(pd);	//根据ID读取
		mv.setViewName("beta/unrolling/paper/paper_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**展示详情页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/detail")
	public ModelAndView detail()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = paperService.findById(pd);
		mv.setViewName("beta/unrolling/paper/paper_detail");
		mv.addObject("msg","detail");
		mv.addObject("pd",pd);
		return mv;
	}

	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Paper");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			paperService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Paper到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
//		titles.add("文件id");	//1
		titles.add("全宗号");	//2
		titles.add("室编档号");	//3
		titles.add("馆编档号");	//4
		titles.add("室编件号");	//5
		titles.add("馆编件号");	//6
		titles.add("归档年度");	//7
		titles.add("机构");	//8
		titles.add("保管期限");	//9
		titles.add("文号");	//10
		titles.add("题名");	//11
		titles.add("责任者");	//12
		titles.add("日期");	//13
		titles.add("页数");	//14
		titles.add("密级");	//15
		titles.add("保管单位名称");	//16
		titles.add("备注");	//17
		dataMap.put("titles", titles);
		List<PageData> varOList = paperService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
//			vpd.put("var1", varOList.get(i).get("UNROLLING_PAPER_ID").toString());	//1
			vpd.put("var1", varOList.get(i).getString("GENERAL_ARCHIVE"));	    //2
			vpd.put("var2", varOList.get(i).getString("ROOM_NUM"));	    //3
			vpd.put("var3", varOList.get(i).getString("LIBRARY_NUM"));	    //4
			vpd.put("var4", varOList.get(i).getString("ROOM_CODE"));	    //5
			vpd.put("var5", varOList.get(i).getString("LIBRARY_CODE"));	    //6
			vpd.put("var6", varOList.get(i).getString("STORAGE_YEAR"));	    //7
			vpd.put("var7", varOList.get(i).get("SECTION").toString());	//8
			vpd.put("var8", varOList.get(i).getString("STORAGE_TIME"));	    //9
			vpd.put("var9", varOList.get(i).getString("PAPER_NUM"));	    //10
			vpd.put("var10", varOList.get(i).getString("PAPER_NAME"));	    //11
			vpd.put("var11", varOList.get(i).getString("PAPER_RESPONSIBLER"));	    //12
			vpd.put("var12", varOList.get(i).getString("PAPER_DATE"));	    //13
			vpd.put("var13", varOList.get(i).get("PAPER_PAGE").toString());	//14
			vpd.put("var14", varOList.get(i).getString("SECRET_LEVEL"));	    //15
			vpd.put("var15", varOList.get(i).getString("COMPANY_NAME"));	    //16
			vpd.put("var16", varOList.get(i).getString("PAPER_DESCRIPTION"));	    //17
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	/**打开上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadExcel")
	public ModelAndView goUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("beta/unrolling/paper/uploadexcel");
		return mv;
	}

	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Papers.xls", "Papers.xls");
	}

	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readExcel")
	public ModelAndView readExcel(
			@RequestParam(value="excel",required=false) MultipartFile file
	) throws Exception{
		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "paperexcel");							//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			/*存入数据库操作======================================*/
//			pd.put("RIGHTS", "");					//权限
//			pd.put("LAST_LOGIN", "");				//最后登录时间
//			pd.put("IP", "");						//IP
//			pd.put("STATUS", "0");					//状态
//			pd.put("SKIN", "default");				//默认皮肤
//			pd.put("ROLE_ID", "1");
//			List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
//			pd.put("ROLE_ID", roleList.get(0).getROLE_ID());		//设置角色ID为随便第一个
			/**
			 * var0 :全宗号
			 * var1 :室编档号
			 * var2 :管编档号
			 * var3 :室编件号
			 * var4 :馆编件号
			 * var5 ：归档年度
			 * var6 ：机构
			 * var7 ：保管期限
			 * var8： 文号
			 * var9 ：题名
			 * var10：责任者
			 * var11：日期
			 * var12：页数
			 * var13：密级
			 * var14：保管单位名称
			 * var15：备注
			 */
			for(int i=0;i<listPd.size();i++){
				pd.put("GENERAL_ARCHIVE", listPd.get(i).getString("var0"));				//全宗号
				pd.put("ROOM_NUM", listPd.get(i).getString("var1"));					//室编档号
				pd.put("LIBRARY_NUM",listPd.get(i).getString("var2"));					//馆编档号
				if (paperService.findByPNum(pd) != null){
					continue;
				}
				pd.put("ROOM_CODE",listPd.get(i).getString("var3"));					//室编件号
				pd.put("LIBRARY_CODE",listPd.get(i).getString("var4"));					//馆编件号
				pd.put("STORAGE_YEAR",listPd.get(i).getString("var5"));					//归档年度
				pd.put("SECTION",listPd.get(i).getString("var6"));					//机构
				pd.put("STORAGE_TIME",listPd.get(i).getString("var7"));					//保管期限
				pd.put("PAPER_NUM",listPd.get(i).getString("var8"));					//文号
				pd.put("PAPER_NAME",listPd.get(i).getString("var9"));					//题名
				pd.put("PAPER_RESPONSIBLER",listPd.get(i).getString("var10"));			//责任者
				pd.put("PAPER_DATE",listPd.get(i).get("var11").toString());					//日期
				pd.put("PAPER_PAGE",listPd.get(i).getString("var12"));					//页数
				pd.put("SECRET_LEVEL",listPd.get(i).getString("var13"));				//密级
				pd.put("COMPANY_NAME",listPd.get(i).getString("var14"));				//保管单位名称
				pd.put("PAPER_DESCRIPTION",listPd.get(i).getString("var15"));			//备注

				paperService.save(pd);
			}
			/*存入数据库操作======================================*/
			mv.addObject("msg","success");
		}
		mv.setViewName("save_result");
		return mv;
	}



	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
