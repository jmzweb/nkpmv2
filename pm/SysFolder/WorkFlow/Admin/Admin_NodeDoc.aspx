<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_NodeDoc.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.Admin.Admin_NodeDoc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>流程节点操作说明</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../../Css/AppDetail.css" />
    <script type="text/javascript" src="../../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../../js/kandytabs.pack.js"></script>
    <script type="text/javascript" src="../../../js/lhgdialog.min.js"></script>
    <style type="text/css"> 
	    dl{text-align:left;}
	    dd .tabcont{height:500px;}
	    dt{cursor:hand;}
	    .normaltbl>tbody>tr> td{padding:3px;}
    </style> 
    <script type="text/javascript">
        jQuery(function () {
            $("dl").KandyTabs({ trigger: "click" });
            $("#wfpic").parent().css("overflow", "auto");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="width:1000px;">
	    <div style="Text-align:left;margin-left:auto;margin-right:auto;">
        <table width="100%" border="0" align="center">
        <tr><td height="30"><h4 style="float:left;color:#4677bf"><span>流程名称：</span><%=defModel.WorkflowName%></h4></td></tr>
        <tr><td style="color:Gray;font-size:12px;">创建人：管理员 &nbsp;&nbsp;&nbsp;&nbsp;版本号：V<%=defModel.Version%>&nbsp;&nbsp;&nbsp;&nbsp;修改时间：<%=defModel._UpdateTime%></td></tr>
    </table>
    </div>
    <dl style="margin-left:auto;margin-right:auto;">
        <dt>流程图</dt>
        <dd>
            <wf:WorkflowImg id="FlowImg" runat="server"></wf:WorkflowImg>
        </dd>
    </dl>
    <div class="tip" style="margin-left:auto;margin-right:auto;">
        提示：请点击流程图中的节点编辑详细信息（需要配置指引的节点必须先配置节点编码）。
    </div>

    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    jQuery(function () {
        $("area").click(function () {
            var nCode = $(this).attr("nodeCode");
            if (nCode == "") {
                alert("请先设置节点的编码"); return;
            }
            var wfid = "<%=defModel.WorkflowCode%>." + nCode
            var dlg = new jQuery.dialog({ title: '节点操作说明', maxBtn: false
                    , page: "../../AppFrame/AppInput.aspx?tblName=T_E_WF_Direction&cpro=WFId=" + wfid + "^1|WFName=<%=defModel.WorkflowName%>^1&condition=WFId=[QUOTES]" + wfid + "[QUOTES]"
                    , btnBar: false, cover: true, lockScroll: true, width: 900, height: 600, bgcolor: 'black'
            });
            dlg.ShowDialog();
        });
    });
</script>