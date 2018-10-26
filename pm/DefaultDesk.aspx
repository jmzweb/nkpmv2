<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultMain.aspx.cs" Inherits="EIS.Web.DefaultMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" class="off">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title><%=MainTitle %></title>
    <link rel="alternate stylesheet" type="text/css" href="css/zxxboxv3.css" media="screen" />
    <link href="Theme/Default/css/reset2.css" rel="stylesheet" type="text/css" />
    <link href="Theme/Default/css/zh-cn-system2.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.7.min.js"></script>
    <link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="js/jquery.ztree.all-3.4.min.js"></script>

    <script language="javascript" type="text/javascript" src="Theme/Default/js/styleswitch.js"></script>
    <link rel="stylesheet" type="text/css" href="Theme/Default/css/style/zh-cn-styles1.css" title="styles1" media="screen" />
    <link rel="alternate stylesheet" type="text/css" href="Theme/Default/css/style/zh-cn-styles2.css" title="styles2" media="screen" />
    <link rel="alternate stylesheet" type="text/css" href="Theme/Default/css/style/zh-cn-styles3.css" title="styles3" media="screen" />
    <link rel="alternate stylesheet" type="text/css" href="Theme/Default/css/style/zh-cn-styles4.css" title="styles4" media="screen" />

    <link rel="stylesheet" type="text/css" href="css/smartMenu.css" />
    <script language="javascript" type="text/javascript" src="js/jquery.zxxbox.3.0-min.js"></script>
        <%=customScript%>
        <script type="text/javascript">var pc_hash = 'QGXBYD'</script>
        <style type="text/css"> 
        .objbody{overflow:hidden;}
        .tipnum{color:red;font-size:14px;font-weight:bold;}
        .switchpos{color:White;text-decoration:none;text-align:center;font-weight:bolder;}
        .switchpos:hover{color:blue;text-decoration:none;background:white;}
        #linkSwitchDesk{color:Blue;}
        .ztree li.level0>span.button{*margin-left:-16px;}
    </style>
</head>
<body scroll="no" class="objbody">
 <form id="form1" runat="server"></form>
<div class="header">
	<div class="logo lf">
        <a href="#" ><span class="invisible">OA协同办公系统</span></a>
    </div>
    <div class="rt-col">
    	<div class="tab_style white cut_line text-r">
        <a href="javascript:;" onclick="show_changepwd()"><img alt="修改密码" src="Theme/Default/images/lock.png"/> 修改密码</a><span>|</span>
        <a href="desktop.aspx?pwbs=switch" target="rightMain">切换系统</a><span>|</span>
        <a href="javascript:" >问题反馈</a><span>|</span>
        <a href="javascript:" >帮助？</a>
        <ul id="Skin">
		    <li class="s1 styleswitch" rel="styles1"></li>
		    <li class="s2 styleswitch" rel="styles2"></li>
		    <li class="s3 styleswitch" rel="styles3"></li>
            <li class="s4 styleswitch" rel="styles4"></li>
	    </ul>
        </div>
    </div>
    <div class="col-auto">
    	<div class="log white cut_line">您好！<%=base.EmployeeName %> [<%=PositionName %> 
        <a class="switchpos" title="切换岗位" href="javascript:;">&nbsp;▼&nbsp;</a>]
        <span>|</span><a href="Default.aspx?logout=1">[退出]</a>
    	</div>
        <div class="topMenuPanel" style="float:left;top:10px;position:relative;overflow:hidden;">
            <ul class="nav white" id="top_menu" style="left:0px;float:left;bottom:-1px;">
                <%=mainMenu %>
            </ul>
            <div style="clear: both"></div>
        </div>
        <div id="horScroll" style="width:70px;border:0px solid red;float:left;position:relative;top:13px;cursor:hand;text-align:center;">
            <a id="btnleft" title="向左" style="display:inline-block;width:27px;height:28px;outline-width:medium;outline-style:none;outline-color:invert;background:transparent url(img/common/scroll.png);"></a>
            &nbsp;
            <a id="btnright" title="向右" style="display:inline-block;width:27px;height:28px;outline-width:medium;outline-style:none;outline-color:invert;background:transparent url(img/common/scroll.png) top right;"></a>
        </div>
        
    </div>
