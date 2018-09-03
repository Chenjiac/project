package com.beta.controller.finance;

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

import com.beta.service.finance.FinanceManager;
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
 * 说明：财务模块
 * 创建人：FH Q313596790
 * 创建时间：2018-07-09
 */
@Controller
@RequestMapping(value="/finance")
public class FinanceController extends BaseController {
	
	String menuUrl = "finance/list.do"; //菜单地址(权限用)
	@Resource(name="financeService")
	private FinanceManager financeService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Finance");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		pd.put("FINANCE_ID", this.get32UUID());	//主键
		financeService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Finance");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		financeService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Finance");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		financeService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Finance");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("VOLUME_NAME");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			StringBuffer sb = new StringBuffer();
			sb.append("%");
			char[] chars = keywords.toCharArray();
			for (char c:chars){
				sb.append(c);
				sb.append("%");
			}
			String str = sb.toString();
			pd.put("str",str);
		}
//		String keyword = pd.getString("COMPANY_NAME");
//		if(null != keyword && !"".equals(keyword)){
//			StringBuffer sb1 = new StringBuffer();
//			sb1.append("%");
//			char[] chars = keyword.toCharArray();
//			for (char c:chars){
//				sb1.append(c);
//				sb1.append("%");
//			}
//			String str1 = sb1.toString();
//			pd.put("str1",str1);
//		}
		page.setPd(pd);
		String currentPage = pd.getString("currentPage");
		if (currentPage != null){
			int curPage = Integer.parseInt(currentPage);
			page.setCurrentPage(curPage);
		}
		List<PageData>	varList = financeService.list(page);	//列出Finance列表

		//将关键字变红
		if (null != keywords && !"".equals(keywords)){
			for (PageData pageData:varList){
				String finance_name = pageData.getString("VOLUME_NAME");
				finance_name = this.stringToRed(keywords,finance_name);
				pageData.put("VOLUME_NAME",finance_name);
			}
		}

		mv.setViewName("beta/finances/finance/finance_list");
//		System.out.println(pd);
//		System.out.println("---------------------------------");
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
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("beta/finances/finance/finance_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**判断档号是否存在
	 * @return
	 */
	@RequestMapping(value="/hasVN")
	@ResponseBody
	public Object hasVN(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(financeService.findByVN(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = financeService.findById(pd);	//根据ID读取
		mv.setViewName("beta/finances/finance/finance_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Finance");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			financeService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Finance到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
//		titles.add("财务id");	//1
		titles.add("全宗号");	//2
		titles.add("目录号");	//3
		titles.add("案卷号");	//4
		titles.add("档号");	//5
		titles.add("顺序号");   //6
		titles.add("题名");	//7
		titles.add("文号");	//8
		titles.add("责任者");   //9
		titles.add("页号");   //10
		titles.add("页数");	//11
		titles.add("日期");  //12
		titles.add("归档年度"); //13
		titles.add("保管期限");	//14
		titles.add("密级");	    //15
		titles.add("保管单位名称");	//16
		titles.add("备注");	//17
		dataMap.put("titles", titles);
		List<PageData> varOList = financeService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
//			vpd.put("var1", varOList.get(i).get("FINANCE_ID").toString());	//1
			vpd.put("var1", varOList.get(i).getString("GENERAL_ARCHIVE"));	    //2
			vpd.put("var2", varOList.get(i).getString("CATALOG_NUMBER"));	    //3
			vpd.put("var3", varOList.get(i).getString("CATEGORY"));	    //4
			vpd.put("var4", varOList.get(i).getString("VOLUME_NUM"));	    //5
			vpd.put("var5", varOList.get(i).getString("VOLUME_SN"));	    //6
			vpd.put("var6", varOList.get(i).getString("VOLUME_NAME"));	    //7
			vpd.put("var7", varOList.get(i).getString("FILE_NUM"));	    //8
			vpd.put("var8", varOList.get(i).getString("RESPONSIBLER"));	    //9
			vpd.put("var9", varOList.get(i).getString("VOLUME_PAGE"));	    //10
			vpd.put("var10", varOList.get(i).getString("VOLUME_PAGES"));	    //11
			vpd.put("var11", varOList.get(i).getString("VOLUME_DATE"));	    //12
			vpd.put("var12", varOList.get(i).getString("STORAGE_YEAR"));	//13
			vpd.put("var12", varOList.get(i).getString("STORAGE_TIME"));	//14
			vpd.put("var12", varOList.get(i).getString("SECRET_LEVEL"));	//15
			vpd.put("var12", varOList.get(i).getString("COMPANY_NAME"));	//16
			vpd.put("var12", varOList.get(i).getString("DESCRIPTION"));	//17
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
		mv.setViewName("beta/finances/finance/uploadexcel");
		return mv;
	}

	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Finances.xls", "Finances.xls");
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
//		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "financeexcel");							//执行上传
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
			 * var1 :目录号
			 * var2 :案卷号
			 * var3 :档号
			 * var4 :顺序号
			 * var5 :题名
			 * var6：文号
			 * var7：责任者
			 * var8：页号
			 * var9 ：页数
			 * var10：日期
			 * var11 ：归档年度
			 * var12：保管期限
			 * var13：密级
			 * var14：保管单位名称
			 * var15：备注
			 */
			for(int i=0;i<listPd.size();i++){
				pd.put("GENERAL_ARCHIVE", listPd.get(i).getString("var0"));				//全宗号
				pd.put("CATALOG_NUMBER", listPd.get(i).getString("var1"));				//目录号
				pd.put("CATEGORY",listPd.get(i).getString("var2"));						//案卷号
				pd.put("VOLUME_NUM",listPd.get(i).getString("var3"));					//档号
				if (financeService.findByNum(pd) != null){
					continue;
				}
				pd.put("VOLUME_SN",listPd.get(i).getString("var4"));                    //顺序号
				pd.put("VOLUME_NAME",listPd.get(i).getString("var5"));					//题名
				pd.put("FILE_NUM",listPd.get(i).getString("var6"));		//档号
				pd.put("RESPONSIBLER",listPd.get(i).getString("var7"));						//责任者
				pd.put("VOLUME_PAGE",listPd.get(i).getString("var8"));
				pd.put("VOLUME_PAGES",listPd.get(i).getString("var9"));			//页数
				pd.put("VOLUME_DATE",listPd.get(i).getString("var10"));					//日期
				pd.put("STORAGE_YEAR",listPd.get(i).getString("var11"));
				pd.put("STORAGE_TIME",listPd.get(i).getString("var12"));
				pd.put("SECRET_LEVEL",listPd.get(i).getString("var13"));					//密级
				pd.put("COMPANY_NAME",listPd.get(i).getString("var14"));					//保管单位名称
				pd.put("DESCRIPTION",listPd.get(i).getString("var15"));				//备注

				financeService.save(pd);
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
