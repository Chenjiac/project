<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="finance/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="FINANCE_ID" id="FINANCE_ID" value="${pd.FINANCE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">全宗号:</td>
								<td><input type="text" name="GENERAL_ARCHIVE" id="GENERAL_ARCHIVE" value="${pd.GENERAL_ARCHIVE}" maxlength="12" placeholder="这里输入全宗号" title="全宗号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">目录号:</td>
								<td><input type="text" name="CATALOG_NUMBER" id="CATALOG_NUMBER" value="${pd.CATALOG_NUMBER}" maxlength="12" placeholder="这里输入目录号" title="目录号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">类别:</td>
								<td><input type="text" name="CATEGORY" id="CATEGORY" value="${pd.CATEGORY}" maxlength="12" placeholder="这里输入类别" title="类别" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">档号:</td>
								<td><input type="text" name="VOLUME_NUM" id="VOLUME_NUM" value="${pd.VOLUME_NUM}" maxlength="32" placeholder="这里输入档号" title="档号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">题名:</td>
								<td>
									<textarea type="text" name="VOLUME_NAME" id="VOLUME_NAME" maxlength="4" placeholder="这里输入题名" title="题名" style="width:98%;height: 90px">${pd.VOLUME_NAME}</textarea>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">起止时间:</td>
								<td><input type="text" name="VOLUME_START_END_TIME" id="VOLUME_START_END_TIME" value="${pd.VOLUME_START_END_TIME}" maxlength="24" placeholder="这里输入起止时间" title="起止时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">归档年度:</td>
								<td><input type="text" name="VOLUME_YEAR" id="VOLUME_YEAR" value="${pd.VOLUME_YEAR}" maxlength="4" placeholder="这里输入归档年度" title="归档年度" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">页数:</td>
								<td><input type="text" name="VOLUME_PAGES" id="VOLUME_PAGES" value="${pd.VOLUME_PAGES}" maxlength="6" placeholder="这里输入页数" title="页数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">保管期限:</td>
								<td id="TIME">
									<select class="chosen-select form-control" name="STORAGE_TIME" id="STORAGE_TIME" data-placeholder="请选择保管期限" style="vertical-align:top;" style="width:98%;" >
										<option value=""></option>
										<%--<c:forEach items="${roleList}" var="role">--%>
										<option value="永久" <c:if test="${'永久'== pd.STORAGE_TIME }">selected</c:if>>永久</option>
										<option value="长期" <c:if test="${'长期'== pd.STORAGE_TIME }">selected</c:if>>长期</option>
										<%--</c:forEach>--%>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">密级:</td>
								<td><input type="text" name="SECRET_LEVEL" id="SECRET_LEVEL" value="${pd.SECRET_LEVEL}" maxlength="24" placeholder="这里输入密级" title="密级" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">保管单位名称:</td>
								<td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="24" placeholder="这里输入保管单位名称" title="保管单位名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="DESCRIPTION" id="DESCRIPTION" value="${pd.DESCRIPTION}" maxlength="24" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){

			if($("#GENERAL_ARCHIVE").val()==""){
				$("#GENERAL_ARCHIVE").tips({
					side:3,
		            msg:'请输入全宗号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GENERAL_ARCHIVE").focus();
			return false;
			}
			if($("#CATALOG_NUMBER").val()==""){
				$("#CATALOG_NUMBER").tips({
					side:3,
		            msg:'请输入目录号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATALOG_NUMBER").focus();
			return false;
			}
//			if($("#CATEGORY").val()==""){
//				$("#CATEGORY").tips({
//					side:3,
//		            msg:'请输入类别',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CATEGORY").focus();
//			return false;
//			}
			if($("#VOLUME_NUM").val()==""){
				$("#VOLUME_NUM").tips({
					side:3,
		            msg:'请输入档号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_NUM").focus();
			return false;
			}
			if($("#VOLUME_NAME").val()==""){
				$("#VOLUME_NAME").tips({
					side:3,
		            msg:'请输入题名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_NAME").focus();
			return false;
			}
			if($("#VOLUME_START_END_TIME").val()==""){
				$("#VOLUME_START_END_TIME").tips({
					side:3,
		            msg:'请输入起止时间发',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_START_END_TIME").focus();
			return false;
			}
			if($("#VOLUME_YEAR").val()==""){
				$("#VOLUME_YEAR").tips({
					side:3,
		            msg:'请输入归档年度',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_YEAR").focus();
			return false;
			}
			if($("#VOLUME_PAGES").val()==""){
				$("#VOLUME_PAGES").tips({
					side:3,
		            msg:'请输入页数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_PAGES").focus();
			return false;
			}
			if($("#STORAGE_TIME").val()==""){
				$("#STORAGE_TIME").tips({
					side:3,
		            msg:'请输入保管期限',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STORAGE_TIME").focus();
			return false;
			}
//			if($("#SECRET_LEVEL").val()==""){
//				$("#SECRET_LEVEL").tips({
//					side:3,
//		            msg:'请输入密级',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#SECRET_LEVEL").focus();
//			return false;
//			}
//			if($("#COMPANY_NAME").val()==""){
//				$("#COMPANY_NAME").tips({
//					side:3,
//		            msg:'请输入保管单位名称',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#COMPANY_NAME").focus();
//			return false;
//			}
//			if($("#DESCRIPTION").val()==""){
//				$("#DESCRIPTION").tips({
//					side:3,
//		            msg:'请输入备注',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#DESCRIPTION").focus();
//			return false;
//			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>