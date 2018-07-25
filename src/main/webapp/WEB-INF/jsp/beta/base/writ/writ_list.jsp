<%--
  Created by IntelliJ IDEA.
  User: 陈cc
  Date: 2018/7/9
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
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
                        <form action="writ/list.do" method="post" name="Form" id="Form">
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
											<input type="text" placeholder="这里输入归档年度" class="nav-search-input" id="nav-search-input" autocomplete="off" name="STORAGE_YEAR" value="${pd.STORAGE_YEAR }" placeholder="这里输入归档年度"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
                                        </div>
                                    </td>
                                    <%--<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>--%>
                                    <%--<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>--%>
                                    <%--<td style="vertical-align:top;padding-left:2px;">--%>
                                        <%--<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;">--%>
                                            <%--<option value=""></option>--%>
                                            <%--<option value="">全部</option>--%>
                                            <%--<option value="">1</option>--%>
                                            <%--<option value="">2</option>--%>
                                        <%--</select>--%>
                                    <%--</td>--%>
                                    <%--<c:if test="${QX.cha == 1 }">--%>
                                        <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                    <%--</c:if>--%>
                                    <%--<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>--%>
                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <%--<th class="center" style="width:35px;">--%>
                                        <%--<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>--%>
                                    <%--</th>--%>
                                    <th class="center" style="width:50px;">序号</th>
                                    <%--<th class="center">文件id</th>--%>
                                    <th class="center">全宗号</th>
                                    <%--<th class="center">目录号</th>--%>
                                    <%--<th class="center">案卷号</th>--%>
                                    <%--<th class="center">档号</th>--%>
                                    <%--<th class="center">顺序号</th>--%>
                                    <th class="center" style="width: 30%">题名</th>
                                    <th class="center">文号</th>
                                    <th class="center" style="width: 20%">责任者</th>
                                    <%--<th class="center">页号</th>--%>
                                    <%--<th class="center">页数</th>--%>
                                    <%--<th class="center">日期</th>--%>
                                    <th class="center">归档年度</th>
                                    <%--<th class="center">保管期限</th>--%>
                                    <%--<th class="center">密级</th>--%>
                                    <%--<th class="center">保管单位名称</th>--%>
                                    <th class="center">备注</th>
                                    <th class="center">文件属性</th>
                                    <%--<th class="center">案卷id</th>--%>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <%--<c:if test="${QX.cha == 1 }">--%>
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr>
                                                    <%--<td class='center'>--%>
                                                        <%--<label class="pos-rel"><input type='checkbox' name='ids' value="${var.FILE_ID}" class="ace" /><span class="lbl"></span></label>--%>
                                                    <%--</td>--%>
                                                    <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                        <%--<td class='center'>${var.FILE_ID}</td>--%>
                                                    <td class='center'>${var.GENERAL_ARCHIVE}</td>
                                                    <%--<td class='center'>${var.CATALOG_NUMBER}</td>--%>
                                                    <%--<td class='center'>${var.VOLUME_SN}</td>--%>
                                                    <%--<td class='center'>${var.VOLUME_NUM}</td>--%>
                                                    <%--<td class='center'>${var.FILE_SN}</td>--%>
                                                    <td class='center'>${var.NAME}</td>
                                                    <td class='center'>${var.NUM}</td>
                                                    <td class='center'>${var.RES}</td>
                                                    <%--<td class='center'>${var.START_PAGE}</td>--%>
                                                    <%--<td class='center'>${var.FILE_PAGE}</td>--%>
                                                    <%--<td class='center'>${var.FILE_DATE}</td>--%>
                                                    <td class='center'>${var.STORAGE_YEAR}</td>
                                                    <%--<td class='center'>${var.STORAGE_TIME}</td>--%>
                                                    <%--<td class='center'>${var.SECRET_LEVEL}</td>--%>
                                                    <%--<td class='center'>${var.COMPANY_NAME}</td>--%>
                                                    <td class='center'>${var.DES}</td>
                                                    <td class='center'>
                                                        <c:if test="${var.ZERO == 1 }">非立卷</c:if>
                                                        <c:if test="${var.ZERO == 0 }">立卷</c:if>
                                                    </td>  
                                                        <%--<td class='center'>${var.VOLUME_ID}</td>--%>
                                                    <td class="center">
                                                        <%--<c:if test="${QX.edit != 1 && QX.del != 1 }">--%>
                                                            <%--<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>--%>
                                                        <%--</c:if>--%>
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
                                                            <a href="javascript:void(0);" onclick="detail('${var.ID}','${var.ZERO}')" style="display: inline-block;text-decoration: none; width: 40px; height: 26px;background-color:yellowgreen;font-size: 13px; color: white;line-height:26px;text-align: center" title="详情" >详情</a>
                                                            <a href="javascript:void(0);" onclick="openPDF('${var.VOLUME_NUM}','${var.FILE_SN}');" style="display: inline-block;text-decoration: none; width: 40px; height: 26px;background-color:blueviolet;font-size: 13px; color: white;line-height:26px;text-align: center" title="预览" >预览</a>
                                                            <%--</div>--%>
                                                            <%--<div class="hidden-md hidden-lg">--%>
                                                        <%--<div class="inline pos-rel">--%>
                                                            <%--<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">--%>
                                                                <%--<i class="ace-icon fa fa-cog icon-only bigger-110"></i>--%>
                                                            <%--</button>--%>

                                                            <%--<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">--%>
                                                                <%--<c:if test="${QX.edit == 1 }">--%>
                                                                    <%--<li>--%>
                                                                        <%--<a style="cursor:pointer;" onclick="edit('${var.FILE_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">--%>
																	<%--<span class="green">--%>
																		<%--<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>--%>
																	<%--</span>--%>
                                                                        <%--</a>--%>
                                                                    <%--</li>--%>
                                                                <%--</c:if>--%>
                                                                <%--<c:if test="${QX.del == 1 }">--%>
                                                                    <%--<li>--%>
                                                                        <%--<a style="cursor:pointer;" onclick="del('${var.FILE_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">--%>
																	<%--<span class="red">--%>
																		<%--<i class="ace-icon fa fa-trash-o bigger-120"></i>--%>
																	<%--</span>--%>
                                                                        <%--</a>--%>
                                                                    <%--</li>--%>
                                                                <%--</c:if>--%>
                                                                <%--<li>--%>
                                                                    <%--<a href="attachment/list.do?FILE_ID=${var.FILE_ID}" style="display: inline-block;text-decoration: none; width: 40px; height: 26px;background-color:#ccc;font-size: 13px; color: darkmagenta;line-height:26px;text-align: center" title="查看" >查看</a>--%>
                                                                <%--</li>--%>
                                                            <%--</ul>--%>
                                                        <%--</div>--%>
                                                            <%--</div>--%>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                        <%--</c:if>--%>
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
                                        <%--<td style="vertical-align:top;">--%>
                                            <%--<c:if test="${QX.add == 1 }">--%>
                                                <%--<a class="btn btn-mini btn-success" onclick="add();">新增</a>--%>
                                            <%--</c:if>--%>
                                            <%--<c:if test="${QX.del == 1 }">--%>
                                                <%--<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>--%>
                                            <%--</c:if>--%>
                                        <%--</td>--%>
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


