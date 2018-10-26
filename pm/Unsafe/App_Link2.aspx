<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="App_Link.aspx.cs" Inherits="EIS.Web.Unsafe.App_Link" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>移动办公客户端下载</title>
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
    <div class="main">
        <div class="itemTitle">
            <h3>安卓（Android）版本下载</h3>
        </div>
        <div class="itemBody">
            <div class="item">
                1、先下载到电脑，再通过数据线安装
                <a href="<%=appUrl %>" class="link1" target="_blank"></a>
            </div>
        </div>
    </div>
    <form id="form1"  runat="server">
    </form>
</body>
</html>
