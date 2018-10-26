<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DaPrjWBSEdit.aspx.cs" Inherits="EIS.Web.Doc.DaPrjWBSEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>分类编辑</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../Css/DefStyle.css" />
    <style type="text/css">
        input[type=submit]{padding:3px;}
    </style>
    <script type="text/javascript">
        function addNode(info) {
            var arr = info.split("|");
            parent.frames['left'].addNode(arr);
        }
        function changeNode(info) {
            var arr = info.split("|");
            parent.frames['left'].changeNode(arr);
        }
        function removeNode(nodeId) {
            parent.frames['left'].removeNode(nodeId);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:30px;">
    <table>
    <tr>
        <td height="25">分类编码：</td>
        <td>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="textbox"></asp:TextBox></td>
    </tr>
        <tr>
        <td height="25">分类名称：</td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server" CssClass="textbox"></asp:TextBox></td>
    </tr>
        <tr>
        <td height="25">同级排序：</td>
        <td>
            <asp:TextBox ID="TextBox3" runat="server" CssClass="textbox"></asp:TextBox></td>
    </tr>
        <tr>
        <td colspan="2" align="center">
        <br />
            <asp:Button ID="Button1" runat="server" Text="增加子分类" Width="80px" OnClick="Button1_Click" />
            <asp:Button ID="Button2" runat="server" Text="保 存" Width="80px" OnClick="Button2_Click" />
         </td>
    </tr>
    </table>
        <input id="openflag" type="hidden" runat="server" value="change" />
    </div>
    </form>
</body>
</html>
