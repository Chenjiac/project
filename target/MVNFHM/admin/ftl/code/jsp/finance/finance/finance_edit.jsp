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
	<%@ include file="../../system/index/top.jsp"%>
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
								<td style="width:75px;text-align: right;padding-top: 13px;">财务id:</td>
								<td><input type="number" name="FINANCE_ID" id="FINANCE_ID" value="${pd.FINANCE_ID}" maxlength="32" placeholder="这里输入财务id" title="财务id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">全宗号:</td>
								<td><input type="text" name="GENERAL_ARCHIVE" id="GENERAL_ARCHIVE" value="${pd.GENERAL_ARCHIVE}" maxlength="12" placeholder="这里输入全宗号" title="全宗号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">目录号:</td>
								<td><input type="text" name="CATALOG_NUMBER" id="CATALOG_NUMBER" value="${pd.CATALOG_NUMBER}" maxlength="12" placeholder="这里输入目录号" title="目录号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">案卷号:</td>
								<td><input type="text" name="VOLUME_NUM" id="VOLUME_NUM" value="${pd.VOLUME_NUM}" maxlength="12" placeholder="这里输入案卷号" title="案卷号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">会计核算材料名称:</td>
								<td><input type="text" name="FINANCE_NAME" id="FINANCE_NAME" value="${pd.FINANCE_NAME}" maxlength="32" placeholder="这里输入会计核算材料名称" title="会计核算材料名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">会计年度:</td>
								<td><input type="text" name="FINANCE_YEAR" id="FINANCE_YEAR" value="${pd.FINANCE_YEAR}" maxlength="4" placeholder="这里输入会计年度" title="会计年度" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">单位名称:</td>
								<td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="24" placeholder="这里输入单位名称" title="单位名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">保管期限:</td>
								<td><input type="text" name="STORAGE_TIME" id="STORAGE_TIME" value="${pd.STORAGE_TIME}" maxlength="4" placeholder="这里输入保管期限" title="保管期限" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">归档号:</td>
								<td><input type="text" name="ARCHIVE_NUM" id="ARCHIVE_NUM" value="${pd.ARCHIVE_NUM}" maxlength="6" placeholder="这里输入归档号" title="归档号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主管:</td>
								<td><input type="text" name="SUPERVISOR" id="SUPERVISOR" value="${pd.SUPERVISOR}" maxlength="24" placeholder="这里输入主管" title="主管" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">记账:</td>
								<td><input type="text" name="BOOKKEEPER" id="BOOKKEEPER" value="${pd.BOOKKEEPER}" maxlength="24" placeholder="这里输入记账" title="记账" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">装订人:</td>
								<td><input type="text" name="BINDING_PERSON" id="BINDING_PERSON" value="${pd.BINDING_PERSON}" maxlength="24" placeholder="这里输入装订人" title="装订人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">页数:</td>
								<td><input type="number" name="PAGES" id="PAGES" value="${pd.PAGES}" maxlength="32" placeholder="这里输入页数" title="页数" style="width:98%;"/></td>
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
	<%@ include file="../../system/index/foot.jsp"%>
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
			if($("#FINANCE_ID").val()==""){
				$("#FINANCE_ID").tips({
					side:3,
		            msg:'请输入财务id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FINANCE_ID").focus();
			return false;
			}
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
			if($("#VOLUME_NUM").val()==""){
				$("#VOLUME_NUM").tips({
					side:3,
		            msg:'请输入案卷号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_NUM").focus();
			return false;
			}
			if($("#FINANCE_NAME").val()==""){
				$("#FINANCE_NAME").tips({
					side:3,
		            msg:'请输入会计核算材料名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FINANCE_NAME").focus();
			return false;
			}
			if($("#FINANCE_YEAR").val()==""){
				$("#FINANCE_YEAR").tips({
					side:3,
		            msg:'请输入会计年度',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FINANCE_YEAR").focus();
			return false;
			}
			if($("#COMPANY_NAME").val()==""){
				$("#COMPANY_NAME").tips({
					side:3,
		            msg:'请输入单位名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMPANY_NAME").focus();
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
			if($("#ARCHIVE_NUM").val()==""){
				$("#ARCHIVE_NUM").tips({
					side:3,
		            msg:'请输入归档号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ARCHIVE_NUM").focus();
			return false;
			}
			if($("#SUPERVISOR").val()==""){
				$("#SUPERVISOR").tips({
					side:3,
		            msg:'请输入主管',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUPERVISOR").focus();
			return false;
			}
			if($("#BOOKKEEPER").val()==""){
				$("#BOOKKEEPER").tips({
					side:3,
		            msg:'请输入记账',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOOKKEEPER").focus();
			return false;
			}
			if($("#BINDING_PERSON").val()==""){
				$("#BINDING_PERSON").tips({
					side:3,
		            msg:'请输入装订人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BINDING_PERSON").focus();
			return false;
			}
			if($("#PAGES").val()==""){
				$("#PAGES").tips({
					side:3,
		            msg:'请输入页数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAGES").focus();
			return false;
			}
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