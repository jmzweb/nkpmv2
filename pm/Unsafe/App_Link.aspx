<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="App_Link.aspx.cs" Inherits="EIS.Web.Unsafe.App_Link" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>移动办公客户端下载</title>
    <script src="../Js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="AppLink/header.js" type="text/javascript"></script>
    <style type="text/css">
        body, dl, dd, h1, h2, h3, h4, h5, h6, p, form {margin:0;}
        ul,ol {margin:0; padding:0;}
        table, td, th { border-collapse:collapse; }
        ol,ul, li { list-style:none;}
        li{float: left;}
        h1, h2, h3, h4 { font-size:100%; }
        img, input, textarea { vertical-align: middle; border:0; }
        a { text-decoration:none; color:#323232; outline:none; }
        a:hover { text-decoration:underline;}
        .b{font-weight: bold;}
        html{height:100%;overflow:hidden;}
        body{font: 12px "微软雅黑",Verdana,SimHei,"Microsoft JhengHei",Tahoma;color: #666;position: relative;overflow-y:scroll; 
             background:url(appLink/Img/xy.png);height:100%;
             }
        /*fontsize*/
        .f12{font-size:12px;} .f13{font-size:13px;} .f14{font-size:14px;} .f16{font-size:16px;} .f18{font-size:18px;} .f20{font-size:20px;} .f24{font-size:24px;}
        /*color*/
        .gray{color:#9D9FA2; /* 灰色 */} .dimgray{color:#666; /* 深灰色 */} .dimgreen{color:#58724E;/* 墨绿 */} .green{color:#51AA36;/* 亮绿 */}
        .blue{color:#5597BD; /* 天蓝 */} .green2{color: #228305; /*略深绿*/}
        #logo{width: 250px;height: 61px;background:url(appLink/Img/Logo.png) no-repeat;float: left;}
        .header{height:81px;background: url(appLink/Img/top.jpg) no-repeat center top;position: relative;z-index: 9}
        .header .nav{width: 980px;margin: 0 auto;height: 70px;padding-top: 10px;}
        .header .nav .lava_lamp{margin-left:340px;float: left;font-size: 16px;line-height: 65px;position: relative;}
        .header .nav .lava_lamp a{color:#D6E1EA;padding:0 12px;height: 66px;display: block;_display:defalut;}
        .header .nav .lava_lamp li{float: left;padding:0 10px;margin: 0 -10px;height: 66px;}
        .header .nav .lava_lamp li.current a{font-size:16px;color: #67E735;}
        .header .nav .lava_lamp a:hover{color: #67E735;text-decoration:none;}
        .header .nav .nav-line {position: absolute;border-bottom: 5px #67E735 solid;height: 0;overflow: hidden;left: 0;bottom: -5px;}
        .main{width: 980px;margin-left:auto;margin-right:auto;margin-bottom:20;padding:0px 0px 30px 0px;background:#fafafa;}
        .itemTitle{padding-left:20px;font-family:"微软雅黑", Verdana, SimHei, "Microsoft JhengHei", Tahoma;line-height:50px;font-size:20px;
                   border-bottom:1px solid gray;
                   background-color:#f0f1f3;
                   }
        .itemBody{padding-left:20px;}
        .item{font-size:16px;line-height:300%;}
        .link1{background:url(appLink/Img/down.png) ;display:block;width:220px;height:70px;}
        .phoneNo{border:1px solid gray;width:200px;font-size:16px;height:30px;color:#444;line-height:30px;font-weight:bold;margin-right:10px;margin-top:0px;}
        .btnPhone{line-height:30px;height:34px;vertical-align:middle;font-weight:bold;color:#666;}
        .phoneNoTip{color:Red;font-weight:bold;padding-left:10px;display:none;}
        .sendInfo{padding-left:10px;font-weight:bold;color:Green;display:none;}
    </style>
</head>
<body>
    <div class="header">
	<div class="nav">
		<a id="logo" href="#"></a>
		<ul class="lava_lamp">
		<li class="current" id="nav1"><a href="#">下载安装</a></li>
		<li ><a href="http://mo.wps.cn/" target="_self">WPS Office安卓版</a></li>
		<li ><a href="javascript:window.history.go(-1);">返 回 >></a></li>
        <div class="nav-line"></div>
		</ul>
	</div>

    </div>
    <div class="main">
        <div class="itemTitle">
            <h3>安卓（Android）版本下载</h3>
        </div>
        <div class="itemBody">
            <div class="item">
                1、先下载到电脑，再通过数据线安装
                <a href="<%=appUrl %>" class="link1"></a>
            </div>
            <div class="item">
                2、用微信或者二维码应用软件扫描即可下载。<br/>
                <img src="../QRCode.axd?v=6&s=3" style="margin:10px;border:4px solid white;border-radius:3px;box-shadow:2px 2px 2px;" alt="下载地址" />
            </div>
            <div class="item">
                3、用手机访问 <span style="color:#5597bd;"><%=appUrl %></span> ，直接下载安装
            </div>
            <div class="item">
                4、通过手机短信，发送一条带有链接的免费短信到您手机上，点击即可下载
                <div style="padding-left:10px;vertical-align:middle;">
                    <input class="phoneNo" type="text" /><button class="btnPhone" type="button" disabled="disabled">发送到手机<span style='color:Red;'>（暂不可用）</span></button>
                    <span style="color:Gray;font-size:10pt;">（预计1分钟之内可以发送到手机）</span>
                </div>
                <div class="phoneNoTip">
                    请输入正确的手机号码!
                </div>
            </div>
            <div class="item">
                注意：安装后首次打程序，需要在登录界面【服务编号】输入<b style="color:Red;"><%=enterCode %></b> ，如下图。<br/>
                <img style="margin:10px 20px;" alt="iPhone1" src="AppLink/Img/Android.png"/>
            </div>
            <br />
            <br />
        </div>
        <div class="itemTitle">
            <h3>苹果（iPhone）版本下载</h3>        
        </div>
        <div class="itemBody">
            <div class="item">
                1、直接在AppStore搜索“e云协同办公”下载即可。
            </div>
            <div class="item">
                2、用二维码软件扫描下方的二维码下载。<br/>
                <img style="margin:10px;border:4px solid white;border-radius:3px;box-shadow:2px 2px 2px;" alt="下载地址" src="AppLink/Img/iPhoneUrl.jpg"/>
            </div>
            <div class="item">
                注意：安装后首次打开程序，需要在登录界面【服务编号】，输入<b style="color:Red;"><%=enterCode %></b> 。
            </div>
        </div>
    </div>
    <form id="form1"  runat="server">
    </form>
</body>
</html>
<script type="text/javascript">
    jQuery(function () {
        $(".btnPhone").click(function () {
            var key = $(".phoneNo").val();
            if (key.length < 10) {
                $(".phoneNoTip").show();
            }
            else {
                $(".phoneNoTip").hide();

                $.ajax({
                    type: "post",
                    url: "app_Sms.aspx",
                    data: { "phoneNo": key },
                    dataType: "html",
                    error: function (result) {
                        alert("发送短信时出错");                        
                    },
                    success: function (result) {
                        alert("短信已经发出，请耐心等待");                    
                    }
                });
            }
        });
    });
</script>