</div>

<div id="content">
	<div class="col-left left_menu">
    	<div id="Scroll"><div id="leftMain" class="ztree"></div></div>
        <a href="javascript:;" id="openClose" style="outline-style: none; outline-color: invert; outline-width: medium;" hideFocus="hidefocus" class="open" title="展开与关闭"><span class="hidden">展开</span></a>
    </div>
    <div class="col-auto mr8">
        <div class="crumbs">
            <div class="shortcut cu-span">
	            <a href="javascript:" onclick="show_online()">共有<span id="user_count" class="tipnum"></span>人在线</a>&nbsp;&nbsp;
                |<a href="javascript:show_todo();" hidefocus='true' style='outline:none;'><span id="todo_count"></span> 待办(<span class="tipnum" id="todo_num"></span>)</a> 
                |<a href="javascript:show_msg();" hidefocus='true' style='outline:none;'> 短消息(<span class="tipnum" id="sms_num"></span>)</a> 
	        </div>
            当前位置：<span id="current_pos">桌面</span>&nbsp;&nbsp;&nbsp;<a id="linkSwitchDesk" href="" target="rightMain"></a>
        </div>
    	<div class="col-1">
        	<div class="content" style="position:relative; overflow:hidden;width:100%;">
                <iframe name="rightMain" id="rightMain" frameborder="0" src="<%=homePage %>" scrolling="auto" style="border:none; margin-bottom:0px" width="100%" height="auto" allowtransparency="true"></iframe>
        	</div>
        </div>
    </div>
</div>
<div class="smart_menu_box">
    <div class="smart_menu_body">
        <ul class="smart_menu_ul">
            <%=sbPosList %>
        </ul>
    </div>
