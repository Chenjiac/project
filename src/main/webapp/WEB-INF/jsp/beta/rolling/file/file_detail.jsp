<%--
  Created by IntelliJ IDEA.
  User: 陈cc
  Date: 2018/7/25
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
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
                                        <td><input type="text" name="GENERAL_ARCHIVE" id="GENERAL_ARCHIVE" value="${pd.GENERAL_ARCHIVE}" maxlength="3" title="全宗号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">目录号:</td>
                                        <td><input type="text" name="CATALOG_NUMBER" id="CATALOG_NUMBER" value="${pd.CATALOG_NUMBER}" maxlength="3" title="目录号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">案卷号:</td>
                                        <td><input type="text" name="VOLUME_SN" id="VOLUME_SN" value="${pd.VOLUME_SN}" maxlength="4" title="案卷号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">档号:</td>
                                        <td><input type="text" name="VOLUME_NUM" id="VOLUME_NUM" value="${pd.VOLUME_NUM}" maxlength="16" title="档号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">顺序号:</td>
                                        <td><input type="number" name="FILE_SN" id="FILE_SN" value="${pd.FILE_SN}" maxlength="32"  title="顺序号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">题名:</td>
                                        <td>
                                            <input type="text" name="FILE_NAME" id="FILE_NAME" value="${pd.FILE_NAME}" maxlength="255"  style="width:98%;height: 100px"  readonly="readonly "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">文号:</td>
                                        <td><input type="text" name="FILE_NUM" id="FILE_NUM" value="${pd.FILE_NUM}" maxlength="32"  title="文号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">责任者:</td>
                                        <td><input type="text" name="FILE_RESPONSIBLER" id="FILE_RESPONSIBLER" value="${pd.FILE_RESPONSIBLER}" maxlength="32" title="责任者" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">页号:</td>
                                        <td><input type="text" name="START_PAGE" id="START_PAGE" value="${pd.START_PAGE}" maxlength="3" title="页号" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">页数:</td>
                                        <td><input type="number" name="FILE_PAGE" id="FILE_PAGE" value="${pd.FILE_PAGE}" maxlength="32" title="页数" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">日期:</td>
                                        <td><input class="span10 date-picker" name="FILE_DATE" id="FILE_DATE" value="${pd.FILE_DATE}" type="text" data-date-format="yyyymmdd" disabled="disabled" title="日期" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">归档年度:</td>
                                        <td><input type="text" name="STORAGE_YEAR" id="STORAGE_YEAR" value="${pd.STORAGE_YEAR}" maxlength="4"  title="归档年度" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">保管期限:</td>
                                        <td><input type="text" name="STORAGE_TIME" id="STORAGE_TIME" value="${pd.STORAGE_TIME}" maxlength="4"  title="保管期限" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">密级:</td>
                                        <td><input type="text" name="SECRET_LEVEL" id="SECRET_LEVEL" value="${pd.SECRET_LEVEL}" maxlength="10" title="密级" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">保管单位名称:</td>
                                        <td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="32" title="保管单位名称" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="FILE_DESCRIPTION" id="FILE_DESCRIPTION" value="${pd.FILE_DESCRIPTION}" maxlength="255" title="备注" style="width:98%;"  readonly="readonly "/></td>
                                    </tr>
                                    <%--<tr>--%>
                                    <%--<td style="width:75px;text-align: right;padding-top: 13px;">案卷id:</td>--%>
                                    <%--<td><input type="number" name="VOLUME_ID" id="VOLUME_ID" value="${pd.VOLUME_ID}" maxlength="32" placeholder="这里输入案卷id" title="案卷id" style="width:98%;"/></td>--%>
                                    <%--</tr>--%>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <%--<a class="btn btn-mini btn-primary" onclick="openPDF('${pd.VOLUME_NUM}','${pd.FILE_SN}');">预览</a>--%>
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
    <%--//预览pdf文件--%>
    <%--function openPDF(num,sn) {--%>

        <%--window.open('<%=basePath%>file/findByNum.do?VOLUME_NUM=' + num + '&FILE_SN=' + sn);--%>

<%--//            var url="/uploadFiles/uploadFile/"+p;--%>
<%--//            window.open("pdfjs/web/viewer.html?file="+url);--%>
    <%--}--%>

    $(function() {
        //日期框
        $('.date-picker').datepicker({autoclose: true,todayHighlight: true});
    });
</script>
</body>
</html>
