<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppWorkFlowInfo.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppWorkFlowInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>查看流程相关信息</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/appDetail.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <%=customScript%>
    <style type="text/css" media="print"> 
	    .NoPrint{display:none;} 
	    .PageNext{page-break-after: always;}
	    #maindiv{overflow:visible;<%=formWidth%>}
    </style> 
    <style type="text/css"> 
	    dl{text-align:left;}
	    dt{cursor:hand;}
	    #maindiv{<%=formWidth%>}
	    .refItem{line-height:25px;height:25px;padding-left:3px;}
	    .refLink{text-decoration:none;}
	    .refLink:hover{text-decoration:underline;color:red;}
	    .addComment{display:none;}
    </style> 
</head>
<body>
    <form id="form1" runat="server">
    <!-- <object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" ></object> 
    工具栏 -->
    <div class="menubar NoPrint">
        <div class="topnav">
            <span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
                <a class="linkbtn" href="javascript:" onclick="appPrint();" >打印</a>
                <em class="split">|</em>
                <a class="linkbtn" href="javascript:" onclick="window.close();" >关闭</a> 
            </span>
        </div>
    </div>
    
    <div id="maindiv">
	    <div style="text-align:left;margin-left:auto;margin-right:auto;">
	        <table width="100%" border="0" align="center">
	        <tr><td height="30"><h4 style="float:left;color:#4677bf;font-size:11pt;"><span>任务名称：</span><%=curInstance.InstanceName%></h4></td></tr>
	        <tr><td style="color:Gray;font-size:12px;line-height:2">流程名称：<%=workflowName%>&nbsp;V<%=workflowVer%> 〔<%=workflowCode%>〕
            &nbsp;&nbsp;发起人：<%=curInstance.EmployeeName%>（<%=curInstance.CompanyName%>） 
	        &nbsp;&nbsp;发起时间：<%=curInstance.K_CreateTime.ToString("yyyy-MM-dd HH:mm")%>
	        &nbsp;&nbsp;审批状态：<%=curInstance.InstanceState%>
            </td></tr>
	    </table>

    </div>
    <div class="kandyTabs">
        <div class="tabtitle">
            <%=btnList %>
        </div>
        <div class="tabbody">
            <%=signHTML%>
            <div class="hidden">
                <%=tblHTML%>
            </div>
            <div class="hidden">
                <wf:InstanceImg id="FlowImg" runat="server"></wf:InstanceImg>
            </div>
            <div class="hidden">
                <%=GetInstanceRefers()%> 
            </div>
            <div class="hidden">
                <wf:InstanceLog id="FlowLog" runat="server"></wf:InstanceLog>
            </div>
        </div>
    </div>

    <div class="wfdealinfo">
        <wf:UserDealInfo id="UserDealInfo" runat="server"></wf:UserDealInfo>
        <br />
        <br />
    </div>

    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $("dl").KandyTabs({ trigger: "click" });
    jQuery(function () {
        $("#wfpic").parent().css("overflow", "auto");
        $(".linkMemo").click(function () { $(this).next("p").toggle(); });
        $(".uMemo").click(function () { $(this).toggle(); });
        $(":radio,:checkbox").each(function () { $(this).prop("disabled", !$(this).prop("checked")); });
        $("div.tabbody>div:first").show();
        $("div.kandyTabs span.tabbtn").click(function () {
            var pt = $(this).parent();
            $(".tabcur", pt).removeClass("tabcur");
            $(this).addClass("tabcur");
            var i = $(this).index();
            var blist = pt.next().children();
            blist.hide();
            blist.eq(i).show();
        });

        $("div.tabZone span.tab_btn").click(function () {
            var pt = $(this).parent();
            $(".tab_cur", pt).removeClass("tab_cur");
            $(this).addClass("tab_cur");
            var i = $(this).index();
            var blist = pt.next().children();
            blist.hide();
            blist.eq(i).show();
        });
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

    <%=viewScript%>
</script>
