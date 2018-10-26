<%@ Page Language="C#" AutoEventWireup="true" Inherits="EIS.Web.MainPage" %>

<!DOCTYPE html>
<html>
<head>
    <title><%=MainTitle %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link href="Static/mainpm/iconfont/iconfont.css" rel="stylesheet" />
    <link href="Static/mainpm/mainpm.css" rel="stylesheet" />
    <script type="text/javascript">  
        var func_Tree = <%=func_Array %>; 
    </script>
    <script src="Js/jquery-1.8.0.min.js"></script>
    <script src="Static/mainpm/echarts.min.js"></script>
    <script src="Static/mainpm/echarts-henan.js"></script>
    <script src="Static/mainpm/mainpm.js"></script>
</head>
<body>
    <div class="hidetips"><i class="iconfont">&#xe6a2;</i><span></span></div>
    <div class="ad-left">
        <div class="ad-menus">
        </div>
    </div>
    <div class="ad-top">
        <img src="Static/mainpm/img/nklogo.png"  class="ad-logo" /> 
        <a class="ad-togglemenus" title="显示/隐藏菜单"><i class="iconfont">&#xe61d;</i></a>
        <a class="show-report show-aditem1" title="显示桌面"><i class="iconfont">&#xe609;</i></a>
        <a class="ad-search"><i class="iconfont">&#xe62d;</i></a>
        <input type="text" id="searchmenus" placeholder="请输入搜索内容" />
        <div class="ad-myinfo">
            <img id="logo" src="static/images/avatar/<%=sex=="女"?"1":"0" %>.gif" />
            <span id="nickname"><%=base.EmployeeName %></span>
            <a title="个人信息"><i class="iconfont">&#xe6cd;</i></a>
            <a title="修改密码"><i class="iconfont">&#xe62f;</i></a>
            <a href="MainPage.aspx" title="切换旧版"><i class="iconfont">&#xe688;</i></a>
            <a href="index.html" title="安全退出"><i class="iconfont">&#xe627;</i></a>
        </div>
    </div>
    <div class="ad-right">
        <div class="ad-iframe aditem2" style="display: none;">
            <iframe id="mainiframe" width="100%" height="100%" allowtransparency="true" frameborder="0"></iframe>
        </div> 
        <div class="aditem1">
            <div class="focusbtns">
                <a class="focusprev"><i class="iconfont">&#xe71b;</i></a>
                <a class="focusnext"><i class="iconfont">&#xe71a;</i></a>
            </div>
            <div class="focusbox">
                <div class="ad-report">
                    <div class="echartbox">
                        <div class="echarts">
                            <div id="main" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main1" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main2" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main3" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main4" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main5" style="width: 100%; height: 100%;"></div>
                        </div>
                    </div>
                </div>
                <div class="ad-report">
                    <div class="echartbox">
                        <div class="echarts">
                            <div id="main10" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main11" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main12" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main13" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main14" style="width: 100%; height: 100%;"></div>
                        </div>
                        <div class="echarts">
                            <div id="main15" style="width: 100%; height: 100%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
