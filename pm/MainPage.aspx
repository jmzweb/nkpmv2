<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="EZ.Web.MainPage" %>
<!DOCTYPE html>
<html>
<head>
    <title><%=MainTitle %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link type="text/css" href="static/js/bootstrap/css/bootstrap.css" rel="stylesheet"/>
    <link type="text/css" href="static/js/bootstrap/tag/bootstrap.tag.css" rel="stylesheet" />
    <link type="text/css" href="static/js/animate/animate.min.css" rel="stylesheet"/>
    <link type="text/css" href="static/theme/default/index.css?v=1" rel="stylesheet" />
    <link type="text/css" href="static/theme/default/other.css" rel="stylesheet" />
    <link type="text/css" href="css/toastr.css" rel="stylesheet" />
    <script type="text/javascript" src="static/js/common/puck.jquery_bootstrap.js"></script>
    <script type="text/javascript" src="static/js/mainpage/puck.t-os.other.js"></script>
    <script type="text/javascript" src="static/js/js_lang.js"></script>
    <script type="text/javascript" src="static/js/seajs/sea.js"></script>
    <script type="text/javascript">
        var gz_postfix = "";
        var static_server = "";

        var loginUser = { uid: "<%=base.EmployeeID %>", user_id: "<%=base.UserName %>", user_name: "<%=base.EmployeeName %>" };
        var monInterval = { online: 120, sms: 30 };
        var portalLoadArray =[]; // [{ id: "desktop", src: "", url: "desktop.aspx", title: "我的桌面", closable: false }];
        var themeArray = [];
        var func_array = {};
        var func_Tree = <%=func_Array %>
        
        //-- 一级菜单 --
        var first_array = ["00020", "00002", "00022", "00017", "00004", "00021", "00023", "00024", "00026", "b0", "y0"];

        //-- 一级菜单对应的字体图标 --
        var module2iconfont = {
            "00020": "&#xe653;","00002": "&#xe65a;","00022": "&#xe64c;","00004": "&#xe655;","00021": "&#xe612;",
            "00017": "&#xe611;","00023": "&#xe645;","00024": "&#xe64a;","00026": "&#xe649;","b0": "&#xe647;",
            "d0": "&#xe652;","dd": "&#xe646;","e0": "&#xe613;", "y0": "&#xe64b;","z0": "&#xe650;","default": "&#xe67a;"
        };

        //-- 系统消息提示条字体图标 --
        var msgTipIconfont = {
            "0": "&#xe65d;","1": "&#xe61e;","2": "&#xe619;","3": "&#xe64f;","4": "&#xe61a;","5": "&#xe616;",
            "6": "&#xe615;","7": "&#xe65a;", "8": "&#xe638;","9": "&#xe618;","10": "&#xe63a;",
            "11": "&#xe64d;","12": "&#xe61c;","13": "&#xe61d;","14": "&#xe65e;","15": "&#xe614;",
            "16": "&#xe638;","17": "&#xe65b;","24": "&#xe617;","message": "&#xe65c;", "default": ""
        };

        var second_array = [], third_array = [];
        //-- 互联网自定义 --
        func_array["extWebApp"] = [];
        //-- 个人收藏 --
        func_array["extFav"] = [];

        seajs.config({
            base: './static/js/',
            alias: {
                'underscore': 'backbone/underscore.js',
                'backbone': 'backbone/backbone.min.js',
                'menu-aim': 'jquery-1.10.2/jquery.menu-aim.js',
                'miniNotification': 'miniNotification.js',
                'tDesktop': 'mainpage/desktop.js'
            }
        });
        jQuery(function () {
            seajs.use(['tDesktop', 'backbone'], function (tDesktop) {
                var tDesktop = new tDesktop.TDesktop;
                window.tDesktop = tDesktop;
            });
            if($(".positem").length == 0)
                $(".gwswitch").hide();
            $(".gwswitch").click(function(){
                $(".poslist").toggle();
            });

        });


    </script>
    <style type="text/css">
        .tipnum{color:red;font-size:14px;font-weight:bold;}
        .dlgbox{background:white url(img/common/body_bg.gif) repeat-x;width:640px;height:360px;padding:5px 15px ;}
        .dlgbox ul{margin-left:15px;}
        .dlgbox li a{font-size:14px;line-height:1.8;}
        .wrap_body{overflow:auto;}
        .person-info-body a{padding:10px 35px;}
        #user_count{padding-left:3px;padding-right:3px;}
        #funcbar_right{position:absolute;right:10px;top:0px;line-height:30px;color:#0364ae;font-family:tahoma,arial,宋体,sans-serif;}
        .positem{display:block;text-align:left;margin-left:15px;}
    </style>
