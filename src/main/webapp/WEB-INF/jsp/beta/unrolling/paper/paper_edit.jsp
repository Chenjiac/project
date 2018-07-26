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
					
					<form action="paper/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PAPER_ID" id="PAPER_ID" value="${pd.PAPER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<%--<tr>--%>
								<%--<td style="width:75px;text-align: right;padding-top: 13px;">文件id:</td>--%>
								<%--<td><input type="number" name="UNROLLING_PAPER_ID" id="UNROLLING_PAPER_ID" value="${pd.UNROLLING_PAPER_ID}" maxlength="32" placeholder="这里输入文件id" title="文件id" style="width:98%;"/></td>--%>
							<%--</tr>--%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">全宗号:</td>
								<td><input type="text" name="GENERAL_ARCHIVE" id="GENERAL_ARCHIVE" value="${pd.GENERAL_ARCHIVE}" maxlength="3" placeholder="这里输入全宗号" title="全宗号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">室编档号:</td>
								<td><input type="text" name="ROOM_NUM" id="ROOM_NUM" value="${pd.ROOM_NUM}" maxlength="32" placeholder="这里输入室编档号" title="室编档号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">管编档号:</td>
								<td><input type="text" name="LIBRARY_NUM" id="LIBRARY_NUM" value="${pd.LIBRARY_NUM}" maxlength="16" placeholder="这里输入管编档号" title="管编档号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">室编件号:</td>
								<td><input type="text" name="ROOM_CODE" id="ROOM_CODE" value="${pd.ROOM_CODE}" maxlength="5" placeholder="这里输入室编件号" title="室编件号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">馆编件号:</td>
								<td><input type="text" name="LIBRARY_CODE" id="LIBRARY_CODE" value="${pd.LIBRARY_CODE}" maxlength="5" placeholder="这里输入馆编件号" title="馆编件号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">归档年度:</td>
								<td><input type="text" name="STORAGE_YEAR" id="STORAGE_YEAR" value="${pd.STORAGE_YEAR}" maxlength="4" placeholder="这里输入归档年度" title="归档年度" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">机构:</td>
								<td>
									<input type="text" name="SECTION" id="SECTION" value="${pd.SECTION}" maxlength="4" placeholder="这里输入机构" title="机构" style="width:98%;"/>
								</td>
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
								<td style="width:75px;text-align: right;padding-top: 13px;">文号:</td>
								<td><input type="text" name="PAPER_NUM" id="PAPER_NUM" value="${pd.PAPER_NUM}" maxlength="32" placeholder="这里输入文号" title="文号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">题名:</td>
								<td><textarea type="text" name="PAPER_NAME" id="PAPER_NAME" maxlength="64" placeholder="这里输入题名" title="题名" style="width:98%;height: 90px">${pd.PAPER_NAME}</textarea></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">责任者:</td>
								<td><input type="text" name="PAPER_RESPONSIBLER" id="PAPER_RESPONSIBLER" value="${pd.PAPER_RESPONSIBLER}" maxlength="32" placeholder="这里输入责任者" title="责任者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">日期:</td>
								<td><input class="span10 date-picker" name="PAPER_DATE" id="PAPER_DATE" value="${pd.PAPER_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="日期" title="日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">页数:</td>
								<td><input type="number" name="PAPER_PAGE" id="PAPER_PAGE" value="${pd.PAPER_PAGE}" maxlength="32" placeholder="这里输入页数" title="页数" style="width:98%;"/></td>
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
								<td><input type="text" name="PAPER_DESCRIPTION" id="PAPER_DESCRIPTION" value="${pd.PAPER_DESCRIPTION}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
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
			if($("#ROOM_NUM").val()==""){
				$("#ROOM_NUM").tips({
					side:3,
		            msg:'请输入室编档号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ROOM_NUM").focus();
			return false;
			}
			if($("#LIBRARY_NUM").val()==""){
				$("#LIBRARY_NUM").tips({
					side:3,
		            msg:'请输入管编档号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LIBRARY_NUM").focus();
			return false;
			}
			if($("#ROOM_CODE").val()==""){
				$("#ROOM_CODE").tips({
					side:3,
		            msg:'请输入室编件号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ROOM_CODE").focus();
			return false;
			}
			if($("#LIBRARY_CODE").val()==""){
				$("#LIBRARY_CODE").tips({
					side:3,
		            msg:'请输入馆编件号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LIBRARY_CODE").focus();
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
			if($("#SECTION").val()==""){
				$("#SECTION").tips({
					side:3,
		            msg:'请输入机构',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SECTION").focus();
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
			if($("#PAPER_NUM").val()==""){
				$("#PAPER_NUM").tips({
					side:3,
		            msg:'请输入文号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAPER_NUM").focus();
			return false;
			}
			if($("#PAPER_NAME").val()==""){
				$("#PAPER_NAME").tips({
					side:3,
		            msg:'请输入题名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAPER_NAME").focus();
			return false;
			}
			if($("#PAPER_RESPONSIBLER").val()==""){
				$("#PAPER_RESPONSIBLER").tips({
					side:3,
		            msg:'请输入责任者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAPER_RESPONSIBLER").focus();
			return false;
			}
			if($("#PAPER_DATE").val()==""){
				$("#PAPER_DATE").tips({
					side:3,
		            msg:'请输入日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAPER_DATE").focus();
			return false;
			}
			if($("#PAPER_PAGE").val()==""){
				$("#PAPER_PAGE").tips({
					side:3,
		            msg:'请输入页数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAPER_PAGE").focus();
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
//			if($("#PAPER_DESCRIPTION").val()==""){
//				$("#PAPER_DESCRIPTION").tips({
//					side:3,
//		            msg:'请输入备注',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#PAPER_DESCRIPTION").focus();
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

        $(function() {
            //下拉框
            if(!ace.vars['touch']) {
                $('.chosen-select').chosen({allow_single_deselect:true});
                $(window)
                    .off('resize.chosen')
                    .on('resize.chosen', function() {
                        $('.chosen-select').each(function() {
                            var $this = $(this);
                            $this.next().css({'width': $this.parent().width()});
                        });
                    }).trigger('resize.chosen');
                $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
                    if(event_name != 'sidebar_collapsed') return;
                    $('.chosen-select').each(function() {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    });
                });
                $('#chosen-multiple-style .btn').on('click', function(e){
                    var target = $(this).find('input[type=radio]');
                    var which = parseInt(target.val());
                    if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
                    else $('#form-field-select-4').removeClass('tag-input-style');
                });
            }
        });
		</script>
</body>
</html>