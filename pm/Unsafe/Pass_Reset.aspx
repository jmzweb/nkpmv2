<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pass_Reset.aspx.cs" Inherits="EIS.Web.Unsafe.Pass_Reset" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>重置密码</title>
    <style type="text/css">
        body{color:#000;background:#f1f1f1;font-size:12px;line-height:166.6%;text-align:center}
        body,input,button{font-family:Verdana,arial,sans-serif}
        *{font-size:100%;margin:0;padding:0}
        img{margin:0;line-height:normal}
        table{border-collapse:collapse;border-spacing:0}
        input,button, img{vertical-align:middle}
        .content{margin:auto}
        #btnConfirm{padding:3px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
<div id="Rpage" class="Rpage-main" style="width:900px;">
        <div id="Rheader">
            <span style="line-height: 100%; position: absolute; color: #76787a; margin-top: 40px;
                font-weight: bold; font-size: 24px; font-family: 黑体;">协同办公信息管理系统 </span>
        </div>
        <div id="Rbody">
            <div class="title">
                <b class="crl"></b><b class="crr"></b>
                <h1>重置密码</h1>
            </div>
            <div class="content">
                <br />
                <br />
                <%=sbMsg %>
                <table width="500" align="center">
                    <tbody>
                        <tr>
                            <td width="100" height="30" valign="middle">
                                &nbsp;新密码：&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:TextBox ID="txtPass" Width="200" CssClass="g-ipt" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="新密码不能为空"
                                    ForeColor="Red" ControlToValidate="txtPass"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td height="30" valign="middle">
                                &nbsp;确认密码：&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:TextBox ID="txtPass2" Width="200" CssClass="g-ipt" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ErrorMessage="两次密码输入不相等" ControlToCompare="txtPass2" 
                                    ControlToValidate="txtPass" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnConfirm" Width="70" runat="server" Text="确 定" OnClick="btnConfirm_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
            </div>
            <div class="bottom">
                <b class="crl"></b><b class="crr"></b>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