</head>

<body class="TOS">
    <form id="form1" runat="server" style="display:none;"></form>
    <div class="navwrapper" id="north">
        <div class="navbar pull-right" id="infobar">
            <ul class="infonav">
                <li class="navin" id="info_avater"><a class="nav-item iconfont" id="avatar" href="javascript:;"></a>
                    <div class="info-wrap">
                        <div class="person-info-header clearfix">
                            <div class="person-info-avator">
                                <img width="60" height="60" id="loginavatar" src="SysFolder/Common/SignImage.aspx?empId=<%=base.EmployeeID %>">
                            </div>
                            <div class="person-info-content">
                                <h6 class="person-info-name">
                                    <span><%=base.EmployeeName %></span>
                                    <div class="person-info-online">
                                        <i class="iconfont tip-1" id="online_flag"> </i>
                                    </div>
                                </h6>
                                <p class="person-info-detail">
                                    <span class="person-info-department"></span><span><%=PositionName %></span>
                                    <br /><a class="gwswitch" href='javascript:'>[切换岗位]</a>
                                </p>
                            </div>
                        </div>
                        <div class="person-info-header clearfix poslist" style="display:none;">
                            <%=sbPosList %>
                        </div>
                        <div class="person-info-body">
                            <a id="person_info" hidefocus="hidefocus" href="javascript:;">个人信息</a> 
                            <a id="change_pwd" hidefocus="hidefocus" href="javascript:;createTab('change_pwd','修改密码','ChangePass.aspx','');">修改密码</a>
                        </div>
                    </div>
                </li>
                <li class="navin"><a title="" class="nav-item iconfont" id="totaskbar" href="javascript:;"
                    data-original-title="流程发起" data-toggle="tooltip" data-placement="bottom"></a>
                </li>
				
                <li class="navin" id="info_switch">
                    <a title="系统切换" class="nav-item iconfont" href="javascript:">&#xe60a;</a>
                        <div class="info-wrap" id="m_switch">
                            <div id="d_switch"><%=sbSwitch %></div>
                        </div>                </li>
                <li class="navin"><a title="" class="nav-item iconfont" id="logout" href="javascript:;"
                    data-original-title="退出系统" data-toggle="tooltip" data-placement="bottom">&#xe666;</a>
                </li>
            </ul>
        </div>
        <div class="pull-left" id="logo">
            <a href="javascript:;">
                <img src="static/theme/default/images/logo_oa.png"/>
            </a>
        </div>
        <div class="pull-left" id="taskbar" >
            <div class="tabs-scroll scroll-left" id="tabs_left_scroll" style="display: none;" title='向左滚动'>
            </div>
            <div class="tabs-container" id="tabs_container" >
                <div class="selected" id="tabs_portal_desktop"><a class="tab" id="tabs_link_portal_desktop" hidefocus="hidefocus" href="javascript:;" closable="false" index="portal_desktop">我的桌面</a></div>
            </div>
            <div class="tabs-scroll scroll-right" id="tabs_right_scroll" style="display: none;" title='向右滚动'>
            </div>
        </div>
    </div>
    <div class="funcbar" id="funcbar">
        <div id="funcmenu_switcher">
            <i class="funcmenu_switcher"></i>
            <span id="menu_switcher">导航菜单</span>
        </div>
        <div id="funcbar_left">
            <div class="second-tabs-container" id="second_tabs_portal_desktop">
                <a title="文字桌面" class="second-tab-item active" hidefocus="hidefocus" action="Home.aspx" secondtabid="portal_desktop"><span>文字桌面</span></a>
                <a title="图标桌面" class="second-tab-item" hidefocus="hidefocus" action="Desktop.aspx" secondtabid="portal_desktop"><span>图标桌面</span></a>
            </div>
        </div>
        <div id="funcbar_right">
            	<a href="javascript:" onclick="show_online()">在线<span id="user_count" class="tipnum"></span>人</a>&nbsp;
                |&nbsp;<a href="javascript:show_todo();" hidefocus='true' style='outline:none;'><span id="todo_count"></span> 待办(<span id="todo_num" class="tipnum"></span>)</a> 
                |&nbsp;<a href="javascript:show_mail();" hidefocus='true' style='outline:none;' title="未读邮件"><span id="mail_count"></span> 邮件(<span id="mail_num" class="tipnum"></span>)</a>
                |&nbsp;<a href="javascript:show_msg();" hidefocus='true' style='outline:none;' title="未读消息"><span id="sms_count"></span> 短消息(<span id="sms_num" class="tipnum"></span>)</a> 
                |&nbsp;<a href="javascript:show_switch();" hidefocus='true' style='outline:none;'><%=AdminOrgName %></a> 
        </div>
    </div>
    <div class="west" id="west" style="bottom: 0px;">
        <div class="west-body">
            <div class="menu-scroll scroll-up" style="display: block;"></div>
            <ul class="first-menu" id="first_menu" style="height: 517px;"></ul>
            <div class="menu-scroll scroll-down" style="display: block;"></div>
        </div>
        <div class="west-footer">
            <ul class="ft-links clearfix">
                <li class="ft-link ft-link-icon"><a title="" class="iconfont" onclick="createTab('portal_desktop','我的桌面','desktop.aspx','');"
                    href="javascript:;" data-original-title="我的桌面" data-toggle="tooltip" data-placement="top">
                    </a></li>
                <li class="ft-link ft-link-icon"><a title="" class="iconfont" hidefocus="hidefocus"
                    href="javascript:" data-original-title="在线帮助" data-toggle="tooltip"
                    data-placement="top"></a></li>
                <li class="ft-link"><a class="west-handle" href="javascript:;"><i title="" class="iconfont left_arrow"
                    data-original-title="图标+文字模式" data-toggle="tooltip" data-placement="top"></i><i
                        title="" class="iconfont right_arrow" data-original-title="图标模式" data-toggle="tooltip"
                        data-placement="top"></i></a></li>
            </ul>
        </div>
    </div>
    <div class="center" id="center" style="bottom: 0px;">
        <div class="tabs-panel selected animated" id="tabs_portal_desktop_panel" style="height: 100%;">
            <iframe name="tabs_portal_desktop_iframe" id="tabs_portal_desktop_iframe" src="home.aspx" border="0" frameborder="0" framespacing="0" marginwidth="0" marginheight="0" style="width: 100%; height: 100%;" allowtransparency="true" onloadx="IframeLoaded('portal_desktop');"></iframe>
        </div>
    </div>
    <ul class="msg-list" style="bottom: 1200px;">
        <div id="msg-ignore"><i class="iconfont"></i><span>忽略全部</span></div>
    </ul>
    <div class="east" id="east" style="bottom: 0px;">
        <ul class="nav nav-tabs">
            <li class="nav-pill active" paneltype="today"><a class="pill-bg" href="javascript:;">今日</a></li>
            <li class="nav-pill" paneltype="msg"><a class="pill-bg" href="javascript:;">消息</a></li>
            <li class="nav-pill" paneltype="org"><a class="pill-bg" href="javascript:;">组织</a></li>
        </ul>
        <div class="tab-content" id="east-tab" style="top:55px;">
            <div class="tab-pane pane-today active">
                <div class="dateArea" id="datetime">
                    <div title='<%=DateTime.Today.ToString("yyyy年M月d日") %>' class="weather-date" id="date">
                        <span><%=DateTime.Today.ToString("M月d日") %></span><%=GetWeek() %></div>
                    <div id="mdate"><%=GetChinaDay() %></div>
                </div>
                <div class="mod">
                    <div class="mod-hd">
                        <span class="mod-hd-title">最近7天日程</span></div>
                    <div class="mod-bd">
                        <ul class="calendar-list" id="cal_list">
                        </ul>
                        <div class="notip" id="caltip">
                            最近7天暂无安排</div>
                    </div>
                </div>
                <div class="mod">
                    <div class="mod-hd">
                        <span class="mod-hd-title">提醒事项</span></div>
                    <div class="mod-bd">
                        <ul class="remind_list" id="remind_list">
                        </ul>
                        <div class="notip" id="remindtip" style="display: block;">
                            今日暂无提醒</div>
                    </div>
                </div>
            </div>
            <div class="tab-pane pane-msg">
                <div class="msg-panel active" id="nocbox" style="top:5px;">
                    <div class="noc" id="new_noc_panel">
                        <div class="nocbox_tips" id="nocbox_tips" style="display: none;">
                            <div class="loading">
                            </div>
                        </div>
                        <div class="nodata_tips" id="nodata_tips" style="display: block;">
                            <div>
                                没有未读的系统消息<a class="tohistory" id="tohistory" hidefocus="hidefocus" href="javascript:;">查看历史消息</a>
                            </div>
                        </div>
                        <div class="noc-info" id="new_noc_title">
                            共<span class="noc_item_num" id="noc_item_num">0</span>条消息记录</div>
                        <div class="new_noc_list" id="new_noc_list">
                        </div>
                        <div class="noc-nav-bar" style="display: none;">
                            <a class="viewbtn" id="ViewAllNoc" hidefocus="hidefocus" href="javascript:;">
                                <i class="iconfont"></i>全部已阅</a>
                            <a class="noc-right" id="check_remind_histroy" hidefocus="hidefocus" href="javascript:;">
                                <i class="iconfont"></i>历史消息</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane pane-org">
                <div class="btn-group org_tool" id="org_tool" style="display:none;">
                    <button class="btn btn-mini online-btn btn-primary" type="button" user-type="user_online">
                        <span>在线</span><span class="user_online"></span></button>
                    <button class="btn btn-mini online-btn" type="button" user-type="user_all">
                        <span>全部</span></button>
                </div>
                <div class="org-panel" id="org_panel" style="top:0px;">
                    <div class="online-panel" id="user_online" style="display:none;">
                        <div id="orgTree0">
                            <iframe id="orgTree0_iframe" src="#"
                                border="0" frameborder="0" framespacing="0" marginwidth="0" marginheight="0"
                                style="width: 100%; height: 98%;" allowtransparency="true"></iframe>
                        </div>
                    </div>
                    <div class="online-panel" id="user_all" style="display:block;">
                        <div id="orgTree1">
                           <iframe id="orgTree1_iframe" src=""
                                border="0" frameborder="0" framespacing="0" marginwidth="0" marginheight="0"
                                style="width: 100%; height: 98%;" allowtransparency="true"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="east-handle" href="javascript:;"><i class="iconfont left_arrow"></i></a>
    </div>
    <!-- 激光加载条(pulse bar) -->
    <div class="done" id="progressBar" style="width: 60%;">
        <span id="flashBar"></span>
    </div>
    <!-- 消息(Message) -->
    <div id="mini-notification"></div>
    <!-- 主题切换 -->
    <div class="over-mask-layer" id="theme_panel">
        <div class="center">
            <div class="theme clearfix" id="theme_slider">
            </div>
        </div>
    </div>
    <div id="overlay_theme"></div>
    <script id="menuTmpl" type="text/x-jquery-tmpl">
    <li data-submenu-id="second-menu-${menuId}">
	    <div id="m${menuId}" hidefocus="hidefocus" class="first-menu-item" onclick="${actionFun}"><i class="iconfont">${iconfont}</i><span class="first-menu-title">${menuText}</span></div>
	    <div id="second-menu-${menuId}" class="second-panel">
		    <h4>${menuText}</h4>
		    <ul id="second-menulist-${menuId}" class="second-menu">  
		    </ul>
	    </div>
    </li> 
    </script>
    <!--二级菜单-->
    <script id="secondMenuTmpl" type="text/x-jquery-tmpl">
    <li class="{{if expand !=false }}expand{{/if}}"><a id="${menuId}" class="second-menu-item" href="javascript:;" onclick="${actionType}" hidefocus="hidefocus" title="${menuText}">
    {{if expand !=true }}<span class='{{if favorite }}menu-star2{{else}}menu-star1{{/if}}' title='点击收藏' onclick="menuSave('${menuId}');">&nbsp;&nbsp;</span>{{/if}}
    ${menuText}</a>{{if expand !=false }}<ul id="third-menulist-${menuId}" class="third-menu"></ul>{{/if}}</li>
    </script>
    <!--三级菜单-->
    <script id="thirdMenuTmpl" type="text/x-jquery-tmpl">
    <li><a id="${menuId}" class="third-menu-item" href="javascript:;" onclick="${actionType}" hidefocus="hidefocus" title="${menuText}">
    <span class='{{if favorite }}menu-star2{{else}}menu-star1{{/if}}' title='点击收藏' onclick="menuSave('${menuId}');">&nbsp;&nbsp;</span>
    ${menuText}</a></li>
    </script>
    <!--系统消息提示条-->
    <script id="item-template" type="text/template"></script>

    <!--日程-->
    <script id="calendar-template" type="text/template">
    <li><a href="javascript:;" cal_id="${id}" cal_type="${type}" class="common-font"><span class="cal_content">{{html formatCalendarTitle(title) }}</span><span class="pull-right">${shortstart}</span></a></li>
    </script>
    <!--提醒事项-->
    <script id="reminder-template" type="text/template">
    <li><a href="javascript:;" data_id="${id}" class="common-font"><span class="cal_content">${title}</span><span class="pull-right">${appoint_time}</span></a></li>
    </script>
    <!--事务提醒模块-->
    <script id="noc-template" type="text/template">
    <div class="noc_item noc_item_${type_id}">
        <div class="noc_item_title" title="展开/收缩">
            <a href="javascript:;" class="noc_item_read pull-right" type_id="${type_id}" title='查看全部'><i class="iconfont">&#xe609;</i></a>
            <a href="javascript:;" class="noc_item_cancel pull-right" type_id="${type_id}" title='全部已阅'><i class="iconfont">&#xe640;</i></a>
            <span>${type_name}</span>
        </div>
        <ul class="noc_item_data">
        </ul>
    </div>
    </script>
    <!--事务提醒条目-->
    <script id="nocitem-template" type="text/template">
    <li id="noc_li_${sms_id}" sms_id="${sms_id}" url="${url}" type_id="${type_id}" class="">
        <a href="javascript:;" class="noc-subitem">
            <p class="noc_item_info">
                <span class="noc_item_time pull-right ">${send_time}</span>
                <span class="name">${from_name}</span>
            </p>
            <p class="noc_item_content">{{html content }}</p>
        </a>
    </li>
    </script>
    <div id="overlay">
    </div>
