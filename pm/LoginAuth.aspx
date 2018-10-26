<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginAuth.aspx.cs" Inherits="EIS.Web.LoginAuth" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>登录授权</title>
    <link href="Css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        body{color:#000;background:#f1f1f1;font-size:12px;line-height:166.6%;text-align:center}
        body,input,button{font-family:Verdana,arial,sans-serif}
        *{font-size:100%;margin:0;padding:0}
        img{margin:0;line-height:normal}
        table{border-collapse:collapse;border-spacing:0}
        input,button,button img{vertical-align:middle}
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
                <h1>登录授权</h1>
            </div>
            <div class="content">
                <br />
                <br />
                <table style="margin-left:auto;margin-right:auto;" width="700" align="center">
                    <tbody>
                        <tr>
                            <td width="120" height="30" valign="middle">
                                &nbsp;发送给 (可选)：&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:TextBox ID="txtUserName" Width="360" CssClass="g-ipt" runat="server"></asp:TextBox>
                                <asp:HiddenField ID="hidUserId" runat="server" />
                                <input id="btnSel" type="button" value=" ... " />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="line-height:40px;color:Gray;">
                                给选择的授权用户发送站内消息，消息内包含登录地址。
                            </td>
                        </tr>
                        <tr>
                            <td height="30" valign="middle">
                                &nbsp;有效期限：&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:TextBox ID="txtEndTime" CssClass="Wdate g-ipt" Width="200" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" runat="server" ErrorMessage=" 请设置有效期限！"
                                    ForeColor="Red" ControlToValidate="txtEndTime"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="line-height:40px;color:Gray;">
                                默认有效期为1天，超过有效期限，登录地址就会失效。
                            </td>
                        </tr>
                                                <tr>
                            <td height="30" valign="middle">
                                &nbsp;登录地址：&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:TextBox ID="txtLoginUrl" Width="400" CssClass="g-ipt" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="line-height:40px;color:Gray;">
                                可以复制此地址通过QQ或者其它方式发给另外的同事。
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td height="40" valign="middle" style="color:Red;">
                                警告：凡是获得登录地址的用户在有效期限内都能以你的身份登录系统。
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
<script type="text/javascript">
    jQuery(function () {
        $(":text").prop("readOnly", true)

        $("#btnSel").click(function () {
            openpage('SysFolder/Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=hidUserId,txtUserName');
        });

        $(".Wdate").focus(function () {
            WdatePicker({ isShowClear: true, dateFmt: 'yyyy-MM-dd HH:mm' });
        });
        $("#txtLoginUrl").click(function () {
            $(this).select();
        });
    });

    function openCenter(url, name, width, height) {
        var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
        if (window.screen) {
            var ah = screen.availHeight - 30;
            var aw = screen.availWidth - 10;
            var xc = (aw - width) / 2;
            var yc = (ah - height) / 2;
            str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
            str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
        }
        return window.open(url, name, str);
    }

    function openpage(url) {
        openCenter(url, "_blank", 680, 500);
    }
</script>

