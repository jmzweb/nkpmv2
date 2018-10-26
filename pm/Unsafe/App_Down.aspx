<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="App_Link.aspx.cs" Inherits="EIS.Web.Unsafe.App_Link" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>移动办公客户端下载</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="../Js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        html{height:100%;overflow:hidden;}
        body{margin:0px;padding:0px;background:#4e5456;}
        .main{margin-left:auto;margin-right:auto;margin:0px;padding:0px;}
        .div_bg {text-align: center;position: relative;}
        .show-img {
	        max-width: 100%;
	        height: auto;
        }
    </style>

    <script type="text/javascript">
        function is_weixin() {
            var ua = navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == "micromessenger") {
                return true;
            } else {
                return false;
            }
        }

        function loadimg() {
            if (is_weixin()) {
                
                $("#android_bg").html('<img class="show-img" src="AppLink/img/android_down.png">');
            }
            else {
                $("#android_bg").html('<p>正在飞速下载中 ,请您稍等片刻。。。</p>');
                window.location = "<%=appUrl %>";
            }
        }
        $(function () {
            loadimg();
        });

    </script>
</head>
<body>
    <div class="main">
        <div class="div_bg" id="android_bg">
		</div>
    </div>
</body>
</html>
