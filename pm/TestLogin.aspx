<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestLogin.aspx.cs" Inherits="EIS.Web.TestLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>测试帐号登录</title>
    <meta http-equiv="refresh" content="300"/>
    <style type="text/css">
        body{
            background:white url(img/common/body_bg.gif) repeat-x;
        }
        h3{color:#444;padding-left:20px;background:transparent url(img/common/site.png) no-repeat;border-bottom:2px solid #add8e6;}
        #mainZone{padding:20px 40px;}
        a.linkUser{font-size:14px;}
        a{color:Blue;padding-right:15px;text-decoration:none;}
        a:hover{color:Red;}
        .tip{border:dotted 1px orange;background:#F9FB91;text-align:left;padding:5px;margin-top:30px;font-size:12px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="mainZone">
        <%=sbList %>
        <div class="tip">
            说&nbsp;明：本功能只有在测试环境才能使用；&nbsp;&nbsp;本页面有效期 5 分钟，过期之后自动刷新。
        </div>
    </div>
    </form>
</body>
</html>
