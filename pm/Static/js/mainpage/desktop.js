// "/static/js/tDesktop/tDesktop.js","/static/js/tDesktop/tDesktop.IM.js","/static/js/tDesktop/tDesktop.Layout.js","/static/js/tDesktop/tDesktop.Menu.js","/static/js/tDesktop/tDesktop.Nocbox.js","/static/js/tDesktop/tDesktop.Notification.js","/static/js/tDesktop/tDesktop.Pulse.js","/static/js/tDesktop/tDesktop.Search.js","/static/js/tDesktop/tDesktop.Tabs.js","/static/js/tDesktop/tDesktop.Theme.js","/static/js/tDesktop/tDesktop.Today.js"
/* "/static/js/tDesktop/tDesktop.js" */
//当前系统主题
var ostheme = 15;
var show_ip = 0;
var ispirit = "";
var bEmailPriv = true;
var bSmsPriv = true;
var bTabStyle = true;
var statusTextScroll = 60;
var timer_sms_mon = null;
var timer_online_tree_ref = null;
//微讯箱自动关闭时间，秒
var closeNocPanel = null;
var nocbox_close_timeout = 3;
var timeLastLoadOnline = 0;
var nextTabId = 0;
var maxSendSmsId = 0;
var newSmsArray = [];

Date.prototype.format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份      
        "d+": this.getDate(), //日      
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时      
        "H+": this.getHours(), //小时      
        "m+": this.getMinutes(), //分      
        "s+": this.getSeconds(), //秒      
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度      
        "S": this.getMilliseconds() //毫秒      
    };
    var week = { "0": "/u65e5", "1": "/u4e00", "2": "/u4e8c", "3": "/u4e09", "4": "/u56db", "5": "/u4e94", "6": "/u516d" };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f" : "/u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;

}

