<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_DeptMove.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_DeptMove" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>组织转移</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../../css/appStyle.css"/>
    <script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../../js/Tools.js"></script>
    <style type="text/css">
        body{background-color:#f9fafe;font-size:10pt;}
        table.outerTbl
        {
            table-layout:fixed;
            border-collapse:collapse;
            border:0px solid gray;
            margin-left:auto;
            margin-right:auto;
            }
        table.innerTbl
        {
            border-collapse:collapse;
            border:1px solid gray;
            }
        .innerTbl th,.innerTbl td
        {
            border:0px solid gray;padding:5px;height:28px;background-color:White;text-align:left;
            }
        .innerTbl th{
            background:#eee url(../../img/toolbar.gif) repeat-x center center;
            height:26px;
            }
        table.outerTbl>tbody>tr>td{border:0px solid gray;padding:5px;}
        .center{text-align:center;}
        input[type=text]{border:1px solid #aaa;height:20px;line-height:20px;}
        .imgbutton{height:30px;padding-left:10px;padding-right:10px;}
         .tip{border:dotted 1px orange;background:#F9FB91;text-align:left;padding:5px;margin-top:10px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="text-align:left;margin-left:auto;margin-right:auto;">
        <br /><br />
        <table width="600" class="outerTbl" align="center">
            <caption style="font-weight:bold;font-size:12pt;line-height:30px;">组织机构转移</caption>
            <tr>
                <td>
                    <table class="innerTbl" width="100%">
                        <tbody>
                            <tr>
                                <td >&nbsp;当前组织名称：&nbsp;<b style="color:blue;"><%=DeptName%></b></td>
                                <td> </td>
                            </tr>
                            <tr>
                                <td>&nbsp;目标父级组织：&nbsp;
                                    <asp:TextBox Width="200" ID="txtParentName" runat="server" CssClass="read"></asp:TextBox>
                                    <asp:HiddenField ID="txtParentId" runat="server" />
                                    <input id="btnParent" type="button" value=" ... "/>
                                    </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="background-color:#eee;">
                                    <div style="padding-left:40px;line-height:1.8;position:relative;">
                                        <span style="position:absolute;left:0px;top:0px;">&nbsp;说明：</span>
                                        转移之后，系统会把当前组织（包括子级）及相应岗位、人员移动到目标父级组织下面<br/>
                                        并且[组织ID]和[岗位ID]信息保持不变，[组织WBS编码]会重新生成，人员权限保持不变。
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <%=TipMsg%>                    
                   <div style="padding:3px;">
                        <div style="line-height:30px;color:Green;">
                        <button  type="button" id="btnMove" class="imgbutton"><img alt="确认转移" src="../../img/common/site.png" />&nbsp;确认转移&nbsp;</button>
                        <button  type="button" id="btnRet" class="imgbutton"><img alt="返回" src="../../img/common/undo.png" />&nbsp;返回上一步&nbsp;</button>
                            <asp:Button ID="Button1" runat="server" CssClass="hidden" Text="Button" onclick="Button1_Click" />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    jQuery(function () {
        $(".read").attr("readonly", true);
        $("#btnParent").click(function () {
            openpage('../Common/DeptTree.aspx?method=1&queryfield=deptwbs,deptname&cid=txtParentId,txtParentName');
        });
        $("#btnMove").click(function () {
            var pName = $("#txtParentName").val();
            if (pName == "") {
                alert("请选择目标父级组织"); return;
            }
            if (!confirm("你确认要转移[<%=DeptName%>] 至 [" + pName + "] 吗？"))
                return;

            $("#Button1").click();
        });
        $("#btnRet").click(function () {
            window.history.back();
        });
    });
</script>
