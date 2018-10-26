<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BizFrame.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.BizFrame" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <link href="css/bizframe.css" rel="stylesheet" />
    <script src="js/bizframe.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.sidebar').find('li').click(function () {
                $(this).addClass('sidebar-current').siblings().removeClass('sidebar-current');
                $("#tabs_iframe").attr("src", $(this).find('a').attr("href"));
            });
            $("#tabs_iframe").attr("src", $('.sidebar a').attr("href"));//默认打开第一个
        });
        $(function () {
            var CompanyCode = '<%=UserInfo.CompanyCode%>';
            switch (CompanyCode) {
                case "1009":
                    $(".main-area .sidebar li.gql").hide();
                    $(".main-area .sidebar li.tzjl a").text("担保记录");
                    break;
                case "1010":
                    $(".main-area .sidebar li.gql").hide();
                    $(".main-area .sidebar li.tzjl a").text("担保记录");
                    break;
                case "1006":
                    $(".main-area .sidebar li.gql").hide();
                    $(".main-area .sidebar li.tzjl a").text("租赁记录");
                    break;
                default:
                    $(".main-area .sidebar li.dbl").hide();
                    $(".main-area .sidebar li.zll").hide();
                    break;
            };
        });
    </script>
    <title></title>
</head>
<body>
    <a class='closebtn' href="javascript:" onclick="_appClose();">关闭</a>
    <div class="main-area ui-v5">
        <div id="new-sidebar" class="bcc-sidebar-box new-sidebar-box">
            <div class="sidebar-wrap sidebar-wrap-l1">
                <ul class="sidebar submenu">
                    <%=render(dt,"<li class='menu-item menu-item-common #DesktopImage#'><a href='" + ResolveUrl("~") + "#LinkFile#&hideclose=1' target='tabs_iframe'>#FunName#</a></li>") %>
                </ul>
            </div>
        </div>
        <div id="main" class="ui-v5">
            <div class="bcc-instance bcc-main-wrap main-wrap-new">
                <div class="content-wrap">
                    <iframe id="tabs_iframe" name="tabs_iframe" allowtransparency="true" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" style="width: 100%; height: 100%;"></iframe>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