define('tDesktop', function (require, exports, module) {
    var $ = window.jQuery; var JSON = window.JSON;
    var TabObj = require('tDesktop/tDesktop.Tabs');
    var tab = TabObj.Tabs;
    var LayoutObj = require('tDesktop/tDesktop.Layout');
    var MenuObj = require('tDesktop/tDesktop.Menu');
    var ThemeObj = require('tDesktop/tDesktop.Theme');
    var theme = ThemeObj.Theme;
    var TodayObj = require('tDesktop/tDesktop.Today');
    var NocboxObj = require('tDesktop/tDesktop.Nocbox');
    var nocbox = NocboxObj.Nocbox;
    var Notification = require('tDesktop/tDesktop.Notification');
    var hasSearchModuleBeenInit;
    window.createTab = function (id, name, code, open_window) {
        tab.createTab(id, name, code, open_window);
        $('body').removeClass('showSearch').removeClass('right-mini');
        $('#eastbar,#searchbar').removeClass('on');
    };
    window.selectTab = function (id) { tab.selectTab(id); };
    window.closeTab = function (id) { id = (typeof (id) != 'string') ? tab.getSelected() : id; tab.closeTab(id); };
    window.IframeLoaded = function (id) { tab.IframeLoaded(id); };
    window.send_msg = function (uid, title) { IMObj.IM.Org.nodeclick(uid, title); }
    var nextTabId = 10000;
    window.openURL = function (id, name, url, open_window, width, height, left, top) {
        id = !id ? ('w' + (nextTabId++)) : id; if (open_window != "1")
        { window.setTimeout(function () { jQuery().addTab(id, name, url, true) }, 1); }
        else
        { width = typeof (width) == "undefined" ? 780 : width; height = typeof (height) == "undefined" ? 550 : height; left = typeof (left) == "undefined" ? (screen.availWidth - width) / 2 : left; top = typeof (top) == "undefined" ? (screen.availHeight - height) / 2 - 30 : top; window.open(url, id, "height=" + height + ",width=" + width + ",status=0,toolbar=no,menubar=yes,location=no,scrollbars=yes,top=" + top + ",left=" + left + ",resizable=yes"); }
        jQuery(document).trigger('click');
    }
    $.fn.addTab = function (id, title, url, closable, selected) {
        tab.addTab(id, title, url, closable, selected);
        $('body').removeClass('showSearch').removeClass('right-mini');
        $('#eastbar,#searchbar').removeClass('on');
    };
    $.fn.selectTab = function (id) { tab.selectTab(id); };
    $.fn.closeTab = function (id) { id = (typeof (id) != 'string') ? tab.getSelected() : id; tab.closeTab(id); };
    $.fn.getSelected = function () { return $('#tabs_container').tabs('selected'); };

    var TDesktop = Backbone.View.extend({ el: $('body'),
        events: { 'click a#person_info': 'initPersonInfo', 'click a#logout': 'initLogout', 'click a#searchbar': 'initSearch', 'click a#totaskbar': 'initTaskCenter', 'click a#tosns': 'initSns', 'click a#eastbar': 'initEast' },
        initialize: function () {
            if (TDesktop._instance) { return TDesktop._instance; }
            _.bindAll(this, 'initPersonInfo', 'initLogout', 'initEast', 'initTaskCenter', 'initSns', 'initMenu');
            var self = this;
            if (self.isTouchDevice()) {
                $('body').addClass('mobile-body'); $('#center').addClass('mobile-center');
                document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
            }
            self.EventManager = {};
            _.extend(self.EventManager, Backbone.Events);
            self.initLayout();
            self.initMenu();
            self.initTabs();
            self.initPortal();
            self.initTheme();
            self.initTip();
            self.initToday();
            self.initOnline();
            self.initNotify();
            self.initNocbox();
            self.initNotification();
            TDesktop._instance = this;
        },
        initTip: function () { if (jQuery && jQuery.fn.tooltip) { jQuery('[data-toggle="tooltip"]').tooltip({ container: 'body' }); } },
        isTouchDevice: function () { try { document.createEvent("TouchEvent"); return userAgent.indexOf("mobile") >= 0 || userAgent.indexOf("maxthon") < 0; } catch (e) { return false; } },
        initLayout: function () { var layout = new LayoutObj.Layout({ tDesktop: this }); },
        initMenu: function () {
            var menu = new MenuObj.Menu.MenuInit({ tDesktop: this });
            var menuscroll = new MenuObj.Menu.MenuScroll({ tDesktop: this }); menu.menuHover(); this.menu = menu;
            this.EventManager.on('createTab', function () { menu.hideActiveMenu(); }); $("#first_menu").resize();
        },
        initTabs: function () {
            var self = this;
            tab.init();
            tab._createTab = tab.createTab;
            tab.createTab = function () { tab._createTab.apply(tab, arguments); self.EventManager.trigger('createTab'); }
        },
        initPortal: function () {
            for (var i = 0; i < portalLoadArray.length; i++) {
                tab.addTab('portal_' + portalLoadArray[i].id, portalLoadArray[i].title, portalLoadArray[i].url, portalLoadArray[i].closable, (i == 0));
            }
        },
        initTheme: function () { theme.init(); },
        initToday: function () {
            var deskdate = new TodayObj.Today.Deskdate({ tDesktop: this });
            var calendar = new TodayObj.Today.Calendar({ tDesktop: this });
            var reminder = new TodayObj.Today.Reminder({ tDesktop: this });
        },
        initOnline: function () {
            $('#online_flag').click(function () {
                if ($('#on_status:visible').length > 0) { $('#on_status').hide(); }
                else { $('#on_status').show(); }
            });
            $('#on_status > a').click(function () {
                var status = $(this).attr('status');
                if (status < "1" || status > "4") return;
                $.get("#", { API: "on_status", CONTENT: status });
                var target = $(this).find('i').text();
                var targetClass = $(this).find('i').attr('class'); $('#online_flag').text(target).attr('class', targetClass); $('#on_status').fadeOut(300);
            });
        },
        initPersonInfo: function () { window.createTab('PersonalInfo', "个人信息", "Workasp/Personal/PersonalInfo.aspx", ""); },
        initLogout: function () {
            var relogin = 0; var msg = "您确定要退出系统吗？";
            if (window.confirm(msg))
            { relogin = 1; window.location = "Default.aspx?logout=1"; }
        },
        initTaskCenter: function () {
            //$('body').addClass('left-mini');
            window.createTab('taskcenter', "流程发起", "SysFolder/Workflow/FlowList.aspx", false);
        },
        initSns: function () { window.createTab(73, func_array["f73"][0], 'sns', ''); },
        initEast: function () { $("#searchbar").removeClass('on'); $("#eastbar").toggleClass('on'); $('body').toggleClass('right-mini').removeClass('showSearch'); },
        initNocbox: function () { nocbox.init({ tDesktop: this }); },
        formatTime: function (c) {
            var c = parseInt(c) * 1000; var a = new Date(); var g = new Date(c); var b = new Date(a); var f = a - c; var e = ""; function d(h) { return h < 10 ? ("0" + h) : h }
            if (f < 0) { e = "" } else { if (f < (60 * 1000)) { e = parseInt(f / 1000) + td_lang.inc.msg_169 } else { if (f < (60 * 60 * 1000)) { e = parseInt(f / 60 / 1000) + td_lang.inc.msg_170 } else { if (f < (24 * 60 * 60 * 1000)) { if (g.getDate() == b.getDate()) { e = td_lang.inc.msg_182 + d(g.getHours()) + ":" + d(g.getMinutes()) } else { e = (g.getMonth() + 1) + td_lang.inc.msg_171 + g.getDate() + td_lang.inc.msg_172 + d(g.getHours()) + ":" + d(g.getMinutes()) } } else { if (f < (365 * 24 * 60 * 60 * 1000)) { if (g.getFullYear() == b.getFullYear()) { e = (g.getMonth() + 1) + td_lang.inc.msg_171 + g.getDate() + td_lang.inc.msg_172 + d(g.getHours()) + ":" + d(g.getMinutes()) } else { e = g.getFullYear() + "-" + (g.getMonth() + 1) + "-" + g.getDate() + " " + d(g.getHours()) + ":" + d(g.getMinutes()) } } else { e = g.getFullYear() + "-" + (g.getMonth() + 1) + "-" + g.getDate() + " " + d(g.getHours()) + ":" + d(g.getMinutes()) } } } } }
            return e;
        },
        initNotify: function () {
            if ($('#notify_panel').length > 0)
            { $('#overlay').show(); $('#notify_panel').show(); $('#notify_panel .btn-ok').click(function () { var cookie_name = $(this).attr("cookie_name"); var cookie_value = $(this).attr("cookie_value"); document.cookie = cookie_name + "=" + cookie_value; path = "/"; expires = 1000; $('#notify_panel .btn-close').click(); }); $('#notify_panel .btn-close').click(function () { $('#overlay').hide(); $('#notify_panel').hide(); }); $('#notify_panel .head-close').click(function () { $('#notify_panel .btn-close').click(); }); }
        },
        initNotification: function () { Notification.init(this); }
    });
    TDesktop.getInstance = function () { return TDesktop._instance; };
    exports.TDesktop = TDesktop;
    window.TDesktop = TDesktop;
    IframeLoaded("portal_desktop");
});

