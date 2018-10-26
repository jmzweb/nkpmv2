<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppSubView.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppSubView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>查看记录</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/jquery-ui/lightness/jquery-ui-1.7.2.custom.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/skins/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/ui.core.js"></script>
    <script type="text/javascript" src="../../js/ui.tabs.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor.js"></script>
    <style type="text/css" media="print"> 
	    .NoPrint{display:none;} 
	    .PageNext{page-break-after: always;} 
    </style> 
    <script type="text/javascript">
        jQuery(function () {
            $(window).resize(function () {
                $("#maindiv").height($(document.body).height() - 75);
            });
            $("#maindiv").height($(document.body).height() - 75);
        });

		//关闭窗口
        function _appClose(){
            if(!!frameElement){
                if(!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else
                    window.close();
            }
            else{
                window.close();
            }
        }

        var _mainTblName = "<%=tblName %>";
        var _mainId = "<%=mainId %>";
    </script>
</head>
<body scroll="auto">
    <form id="form1" runat="server">
    <div class="menubar NoPrint">
        <div class="topnav">
            <ul>
                <li><a href="javascript:" onclick="_appClose();" >关闭</a> </li>
            </ul>
        </div>
    </div>
    
    <div id="maindiv" style="background:white;">
    <br />
    <% =tblHTML%>
    </div>
    </form>
</body>
</html>
