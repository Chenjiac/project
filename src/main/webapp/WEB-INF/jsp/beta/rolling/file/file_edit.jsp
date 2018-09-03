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
					
					<form action="file/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="FILE_ID" id="FILE_ID" value="${pd.FILE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">文件id:</td>--%>
								<%--<td><input type="number" name="FILE_ID" id="FILE_ID" value="${pd.FILE_ID}" maxlength="32" placeholder="这里输入文件id" title="文件id" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">全宗号:</td>
								<td><input type="text" name="GENERAL_ARCHIVE" id="GENERAL_ARCHIVE" value="${pd.GENERAL_ARCHIVE}" maxlength="3" placeholder="这里输入全宗号" title="全宗号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">目录号:</td>
								<td><input type="text" name="CATALOG_NUMBER" id="CATALOG_NUMBER" value="${pd.CATALOG_NUMBER}" maxlength="3" placeholder="这里输入目录号" title="目录号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">案卷号:</td>
								<td><input type="text" name="VOLUME_SN" id="VOLUME_SN" value="${pd.VOLUME_SN}" maxlength="4" placeholder="这里输入案卷号" title="案卷号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">档号:</td>
								<td><input type="text" name="VOLUME_NUM" id="VOLUME_NUM" value="${pd.VOLUME_NUM}" maxlength="16" placeholder="这里输入档号" title="档号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">顺序号:</td>
								<td><input type="number" name="FILE_SN" id="FILE_SN" value="${pd.FILE_SN}" maxlength="32" placeholder="这里输入顺序号" title="顺序号" onblur="hasSN('${pd.VOLUME_NUM}')" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">题名:</td>
								<td>
									<textarea type="text" name="FILE_NAME" id="FILE_NAME"  maxlength="255"  style="width:98%;height: 100px"/>${pd.FILE_NAME}</textarea>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文号:</td>
								<td><input type="text" name="FILE_NUM" id="FILE_NUM" value="${pd.FILE_NUM}" maxlength="32" placeholder="这里输入文号" title="文号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">责任者:</td>
								<td><input type="text" name="FILE_RESPONSIBLER" id="FILE_RESPONSIBLER" value="${pd.FILE_RESPONSIBLER}" maxlength="32" placeholder="这里输入责任者" title="责任者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">页号:</td>
								<td><input type="text" name="START_PAGE" id="START_PAGE" value="${pd.START_PAGE}" maxlength="3" placeholder="这里输入页号" title="页号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">页数:</td>
								<td><input type="number" name="FILE_PAGE" id="FILE_PAGE" value="${pd.FILE_PAGE}" maxlength="32" placeholder="这里输入页数" title="页数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">日期:</td>
								<td><input class="span10 date-picker" name="FILE_DATE" id="FILE_DATE" value="${pd.FILE_DATE}" type="text" data-date-format="yyyymmdd" readonly="readonly" placeholder="日期" title="日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">归档年度:</td>
								<td><input type="text" name="STORAGE_YEAR" id="STORAGE_YEAR" value="${pd.STORAGE_YEAR}" maxlength="4" placeholder="这里输入归档年度" title="归档年度" style="width:98%;"/></td>
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
								<td><input type="text" name="SECRET_LEVEL" id="SECRET_LEVEL" value="${pd.SECRET_LEVEL}" maxlength="10" placeholder="这里输入密级" title="密级" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">保管单位名称:</td>
								<td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="32" placeholder="这里输入保管单位名称" title="保管单位名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="FILE_DESCRIPTION" id="FILE_DESCRIPTION" value="${pd.FILE_DESCRIPTION}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">案卷id:</td>--%>
								<%--<td><input type="number" name="VOLUME_ID" id="VOLUME_ID" value="${pd.VOLUME_ID}" maxlength="32" placeholder="这里输入案卷id" title="案卷id" style="width:98%;"/></td>--%>
							<%--</tr>--%>
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

        //判断档号是否存在
        function hasSN(VOLUME_NUM){
            var FILE_SN = $.trim($("#FILE_SN").val());
            var VOLUME_NUM = $.trim($("#VOLUME_NUM").val());
            $.ajax({
                type: "POST",
                url: '<%=basePath%>file/hasSN.do',
                data: {FILE_SN:FILE_SN,VOLUME_NUM:VOLUME_NUM,tm:new Date().getTime()},
                dataType:'json',
                cache: false,
                success: function(data){
                    if("success" != data.result){
                        $("#FILE_SN").tips({
                            side:3,
                            msg:'该档号下的顺序号 '+FILE_SN+' 已存在',
                            bg:'#AE81FF',
                            time:3
                        });
                        $("#FILE_SN").val('');
                    }
                }
            });
        }



		//保存
		function save(){
//			if($("#FILE_ID").val()==""){
//				$("#FILE_ID").tips({
//					side:3,
//		            msg:'请输入文件id',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#FILE_ID").focus();
//			return false;
//			}
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
			if($("#VOLUME_SN").val()==""){
				$("#VOLUME_SN").tips({
					side:3,
		            msg:'请输入案卷号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VOLUME_SN").focus();
			return false;
			}
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
			if($("#FILE_SN").val()==""){
				$("#FILE_SN").tips({
					side:3,
//		            msg:'请输入顺序号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_SN").focus();
			return false;
			}
			if($("#FILE_NAME").val()==""){
				$("#FILE_NAME").tips({
					side:3,
		            msg:'请输入题名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_NAME").focus();
			return false;
			}
//			if($("#FILE_NUM").val()==""){
//				$("#FILE_NUM").tips({
//					side:3,
//		            msg:'请输入文号',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#FILE_NUM").focus();
//			return false;
//			}
//			if($("#FILE_RESPONSIBLER").val()==""){
//				$("#FILE_RESPONSIBLER").tips({
//					side:3,
//		            msg:'请输入责任者',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#FILE_RESPONSIBLER").focus();
//			return false;
//			}
			if($("#START_PAGE").val()==""){
				$("#START_PAGE").tips({
					side:3,
		            msg:'请输入页号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_PAGE").focus();
			return false;
			}
			if($("#FILE_PAGE").val()==""){
				$("#FILE_PAGE").tips({
					side:3,
		            msg:'请输入页数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_PAGE").focus();
			return false;
			}
			if($("#FILE_DATE").val()==""){
				$("#FILE_DATE").tips({
					side:3,
		            msg:'请输入日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_DATE").focus();
			return false;
			}
			if($("#STORAGE_YEAR").val()==""){
				$("#STORAGE_YEAR").tips({
					side:3,
		            msg:'请输入归档年度',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STORAGE_YEAR").focus();
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
//			if($("#FILE_DESCRIPTION").val()==""){
//				$("#FILE_DESCRIPTION").tips({
//					side:3,
//		            msg:'请输入备注',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#FILE_DESCRIPTION").focus();
//			return false;
//			}
//			if($("#VOLUME_ID").val()==""){
//				$("#VOLUME_ID").tips({
//					side:3,
//		            msg:'请输入案卷id',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#VOLUME_ID").focus();
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