</div>
<div class="scroll">
<a href="javascript:;" class="per" title="使用鼠标滚轴滚动侧栏" onclick="menuScroll(1);"></a>
<a href="javascript:;" class="next" title="使用鼠标滚轴滚动侧栏" onclick="menuScroll(2);"></a>
</div>
<div id="sms_sound"></div>
<script type="text/javascript">
    
    var nav = $(".topMenuPanel");
    var navul = $("#top_menu");
    var list  = $("#top_menu li");
    var scroll = $("#horScroll");
    var btn = scroll.find("a");
    var _width = 0;
    var _total = 0;
    var _totaltmp = 0;
    var timer=null;
    if (list.length > 8) {
        for (var i = 0; i < list.length; i++) {
            if (i < 8)
                _width += list[i].offsetWidth ;
            _total += list[i].offsetWidth ;
        }
        _total = _total + 10;
        nav.width(_width);
        navul.width(_total);
        _totaltmp = _total = _total - _width;

    }
    else {
        scroll.hide();
    }
    function stopMove(){
        clearInterval(timer);
        if (_totaltmp <= 0)
            btn[1].style.visibility = "hidden";
        if (_totaltmp >= _total)
            btn[0].style.visibility = "hidden";
    }
    stopMove();
    //切换桌面显示风格
    function switchDeskTop(flag) {
        if(flag==1)
            $("#linkSwitchDesk").attr("href","DeskTop.aspx").html("切换到图标桌面").show();
        else if(flag==2)
            $("#linkSwitchDesk").attr("href","Home.aspx").html("切换到文字桌面").show();
        else
            $("#linkSwitchDesk").hide();
    }
    jQuery(function(){
        <%=sbFlash %>
        var mwidth = $(".smart_menu_box").width();
        $(".switchpos").click(function(e){
            
            var pos =$(this).position();
            var mtop = pos.top + $(this).height();
            var mleft = pos.left-mwidth+20;
            $(".smart_menu_box").css({
                display: "block",
			    left: mleft ,
			    top: mtop
            });
             $(".smart_menu_a").width(mwidth);
            return false;
         });
         $(".smart_menu_box").click(function(e){
            $(this).hide();
            //return false;
         });

        $(document).click(function(){
            $(".smart_menu_box").hide();
        });
        $("#btnright").hover(function(){
            var menuObj = $("#top_menu");
            if (_totaltmp <= 0) return;
            btn[0].style.visibility = "visible";
            timer = setInterval(function() {
                _totaltmp -= 10;
                var pos = menuObj.position();
                var left = pos.left - 10;
                menuObj.css("left",left+"px");
                if (_totaltmp <= 0) {
                    stopMove(false);
                }
            }, 20);
        },function(){
            stopMove(false);
        });

        $("#btnleft").hover(function(){
            var menuObj = $("#top_menu");
            if (_totaltmp >= _total) return;
            btn[1].style.visibility = "visible";
            timer = setInterval(function() {
                _totaltmp += 10;

                var pos = menuObj.position();
                var left = pos.left + 10;
                menuObj.css("left",left+"px");

                if (_totaltmp >= _total) {
                    stopMove(true);
                }
            }, 20);
        },stopMove);

        $(".topswitch").toggle(function(){
            $(this).attr("src","img/common/down.jpg");
            $(".header").toggle();
            var h = $(window).height();;
            h = h - 45;
            $('#content,#rightMain').height(h);

        },function(){
            $(this).attr("src","img/common/up.jpg");
            $(".header").toggle();
            var h = $(window).height();;
            h = h - 115; 
            $('#content,#rightMain').height(h);
        });

    });

    if (!Array.prototype.map)
        Array.prototype.map = function (fn, scope) {
            var result = [], ri = 0;
            for (var i = 0, n = this.length; i < n; i++) {
                if (i in this) {
                    result[ri++] = fn.call(scope, this[i], i, this);
                }
            }
            return result;
        };

    var getWindowSize = function () {
        return ["Height", "Width"].map(function (name) {
            return window["inner" + name] || document.compatMode === "CSS1Compat" && document.documentElement["client" + name] || document.body["client" + name]
        });
    }
    window.onload = function () {
        if (! +"\v1" && !document.querySelector) { // for IE6 IE7
            document.body.onresize = resize;
        } else {
            window.onresize = resize;
        }
        function resize() {
            wSize();
            return false;
        }
    }
    function wSize() {
        //这是一字符串
        var str = getWindowSize();
        var strs = []; //定义一数组
        strs = str.toString().split(","); //字符分割
        var heights = strs[0] - 115, Body = $('body'); $('#rightMain').height(heights);
        //iframe.height = strs[0]-46;
        if (strs[1] < 980) {
            $('.header').css('width', 980 + 'px');
            $('#content').css('width', 980 + 'px');
            Body.attr('scroll', '');
            Body.removeClass('objbody');
        } else {
            $('.header').css('width', 'auto');
            $('#content').css('width', 'auto');
            Body.attr('scroll', 'no');
            Body.addClass('objbody');
        }

        var openClose = $("#rightMain").height();

        //$('#center_frame').height(openClose -50);
        $("#openClose").height(openClose + 30);
        $("#Scroll").height(openClose - 10);
        windowW();
    }
    wSize();
    function windowW() {
        if ($('#Scroll').height() < $("#leftMain").height()) {
            $(".scroll").show();
        } else {
            $(".scroll").hide();
        }
    }
    windowW();
    //站点下拉菜单
    $(function () {
        var offset = $(".tab_web").offset();
        $(".tab_web").mouseover(function () {
            $(".tab-web-panel").css({ "left": +offset.left + 4, "top": +offset.top + $('.tab_web').height() + 2 });
            $(".tab-web-panel").show();
        });
        $(".tab_web span").mouseout(function () { hidden_site_list_1() });
        $(".tab-web-panel").mouseover(function () { clearh(); $('.tab_web a').addClass('on') }).mouseout(function () { hidden_site_list_1(); $('.tab_web a').removeClass('on') });
        $("#leftMain").bind("mousewheel",function(){
            if (event.wheelDelta >= 120)
                menuScroll(1);
            else if (event.wheelDelta <= -120)
                menuScroll(2);  
        });
        //默认载入左侧菜单
        var firstMenu =$(".top_menu:eq(0)");
	    var menuName=firstMenu.text();
	    var menuId=firstMenu.attr("id").substring(2);
            $.ajax({
                type: "post",
                url: "treenode.aspx?type=ztree",
                data: { parentnode: menuId},
                async: true,
                dataType: "json",
                success: function (data) {
                    createMenu(data,menuName);
                    wSize();
                },
                error: function (e) {
                    alert("会话超时，请重新登录");
                    window.location = "default.aspx?logout=1";
                }
            });

        $("h3.f14").live("mousewheel",function(){
            if (event.wheelDelta >= 120)
                menuScroll(1);
            else if (event.wheelDelta <= -120)
                menuScroll(2);  
        }).live("click",function(){
            $(".switchs",this).click();
        });

        $(".switchs").live("click",function(){
			$(this).toggleClass('on');
	        var ul = $(this).parent().next();
			ul.toggle();
            return false;
        });
    })

    //隐藏站点下拉。
    var s = 0;
    var h;
    function hidden_site_list() {
        s++;
        if (s >= 3) {
            $('.tab-web-panel').hide();
            clearInterval(h);
            s = 0;
        }
    }
    function clearh() {
        if (h) clearInterval(h);
    }
    function hidden_site_list_1() {
        h = setInterval("hidden_site_list()", 1);
    }

    //左侧开关
    $("#openClose").click(function () {
        if ($(this).data('clicknum') == 1) {
            $("html").removeClass("on");
            $(".left_menu").removeClass("left_menu_on");
            $(this).removeClass("close");
            $(this).data('clicknum', 0);
            $(".scroll").show();
        } else {
            $(".left_menu").addClass("left_menu_on");
            $(this).addClass("close");
            $("html").addClass("on");
            $(this).data('clicknum', 1);
            $(".scroll").hide();
        }
        return false;
    });
    var mainMenu="";
    function _M(menuid, targetUrl) {
        $("#menuid").val(menuid);
        $("#bigid").val(menuid);
        switchDeskTop(0);//$("#paneladd").html('<a class="panel-add" href="javascript:add_panel();"><em>添加</em></a>');
        /*
        $("#leftMain").load("inc/lmenu.php?menuid=" + menuid, { limit: 25 }, function () {
            windowW();
        });*/
        mainMenu=$("#_M"+menuid).text();
        //加载菜单
        $.ajax({
            type: "post",
            url: "treenode.aspx?type=ztree",
            data: { parentnode: menuid },
            async: true,
            dataType: "json",
            success: function (data) {
                createMenu(data,mainMenu);
                wSize();
            },
            error: function (e) {
                alert("会话超时，请重新登录");
                window.location = "default.aspx?logout=1";
            }
        });
        if(targetUrl == "")
            targetUrl="DeskTop.aspx?pwbs="+menuid;
        $("#rightMain").attr('src', targetUrl);
        $('.top_menu').removeClass("on");
        $('#_M' + menuid).addClass("on");
        /*
        $.get("inc/tmenu.php?table=menu&name=menuname&menuid=" + menuid, function (data) {
            $("#current_pos").html(data);
        });*/
        $("#current_pos").html(""+mainMenu + '<span id="current_pos_attr"></span>');

        //当点击顶部菜单后，隐藏中间的框架
        //$('#display_center_id').css('display', 'none');
        //显示左侧菜单，当点击顶部时，展开左侧
        $(".left_menu").removeClass("left_menu_on");
        $("#openClose").removeClass("close");
        $("html").removeClass("on");
        $("#openClose").data('clicknum', 0);
        $("#current_pos").data('clicknum', 1);
    }

    var zTreeSet = { 
        edit: {enable: false},
        view: {showLine:true},
        callback:{onClick:nodeClick,onExpand:nodeOpen}
    };

    function createMenu(data,mainMenu)
    {
        var children = data[0].children;
        if(!children)
            return;
        for (var i = 0; i < children.length; i++) {
            if(!!children[i].children)
                children[i].icon="img/common/mode_preview.png";
        }
        $.fn.zTree.init($("#leftMain"), zTreeSet, children);
        var zTree = $.fn.zTree.getZTreeObj("leftMain");

    }
    function nodeOpen(e,treeId,node){
        windowW();
    }
    function nodeClick(e,treeId,node)
    {
        var menuid = node.id;
        var path = node.name;
        $("#menuid").val(menuid);
        switchDeskTop(0);
        if(node.value!=""){
            if(node.tag == "2"){
                window.open(node.value,"_blank");
            }
            else{
                $("#rightMain").attr('src', node.value);
            }
        }

        $('.sub_menu').removeClass("on fb blue");
        $('#_MP' + menuid).addClass("on fb blue");
        $("#current_pos").html(path + '<span id="current_pos_attr"></span>');
        $("#current_pos").data('clicknum', 1);

    }

    function _MP(menuid, targetUrl, path, tag, snum) {
        $("#menuid").val(menuid);
        switchDeskTop(0);//$("#paneladd").html('<a class="panel-add" href="javascript:add_panel();"><em>添加</em></a>');
        if(targetUrl!=""){
            if(tag == "2"){
                window.open(targetUrl,"_blank");
            }
            else{
                $("#rightMain").attr('src', targetUrl);
            }
        }
        else{
            if(menuid.length==13 && snum>0){
                $("#rightMain").attr('src', "SysFolder/AppFrame/AppNavi.aspx?menu="+menuid);
            }
        }
        $('.sub_menu').removeClass("on fb blue");
        $('#_MP' + menuid).addClass("on fb blue");
        $("#current_pos").html(path + '<span id="current_pos_attr"></span>');
        $("#current_pos").data('clicknum', 1);
    }
    function menuScroll(num) {
        var Scroll = document.getElementById('Scroll');
        if (num == 1) {
            Scroll.scrollTop = Scroll.scrollTop - 60;
        } else {
            Scroll.scrollTop = Scroll.scrollTop + 60;
        }
    }
    function show_msg() {

        _MP("viewmsg","Workasp/msg/msgFrame.aspx","首页 > 系统消息");
    }
    function show_online() {
        mytop = (screen.availHeight - 370) / 2;
        myleft = (screen.availWidth - 312) / 1;
        _MP("userback","Online.aspx","首页 > 在线人数");
    }
    function show_changepwd()
    {
        _MP("userback","ChangePass.aspx","首页 > 修改密码");
    }
    function show_todo() {
        mytop = (screen.availHeight - 370) / 2;
        myleft = (screen.availWidth - 312) / 1;
        _MP("todo","Sysfolder/workflow/flowtodo.aspx","首页 > 我的待办")
    }

    //刷新在线人数
    var maxtest = 0;
    var msgFlag = "";
    function updateol() {
        //在线人数|待办任务数|未读消息数量,上次读取数量
        var i = EIS.Web.DefaultMain.OnlineFlash();

        if (i.error || i.value==null) {
            if (maxtest >= 3) {
                        alert("会话超时，请重新登录");
                        window.location = "default.aspx?logout=1";
            }
            else {
                maxtest++;
                window.setTimeout("updateol()", 1000 * <%=refreshInterval %>); 
            }

        }
        else {
            var vals=i.value.split("|");
            $("#user_count").html(vals[0]);
            $("#todo_num").html(vals[1]);
            
            if(msgFlag != vals[2])
            {
                var arr = vals[2].split(",");                
                if (arr[0] != arr[1]) {
                    //jQuery('#shortcut').click();
                    $('#sms_count').html('<img src="Theme/Default/images/xin.gif">');

                    //消息提示,设定标题提示
                    var newSmsSoundHtml =[ "<object id='sms_sound' classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='Theme/Default/swf/swflash.cab' width='0' height='0'>"
                    ,"<param name='movie' value='Theme/Default/swf/9.swf?t=",Math.random(),"'><param name=quality value=high>"
                    ,"<embed id='sms_sound' src='Theme/Default/swf/9.swf?t=",Math.random()
                    ,"' width='0' height='0' quality='autohigh' wmode='opaque' type='application/x-shockwave-flash' "
                    ,"plugspace='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash'></embed></object>"];

                    $('#sms_sound').html(newSmsSoundHtml.join(""));
                    setTimeout(function(){
                        $('#sms_sound').html("");
                    },10000);
                    $("#sms_num").html(arr[0]);

                    if(msgFlag!="")
                    {
                        $.zxxbox.ask("您有新的系统消息，请注意查收", function(){  $.zxxbox.hide(); }, null, { title: "系统提示" }); 
                        //window.frames["rightMain"].location.reload();
                    }
                } else {
                    $("#sms_num").html(arr[0]);
                    $('#sms_count').html('  ');
                }

                msgFlag = vals[2];

            }


            window.setTimeout("updateol()", 1000 * <%=refreshInterval %>); 
            maxtest = 0;
        }

    }
    updateol();


</script>
</body>
</html>