/* "/static/js/tDesktop/tDesktop.Layout.js" */
define('tDesktop/tDesktop.Layout', function (require, exports, module) {
    var $ = window.jQuery; var Layout = Backbone.View.extend({ el: 'body', events: { 'click a.west-handle': 'leftHandle', 'click a.east-handle': 'rightHandle', 'click #funcmenu_switcher': 'toggleMenu' }, initialize: function (c) {
        _.bindAll(this, 'leftHandle', 'rightHandle', 'toggleMenu'); this.initEastPanel(); this.initRegPanel(); this.tDesktop = c.tDesktop; if (localStorage.open_menu == 'open-menu') { $(this.el).addClass('open-menu'); $('.funcmenu_switcher').addClass('active'); } else { $(this.el).removeClass('open-menu'); $('.funcmenu_switcher').removeClass('active'); }
        if (localStorage.left_mini == 'left-mini') { $(this.el).addClass('left-mini'); } else { $(this.el).removeClass('left-mini'); } 
    }, initRegPanel: function () { if ($('#hero_bar').length > 0) { $('#east,#west,#center').css('bottom', '61px'); } else { $('#east,#west,#center').css('bottom', '0'); } }, leftHandle: function () { $(this.el).toggleClass('left-mini'); if (window.localStorage || typeof window.localStorage != 'undefined') { if (localStorage.left_mini == '' || localStorage.left_mini == undefined) { localStorage.left_mini = 'left-mini'; } else { localStorage.left_mini = ''; } } }, rightHandle: function () { $(this.el).toggleClass('right-mini'); $('#eastbar').toggleClass('on'); }, toggleMenu: function () { $(this.el).toggleClass('open-menu'); $('.funcmenu_switcher').toggleClass('active'); if (window.localStorage || typeof window.localStorage != 'undefined') { if (localStorage.open_menu == '' || localStorage.open_menu == undefined) { localStorage.open_menu = 'open-menu'; } else { localStorage.open_menu = ''; } } }, initEastPanel: function () {
        var self = this; $('.nav-pill').click(function () {
            $('.nav-pill').removeClass('active'); $('.tab-pane').removeClass('active'); $(this).addClass('active'); var target = $(this).attr('panelType'); $('.pane-' + target).addClass('active'); if (target == "org") { self.tDesktop.EventManager.trigger('online:comet'); }
            else { self.tDesktop.EventManager.trigger('online:stopcomet'); } 
        }); $("#msg-tool .btn").click(function () { $(".msg-tool .btn").removeClass("btn-primary"); $(this).addClass("btn-primary"); var target = $(this).attr("msg-panel"); $(".msg-panel").removeClass("active"); $("#" + target).addClass("active"); });
    } 
    }); exports.Layout = Layout;
});
/* "/static/js/tDesktop/tDesktop.Menu.js" */
define('tDesktop/tDesktop.Menu', function (require, exports, module) {
    var $ = window.jQuery;
    require('menu-aim');
    require('backbone');
    var Menu = Backbone.Model.extend({ defaults: { menuId: null, menuText: "", iconfont: ""} });
    var MenuList = Backbone.Collection.extend({ model: Menu, url: '', sync: function () { } });
    var secondMenu = Backbone.Model.extend({ defaults: { parentId: null, menuId: null, menuText: "", expand: null, actionType: ""} });
    var secondMenuList = Backbone.Collection.extend({ model: secondMenu, url: '', sync: function () { } });
    var thirdMenuList = Backbone.Collection.extend({ model: secondMenu, url: '', sync: function () { } });


    var menuItemView = Backbone.View.extend({ el: 'ul.first-menu',
        template: $("#menuTmpl").template(),
        initialize: function () { _.bindAll(this, 'render'); this.model.bind('change', this.render); },
        render: function () { var element = jQuery.tmpl(this.template, this.model.toJSON()); $(this.el).append(element); return this; }
    });

    var secondMenuView = Backbone.View.extend({ el: 'ul.second-menu',
        template: $("#secondMenuTmpl").template(),
        initialize: function () { _.bindAll(this, 'render'); this.model.bind('change', this.render); },
        render: function () { var element = jQuery.tmpl(this.template, this.model.toJSON()); var menu_id = this.model.toJSON().parentId; $('#second-menulist-' + menu_id).append(element); return this; }
    });

    var thirdMenuView = Backbone.View.extend({ el: 'ul.third-menu',
        template: $("#thirdMenuTmpl").template(),
        initialize: function () { _.bindAll(this, 'render'); this.model.bind('change', this.render); },
        render: function () { var element = jQuery.tmpl(this.template, this.model.toJSON()); var menu_id = this.model.toJSON().parentId; $('#third-menulist-' + menu_id).append(element); return this; }
    });

    var MenuView = Backbone.View.extend({ el: '.west-body',
        initialize: function () {
            var self = this;
            _.bindAll(this, 'createMenu', 'menuHover', 'createSecondMenu', 'createThirdMenu', 'showSubmenu', 'hideSubmenu', 'hideAllSubmenu');

            var menulist = new MenuList; var secondmenulist = new secondMenuList; var thirdmenulist = new thirdMenuList;
            menulist.bind('add', self.createMenu);
            menulist.fetch();
            secondmenulist.bind('add', self.createSecondMenu);
            secondmenulist.fetch();
            thirdmenulist.bind('add', self.createThirdMenu);
            thirdmenulist.fetch();
            if (func_Tree.length == 0)
                return;
            var rootNode = func_Tree[0];
            var extend_menus = [[], []];
            var funArry1 = rootNode.ChildNodes || [];

            for (var i = 0; i < funArry1.length; i++) {
                var json = {};
                var oneNode = funArry1[i];
                var menu_id = oneNode.id;
                var menu_module = '';

                var image = 'oa';
                json["menuId"] = menu_id;
                json['module'] = menu_module;
                json["menuText"] = oneNode.text;
                json["iconfont"] = module2iconfont[first_array[i]] || module2iconfont['default'];

                var func_id = oneNode.id;
                var func_code = oneNode.value;
                var func_name = oneNode.text;
                var open_window = oneNode.tag == "2" ? "1" : "";

                var onclick = func_code.length == 0 ? "" : "createTab('" + func_id + "','" + func_name.replace("'", "\'") + "','" + func_code.replace("'", "\'") + "','" + open_window + "');";
                json["actionFun"] = onclick;
                menulist.add(json);
            }

            for (var i = 0; i < funArry1.length; i++) {
                var menu = funArry1[i];
                var menu_id = menu.id;
                var funArry2 = menu.ChildNodes || [];
                if (funArry2.length == 0) {
                    $("#second-menu-" + menu_id).remove();
                    continue;
                }
                for (var j = 0; j < funArry2.length; j++) {
                    var json = {}
                    var funcNode = funArry2[j];

                    var func_id = funcNode.id;
                    var func_code = funcNode.value;
                    var func_name = funcNode.text;
                    var open_window = funcNode.tag == "2" ? "1" : "";

                    var funArry3 = funcNode.ChildNodes || [];
                    var bExpand = funArry3.length > 0;

                    var onclick = bExpand ? "" : "createTab('" + func_id + "','" + func_name.replace("'", "\'") + "','" + func_code.replace("'", "\'") + "','" + open_window + "');";
                    json["parentId"] = menu_id;
                    json["menuId"] = func_id;
                    json["menuText"] = func_name;
                    json["expand"] = bExpand;
                    json["actionType"] = onclick;
                    json["favorite"] = funcNode.showcheck;

                    /*if (bExpand == false) {
                        secondmenulist.add(json);
                    }
                    else {
                        extend_menus[0].push(json);
                    }*/
                    extend_menus[0].push(json);

                    if (bExpand) {
                        for (var k = 0; k < funArry3.length; k++) {
                            var tNode = funArry3[k];
                            var json = {};
                            var third_id = tNode.id;
                            var third_name = tNode.text;
                            var third_code = tNode.value;
                            var open_window1 = tNode.tag == "2" ? "1" : "";
                            var onclick1 = "createTab('" + third_id + "','" + third_name.replace("'", "\'") + "','" + third_code.replace("'", "\'") + "','" + open_window1 + "');";
                            json["parentId"] = func_id;
                            json["menuId"] = third_id;
                            json["menuText"] = third_name;
                            json["expand"] = false;
                            json["actionType"] = onclick1;
                            json["favorite"] = tNode.showcheck;
                            extend_menus[1].push(json);
                        }
                    }
                }
            }
            $.each(extend_menus[0], function () { secondmenulist.add(this); })
            $.each(extend_menus[1], function () { thirdmenulist.add(this); })
        },
        menuHover: function () {
            var self = this;
            var $menu = jQuery(".first-menu");
            $menu.menuAim({ activate: self.showSubmenu, deactivate: self.hideSubmenu, exitMenu: self.hideAllSubmenu });
            $(".first-menu li a").click(function (e) { e.stopPropagation(); });
        },
        createMenu: function (menuitem) {
            var view = new menuItemView({ model: menuitem }); $('.first-menu').prepend(view.render().el);
        },
        createSecondMenu: function (secondmenuitem) {
            var secondview = new secondMenuView({ model: secondmenuitem }); $('.second-menu').prepend(secondview.render().el);
        },
        createThirdMenu: function (thirdmenuitem) {
            var thirdview = new thirdMenuView({ model: thirdmenuitem }); $('.third-menu').prepend(thirdview.render().el);
        },
        showSubmenu: function (row) {
            var $menu = $(".first-menu"), $row = $(row),
            submenuId = $row.data("submenuId"),
            $submenu = $("#" + submenuId), width = $menu.outerWidth();
            this.$active = $row;
            $submenu.css({ display: "block", top: -28, left: width });
            $submenu.animate('width', '400');
            $row.find("div.first-menu-item").addClass("first-menu-item-hover");
        },
        hideSubmenu: function (row) {
            var $row = $(row),
            submenuId = $row.data("submenuId"),
            $submenu = $("#" + submenuId);
            $submenu.css("display", "none");
            $row.find("div.first-menu-item").removeClass("first-menu-item-hover");
        },
        hideAllSubmenu: function () {
            $(".second-panel").css("display", "none");
            $("div.first-menu-item").removeClass("first-menu-item-hover"); return true;
        },
        hideActiveMenu: function () {
            if (this.$active) { this.hideSubmenu(this.$active); }
        }
    });
    var MenuScrollView = Backbone.View.extend({ el: $('.west'),
        events: { 'click div.scroll-up': 'scrollUp', 'click div.scroll-down': 'scrollDown' },
        initialize: function () {
            var self = this; _.bindAll(this, 'scrollUp', 'scrollDown');
            $(window).resize(function () { self.initMenuHeight(); });
            this.initMenuHeight();
            $('#first_menu').mousewheel(function (event, delta) {
                var ul = $('#first_menu'); if (delta > 0) { ul.scrollTop(ul.scrollTop() - 46); }
                else { ul.scrollTop(ul.scrollTop() + 46); }
                return false;
            });
            $(".second-panel").mousewheel(function (e) { e.stopPropagation(); });
        },
        initMenuHeight: function () {
            var availheight = $('.west-footer').offset().top - $('#north').height() - $("#funcbar").height();
            var scrollheight = $("#first_menu")[0].scrollHeight;
            if (availheight < scrollheight) { availheight = availheight - 40; $("#first_menu").height(availheight); $('.scroll-up').show(); $('.scroll-down').show(); }
            else { $("#first_menu").height(availheight); $('.scroll-up').hide(); $('.scroll-down').hide(); }
        },
        scrollUp: function () { var ul = $('#first_menu'); ul.animate({ 'scrollTop': (ul.scrollTop() - 144) }, 600); },
        scrollDown: function () { var ul = $('#first_menu'); ul.animate({ 'scrollTop': (ul.scrollTop() + 144) }, 600); }
    });
    exports.Menu = { MenuInit: MenuView, MenuScroll: MenuScrollView };
});

