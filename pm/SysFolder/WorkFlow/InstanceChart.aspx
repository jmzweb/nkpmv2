<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstanceChart.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.InstanceChart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程图</title>
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <style type="text/css">
        #_dp img{margin-left:-60px;z-index:1000;}
    </style>
    <script type="text/javascript">
        jQuery(function () {

            $(".tabZone span.tab_btn").click(function () {
                var pt = $(this).parent();
                $(".tab_cur", pt).removeClass("tab_cur");
                $(this).addClass("tab_cur");
                var i = $(this).index();
                var blist = pt.next().children();
                blist.hide();
                blist.eq(i).show();
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <table width="90%" border="0" align="center">
        <tr><td height="30"><h4 style="float:left;color:#4677bf"><span>任务名称：</span><%=defModel.InstanceName%></h4></td></tr>
        <tr><td style="color:Gray;font-size:12px;">流程名称：<%=workflowName%>&nbsp;&nbsp;&nbsp;&nbsp;
        发起人：<%=defModel.EmployeeName%>（<%=defModel.CompanyName%>） 
        &nbsp;&nbsp;&nbsp;&nbsp;发起时间：<%=defModel._CreateTime%>
        &nbsp;&nbsp;&nbsp;&nbsp;处理状态：<%=defModel.InstanceState%>
        </td></tr>
    </table>
    <div id="_dp" style="margin-top:5px;margin-left:auto;margin-right:auto;font-size:12px;border:blue 0px solid;width:90%;height:<%=MaxHeight%>px;">
        <wf:InstanceImg id="FlowImg" runat="server"></wf:InstanceImg>
    </div>
    </form>
</body>
</html>
