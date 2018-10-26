<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppWorkFlowPrint.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppWorkFlowPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>打印流程信息</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/appPrint.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../Js/DateExt.js"></script>
    <%=customScript%>
    <style type="text/css" media="print"> 
	    .NoPrint{display:none;} 
	    .PageNext{page-break-after: always;}
	    #maindiv{overflow:visible} 
    </style>
    <style type="text/css"> 
	    #maindiv{<%=formWidth%>}
    </style>  
    <script type="text/javascript">
        function appPrint() {
            //document.getElementById("WebBrowser").ExecWB(7, 1);
            //window.print();
            var LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.PRINT_INIT("打印任务名");               //首先一个初始化语句 
            LODOP.ADD_PRINT_HTM(0, 0, "100%", "100%", "url:"+window.location.href); //然后多个ADD语句及SET语句 
            LODOP.PREVIEW();                               //最后一个打印(或预览、维护、设计)语句
        }
        jQuery(function () {
            $(":radio,:checkbox").each(function () { $(this).prop("disabled", !$(this).prop("checked")); });
            if (!isActiveXEnabled()) {
                //$("#tipActiveX").show();
            }

        });
        function isActiveXEnabled() {
            try {
                new ActiveXObject("Shell.Explorer.2");
            } catch (e) {
                return false;
            }
            return true;
        }
    </script>
    <script type="text/javascript" src="LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
      <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0"></embed>
    </object>
</head>
<body>
    <form id="form1" runat="server">
    <!-- <object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" ></object> 
    工具栏 -->
    <div class="menubar NoPrint">
        <div class="topnav">
            <ul>
                <li><a href="javascript:" onclick="appPrint();" >打印</a></li>
                <li><a href="AppExport.aspx?tblName=<%=tblName %>&mainId=<%=mainId %>&sindex=<%=sIndex %>&funType=2&docType=doc" target="_blank" >导出Word</a></li>
                <!--
                <li><a href="AppExport.aspx?tblName=<%=tblName %>&mainId=<%=mainId %>&sindex=<%=sIndex %>&funType=2&docType=pdf" target="_blank" >导出Pdf</a></li>
                -->
                <li><a href="javascript:" onclick="window.close();" >关闭</a> </li>
            </ul>
        </div>
    </div>
    <div id="tipActiveX" style="display:none;margin:0px;padding:7px 5px;border:dotted 1px orange;background:#F9FB91;font-size:14px;">当前您的浏览器安全设置不允许调用本地ActiveX，点击【打印】会没有反应，请按<a href="" target="_blank">调整设置</a></div>    
    <div id="maindiv" style="background:white;">
        <% =tblHTML%>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    <%=printScript%>
</script>