/* "/static/js/tDesktop/tDesktop.Nocbox.js" */
define('tDesktop/tDesktop.Nocbox', function (require, exports, module) {
    var $ = window.jQuery;
    var Nocbox = { init: function (c) {
        this.tDesktop = c.tDesktop;
        this.loadNoc(); this.bindEvent();
    }
    , bindEvent: function () {
        var self = this;
        self.tDesktop.EventManager.on('loadNoc:load', function () { self.loadNoc(); });
        self.tDesktop.EventManager.on('notify:read', function (item) {
            var $target = $('#new_noc_list li[sms_id="' + item.sms_id + '"]'); var url = item.url; var sms_id = item.sms_id; var type_id = item.type_id;
            self.removeNoc($target, sms_id, 0);
            if (url != "") { self.openURL('', item.type_name, url); }
        });
        $('#new_noc_list').delegate('li', 'click', function () {
            var sms_id = $(this).attr('sms_id');
            var type_id = $(this).attr('type_id');

            var url = "WorkAsp/Msg/MsgRead.aspx?msgid=" + sms_id;
            //if ($(this).attr('url'))
            //    url = $(this).attr('url');

            //self.removeNoc($(this), sms_id, 0);
            if (sms_id != "") { self.openURL('', '', url, '1'); }
        });
        $('#check_remind_histroy,#tohistory').click(function () {
            self.openURL('', "系统消息", "WorkAsp/Msg/MsgFrame.aspx");
        });
        //全部已阅
        $('#ViewAllNoc').click(function () {
            var idstr = self.get_noc_idstr();
            var ret = _mainPage.UpdateMsgState("all");
            if (ret.error) {
                alert(ret.error.Message);
                return;
            }

            $('#new_noc_list').empty().hide();
            var datanum = self.get_noc_num();
            $("#noc_item_num").html(datanum);
            $('#nodata_tips').show();
            $('.noc-nav-bar').hide();
        });

        //分类标题点击
        $('#new_noc_list').delegate('.noc_item_title', 'click', function () {
            var typeList = $(this).next();
            typeList.toggle("fast");
        });

        //分类查看全部
        $('#new_noc_list').delegate('.noc_item_read', 'click', function () {
            var type_id = $(this).attr('type_id');

        });

        //分类全部已阅
        $('#new_noc_list').delegate('.noc_item_cancel', 'click', function () {
            var type_id = $(this).attr('type_id');
            if (type_id == "0")
                type_id = "";
            var ret = _mainPage.UpdateMsgState(type_id);
            if (ret.error) {
                alert(ret.error.Message);
                return;
            }
            var idstr_all = self.get_noc_idstr(type_id);
            self.removeNoc($(this), idstr_all, 0);
        });
    },
        loadNoc: function (flag) {
            var self = this; flag = typeof (flag) == "undefined" ? "1" : "0";
            return;
            var ret = _mainPage.GetMessage("");
            if (ret && ret.error) {
                $('#nocbox_tips').hide();
                $('#nodata_tips').show();
                $('.noc-nav-bar').hide();
                return;
            }
            else {
                var dt = ret.value;
                $('#nocbox_tips').hide();
                if (dt.Rows.length == 0) {
                    $('#nodata_tips').show();
                    $('.noc-nav-bar').hide();
                }
                else {
                    $("#nodata_tips").hide();
                    $('.noc-nav-bar').show();
                    self.formatNoc(dt);
                }
            }

        },
        formatNoc: function (data) {
            var totalnum = "", self = this; $('#new_noc_list').empty();
            $.each(data.Rows, function (key, dr) {
                var item = {};
                item.type_id = dr.msgtype == "" ? "0" : dr.msgtype;
                item.from_id = dr.recid;
                item.sms_id = dr.msgid;
                item.content = dr.content;
                item.type_name = dr.msgtype == "" ? "普通消息" : dr.msgtype;
                item.send_time = dr.sendtime.format("yyyy-MM-dd hh:mm");
                item.from_name = dr.sender;
                item.url = !!dr.msgurl ? dr.msgurl : "";

                self.tDesktop.EventManager.trigger('message:create', item);
                if ($('#new_noc_list').find('.noc_item_' + item.type_id).size() != 0) {
                    var itemObj = $("#nocitem-template").tmpl(item);
                    $('.noc_item_' + item.type_id + ' > ul').append(itemObj);

                }
                else {

                    $('#new_noc_list').append($("#noc-template").tmpl(item));
                    var itemObj = $("#nocitem-template").tmpl(item);
                    $('.noc_item_' + item.type_id + ' > ul').append(itemObj);

                }
            });
            $('.noc').addClass("on"); var num = self.get_noc_num(); $("#noc_item_num").html(num);
        },
        get_noc_num: function () {
            var totalnum = ''; totalnum = $("#new_noc_list > .noc_item > .noc_item_data > li").length; return totalnum;
        },
        get_noc_idstr: function (type_id) {
            var idstr = ''; var separator = ''; if (type_id != "" && typeof (type_id) !== "undefined")
            { var idsobj = $("#new_noc_list > .noc_item_" + type_id + " > .noc_item_data > li"); } else
            { var idsobj = $("#new_noc_list > .noc_item > .noc_item_data > li"); }
            $.each(idsobj, function () { idstr += separator + $(this).attr("sms_id"); separator = ","; }); return idstr;
        },
        removeNoc: function (obj, recvIdStr, del) {
            var self = this; if (!recvIdStr) { return }

            //$('#new_noc_list').hide();
            var lis = obj.parents(".noc_item").find("li").size();
            if (recvIdStr.indexOf(",") != '-1') {
                obj.parents(".noc_item").remove()
            } else {
                lis == 1 ? obj.parents(".noc_item").remove() : obj.remove();
            }
            var num = self.get_noc_num();
            $("#noc_item_num").html(num);
            if (num < 1) { $('#nodata_tips').show(); $('.noc-nav-bar').hide(); }

        },
        openURL: function (id, name, url, open_window, width, height, left, top) {
            id = !id ? ('w' + (nextTabId++)) : id; if (open_window != "1")
            { window.setTimeout(function () { $().addTab(id, name, url, true) }, 1); }
            else {
                width = typeof (width) == "undefined" ? 780 : width;
                height = typeof (height) == "undefined" ? 550 : height;
                left = typeof (left) == "undefined" ? (screen.availWidth - width) / 2 : left;
                top = typeof (top) == "undefined" ? (screen.availHeight - height) / 2 - 30 : top;
                window.open(url, id, "height=" + height + ",width=" + width + ",status=0,toolbar=no,menubar=yes,location=no,scrollbars=yes,top=" + top + ",left=" + left + ",resizable=yes");
            }
        }
    }; exports.Nocbox = Nocbox;
});

