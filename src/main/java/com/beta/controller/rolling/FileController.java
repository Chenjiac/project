package com.beta.controller.rolling;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.druid.sql.visitor.functions.If;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.beta.service.rolling.FileManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.*;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
 * 说明：卷内文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-07-04
 */
@Controller
@RequestMapping(value="/file")
public class FileController extends BaseController {
	
	String menuUrl = "file/list.do"; //菜单地址(权限用)
	@Resource(name="fileService")
	private FileManager fileService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增File");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		pd.put("FILE_ID", this.get32UUID());	//主键
		fileService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasSN")
	@ResponseBody
	public Object hasSN(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(fileService.findBySN(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除File");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		fileService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改File");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		fileService.edit(pd);

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
		logBefore(logger, Jurisdiction.getUsername()+"列表File");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("NAME");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
//			pd.put("keywords", keywords.trim());
			char[] chars = keywords.toCharArray();
			String str = "%";
			for (char c:chars){
				str += c;
				str += "%";
			}
			pd.put("str",str);
		}
//		String keyword = pd.getString("COMPANY_NAME");
//		if(null != keyword && !"".equals(keyword)){
////			pd.put("COMPANY_NAME",keyword.trim());
//			char[] chars = keyword.toCharArray();
//			String str1 = "%";
//			for (char c:chars){
//				str1 += c;
//				str1 += "%";
//			}
//			pd.put("str1",str1);
//		}
		page.setPd(pd);
		String currentPage = pd.getString("currentPage");
		if (currentPage != null){
			int curPage = Integer.parseInt(currentPage);
			page.setCurrentPage(curPage);
		}
		List<PageData>	varList = fileService.list(page);	//列出File列表

		//将关键字变红
		if (null != keywords && !"".equals(keywords)){
			for (PageData pageData:varList){
				String file_name = pageData.getString("NAME");
				file_name = this.stringToRed(keywords,file_name);
				pageData.put("NAME",file_name);
			}
		}

		mv.setViewName("beta/rolling/file/file_list");
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
		mv.setViewName("beta/rolling/file/file_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
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
		pd = fileService.findById(pd);	//根据ID读取
		mv.setViewName("beta/rolling/file/file_edit");
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
		pd = fileService.findById(pd);
		mv.setViewName("beta/rolling/file/file_detail");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除File");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			fileService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
//		System.out.println(pd);
		pdList.add(pd);
		System.out.println(pdList);
		map.put("list", pdList);
//		System.out.println(map);
		return AppUtil.returnObject(pd, map);
	}

	/**批量下载
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadAll")
	@ResponseBody
	public ResponseEntity<byte[]> downloadAll(HttpServletRequest request) throws Exception {
//		System.out.println("--------------");
		logBefore(logger, Jurisdiction.getUsername() + "批量下载PDF");
		PageData pd = new PageData();
//		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
//		List<PageData> pdList = new ArrayList<PageData>();
		String DATA = pd.getString("DATA");
		//需要压缩的文件地址
		if (DATA.contains(",")) {
			String[] data = DATA.split(",");
			StringBuffer sb = new StringBuffer();
			for (String str : data) {
				int id = Integer.parseInt(str);
				pd.put("FILE_ID", id);
				PageData fileInfo = fileService.findById(pd);
				String volume_num = fileInfo.getString("VOLUME_NUM");
				pd.put("VOLUME_NUM", volume_num);
				String file_sn = fileInfo.getString("FILE_SN");
				List<PageData> files = fileService.findByNum(pd);
				if (files.size() == 1) {
					sb.append("H:\\Project\\project\\target\\MVNFHM\\uploadFiles\\uploadFile\\" + volume_num + ".pdf" + "。");
				} else if (files.size() > 1) {
					sb.append("H:\\Project\\project\\target\\MVNFHM\\uploadFiles\\uploadFile\\" + volume_num + "-" + file_sn + ".pdf" + "。");
				}
//				pdList.add(pd);
//				System.out.println(pdList);
//				map.put("list", pdList);
			}
			String str = sb.toString();
			String[] path = str.split("。");


			// 要生成的压缩文件地址和文件名称
			String resourcesName = "DownLoad.zip";
			File zipFile = new File("H:/" + resourcesName);
			ZipOutputStream zipStream = null;
			FileInputStream zipSource = null;
			try {
				//构造最终压缩包的输出流
				zipStream = new ZipOutputStream(new FileOutputStream(zipFile));
				for (int i = 0; i < path.length; i++) {
					File file = new File(path[i]);
					//将需要压缩的文件格式化为输入流
					zipSource = new FileInputStream(file);
					//压缩条目不是具体独立的文件，而是压缩包文件列表中的列表项，称为条目，就像索引一样
					ZipEntry zipEntry = new ZipEntry(file.getName());
					//定位该压缩条目位置，开始写入文件到压缩包中
					zipStream.putNextEntry(zipEntry);
					int temp = 0;
					while ((temp = zipSource.read()) != -1) {
						zipStream.write(temp);
					}

					try {
						if (null != zipSource) zipSource.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				zipStream.close();
				File file = new File("H:/"+resourcesName);
				HttpHeaders headers = new HttpHeaders();
				String filename = new String(resourcesName.getBytes("utf-8"),"iso-8859-1");
				headers.setContentDispositionFormData("attachment", filename);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return null;
	}


	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出File到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
//		titles.add("文件id");	//1
		titles.add("全宗号");	//2
		titles.add("目录号");	//3
		titles.add("案卷号");	//4
		titles.add("档号");	//5
		titles.add("顺序号");	//6
		titles.add("题名");	//7
		titles.add("文号");	//8
		titles.add("责任者");	//9
		titles.add("页号");	//10
		titles.add("页数");	//11
		titles.add("日期");	//12
		titles.add("归档年度");	//13
		titles.add("保管期限");	//14
		titles.add("密级");	//15
		titles.add("保管单位名称");	//16
		titles.add("备注");	//17
		dataMap.put("titles", titles);
		List<PageData> varOList = fileService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GENERAL_ARCHIVE"));	    //全宗号
			vpd.put("var2", varOList.get(i).getString("CATALOG_NUMBER"));	    //目录号
			vpd.put("var3", varOList.get(i).getString("VOLUME_SN"));	    	//案卷号
			vpd.put("var4", varOList.get(i).getString("VOLUME_NUM"));	    	//档号
			vpd.put("var5", varOList.get(i).get("FILE_SN").toString());				//顺序号
			vpd.put("var6", varOList.get(i).getString("FILE_NAME"));	   	 	//题名
			vpd.put("var7", varOList.get(i).getString("FILE_NUM"));	    		//文号
			vpd.put("var8", varOList.get(i).getString("FILE_RESPONSIBLER"));	//责任者
			vpd.put("var9", varOList.get(i).getString("START_PAGE"));	    	//页号
			vpd.put("var10", varOList.get(i).get("FILE_PAGE").toString());			//页数
			vpd.put("var11", varOList.get(i).getString("FILE_DATE"));	    	//日期
			vpd.put("var12", varOList.get(i).getString("STORAGE_YEAR"));	    //归档年度
			vpd.put("var13", varOList.get(i).getString("STORAGE_TIME"));	    //保管期限
			vpd.put("var14", varOList.get(i).getString("SECRET_LEVEL"));	    //密级
			vpd.put("var15", varOList.get(i).getString("COMPANY_NAME"));	    //保管单位名称
			vpd.put("var16", varOList.get(i).getString("FILE_DESCRIPTION"));	//备注
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
		mv.setViewName("beta/rolling/file/uploadexcel");
		return mv;
	}

	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Files.xls", "Files.xls");
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
			String fileName =  FileUpload.fileUp(file, filePath, "fileexcel");							//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第2行开始；0:从第A列开始；0:第1个sheet
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
			 * var5 ：题名
			 * var6 ：文号
			 * var7 ：责任者
			 * var8： 页号
			 * var9 ：页数
			 * var10：日期
			 * var11：归档年度
			 * var12：保管期限
			 * var13：密级
			 * var14：保管单位名称
			 * var15：备注
			 */
			for(int i=0;i<listPd.size();i++){
				pd.put("GENERAL_ARCHIVE", listPd.get(i).getString("var0"));				//全宗号
				pd.put("CATALOG_NUMBER", listPd.get(i).getString("var1"));				//目录号
				pd.put("VOLUME_SN",listPd.get(i).getString("var2"));					//案卷号

				pd.put("VOLUME_NUM",listPd.get(i).getString("var3"));					//档号
				pd.put("FILE_SN",listPd.get(i).getString("var4"));						//顺序号
				if(fileService.findByFName(pd) != null){
					continue;
				}

				pd.put("FILE_NAME",listPd.get(i).getString("var5"));							//题名
				pd.put("FILE_NUM",listPd.get(i).getString("var6"));							//文号
				pd.put("FILE_RESPONSIBLER",listPd.get(i).getString("var7"));							//责任者
				pd.put("START_PAGE",listPd.get(i).getString("var8"));					//页号
				pd.put("FILE_PAGE",listPd.get(i).getString("var9"));					//页数
				pd.put("FILE_DATE",listPd.get(i).get("var10").toString());					//日期
				pd.put("STORAGE_YEAR",listPd.get(i).getString("var11"));					//归档年度
				pd.put("STORAGE_TIME",listPd.get(i).getString("var12"));				//保管期限
				pd.put("SECRET_LEVEL",listPd.get(i).getString("var13"));				//密级
				pd.put("COMPANY_NAME",listPd.get(i).getString("var14"));				//保管单位名称
				pd.put("FILE_DESCRIPTION",listPd.get(i).getString("var15"));							//备注

//				String USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1"));	//根据姓名汉字生成全拼
//				pd.put("USERNAME", USERNAME);
//				if(userService.findByUsername(pd) != null){									//判断用户名是否重复
//					USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1"))+Tools.getRandomNum();
//					pd.put("USERNAME", USERNAME);
//				}
//				pd.put("BZ", listPd.get(i).getString("var4"));								//备注
//				if(Tools.checkEmail(listPd.get(i).getString("var3"))){						//邮箱格式不对就跳过
//					pd.put("EMAIL", listPd.get(i).getString("var3"));
//					if(userService.findByUE(pd) != null){									//邮箱已存在就跳过
//						continue;
//					}
//				}else{
//					continue;
//				}
//				pd.put("NUMBER", listPd.get(i).getString("var0"));							//编号已存在就跳过
//				pd.put("PHONE", listPd.get(i).getString("var2"));							//手机号
//
//				pd.put("PASSWORD", new SimpleHash("SHA-1", USERNAME, "123").toString());	//默认密码123
//				if(userService.findByUN(pd) != null){
//					continue;
//				}
				fileService.save(pd);
			}
			/*存入数据库操作======================================*/
			mv.addObject("msg","success");
		}
		mv.setViewName("save_result");
		return mv;
	}

	//预览pdf页面
	@RequestMapping(value = "/findByNum")
	public ModelAndView findByNum() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String url="";
		List<PageData> files = fileService.findByNum(pd);
		if(files.size() == 1){
			url = "/uploadFiles/uploadFile/"+ pd.getString("VOLUME_NUM") + ".pdf";
		}else if (files.size() > 1){
			url = "/uploadFiles/uploadFile/"+ pd.getString("VOLUME_NUM") + "-" +pd.getString("FILE_SN") +".pdf";
		}
		mv.setViewName("redirect:/pdfjs/web/viewer.html?file=" + url);
		return mv;
	}



	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
