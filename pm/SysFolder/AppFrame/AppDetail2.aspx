<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppDetail.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>查看记录</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/appDetail.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <%=customScript%>
    <style type="text/css" media="print"> 
	    .NoPrint{display:none;} 
	    .PageNext{page-break-after: always;} 
    </style>
    <style type="text/css">
        .kandyTabs .tabtitle{text-align:left;}
        #maindiv{<%=formWidth%>}
    </style> 
    <script type="text/javascript">
        jQuery(function () {
            $("dl").KandyTabs({trigger:"click"});
            if('<%=Request["toolbar"] %>'!=""){
                $(".menubar a").hide();
            }
            $(":radio,:checkbox").each(function(){$(this).prop("disabled",!$(this).prop("checked"));}); 
        });
        function appPrint() {
            //document.getElementById("WebBrowser").ExecWB(7, 1);
            window.print();
        }
        function _fnSubView(subName, subId, sindex) {
            var url = "../AppFrame/AppSubView.aspx?tblName=" + subName + "&subId=" + subId + "&sindex=" + sindex;
            var dlg = new jQuery.dialog({ title: '查看', maxBtn: true, page: url
                    , btnBar: false, cover: true, lockScroll: true, width: 900, height: 600, bgcolor: 'black'
            });
            dlg.ShowDialog();
        }
        var _mainTblName = "<%=tblName %>";
        var _mainId = "<%=mainId %>";
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!-- <OBJECT id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" ></OBJECT> 
    工具栏 -->
    <div class="menubar NoPrint">
        <div class="topnav">
            <ul>
                <li><a href="javascript:" onclick="appPrint();" >打印</a></li>
                <li><a href="javascript:" onclick="window.close();" >关闭</a>&nbsp;&nbsp;</li>
            </ul>
        </div>
    </div>
    
    <div id="maindiv">
    <% =tblHTML%>
    </div>
    </form>
    <br />
    <br />
</body>
</html>
<script type="text/javascript">
    <%=viewScript%>
</script>
