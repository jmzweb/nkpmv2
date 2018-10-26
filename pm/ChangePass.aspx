<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePass.aspx.cs" Inherits="EZ.Web.ChangePass" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改密码</title>
    <meta http-equiv="Pragma" content="no-cache" />

    <!-- <link rel="stylesheet" type="text/css" href="Css/password.css" /> -->
    <link type="text/css" rel="stylesheet" href="Css/appInput2.css" />
    <link type="text/css" rel="stylesheet" href="Css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" href="Editor/kindeditor-4.1.11/themes/default/default.css" />

    <script language="javascript" type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery.validate.min.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            jQuery.validator.addMethod("strongPass", function (value, element) {
                var strongRegex = new RegExp("^(?=.{6,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*\\W).*$", "g");
                if (strongRegex.test(value)) {
                    return true;
                }
                return false;

            }, "密码不符合要求");

            $(".Read").attr("readonly", true);
            var validator = $("#form1").validate({
                rules: {
                    txtOldPass: "required",
                    newPass: {
                        required: true
                    },
                    newPass: {
                        required: true//,
                        //strongPass:true
                    },
                    newPass2: {
                        required: true,
                        equalTo: "#newPass"
                    }
                }
            });
            $("#Button1").click(function () {
                return $("#form1").valid();
            });
        });
         function afterChg(){
            alert('密码修改成功!');
            winClose();
        }
        function winClose() {
            if (window.top!=window.self) {
                try { window.top.closeTab('change_pwd') } catch (e) { }
            }
            else {
                window.close();
            }
        }
    </script>
    <style type="text/css">
         #btnSave { line-height: 48px;height:50px;border:none; padding: 0px 0px 0 20px; text-decoration: none; display: inline-block; color: #000; font-size: 14px; } 
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <asp:Button ID="btnSave" runat="server" Text="保 存" OnClick="Button1_Click" CssClass="linkbtn" />
                </span>
            </div>
        </div>
        <div id="maindiv"> 
            <table class='normaltbl' border="0" style='width: 52%' align="center">
                <caption>修改密码</caption>
                <tbody>
                    <tr>
                        <td>当前密码：</td>
                        <td>
                            <asp:TextBox ID="txtOldPass" TextMode="Password" CssClass="TextBoxInChar" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>新密码：</td>
                        <td>
                            <asp:TextBox ID="newPass" TextMode="Password" CssClass="TextBoxInChar" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td>
                            <asp:TextBox ID="newPass2" TextMode="Password" CssClass="TextBoxInChar" runat="server"></asp:TextBox></td>
                    </tr>
                </tbody>
            </table>

        </div>
    </form>
</body>
</html>