/* "/static/js/tDesktop/tDesktop.Notification.js" 提示框 */
define('tDesktop/tDesktop.Notification', function (require, exports, module) {
    var $ = window.jQuery; require('miniNotification'); require('backbone');
    var tDesktop = window.tDesktop;
    var Msg = Backbone.Model.extend({
        defaults: { id: "", mid: "", name: "", module: "", title: "", msg: "", num: 1, closable: true, autoClose: true }
        , initialize: function (item) { this.items = []; this.addItem(item); }
        , addItem: function (item) { this.items.push(item); this.set({ title: item.title, mid: item.mid, msg: item.msg, num: this.size(), url: item.url }); }
        , removeLastItem: function () {
            this.items.pop();
            var last = this.getLastItem();
            if (last) { this.set({ title: last.title, mid: last.mid, msg: last.msg, num: this.size(), url: last.url }); } else { this.destroy(); }
        }
        , getLastItem: function () { return _.last(this.items); }
        , size: function () { return this.items.length; }
        , getData: function () { return $({}, this.getLastItem(), { num: this.size() }); }
        , sync: function () { }
    });
    var MsgList = Backbone.Collection.extend({ model: Msg, url: 'index.php',
        addItem: function (item) {
            var self = this, model = this.findWhere({ id: item.id });
            if (model) {
                model.addItem(item);
            }
            else {
                this.add(item);
                item.autoClose && setTimeout((function (id) { return function () { var item = self.findWhere({ id: id }); item && item.destroy(); calculateItemPosition(); } })(item.id), 6000);
            }
        }
        , removeGroup: function (id) { var models = this.where({ id: id }); this.remove(models); return; models.each(function (model) { model.unset(); }); }
        , clear: function (noagain) { var self = this; this.each(function (model) { model.destroy(); }); !noagain && setTimeout(function () { self.clear(1) }, 100); }
    });
    var msgs = new MsgList; window.msgs = msgs;
    var MsgView = Backbone.View.extend({ tagName: "li",
        template: $("#item-template").template(),
        events: { "click .msg-close": "destroy", "click": "clickHandle", "click .ignore-this": "destroy", "click .ignore-all": "ignoreAllMessage" }
        , initialize: function () {
            var self = this;
            _.bindAll(this, 'render', 'remove');
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
        }
        , render: function () { var data = this.model.toJSON(); var element = jQuery.tmpl(this.template, data); $(this.el).html(element); return this; }
        , remove: function () { $(this.el).remove(); msgs.ignoreThis && msgs.ignoreThis(this.model); }
        , destroy: function () { this.model.destroy(); calculateItemPosition(); return false; }
        , clickHandle: function () {
            if (this.model.items.length <= 1) { this.destroy(); }

            msgs.clickCallback && msgs.clickCallback(this.model);
            this.model.removeLastItem();
        }
        , ignoreAllMessage: function () { msgs.ignoreAll && msgs.ignoreAll(this); return false; }
    });
    var ListView = Backbone.View.extend({ el: $('.msg-list'),
        initialize: function () {
            _.bindAll(this, 'addOne', 'addAll');
            msgs.bind('add', this.addOne);
            msgs.bind('refresh', this.addAll);
            msgs.bind('reset', this.removeAll);
        },
        addOne: function (msg) { var view = new MsgView({ model: msg }); $('.msg-list').prepend(view.render().el); calculateItemPosition(); }
    , addAll: function () { msgs.each(this.addOne); }
    , removeAll: function () { $('.msg-list').animate({ right: -300, opacity: 0 }, { duration: 500, complete: function () { $('.msg-list li').remove(); $(this).css({ right: 0, opacity: 1 }) } }); }
    });
    var calculateItemPosition = (function () {
        var timer;
        return function () {
            timer && clearTimeout(timer);
            timer = setTimeout(function () { _calculateItemPosition(); }, 300);
        }
    })();

    function _calculateItemPosition() {
        var totalHeight = $('.center').height() + parseInt(jQuery('.center').css('bottom')) - 75,
        singleHeight = $('.msg-list .msg-wrapper').outerHeight(true) || 70,
        itemCount = Math.floor(totalHeight / singleHeight),
        elBottom = totalHeight - itemCount * singleHeight,
        el = $('.msg-list');
        if (itemCount >= msgs.length) {
            elBottom = totalHeight - msgs.length * singleHeight; el.animate({ bottom: elBottom });
            if (msgs.length <= 0) { el.animate({ bottom: 1200 }); }
        } else { el.animate({ bottom: (elBottom + 5) }); }
    }

    $(window).resize(calculateItemPosition);
    var Alert = function (msg, type) {
        $('#mini-notification').miniNotification({ closeButton: true, closeButtonText: 'x',
            closeButtonClass: 'closeMsg',
            onLoad: function () { $('#mini-notification .inner p').text(msg); $('#mini-notification').addClass(type); }
        });
    };
    function bindEvents(tD) {
        tD.EventManager.on('alert', function (arg) { Alert(arg.content, arg.type); });
        tD.EventManager.on('message:create', function (cfg) {
            var arg;
            if (cfg.type_id == 'message') {
                arg = { id: cfg.type_id + '-' + cfg.from_id, mid: cfg.type_id, closable: true, title: cfg.from_name, msg: $('<div>').html(cfg.content).text(), module: 'message', autoClose: false, key: cfg.sms_id, url: cfg.url, data: cfg };
            } else {
                arg = { id: cfg.type_id + '-' + cfg.from_id, mid: cfg.type_id, closable: true, title: cfg.from_name, autoClose: !cfg.url, msg: cfg.type_name, key: cfg.sms_id, url: cfg.url, data: cfg };
            }
            if (cfg.receive !== "1") { return; }
            msgs.addItem(arg);
        });
        tD.EventManager.on('message:remove', function (arg) { });
        tD.EventManager.on('message:clear', function (arg) {
            msgs.trigger('reset'); msgs.reset();
        });
        msgs.clickCallback = function (model) {
            var eventType = model.get('module') == 'message' ? 'msg:read' : 'notify:read';
            if (eventType == 'msg:read') { model.destroy(); calculateItemPosition(); }
            tD.EventManager.trigger(eventType, model.getLastItem().data);
        };
        msgs.ignoreThis = function (model) { tD.EventManager.trigger('message:remove', model); };
        msgs.ignoreAll = function (view) { tD.EventManager.trigger('message:clear', view); };
        //Alert("测试系统", "success");
    }
    module.exports = { init: function (tDesktop) { var app = new ListView; bindEvents(tDesktop); } };
});
/* "/static/js/tDesktop/tDesktop.Pulse.js" */
define('tDesktop/tDesktop.Pulse', function (require, exports, module) {
    var $ = window.jQuery;
    exports.pulseFormer = function () {
        $('#progressBar').removeClass('done');
        $({ property: 7 }).animate({ property: 60 }, { duration: 3000, step: function () {
            var percentage = Math.round(this.property);
            $('#progressBar').css('width', percentage + '%');
        } 
        });

        setTimeout(function () { exports.pulseLater(); }, 1000);
    };

    exports.pulseLater = function () {
        $({ property: 60 }).animate({ property: 100 },
        { duration: 500, step: function () {
            var percentage = Math.round(this.property); 
            $('#progressBar').css('width', percentage + '%');
            if (percentage == 100) { $('#progressBar').addClass('done'); }
        } 
    }); } 
});

