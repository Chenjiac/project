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
					
					<form action="box/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="BOX_ID" id="BOX_ID" value="${pd.BOX_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">盒子编号:</td>
								<td><input type="number" name="BOX_SN" id="BOX_SN" value="${pd.BOX_SN}" maxlength="32" placeholder="这里输入盒子编号" title="盒子编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">全宗号:</td>
								<td><input type="number" name="BOX_NUM" id="BOX_NUM" value="${pd.BOX_NUM}" maxlength="32" placeholder="这里输入全宗号" title="全宗号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">目录号:</td>
								<td><input type="number" name="BOX_CATALOG" id="BOX_CATALOG" value="${pd.BOX_CATALOG}" maxlength="32" placeholder="这里输入目录号" title="目录号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">年份:</td>
								<td><input type="number" name="BOX_YEAR" id="BOX_YEAR" value="${pd.BOX_YEAR}" maxlength="32" placeholder="这里输入年份" title="年份" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">起卷号:</td>
								<td><input type="number" name="BOX_START_VOLUME" id="BOX_START_VOLUME" value="${pd.BOX_START_VOLUME}" maxlength="32" placeholder="这里输入起卷号" title="起卷号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">止卷号:</td>
								<td><input type="number" name="BOX_END_VOLUME" id="BOX_END_VOLUME" value="${pd.BOX_END_VOLUME}" maxlength="32" placeholder="这里输入止卷号" title="止卷号" style="width:98%;"/></td>
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
			if($("#BOX_SN").val()==""){
				$("#BOX_SN").tips({
					side:3,
		            msg:'请输入盒子编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_SN").focus();
			return false;
			}
			if($("#BOX_NUM").val()==""){
				$("#BOX_NUM").tips({
					side:3,
		            msg:'请输入全宗号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_NUM").focus();
			return false;
			}
			if($("#BOX_CATALOG").val()==""){
				$("#BOX_CATALOG").tips({
					side:3,
		            msg:'请输入目录号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_CATALOG").focus();
			return false;
			}
			if($("#BOX_YEAR").val()==""){
				$("#BOX_YEAR").tips({
					side:3,
		            msg:'请输入年份',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_YEAR").focus();
			return false;
			}
			if($("#BOX_START_VOLUME").val()==""){
				$("#BOX_START_VOLUME").tips({
					side:3,
		            msg:'请输入起卷号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_START_VOLUME").focus();
			return false;
			}
			if($("#BOX_END_VOLUME").val()==""){
				$("#BOX_END_VOLUME").tips({
					side:3,
		            msg:'请输入止卷号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BOX_END_VOLUME").focus();
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