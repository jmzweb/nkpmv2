<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePass.aspx.cs" Inherits="EZ.Web.ChangePass" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>修改密码</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="Css/password.css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery.validate.min.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var t = $(".tip").text();
            if (t != "") $(".tip").show();

            jQuery.validator.addMethod("strongPass", function (value, element) {
                if ("<%=Strong %>" == "2") {
                    var strongRegex = new RegExp("^(?=.{<%=MinLen %>,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
                    return strongRegex.test(value)
                }
                else { 
                    return value.length >= parseInt(<%=MinLen %>);
                }

            }, "密码不符合要求");

            $(".Read").attr("readonly", true);
            var validator = $("#form1").validate({
                rules: {
                    txtOldPass: "required",
                    newPass: {
                        required: true
                    },
                    newPass: {
                        required: true,
                        strongPass: true
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

            $('#newPass').keyup(function () {
                var strongRegex = new RegExp("^(?=.{<%=MinLen %>,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
                var mediumRegex = new RegExp("^(?=.{<%=MinLen %>,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
                var enoughRegex = new RegExp("(?=.{6,}).*", "g");
                var len = "<%=MinLen %>";

                if (strongRegex.test($(this).val())) {
                    $('#level').removeClass('pw-weak');
                    $('#level').removeClass('pw-medium');
                    $('#level').removeClass('pw-strong');
                    $('#level').addClass(' pw-strong');
                    //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
                }
                else if (mediumRegex.test($(this).val())) {
                    $('#level').removeClass('pw-weak');
                    $('#level').removeClass('pw-medium');
                    $('#level').removeClass('pw-strong');
                    $('#level').addClass(' pw-medium');
                    //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
                }
                else {
                    $('#level').removeClass('pw-weak');
                    $('#level').removeClass('pw-medium');
                    $('#level').removeClass('pw-strong');
                    $('#level').addClass('pw-weak');
                    //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
                }
                return true;
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
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="width:640px;margin-left:auto;margin-right:auto;"><br /><br />
    <table class='defaultstyle' style="width:620px"  border="1"   align="center">
        <caption>修改密码</caption>
        <tbody>
          <tr>
            <td  width="160">当前密码</td>
            <td  >
                <asp:TextBox ID="txtOldPass" TextMode="Password" Width="300px" CssClass="TextBoxInChar" runat="server"></asp:TextBox></td>
          </tr>
          <tr>
            <td  >新密码</td>
            <td >
            <asp:TextBox ID="newPass" TextMode="Password" Width="300px" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
            <p style='clear:both;font-size:12px;line-height:260%;height:30px;text-align:left;'>密码要求由大小写字母、数字、符号混合组成，长度大于<%=MinLen %>
            </p>
                 <div id="level" class="pw-strength">           	
			        <div class="pw-bar"></div>
			        <div class="pw-bar-on"></div>
			        <div class="pw-txt">
			        <span>弱</span>
			        <span>中</span>
			        <span>强</span>
			        </div>
		        </div>
            </td>
          </tr>
            <tr>
            <td  >确认密码</td>
            <td ><asp:TextBox ID="newPass2" TextMode="Password" Width="300px" CssClass="TextBoxInChar" runat="server"></asp:TextBox></td>
          </tr>
        </tbody>
    </table>
    <table align="center" style="width:620px">
    <tr>
        <td align="center">
            <div class="tip" style="display:none;"><%=Msg %></div>
            <br />
        <asp:Button ID="Button1" runat="server" Text=" 保 存 " onclick="Button1_Click" />&nbsp;&nbsp;
        <input type="button" value=" 关 闭 "  onclick="winClose();"/>
        </td>
    </tr>
    </table>
</div>
    </form>
</body>
</html>