//    function toNext(Id,x){
////        alert(Id);
////        alert(x);
//        if(x==0){
//            window.location.href = 'file/list.do?ID='+Id;
////            alert(2);
//        }else{
////            alert(3);
//            window.location.href = 'paper/list.do?ID='+Id;
//        }
//    }

    function detail(Id,x) {
        if (x == 0) {                //立卷
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag = true;
            diag.Title = "详情";
            diag.URL = '<%=basePath%>file/detail.do?FILE_ID=' + Id;
            diag.Width = 450;
            diag.Height = 355;
            diag.Modal = true;				//有无遮罩窗口
            diag.ShowMaxButton = true;	//最大化按钮
            diag.ShowMinButton = true;		//最小化按钮
            diag.CancelEvent = function () { //关闭事件
                if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                    tosearch();
                }
                diag.close();
            };
            diag.show();
        } else if (x == 1) {                 //非立卷
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag = true;
            diag.Title = "详情";
            diag.URL = '<%=basePath%>paper/detail.do?PAPER_ID=' + Id;
            diag.Width = 450;
            diag.Height = 355;
            diag.Modal = true;				//有无遮罩窗口
            diag.ShowMaxButton = true;	//最大化按钮
            diag.ShowMinButton = true;		//最小化按钮
            diag.CancelEvent = function () { //关闭事件
                if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                    tosearch();
                }
                diag.close();
            };
            diag.show();
        }
    }

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
</script>


</body>
</html>