/* "/static/js/tDesktop/tDesktop.Tabs.js" */
define('tDesktop/tDesktop.Tabs', function (require, exports, module) {
    var $ = window.jQuery;
    var pulser = require('tDesktop/tDesktop.Pulse');
    var Tabs = {
        init: function () { this.initTabs(); },
        initTabs: function () {
            var self = this; $(window).resize(function () { self.resizeLayout(); }); self.resizeLayout();
            $('#tabs_container').tabs({
                tabsLeftScroll: 'tabs_left_scroll',
                tabsRightScroll: 'tabs_right_scroll',
                panelsContainer: 'center',
                secondTabsContainer: 'funcbar_left'
            });
            $('#funcbar_left').delegate('.second-tab-item', 'click', function () {
                var self = $(this); var url = self.attr('action');
                var id = self.attr('secondTabId');
                $("#tabs_" + id + "_iframe").attr('src', url);

                jQuery('a.active', self.parent()).removeClass('active');
                jQuery(this).addClass('active');

            });
        },
        resizeLayout: function () {
            var wWidth = (window.document.documentElement.clientWidth || window.document.body.clientWidth || window.innerHeight);
            var width = wWidth - $('#logo').outerWidth() - $('#infobar').outerWidth();
            $('#tabs_container').width(width - $('#tabs_left_scroll').outerWidth() - $('#tabs_right_scroll').outerWidth() - 2);
            $('#taskbar').width(width - 2);
            $('#tabs_container').triggerHandler('_resize');
        },
        createTab: function (id, name, code, open_window) {
            var self = this;
            jQuery('#funcbar_left > div.second-tabs-container').hide();
            var url = code;
            if (open_window == "1") {
                self.openURL(id, name, url, open_window);
                return;

            }
            else if (url != "") {
                self.openURL(id, name, url, open_window);
            }
            if (id.length < 13) return;
            //加载四级菜单
            jQuery.ajax({ type: 'GET', url: 'TreeNode.aspx?_rnd=' + Math.random(), data: { 'parentnode': id }, dataType: 'text',
                success: function (data) {
                    var index = 0; var html = '';
                    var array = self.Text2Object(data);
                    if (typeof (array) != "object" || typeof (array.length) != "number") {
                        //self.openURL(id, name, url, open_window);  
                        return;
                    }

                    array = array[0].ChildNodes;
                    if (array == null || array.length == 0) {
                        //html += '<a title="后退"  secondTabId="' + id + '" class="second-tab-item" action="' + url + '" hidefocus="hidefocus"><span>后退</span></a>';
                        html += '<a title="刷新"  secondTabId="' + id + '" class="second-tab-item active" action="' + url + '" hidefocus="hidefocus"><span>刷新</span></a>';
                        html = '<div id="second_tabs_' + id + '" class="second-tabs-container">' + html + '</div>';
                        jQuery(html).appendTo('#funcbar_left');
                        return;
                    }

                    self.addTab(id, name, array[0].value, true);

                    for (var i = 0; i < array.length; i++) {
                        var className = (i == 0) ? ' class="second-tab-item active"' : 'class="second-tab-item"';

                        html += '<a title="' + array[i].text + '"  secondTabId="' + id + '"' + className + ' action="' + array[i].value + '" ' + ' hidefocus="hidefocus"><span>' + array[i].text + '</span></a>';
                    }

                    html = '<div id="second_tabs_' + id + '" class="second-tabs-container">' + html + '</div>';
                    jQuery(html).appendTo('#funcbar_left');

                    var secondTabs = jQuery('#second_tabs_' + id);
                    jQuery('a', secondTabs).click(function () {
                        jQuery('a.active', secondTabs).removeClass('active');
                        jQuery(this).addClass('active');
                    });
                    if (jQuery('a.active', secondTabs).length <= 0)
                        jQuery('a:first', secondTabs).addClass('active');
                    jQuery('a:last', secondTabs).addClass('last');


                },
                error: function (request, textStatus, errorThrown) {
                    self.openURL(id, name, url, open_window);
                }
            });
        },
        addTab: function (id, title, url, closable, selected, callback) {
            var self = this;
            if (!id) return;
            closable = (typeof (closable) == 'undefined') ? true : closable;
            selected = (typeof (selected) == 'undefined') ? true : selected;
            var height = '100%';
            jQuery('#tabs_container').tabs('add', { id: id, title: title, closable: closable, selected: selected,
                style: 'height:' + height + ';',
                content: '<iframe id="tabs_' + id + '_iframe" name="tabs_' + id + '_iframe" allowTransparency= "true"'
                    + (!selected ? (' _src="' + url + '"') : '') + ' src="' + (selected ? url : '') + '"' + (selected ? (' onload="IframeLoaded(\'' + id + '\');"') : '')
                    + ' border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" style="width:100%;height:' + height + ';"></iframe>',
                callback: function () { pulser.pulseFormer(); callback && callback(); }
            });
        },
        selectTab: function (id) { $('#tabs_container').tabs('select', id); },
        closeTab: function (id) { $('#tabs_container').tabs('close', id); },
        getSelected: function () { return $('#tabs_container').tabs('selected'); },
        isTouchDevice: function () { try { document.createEvent("TouchEvent"); return userAgent.indexOf("mobile") >= 0 || userAgent.indexOf("maxthon") < 0; } catch (e) { return false; } },
        openURL: function (id, name, url, open_window, width, height, left, top) {
            var self = this;
            id = !id ? ('w' + (nextTabId++)) : id;
            if (open_window != "1") {
                window.setTimeout(function () { self.addTab(id, name, url, true) }, 1);
            }
            else {
                width = typeof (width) == "undefined" ? 780 : width;
                height = typeof (height) == "undefined" ? 550 : height;
                left = typeof (left) == "undefined" ? (screen.availWidth - width) / 2 : left;
                top = typeof (top) == "undefined" ? (screen.availHeight - height) / 2 - 30 : top;
                window.open(url, id);
            }
        },
        Text2Object: function (data) {
            var self = this; try { var func = new Function("return " + data); return func(); }
            catch (ex) { return '<b>' + ex.description + '</b><br /><br />' + self.HTML2Text(data) + ''; }
        },
        HTML2Text: function (html) { var div = document.createElement('div'); div.innerHTML = html; return div.innerText; },
        IframeLoaded: function (id) {
            var iframe = window.frames['tabs_' + id + '_iframe'];
            if (iframe && $('#tabs_link_' + id) && $('#tabs_link_' + id).innerText == '')
            { $('#tabs_link_' + id).innerText = !iframe.document.title ? td_lang.inc.msg_27 : iframe.document.title; }
            pulser.pulseLater();
        }
    };
    exports.Tabs = Tabs;
});
/* "/static/js/tDesktop/tDesktop.Theme.js" */
define('tDesktop/tDesktop.Theme', function (require, exports, module) {
    var $ = window.jQuery; var Theme = { init: function () { this.bindEvent(); }, bindEvent: function () {
        var self = this; $("#theme").click(function () {
            $('#theme').toggleClass('on'); if ($("#theme_panel:visible").length) { $("#theme_panel").slideUp(); $('#overlay_theme').hide(); return; }
            if ($('#theme_slider').text() == "") {
                for (var id in themeArray) {
                    if (themeArray[id].src == "") return;
                    var aobj = $('<a class="theme_thumb" hidefocus="hidefocus"><img src="' + themeArray[id].src + '" /><span>' + themeArray[id].title + '</span></a>');
                    aobj.attr("index", id);
                    $('#theme_slider').append(aobj); 
                }
                $('#theme_slider a.theme_thumb').each(function () {
                    var index = $(this).attr("index");
                    if (ostheme == index) { $(this).find("span").addClass("focus"); } 
                }); 
                $("#theme_slider").delegate('a.theme_thumb', 'click', function () {
                    var index = $(this).attr("index"); 
                    if (ostheme == index) { return; }
                    self.setTheme(index); $('#theme_slider a.theme_thumb span').removeClass("focus"); 
                    $(this).find("span").addClass("focus");
                });
            }
            $('.over-mask-layer').hide(); $('#overlay_theme').show(); $('#theme_panel').slideDown();
        }); $('#overlay_theme').click(function () { $('#theme').trigger('click'); });
    }, setTheme: function (themeid) { var flag = false; $.ajax({ async: false, data: { "themeid": themeid }, url: '/general/person_info/theme/switch.php', success: function (r) { if (r == "+ok") { flag = true; window.location.reload(); } } }); return flag; } 
    }; exports.Theme = Theme;
});
/* "/static/js/tDesktop/tDesktop.Today.js" */
define('tDesktop/tDesktop.Today', function (require, exports, module) {

    var $ = window.jQuery;
    require('backbone');
    var Deskdate = Backbone.View.extend({ el: $('.dateArea'),
        events: { 'click div#date': 'openCal', 'click div#mdate': 'openCal', 'click div#time_area': 'openTime' },
        initialize: function () {
            _.bindAll(this, 'openCal', 'openTime');
            var solarTerm = "";
            if (solarTerm != "")
                $('#mdate').text(solarTerm);
        },
        openCal: function () { return; $().addTab('dt_date', "万年历", "http://rili.zhwnl.cn/", false); },
        openTime: function () { return; }
    });

    var Calendar = Backbone.View.extend({
        initialize: function () { this.render(); },
        render: function () {
            var now = new Date();
            if ($("#cal_list").children().length == 0)
                $("#caltip").show();

            return;
            $.ajax({ url: '#',
                data: { starttime: now.getTime() / 1000, endtime: now.getTime() / 1000, view: "agendaDay" },
                async: true,
                type: 'get',
                success: function (d) {
                    if (d.length > 0) {
                        $.each(d, function (k, v) {
                            $("#calendar-template").tmpl(v).appendTo('#cal_list');
                        });
                    }
                    else {
                        $("#caltip").show();
                    }
                }
            });
        }
    });

    var Reminder = Backbone.View.extend({
        initialize: function () { this.render(); },
        render: function () {
            return;
            $.ajax({ url: '#', data: "", async: true, type: 'get',
                success: function (d) {
                    if (d.length > 0) { $.each(d, function (k, v) { $("#reminder-template").tmpl(v).appendTo('#remind_list'); }); }
                    else { $("#remindtip").show(); }
                }
            });
        }
    });
    exports.Today = { Deskdate: Deskdate, Calendar: Calendar, Reminder: Reminder };
});
//增加菜单
function menuSave(menuId) {
    var obj = $(event.srcElement);
    var flag = false;
    if (menuId.substring(0, 1) == 'f') {
        flag = true;
        menuId = menuId.substring(1);
    }
    if (obj.hasClass("menu-star1")) {
        obj.removeClass("menu-star1").addClass("menu-star2");
        addMenu(menuId);
    }
    else {
        if (flag) {
            obj.closest('li').remove();
            $("#" + menuId + " span").removeClass("menu-star2").addClass("menu-star1");
        }
        else {
            obj.removeClass("menu-star2").addClass("menu-star1");
            $("#f" + menuId).closest('li').remove();
        }
    }
    jQuery.ajax({ type: 'GET', url: 'Unsafe/service.ashx?t=menufav&_rnd=' + Math.random()
        , data: { 'funId': menuId }
        , dataType: 'text',
        success: function (data) {
            layer.msg('操作成功！', {time:500, offset: ['70px', '320px'] });
        },
        error: function (request, textStatus, errorThrown) {
            layer.msg('操作时出错！', { offset: ['70px', '320px'] });
        }
    });
    event.stopPropagation();
}

//添加收藏
function addMenu(menuId) {
    var menuObj = $("#" + menuId);
    var click = menuObj.attr("onclick");
    var func_id = "f" + menuId;
    var func_name = menuObj.attr("title");

    var li = $("#menufav").parent();
    if (li.length == 0)
        return;
    var ul = li.find("ul");
    if (ul.length == 0) ul = $("<ul class='third-menu'></ul>").appendTo(li);

    var tmpl = $("#thirdMenuTmpl").template();
    var onclick = click.replace(menuId, func_id);

    var model = {};
    model["parentId"] = "";
    model["menuId"] = func_id;
    model["menuText"] = func_name;
    model["expand"] = false;
    model["actionType"] = onclick;
    model["favorite"] = true;

    var el = jQuery.tmpl(tmpl, model);
    ul.append(el);
}
