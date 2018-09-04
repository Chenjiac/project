<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
							
						<!-- 检索  -->
						<form action="file/list.do?currentPage=${page.currentPage}" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入题名" class="nav-search-input" id="nav-search-input" autocomplete="off" name="NAME" value="${pd.NAME }" placeholder="这里输入题名"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入归档年度" class="nav-search-input" id="nav-search-input" autocomplete="off" name="STORAGE_YEAR" value="${pd.STORAGE_YEAR }" placeholder="这里输入归档年度FILE"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;">
									<select class="chosen-select form-control" name="STORAGE_TIME" id="STORAGE_TIME" data-placeholder="请选择保管期限" style="vertical-align:top;width: 120px;">
										<option value=""></option>
										<option value="">全部</option>
										<option value="永久" <c:if test="${pd.STORAGE_TIME=='永久'}">selected</c:if>>永久</option>
										<option value="长期" <c:if test="${pd.STORAGE_TIME=='长期'}">selected</c:if>>长期</option>
									</select>
								</td>
								<%--&lt;%&ndash;<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>&ndash;%&gt;--%>
								<%--&lt;%&ndash;<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>&ndash;%&gt;--%>
								<%--&lt;%&ndash;<td style="vertical-align:top;padding-left:2px;">&ndash;%&gt;--%>
								 	<%--&lt;%&ndash;<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;">&ndash;%&gt;--%>
									<%--&lt;%&ndash;<option value=""></option>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<option value="">全部</option>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<option value="">1</option>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<option value="">2</option>&ndash;%&gt;--%>
								  	<%--&lt;%&ndash;</select>&ndash;%&gt;--%>
								<%--&lt;%&ndash;</td>&ndash;%&gt;--%>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								<c:if test="${QX.FromExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:30px;">序号</th>
									<%--<th class="center">文件id</th>--%>
									<th class="center">全宗号</th>
									<th class="center">目录号</th>
									<th class="center">案卷号</th>
									<th class="center">档号</th>
									<th class="center">顺序号</th>
									<th class="center" style="width: 20%">题名</th>
									<th class="center">文号</th>
									<th class="center">责任者</th>
									<th class="center">页号</th>
									<th class="center">页数</th>
									<th class="center">日期</th>
									<th class="center">归档年度</th>
									<th class="center">保管期限</th>
									<th class="center">密级</th>
									<th class="center">保管单位名称</th>
									<th class="center">备注</th>
									<th class="center">预览</th>
									<%--<th class="center">案卷id</th>--%>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<%--<td class='center'>${var.FILE_ID}</td>--%>
											<td class='center'>${var.GENERAL_ARCHIVE}</td>
											<td class='center'>${var.CATALOG_NUMBER}</td>
											<td class='center'>${var.VOLUME_SN}</td>
											<td class='center'>${var.VOLUME_NUM}</td>
											<td class='center'>${var.FILE_SN}</td>
											<%--<td class='center'>${var.NAME}</td>--%>
											<td class="center"><a style="cursor: pointer; text-decoration: none;" onclick="openPDF('${var.VOLUME_NUM}','${var.FILE_SN}')">${var.NAME}</a></td>
											<td class='center'>${var.NUM}</td>
											<td class='center'>${var.RES}</td>
											<td class='center'>${var.START_PAGE}</td>
											<td class='center'>${var.FILE_PAGE}</td>
											<td class='center'>${var.FILE_DATE}</td>
											<td class='center'>${var.STORAGE_YEAR}</td>
											<td class='center'>${var.STORAGE_TIME}</td>
											<td class='center'>${var.SECRET_LEVEL}</td>
											<td class='center'>${var.COMPANY_NAME}</td>
											<td class='center'>${var.DES}</td>
											<td class="center">
												<button style="cursor:pointer; width: 40px;height: 24px;font-size: 12px;line-height: 24px;vertical-align: middle" onclick="openPDF('${var.VOLUME_NUM}','${var.FILE_SN}');" title="预览">预览</button>
											</td>
											<%--<td class='center'>${var.VOLUME_ID}</td>--%>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<%--<div class="hidden-sm hidden-xs btn-group">--%>
													<%--<c:if test="${QX.edit == 1 }">--%>
													<%--<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.FILE_ID}');">--%>
														<%--<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>--%>
													<%--</a>--%>
													<%--</c:if>--%>
													<%--<c:if test="${QX.del == 1 }">--%>
													<%--<a class="btn btn-xs btn-danger" onclick="del('${var.FILE_ID}');">--%>
														<%--<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>--%>
													<%--</a>--%>
													<%--</c:if>--%>
													<%--<a href="file/list.do?VOLUME_ID=${var.VOLUME_ID}" style="display: inline-block;text-decoration: none; width: 40px; height: 26px;background-color:#ccc;font-size: 13px; color: darkmagenta;line-height:26px;text-align: center" title="附件" >附件</a>--%>
												<%--</div>--%>
												<%--<div class="hidden-md hidden-lg">--%>
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<%--<li>--%>
																<%--<a style="cursor:pointer;" onclick="openPDF('${var.VOLUME_NUM}','${var.FILE_SN}');" class="tooltip-success" data-rel="tooltip" title="预览">--%>
																	<%--<span class="green">--%>
																		<%--<i class="ace-icon fa fa-eye pink"></i>--%>
																	<%--</span>--%>
																<%--</a>--%>
															<%--</li>--%>
														</ul>
													</div>
												<%--</div>--%>
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?','请再次确认是否删除选中的数据？？？？');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
									<a class="btn btn-xs btn-success" title="下载" onclick="downloadAll('确定下载选中的PDF文档吗？')">
										<i class="ace-icon fa fa-cloud-download bigger-120" title="下载"></i>
									</a>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
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
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>file/goAdd.do';
			 diag.Width = 500;
			 diag.Height = 550;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				}
				diag.close();
			 };
			 diag.show();
		}

        //删除
        <%--function del(Id){--%>
            <%--bootbox.confirm("确定要删除吗?", function(result) {--%>
                <%--if(result) {--%>
                    <%--top.jzts();--%>
                    <%--var url = "<%=basePath%>file/delete.do?FILE_ID="+Id+"&tm="+new Date().getTime();--%>
                    <%--$.get(url,function(data){--%>
                        <%--tosearch();--%>
                    <%--});--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>

        function del(Id) {
            bootbox.confirm("确定要删除吗？",function (result) {
                if(result == true){
                    bootbox.confirm("请再次确认是否删除？？？",function (res) {
                        if (res){
                            top.jzts();
                            var url = "<%=basePath%>file/delete.do?FILE_ID="+Id+"&tm="+new Date().getTime();
                            $.get(url,function (data) {
                                tosearch();
                            });
                        }
                    });
                }
            });
        }

		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>file/goEdit.do?FILE_ID='+Id;
			 diag.Width = 500;
			 diag.Height = 550;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(msg1,msg2){
			bootbox.confirm(msg1, function(result) {
				if(result) {
				    bootbox.confirm(msg2,function (res) {
						if (res){
                            var str = '';
                            for(var i=0;i < document.getElementsByName('ids').length;i++){
                                if(document.getElementsByName('ids')[i].checked){
                                    if(str=='') str += document.getElementsByName('ids')[i].value;
                                    else str += ',' + document.getElementsByName('ids')[i].value;
                                }
                            }
                            if(str==''){
                                bootbox.dialog({
                                    message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                                    buttons:
                                        { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                                });
                                $("#zcheckbox").tips({
                                    side:1,
                                    msg1:'点这里全选',
                                    bg:'#AE81FF',
                                    time:8
                                });
                                return;
                            }else{
                                if(msg1 == '确定要删除选中的数据吗?' && msg2 == '请再次确认是否删除选中的数据？？？？'){
                                    top.jzts();
                                    $.ajax({
                                        type: "POST",
                                        url: '<%=basePath%>file/deleteAll.do?tm='+new Date().getTime(),
                                        data: {DATA_IDS:str},
                                        dataType:'json',
                                        //beforeSend: validateData,
                                        cache: false,
                                        success: function(data){
                                            $.each(data.list, function(i, list){
                                                tosearch();
                                            });
                                        }
                                    });
                                }
                            }
						}
                    })

				}
			});
		};

		//预览pdf文件
        function openPDF(num,sn) {

                window.open('<%=basePath%>file/findByNum.do?VOLUME_NUM=' + num + '&FILE_SN=' + sn);

//            var url="/uploadFiles/uploadFile/"+p;
//            window.open("pdfjs/web/viewer.html?file="+url);
        }

		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>file/excel.do';
		}

        //打开上传excel页面
        function fromExcel(){
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="EXCEL 导入到数据库";
            diag.URL = '<%=basePath%>file/goUploadExcel.do';
            diag.Width = 300;
            diag.Height = 150;
            diag.CancelEvent = function(){ //关闭事件
                if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                    if('${page.currentPage}' == '0'){
                        top.jzts();
                        setTimeout("self.location.reload()",100);
                    }else{
                        nextPage(${page.currentPage});
                    }
                }
                diag.close();
            };
            diag.show();
        }

        //批量操作
        function downloadAll(msg){
            bootbox.confirm(msg, function(result) {
                if(result) {
                    var arr = new Array();
                    for(var i=0;i < document.getElementsByName('ids').length;i++){
                        if(document.getElementsByName('ids')[i].checked){
                            arr.push(document.getElementsByName('ids')[i].value);
                        }
                    }
					var str = JSON.stringify(arr);
					console.log(str);
                    if(arr.length == 0){
                        bootbox.dialog({
                            message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                            buttons:
                                { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                        });
                        $("#zcheckbox").tips({
                            side:1,
                            msg:'点这里全选',
                            bg:'#AE81FF',
                            time:8
                        });
                        return;
                    }else{
                        if(msg == '确定下载选中的PDF文档吗？'){
                            window.location.href='<%=basePath%>file/downloadAll.do?DATA=' + arr;
                            <%--top.jzts();--%>
                            <%--$.ajax({--%>
                                <%--type: "POST",--%>
                                <%--url: '<%=basePath%>file/downloadAll.do',--%>
                                <%--data: {DATA:str},--%>
                                <%--dataType:'json',--%>
                                <%--//beforeSend: validateData,--%>
                                <%--cache: false,--%>
                                <%--success: function(data){--%>
                                    <%--$.each(data.list, function(i, list){--%>
                                        <%--nextPage(${page.currentPage});--%>
                                    <%--});--%>
                                <%--}--%>
                            <%--});--%>
                        }
                    }
                }
            });
        };

	</script>


</body>
</html>