</body>
<!--一级菜单-->
</html>
<script type="text/javascript" src="js/jquery.toastr.js"></script>
<script type="text/javascript" src="js/layer/3.0.2/layer.js"></script>
<script type="text/javascript">
    var _mainPage = EZ.Web.MainPage;
    function show_online(){
        window.createTab('onLine', "在线人员", "online.aspx", false);
    }
    function show_msg(){
        window.createTab('viewMsg', "系统消息", "Workasp/msg/msgFrame.aspx", false);
    }
    function show_todo(){
        window.createTab('todoList', "我的待办", "Sysfolder/workflow/flowtodo.aspx", false);
    }
    function show_mail(){
        window.createTab('viewMail', "内部邮件", "mail/mailFrame.aspx?read=0", false);
    }
    function show_switch(){
        var url="OrgSwitch.aspx?page=MainPage";
        var layIndex = layer.open({
	        type: 2,
	        title: '切换组织',
	        area: ['640px', '520px'],
	        content: url
	    });
    }
    if('<%=showOrg %>'=='1'){
        show_switch();
    }

    //刷新在线人数
    var maxtest = 0;
    var msgFlag = "";
    function updateol() {
        jQuery.ajax({
            type: "get",
            url: 'getMsg.ashx?_r='+Math.random(),
            dataType: "html",
            success: function (result) {
                var ret = eval("(" + result + ")");

                $("#user_count").html(ret.online);
                $("#todo_num").html(ret.todo.num);
                $("#sms_num").html(ret.msg.num);
                $("#mail_num").html(ret.mail.num);
                

                var count = ret.msg.num + ret.todo.num + ret.mail.num;
                if (count > 0) {
                    if (ret.msg.rows.length > 0) {
                        for (var i = 0; i < ret.msg.rows.length; i++) {
                            var dr = ret.msg.rows[i];
                            if(!toastr.push(dr.id)) continue;
                            var html = "<div onclick=\"javascript:tipClick(1,'"+dr.id+"');\">"+ dr.title + "</div>";
                            toastr.success(html);
                        }
                    }
                    if (ret.todo.rows.length > 0) {
                        for (var i = 0; i < ret.todo.rows.length; i++) {
                            var dr = ret.todo.rows[i];
                            if(!toastr.push(dr.id)) continue;
                            var html = "<div onclick=\"javascript:tipClick(2,'"+dr.id+"');\">"+ dr.title + "</div>";
                            toastr.success(html);
                        }
                    }
                    if (ret.mail.rows.length > 0) {
                        var arrHtml = [];
                        for (var i = 0; i < ret.mail.rows.length; i++) {
                            var dr = ret.mail.rows[i];
                            if(!toastr.push(dr.id)) continue;

                            var html = "<div onclick=\"javascript:tipClick(3,'"+dr.id+"');\">"+ dr.title + "</div>";
                            toastr.success(html);
                        }
                    }
                    
                }

                window.setTimeout("updateol()", 1000 * <%=refreshInterval %>); 

            }
        });


    }
    updateol();

    toastr.options ={
        timeOut: 600000 ,
        closeButton: true ,
        positionClass: "toast-bottom-right",
        onclick: function(){}
    };

    function tipClick(t,itemId){
        if(t==1)
            window.open("Workasp/msg/msgRead.aspx?msgId=" + itemId,"_blank");
        else if(t==2)
            window.open("SysFolder/Workflow/Dealflow.aspx?taskId=" + itemId,"_blank");
        else if(t==3)
            window.open("Mail/MailRead.aspx?mailId=" + itemId,"_blank");
    }
</script>
