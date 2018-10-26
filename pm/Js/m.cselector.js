/* uiZjs v1.0.3 - http://www.uizjs.cn - uizjs.cn/license 

基础JS模型 uiZjs选择器组件 表格、表单、下拉列表、复选按钮组、下拉复选按钮组、单选按钮组、树、下拉树、下拉复选树、图片选择器、幻灯片等
 
更新日志：
待实现功能：1点击表头排序 2设置显示列
版本2.0.0 日期20170725 2.0版本提炼 将源文件放在主框架中 其他的md5和面向对象重构迁移到jquery文件 包括其他plugins插件
*/
//声明zjs命名空间
if (!window.zjs) { zjs = {}; };
if (!window.zjss) { zjss = {} };
if (!window.zjsss) { zjsss = {} };

/*执行命令*/
zjs.success = function (e, data) {
    //处理公共返回消息
    var rep = data.responseid == undefined ? data.ResponseID : data.responseid;
    var meg = data.message == undefined ? data.Message : data.message;
    var dat = data.data == undefined ? data.Data : data.data;
    if (meg && meg != "") {
        if (zjs.message) {//如果有自定义处理函数 就按自定义走
            zjs.message(data);
        } else if (e.message) {//如果有自定义处理函数 就按自定义走
            e.message(data);
        } else {//如果没有 就按公共的走
            zjs.tips(meg, rep, undefined, e);
        }
    }
    if (rep != undefined) {
        if (zjs.checkrep(rep)) {//检验responseid是否是失败 如果是失败就调用alwayscallback
            if (e.alwayscallback) {//执行错误的回执操作 .NET下0成功 >0都是各种失败  JAVA的是0失败 1成功
                e.alwayscallback(dat);
            }
        } else {//如果不是失败 那就是成功了 执行callback
            if (e.callback) {//执行回执操作 
                e.callback(dat);
            }
        }
    } else {//如果没有ResponseID 就认为是精简模式 直接返回data 
        if (e.callback) {//执行回执操作 
            e.callback(data);
        }
    }
};
zjs.cmd = function (e) {
    var async = true;//默认异步
    if (!e.async) {//如果用户传了同步 就用用户的
        async = e.async;
    }
    //默认的url和Data参数都是.NET语法 .NET为统一一个接收地址 通过不同的cmd参数来反射不同的函数
    var url = zjs.cmdurl + (zjs.cmdurl.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
    var data = { cmd: e.cmd, para: $.toJSON(e.para) };
    if (zjs.cmdurl == "") {//如果不是.NET语法的统一的处理 那就是类似JAVA的每一个命令都是自己的地址
        var dir = zjs.rootdir;//默认命令的目录都是zjs.rootdir为前缀的
        if (zjs.cmddir)//如果专门又配置了cmddir那就以它为前缀
            dir = zjs.cmddir;
        //最终的地址为 目录+命令地址+时间戳 是为了怕AJAX有缓存 每次发命令都取最新数据
        if (dir.indexOf("{{cmd}}") > -1) {//新模式 可以配置为命令穿插其中 
            //比如假数据的地址为/data/index.txt那么配置/data/{{cmd}}.txt 转换成服务器端模式后就变成了/api/1.0/{{cmd}}
            url = (dir.replace("{{cmd}}", e.cmd)) + (e.cmd.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
        } else {
            url = dir + e.cmd + (e.cmd.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
        }
        data = e.para;
    }
    if (e.url) {//如果命令写死了url属性 那上面的一堆地址都无效 直接使用命令中的
        url = e.url;
    }
    var ajaxpara = {//打包ajax数据
        async: async, url: url, data: data, type: zjs.cmdtype,
        success: function (data) {//假数据模式下 zepto使用ajax请求数据时会出现406报错 不要加json模式就好了
            zjs.success(e, $.evalJSON(data));//默认假数据模式 返回的是字符串 再转换成JSON对象
        }
    };
    if (!zjs.uitest) { //如果不是假数据模式就按照正常的请求json
        ajaxpara.dataType = "json";
        ajaxpara.success = function (data) {
            zjs.success(e, data);
        }
    }
    if (zjs.contentType) {//如果全局配置的有命令类型 就用全局的
        ajaxpara.contentType = zjs.contentType;
    }
    if (e.contentType) {//如果传的类型 就使用传的
        ajaxpara.contentType = e.contentType;
    }
    if (ajaxpara.contentType) {
        if (ajaxpara.contentType.indexOf("json") > -1) {
            ajaxpara.data = $.toJSON(e.para);//如果最终的类型是json
        }
    }
    //如果有备用命令目录 那么当服务器端接口没有开发完成的时候 可以转到前端接口
    ajaxpara.error = function (XMLHttpRequest, textStatus, errorThrown) {
        if (zjs.backcmddir) {
            if (XMLHttpRequest.status == "404") {
                ajaxpara.error = null;
                ajaxpara.url = (zjs.backcmddir.replace("{{cmd}}", e.cmd)) + (e.cmd.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
                $.ajax(ajaxpara);
            }
        }
        if (zjs.myexception) {
            zjs.myexception(XMLHttpRequest);
        }
    };
    //AJAX发起命令
    $.ajax(ajaxpara);
};
zjs.getparent = function () {
    try {
        top["test"] = 1;//跨域情况下 尝试访问top顶层对象 如果可以访问就访问不行就继续下面
        return top;
    } catch (ex) { };
    try {
        parent["test"] = 1;//跨域情况下 尝试访问parent父层对象 如果可以访问就访问不行就继续下面
        return parent;
    } catch (ex) { };
    return window;//不能访问 就用当前对象
};
//短暂提示
zjs.tips = function (message, succ, time, e) {
    if (zjs.lhgtips) {//如果有lhg的 就表示是PC端 按PC端提示
        if (succ != undefined) {//如果没有传 就显示是loading
            if (zjs.checkrep(succ)) {//如果大于0 表示失败 
                //zjs.lhgtips(message, (time || 3.5), "e.png");
                zjs.lhgtips("", 0.1, "loading.gif");
                setTimeout(function () {
                    zjs.alert("<table><tr><td width='22'><img src='" + zjs.rootdir + "img/e.png'/></td><td style='line-height:20px;'>" + message + "</td></tr></table>");
                }, 300);
            } else {//小于等于0表示成功
                if (e && e.isalert) {
                    zjs.lhgtips("", 0.1, "loading.gif");
                    alert(message);
                } else {
                    zjs.lhgtips(message, (time || 2.5), "s.png");
                }
            }
        } else {
            zjs.lhgtips(message, (time || 1.5), "loading.gif");
        }

    } else {
        $("div.zjstips").remove();
        var $msg = $("<div class='zjstips zjstips" + succ + "'>" + message + "</div>");//加上样式名 以后显示什么图片在css里定义
        //    $msg.append("<img src='" + zjs.rootdir + "img/loading.gif' align='left' />");

        $("body").append($msg);//追加提示语
        $msg.css({ "left": ($("body").width() - $msg.width()) / 2 });
        $msg.click(function () {//点击删除
            $msg.remove();
        });
        setTimeout(function () {//超时删除
            $msg.remove();
        }, (time || 1500));
    }
};
/*! 得到URL中参数的值 */
zjs.getQueryStr = function () {
    var qs = {};
    var url = decodeURIComponent(window.location.href);
    if (zjs.isredirect) {//如果有伪静态 就得分割出页面编号和编号
        if (url.indexOf('htm') > -1) {
            url = url.substring(url.indexOf('/', 7) + 1);//http:// 7位
            var paras = ["pageid", "id"];
            var prm = url.split('/');
            if (url.indexOf("_") > -1) {
                prm = url.split('_');
            }
            for (var p in prm) {
                var index = prm[p].split('.');
                if (/^\d+$/.test(index[0])) {
                    qs[paras[p]] = index[0];
                }
            }
        } else {//如果不是子页面 就只判断页面编号
            url = url.substring(url.indexOf('/', 7) + 1);//http:// 7位 
            var prm = url.split('/');
            if (/^\d+$/.test(prm[0])) {
                qs.pageid = prm[0];
            }
        }
    }

    //不管有没有伪静态 都看一下?问号后面的参数
    if (url.indexOf('?') > -1) {
        url = url.substring(url.indexOf('?') + 1);
        var prm = url.split('&');
        for (var p in prm) {
            if (prm[p]) {
                var sp = prm[p].split('=');
                if (sp.length > 1) {
                    var spkey = sp[0];
                    var spvalue = sp[1];

                    if (spvalue.indexOf('#') > -1) {
                        spvalue = spvalue.substring(0, spvalue.indexOf('#'));
                    }
                    qs[spkey] = spvalue;
                }
            }
        }
    }
    return qs;
};
zjs.getParas = function (url) {
    var qs = {};
    //不管有没有伪静态 都看一下?问号后面的参数 
    var prm = url.split('&');
    for (var p in prm) {
        var sp = prm[p].split('=');
        qs[sp[0]] = sp[1];
    }
    return qs;
};
//zjs.openidlogin();//调用使用openid等登录
zjs.refreshimage = function ($t) {
    var url = $t.attr("imageurl") + "?tm=" + (new Date()).getTime();
    $t.children("img").attr("src", url);
};
//扩展数组方法 按下标删除数组
zjs.removeArray = function (array, dx) {
    if (isNaN(dx) || dx > array.length) { return false; }
    for (var i = 0, n = 0; i < array.length; i++) {
        if (array[i] != array[dx]) {
            array[n++] = array[i];
        }
    }
    array.length -= 1;
};
//确认框
zjs.confirm = function (msg, callback, nocallback) {
    if (zjs.lhgconfirm) {
        zjs.lhgconfirm(msg, callback, nocallback);
    } else {
        if (window.confirm(msg)) {
            callback();
        } else {
            if (nocallback) nocallback();
        }
    }
};
/*日期格式化*/
zjs.dateformat = function (value, dateformat) {
    if (value && dateformat) {
        var reg = /(\d{4})\S(\d{1,2})\S(\d{1,2})[\S\s](\d{1,2}):(\d{1,2}):(\d{1,2})/;
        var regdate = /(\d{4})\S(\d{1,2})\S(\d{1,2})/;
        if (reg.test(value) && value.toString().length < 20) {
            var result = value.match(reg);
            dateformat = dateformat.replace("yyyy", result[1]); //代表年
            dateformat = dateformat.replace("MM", result[2]);   //代表月
            dateformat = dateformat.replace("dd", result[3]);   //代表日
            dateformat = dateformat.replace("hh", result[4]);   //代表时
            dateformat = dateformat.replace("mm", result[5]);   //代表分
            dateformat = dateformat.replace("ss", result[6]);   //代表秒
            if (dateformat == "diff") {
                return zjs.getDateDiff(result[1] + "/" + result[2] + "/" + result[3] + " " + result[4] + ":" + result[5] + ":" + result[6]);
            }
            return dateformat;
        } else if (regdate.test(value) && value.toString().length < 20) {
            var result = value.match(regdate);
            dateformat = dateformat.replace("yyyy", result[1]); //代表年
            dateformat = dateformat.replace("MM", result[2]);   //代表月
            dateformat = dateformat.replace("dd", result[3]);   //代表日 
            if (dateformat == "diff") {
                return zjs.getDateDiff(result[1] + "/" + result[2] + "/" + result[3] + "");
            }
            return dateformat;
        }
    }
    return value;
};
zjs.getnow = function (dateformat) {
    var d = new Date();
    if (!dateformat) dateformat = "yyyy-MM-dd";
    dateformat = dateformat.replace("yyyy", d.getFullYear()); //代表年
    dateformat = dateformat.replace("MM", d.getMonth() > 8 ? d.getMonth() + 1 : "0" + (d.getMonth() + 1));   //代表月
    dateformat = dateformat.replace("dd", d.getDate() > 9 ? d.getDate() : "0" + d.getDate());   //代表日
    dateformat = dateformat.replace("hh", d.getHours() > 9 ? d.getHours() : "0" + d.getHours());   //代表时
    dateformat = dateformat.replace("mm", d.getMinutes() > 9 ? d.getMinutes() : "0" + d.getMinutes());   //代表分d.getMinutes()
    dateformat = dateformat.replace("ss", d.getSeconds() > 9 ? d.getSeconds() : "0" + d.getSeconds());   //代表秒d.getSeconds()
    return dateformat;
};
//获取数组中所有字段=值的记录   数组 值 字段
zjs.getmylist = function (data, id, idkey) {
    var temp = [];
    for (var di in data) {
        var datai = data[di];
        if (datai[idkey] == id) {
            temp.push(datai);
        }
    }
    return temp;
};
//获取数组中对应的一条记录
zjs.getmyobject = function (data, id, idkey) {
    var temp = {};
    for (var di in data) {
        var datai = data[di];
        if (datai[idkey] == id) {
            temp = datai;
        }
    }
    return temp;
};
//复制对象
zjs.copyobject = function (data) {
    var newobj = {};
    for (var di in data) {
        newobj[di] = data[di];
    }
    return newobj;
};

/*单行渲染*/
zjs.fastrenderRow = function (datai, render) {
    var row = render;
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), datai[attr]);
    }
    return row;
};
/*数组渲染*/
zjs.fastrender = function (data, render) {
    var tmp = [];
    for (var i = 0; i < data.length; i++) {
        var datai = data[i];//当前行 
        datai.datai = i;
        tmp.push(zjs.fastrenderRow(datai, render));
    }
    return (tmp.join(''));
};
/*数据预处理*/
zjs.htmlinit = function (value, htmlbox, colname) {
    var rvalue = value;
    if (typeof rvalue == "string") {
        if ((value + "").indexOf("<") > -1) {//如果值里面有< 这种HTML的起始关键元素的话 就把整个值HTML编码一下
            if (htmlbox) {//如果传的有htmlbox 说明有非强制过滤字段 
                if (htmlbox.indexOf(colname) > -1) {
                    //那么判断一下当前的字段是不是需要 不过滤HTML内容
                    return value;
                } else {//否则就过滤一下HTML
                    rvalue = zjs.htmlEncode(value);
                }
            } else {//如果没传htmlbox 而元素中有HTML 就直接过滤
                rvalue = zjs.htmlEncode(value);
            }
        }//如果元素里没有HTML标签 就不用管了  
        rvalue = rvalue.replace(new RegExp(" ", 'g'), "&nbsp;");
    }

    return rvalue;
};
/*单行渲染*/
zjs.renderRow = function (datai, render, dateformat, htmlbox) {
    var row = render;//new RegExp是正则表达式替换全局的语法 'g'为全局 为了解决js的替换bug 正常情况下js只能替换第一个
    if (row.indexOf("zjs-src") > -1) {
        row = row.replace(new RegExp("zjs-src", 'g'), "src");
    }
    if (row.indexOf("zjs-style") > -1) {
        row = row.replace(new RegExp("zjs-style", 'g'), "style");
    }
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), zjs.htmlinit(datai[attr], htmlbox, attr));
    }
    return row;
};
/*数组渲染*/
zjs.render = function (data, render, dateformat, htmlbox) {
    var tmp = [];
    for (var i = 0; i < data.length; i++) {
        var datai = data[i];//当前行 
        datai.datai = i;
        tmp.push(zjs.renderRow(datai, render, dateformat, htmlbox));
    }
    return (tmp.join(''));
};
//设置table固定宽度
zjs.tdfixed = function ($id) {
    if ($id.children("thead.tfixed").length > 0) {//如果是表格模式 并启动固定宽模式
        if (!$id.children("thead.tfixed").attr("basewidth")) {//如果有基础宽度 那么就拿浏览器宽－基础宽 如果没有设置 就按照所有twidth的合自动设置
            var hjbasewidth = 0;
            $id.children("thead.tfixed").children("tr.trth").find("td").each(function (tdi, tdv) {
                var $td = $(tdv);
                if ($td.attr("twidth")) {
                    hjbasewidth += parseFloat($td.attr("twidth").replace("px", ""));
                }
            });
            $id.children("thead.tfixed").attr("basewidth", hjbasewidth);
            if (hjbasewidth > $id.parent().width()) {//如果总宽大于浏览器 就设置table宽为总宽 否则为98%
                $id.width(hjbasewidth);
            }
        }
        var $tbody = $id.children("tbody").find("tr");
        var tdlength = $id.children("thead.tfixed").children("tr.trth").find("td").length;
        var basewidth = parseInt($id.children("thead.tfixed").attr("basewidth"));
        var tablewidth = $id.width();
        var fpwidth = tablewidth - basewidth - (tdlength * 16);//剩余可分配宽度
        $id.children("thead.tfixed").children("tr.trth").find("td").each(function (tdi, tdv) {//先设置thead本身的宽度
            var $td = $(tdv);
            if (!$td.attr("tfixed")) {
                $td.attr("tfixed", "1");
                if ($td.attr("twidth")) {//如果这一列固定宽度就继续 没有不用
                    var tdwidth = parseFloat($td.attr("twidth").replace("px", ""));
                    if (fpwidth >= 0) {//如果当前浏览器宽度比基准宽大 就按照bwidth比例分配多余的宽
                        if ($td.attr("bwidth")) {
                            tdwidth = tdwidth + parseFloat($td.attr("bwidth")) * fpwidth;
                        }
                    }
                    //else {//如果浏览器宽度比基准小 就平均减少   不减少
                    //    tdwidth = tdwidth * (tablewidth / basewidth) - 10;
                    //    if (tdwidth < 0) tdwidth = 30;//最少不能小于30像素宽
                    //}
                    $td.attr("width", tdwidth).html("<div class='tdfixed' style='width:" + tdwidth + "px;'>" + $td.html() + "</div>");
                }
            }
        });
        $id.children("thead.tfixed").children("tr.trth").find("td").each(function (tdi, tdv) {
            var $td = $(tdv);
            if ($td.attr("width")) {//如果这一列固定宽度 就把所有内容列都加上固定宽度
                var tdwidth = parseFloat($td.attr("width").replace("px", ""));
                $tbody.each(function (tri, trv) {//循环每一行的这一列
                    var $tr = $(trv);
                    if ($tr.find("td").length == tdlength) {//如果td数量和表头一样 再设置 title='" + $std.text() + "'
                        var $std = $tr.find("td").eq(tdi);
                        if (!$std.attr("tfixed")) {
                            $std.attr("tfixed", "1");
                            $std.html("<div class='tdfixed' style='width:" + tdwidth + "px;'>" + $std.html() + "</div>");
                        }
                    }
                });
            }
        });
    }
};
//设置布局宽高
zjs.locksetlayout = function ($id, myheight, iskong) {
    $(".locktable-body .markbox").width($(".locktable-header-left").width());//设置蒙滚动条层宽
    $(".locktable-body-left").width($(".locktable-header-left").width() + 35);//设置内容左侧的宽是头左侧宽+35 把滚动条隐藏里面去
    $(".locktable-body-right").css("margin-left", $(".locktable-header-left").width());//设置右侧左边距

    var hrwidth = $(".locktable-box").width() - $(".locktable-header-left").width() - 30;//布局总宽-左侧宽是右侧的宽  再-30是为了不超出

    if ($(window).width() < 1024 && iskong == true && zjs.ieversion() == "7") {//如果是小屏 并且没有数据的情况下 要再-80像素 要不然宽超出来了
        var hrwh = 0;
        switch ($(".locktable-header-left").width()) {
            case 300:
                hrwh = 80;
                break;
            case 230:
                hrwh = 10;
                break;
            case 150:
                hrwh = -10;
                break;
        }
        hrwidth = hrwidth - hrwh;
    }
    $(".locktable-header-right,.locktable-body-right").width(hrwidth); //设置头和主右侧的宽

    var h = $(window).height() - myheight;
    if ($id.height() > 20 && $id.height() < ($(window).height() - myheight - 50)) {//如果主体内容不多 高度在20以上 并且不到底 的话 就按照主体内容的高来设置容器
        h = $id.height() + 20;
    }
    $(".locktable-body-left,.locktable-body-right").height(h);
    $(".locktable-body .markbox").css("top", h - 18);
};
//设置锁表头的滚动条
zjs.lockready = function ($id, myheight, iskong) {
    zjs.locksetlayout($id, myheight, iskong);
    if (!$(".locktable-body-right").attr("isscroll")) {
        $(".locktable-body-right").attr("isscroll", "1");
        $(".locktable-body-right").scroll(function (e) {
            $(".locktable-header-right").scrollLeft($(".locktable-body-right").scrollLeft());
            $(".locktable-body-left").scrollTop($(".locktable-body-right").scrollTop());

            if (($(this).scrollTop() || e.pageY) > ($id.height() - $(this).height() - 50)) {
                $(".nextPage").trigger("click");
            }
        });
    }
};
//判断IE版本
zjs.ieversion = function () {
    var ua = navigator.userAgent;
    if (ua.indexOf("MSIE 7") > -1) {
        return "7";
    }
    if (ua.indexOf("MSIE 8") > -1) {
        return "8";
    }
    if (ua.indexOf("MSIE 9") > -1) {
        return "9";
    }
};
//渲染表单字段
zjs.renderForm = function ($id, datai) {
    for (var di in datai) {
        //如果属性本身就是object对象 就转一下字符串 再放进去
        var dvalue = typeof datai[di] == "object" ? $.toJSON(datai[di]) : datai[di];//字段原值
        if (dvalue == null || dvalue == undefined || dvalue == "null") dvalue = "";
        var dtext = dvalue;//用于展示时的值
        if (typeof dvalue == "string") {
            dtext = (dvalue).replace(new RegExp("\n", 'g'), "<br>").replace(new RegExp(" ", 'g'), "&nbsp;");//用于展示时的值 需要将换行和空格特殊处理
            if ((dvalue + "").indexOf("<") > -1) {//如果值里面有< 这种HTML的起始关键元素的话 就把整个值HTML编码一下 再处理换行和空格
                dtext = zjs.htmlEncode(dvalue).replace(new RegExp("\n", 'g'), "<br>").replace(new RegExp(" ", 'g'), "&nbsp;");
            }
        }

        var $did = $id.find("#" + di + ",." + di);
        $did.each(function (i, v) {
            if ($(v).parents("table[pathsave]").length == 0 && $(v).parents("table[savepath]").length == 0 && $(v).parents(".table[savepath]").length == 0) {
                switch (v.nodeName) {
                    case "I"://普通i展示 i用于展示时间 前5个展示类
                        $(v).html(zjs.dateformat(dvalue, $id.attr("dateformat")));
                        break;
                    case "SPAN"://普通input展示
                        $(v).html(dtext);
                        break;
                    case "DIV"://普通textarea展示
                        if ($(v).hasClass("htmlbox")) {
                            $(v).html(dvalue);
                        } else {
                            $(v).html(dtext);
                        }
                        break;
                    case "IMG"://图片展示
                        $(v).attr("src", dvalue);
                        break;
                    case "A"://超链接展示
                        $(v).attr("href", dvalue);
                        break;
                    case "TEXTAREA"://普通textarea 管理类
                        if ($(v).hasClass("ceditor") || $(v).hasClass("ceditormin") || $(v).hasClass("htmlbox")) {
                            $(v).val(dvalue).trigger("change");
                        } else {
                            $(v).val(zjs.htmlDecode(dvalue)).height($(v).height() - 1).trigger("change");
                        }
                        break;
                    case "TABLE"://多列模式
                        var trdatas = $.evalJSON(datai[di] || "[]");
                        var theadhtml = $(v).find("thead.hide").html();
                        var tbodyhtml = [];
                        tbodyhtml.push("<tbody>");
                        for (var i = 0; i < trdatas.length; i++) {
                            var trhtml = theadhtml;
                            var datatri = trdatas[i];//当前行  
                            if ($(v).attr("subid")) {
                                var subids = $(v).attr("subid").split('|');//subid配置项以字典格式 ,分割多子行 |分割字段名和模板
                                for (var sbi in subids) {
                                    var sbspl = subids[sbi].split(',');
                                    var sbid = sbspl[0];
                                    var sbtemp = sbspl[1];
                                    var sbdatas = $.evalJSON(datatri[sbid] || "[]");
                                    trhtml = trhtml.replace(new RegExp("#" + sbid + "#", 'g'), zjs.fastrender(sbdatas, sbtemp));
                                }
                            }
                            tbodyhtml.push(zjs.fastrenderRow(datatri, trhtml));
                        }

                        tbodyhtml.push("</tbody>");
                        $(v).append(tbodyhtml.join(''));
                        break;
                    default://普通input select等 在save里对所有输入进行了编码 所以在还原时也要解码  
                        if ($(v).hasClass("htmlbox")) {
                            $(v).val(dvalue).trigger("change");
                        } else {
                            if ($(v).attr("onclick")) {
                                if ($(v).attr("onclick").indexOf("WdatePicker") > -1) {
                                    $(v).val(zjs.dateformat(dvalue, $id.attr("dateformat"))).trigger("change");
                                } else {
                                    $(v).val(zjs.htmlDecode(dvalue)).trigger("change");
                                }
                            } else {
                                $(v).val(zjs.htmlDecode(dvalue)).trigger("change");
                            }
                        }
                        break;
                }
            }
        });
    }
};
//树渲染
zjs.tree = function (data, pid, template, idkey, pidkey, deep) {
    var $ul = $("<ul class='nav" + (deep || 1) + "'></ul>");
    var hasChildren = false;
    for (var di in data) {
        var datai = data[di];
        if (datai[pidkey] == pid && datai[idkey] != pid) {//如果父层相等 并且不是他自己
            var $row = $(zjs.fastrenderRow(datai, template));
            $row.append(zjs.tree(data, datai[idkey], template, idkey, pidkey, (deep || 1) + 1));
            $ul.append($row);
            hasChildren = true;
        }
    }
    if (hasChildren) {
        return $ul;
    } else {
        return "";
    }
};
//JSON格式树渲染 接收单对象
zjs.jsontree = function (data, template, deep) {
    var $ul = $("<ul class='nav1'></ul>");
    var $row = $(zjs.renderRow(data, template)); //这里是li
    $row.append(zjs.jsontreechildren(data.children, template, 2));//从这个函数开始统一返回ul格式
    $ul.append($row);
    return $ul;
};
//JSON格式树 接收数组
zjs.jsontrees = function (datas, template, deep) {
    var $ul = $("<ul class='nav1'></ul>");
    for (var di in datas) {
        var data = datas[di];
        var $row = $(zjs.renderRow(data, template)); //这里是li
        $row.append(zjs.jsontreechildren(data.children, template, 2));//从这个函数开始统一返回ul格式
        $ul.append($row);
    }
    return $ul;
};
//JSON格式树渲染 data是子对象数组　从此函数递归后　data都是数组 开始返回ul li ul li格式
zjs.jsontreechildren = function (data, template, deep) {
    if (data && data.length > 0) {
        var $ul = $("<ul class='nav" + (deep) + "'></ul>");
        for (var di in data) {
            var datai = data[di];
            var $row = $(zjs.renderRow(datai, template));
            $row.append(zjs.jsontreechildren(datai.children, template, (deep) + 1));
            $ul.append($row);
        }
        return $ul;
    } else {
        return "";
    }
};
//反向获取当前选中节点的文本 新互联 - 技术部 - 技术总监 - 朱 <span>{{name}}</span>
zjs.treedefy = function (data, pid, template, idkey, pidkey) {
    var temp = "";
    var hasChildren = false;
    for (var di in data) {
        var datai = data[di];
        if (datai[pidkey] != pid && datai[idkey] == pid) {//如果父层相等 并且不是他自己
            temp = zjs.renderRow(datai, template);
            temp = zjs.treedefy(data, datai[pidkey], template, idkey, pidkey) + temp;
            hasChildren = true;
        }
    }
    if (hasChildren) {
        return temp;
    } else {
        return "";
    }
};
/*判断元素长度*/
zjs.getLen = function (val) {
    //var len = 0;
    //for (var i = 0; i < val.length; i++) {
    //    if (val[i].match(/[^\x00-\xff]/ig) != null)
    //        len += 2;
    //    else
    //        len += 1;
    //}
    //return len;
    return val.length;
};
//写cookies
zjs.setCookie = function (name, value) {
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();//escape将参数值进行编码 expires过期时间
};
//读取cookies
zjs.getCookie = function (name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");//从完整的cookie字符串中提取要的字段值
    if (arr = document.cookie.match(reg)) return unescape(arr[2]);//unescape反编码
    else return null;
};
//删除cookies
zjs.delCookie = function (name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = zjs.getCookie(name);
    if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
};
//获取城市的原型 省市区
zjs.getcitydeep = function (citycode) {
    var pro = "";
    var city = "";
    var area = "";
    if (zjs.citys) {
        var nodes = zjs.citys;
        for (var i in nodes) {//遍历所有选项
            var ni = nodes[i];
            if (i == citycode) {
                pro = i;
            }
            for (var j in ni.c) {
                var nj = nodes[i].c[j];
                var njn = nj.n[0];
                if (j == citycode) {
                    pro = i;
                    city = j;
                }
                for (var k in nj.c) {
                    var nk = nodes[i].c[j].c[k];
                    if (k == citycode) {
                        pro = i;
                        city = j;
                        area = k;
                    }
                }
            }
        }
    }
    return { pro: pro, city: city, area: area };
};
//递归获取城市名称所代表的城市代码
zjs.getcitycode = function (cityname, citys) {
    if (zjs.citys) {
        var nodes = citys || zjs.citys;
        for (var i in nodes) {//遍历所有选项
            var ni = nodes[i];
            if (ni.n == cityname) {
                return i;
            } else {
                if (ni.c) {
                    var rcode = zjs.getcitycode(cityname, ni.c);
                    if (rcode != "")
                        return rcode;
                }
            }
        }
    }
    return "";
};
/*字典值转换为文本 多个值 e字典名称 v当前值 t是设置是否延伸 410100金水区  延伸后是410100 河南-郑州-金水区*/
zjs.getvalc = function (e, v, t) {
    var data = "";
    if (!v) {
        return "";
    }
    var tmp = v.split(',');
    for (var i in tmp) {
        if (tmp[i] != "")
            data += "" + zjs.getvals(e, tmp[i], t) + "/";
    }
    if (data != "")
        return data.substr(0, data.length - 1);
    else
        return "不限";
};
/*字典值转换为文本 单值 用于含其他的 如果字典匹配 就显示字典值 不匹配 就直接显示原值 e字典名称 v当前值*/
zjs.getvalueother = function (e, v) {
    if (zjss[e]) {/*加载一次就缓存 如果缓存有 就直接返回*/
        if (zjss[e][v])//如果字典匹配 就显示字典值
            return zjss[e][v];
        else
            return v;//不匹配 就直接显示原值
    }
    else {
        if (zjs[e]) {/*加载一次就缓存 如果缓存没有 就添加到缓存*/
            zjss[e] = {};
            var tmp = zjs[e].split(',');
            for (var i = 0; i < tmp.length; i++) {
                var t1 = tmp[i].split('|')[0];
                var t2 = tmp[i].split('|')[1];
                zjss[e][t1] = t2;//e字典名称 t1字典项名
            }
            if (zjss[e][v])//如果字典匹配 就显示字典值
                return zjss[e][v];
            else
                return v;//不匹配 就直接显示原值
        }
    }
};
/*字典值转换为文本 单值*/
zjs.getvals = function (e, v, t) {
    if (zjss[e]) {/*加载一次就缓存 如果缓存有 就直接返回*/
        if (typeof zjs[e] == "string") {
            if (zjss[e][v])
                return zjss[e][v];
            else
                return "";
        } else {
            if (t)
                return zjss[e][v];
            else {
                if (zjss[e][v])
                    return zjss[e][v][0];
                else
                    return "";
            }
        }
    }
    else {
        if (zjs[e]) {/*加载一次就缓存 如果缓存没有 就添加到缓存*/
            zjss[e] = {};
            if (typeof zjs[e] == "string") {//判断字典是不是字符串 正常的都是字符串
                var tmp = zjs[e].split(',');
                for (var i = 0; i < tmp.length; i++) {
                    var t1 = tmp[i].split('|')[0];
                    var t2 = tmp[i].split('|')[1];
                    zjss[e][t1] = t2;
                }
                if (zjss[e][v])///如果字典匹配 就显示字典值
                    return zjss[e][v];
                else
                    return "";
            }
            else {//城市选择器不是字符串
                var nodes = zjs[e];
                for (var i in nodes) {//遍历省级
                    var ni = nodes[i];
                    zjss[e][i] = [ni.n[0], ni.n];//ni.n[0]省级文本
                    for (var j in ni.c) {//遍历市级
                        var nj = nodes[i].c[j];
                        zjss[e][j] = [ni.n + " " + nj.n, i];//省级+市级
                        for (var k in nj.c) {//遍历县区级
                            var nk = nodes[i].c[j].c[k];
                            zjss[e][k] = [ni.n + " " + nj.n + " " + nk.n, j, i];//省级+市级+县区
                        }
                    }
                }
                if (t)
                    return zjss[e][v];//返回匹配字符串
                else {
                    if (zjss[e][v])
                        return zjss[e][v][0];//返回匹配字符串
                    else
                        return "";
                }
            }
        }
    }
};
/*按照values转换字典值*/
zjs.getvalues = function (values, v) {
    var tmp = values.split(',');
    for (var i = 0; i < tmp.length; i++) {
        var t1 = tmp[i].split('|')[0];
        var t2 = tmp[i].split('|')[1];
        if (t1 == v) {
            return t2;
        }
    }
    return "";
};
/*将时间转换成发表时间*/
zjs.getDateDiff = function (dateadded) {
    var minute = 1000 * 60;
    var hour = minute * 60;
    var day = hour * 24;
    var halfamonth = day * 15;
    var month = day * 30;
    var now = new Date().getTime();//当前时间的时间戳 时间戳是1970-1-1到现在的所有秒数
    var dateTimeStamp = new Date(dateadded).getTime();//你传的时间的时间戳
    var diffValue = now - dateTimeStamp;//相减 得出来相差的多少时间戳

    if (diffValue < 0) {
        //非法操作
        //alert("结束日期不能小于开始日期！");
    }

    var monthC = diffValue / month;
    var weekC = diffValue / (7 * day);
    var dayC = diffValue / day;
    var hourC = diffValue / hour;
    var minC = diffValue / minute;

    if (monthC >= 1) {
        result = parseInt(monthC) + "月前";
    }
    else if (weekC >= 1) {
        result = parseInt(weekC) + "星期前";
    }
    else if (dayC >= 1) {
        result = parseInt(dayC) + "天前";
    }
    else if (hourC >= 1) {
        result = parseInt(hourC) + "小时前";
    }
    else if (minC >= 1) {
        result = parseInt(minC) + "分钟前";
    } else
        result = "刚刚";
    return result;
};
/*将时间转换成发表时间*/
zjs.getMinuteText = function (diffValue) {
    var minute = 1;
    var hour = minute * 60;
    var day = hour * 24;
    var halfamonth = day * 15;
    var month = day * 30;

    var monthC = diffValue / month;
    var weekC = diffValue / (7 * day);
    var dayC = diffValue / day;
    var hourC = diffValue / hour;
    var minC = diffValue / minute;

    if (monthC >= 1) {
        result = parseInt(monthC) + "月";
    }
    else if (weekC >= 1) {
        result = parseInt(weekC) + "星期";
    }
    else if (dayC >= 1) {
        result = parseInt(dayC) + "天";
    }
    else if (hourC >= 1) {
        result = parseInt(hourC) + "小时";
    }
    else if (minC >= 1) {
        result = parseInt(minC) + "分钟";
    } else
        result = "片刻";
    return result;
};
/*计算年龄 精确到月*/
zjs.getAge = function (dateadded) {
    var minute = 1000 * 60;
    var hour = minute * 60;
    var day = hour * 24;
    var halfamonth = day * 15;
    var month = day * 30;
    var now = new Date().getTime();
    var dateTimeStamp = new Date(dateadded).getTime();
    var diffValue = now - dateTimeStamp;

    if (diffValue < 0) {
        //非法操作
        //alert("结束日期不能小于开始日期！");
    }

    var yearC = diffValue / (12 * month);
    var monthC = diffValue / month % 12;

    result = parseInt(yearC) + "岁 零" + parseInt(monthC) + "个月";
    return result;
};
/*获取还剩余多少天*/
zjs.getDateOver = function (dateadded) {
    var minute = 1000 * 60;
    var hour = minute * 60;
    var day = hour * 24;
    var halfamonth = day * 15;
    var month = day * 30;
    var now = new Date().getTime();//当前时间的时间戳 时间戳是1970-1-1到现在的所有秒数
    var dateTimeStamp = new Date(dateadded).getTime();//你传的时间的时间戳
    var diffValue = dateTimeStamp - now;//相减 得出来相差的多少时间戳

    if (diffValue < 0) {
        //非法操作
        //alert("结束日期不能小于开始日期！");
    }

    var monthC = diffValue / month;
    var weekC = diffValue / (7 * day);
    var dayC = diffValue / day;
    var hourC = diffValue / hour;
    var minC = diffValue / minute;

    if (monthC >= 1) {
        result = "剩余" + parseInt(monthC) + "个月";
    }
    else if (weekC >= 1) {
        result = "剩余" + parseInt(weekC) + "周";
    }
    else if (dayC >= 1) {
        result = "剩余" + parseInt(dayC) + "天";
    }
    else if (hourC >= 1) {
        result = "剩余" + parseInt(hourC) + "小时";
    }
    else if (minC >= 1) {
        result = "剩余" + parseInt(minC) + "分钟";
    } else
        result = "马上到期";
    return result;
};
//清理HTML格式
zjs.clearALL = function (html) {
    html = html.replace(/<(.[^>]*)>/gi, "");
    html = html.replace(/[ \f\n\t\v]+/g, "");
    html = html.replace(new RegExp("&nbsp;", 'g'), "");
    return html;
};
//将html编码 比如<h1>123</h1> 编码后&lt;h1&gt;123&lt;/h1&gt;
zjs.htmlEncode = function (value) {
    if ($.browser.msie) {
        if (typeof value == "string") {
            value = value.replace(new RegExp("\r", 'g'), "").replace(new RegExp("\n", 'g'), "#n#").replace(new RegExp(" ", 'g'), "#k#");
            return $('<div/>').text(value).html().replace(new RegExp("#n#", 'g'), "\n").replace(new RegExp("#k#", 'g'), " ");
        }
    }
    return $('<div/>').text(value).html();
};
//将html解码 比如&lt;h1&gt;123&lt;/h1&gt; 解码后<h1>123</h1>
zjs.htmlDecode = function (value) {
    if ($.browser.msie) {
        if (typeof value == "string") {
            value = value.replace(new RegExp("\r", 'g'), "").replace(new RegExp("\n", 'g'), "#n#").replace(new RegExp(" ", 'g'), "#k#");
            return $('<div/>').html(value).text().replace(new RegExp("#n#", 'g'), "\n").replace(new RegExp("#k#", 'g'), " ");
        }
    }
    return $('<div/>').html(value).text();
};
//如果是老项目 就加一个zjs.keephtml=true; 就不再过滤HTML了
if (zjs.keephtml) {
    zjs.htmlEncode = function (value) {
        return value;
    };
    zjs.htmlDecode = function (value) {
        return value;
    };
}

/*! 获取鼠标是否在对应元素上 返回鼠标在左上 左下 右上 右下四种状态 */
zjs.checkPosition = function (o, e) {
    var $o = $(o);
    var os = $o.offset();
    var width = $o.width();
    var height = $o.height();

    var left = os.left;
    var top = os.top;
    var right = left + width;
    var bottom = top + height;

    var cl = left + (width / 2);
    var ct = top + (height / 2);

    //左上1  左下2    右上3 右下4
    if (e.offsetX > left && e.offsetX < cl) {//左半部分
        if (e.offsetY > top && e.offsetY < ct)//上半部分
            return 1;
        else if (e.offsetY > ct && e.offsetY < bottom)//下半部分
            return 2;
    }
    if (e.offsetX > cl && e.offsetX < right) {
        if (e.offsetY > top && e.offsetY < ct)//上半部分
            return 3;
        else if (e.offsetY > ct && e.offsetY < bottom)//下半部分
            return 4;
    }

    return 0;
};
//获取鼠标是否在元素上 只在元素的任意位置就返回1在 否则0不在
zjs.checkPositionclient = function (o, e) {
    var $o = $(o);
    var os = $o.offset();
    var width = $o.width();
    var height = $o.height();

    var left = os.left;
    var top = os.top;
    var right = left + width;
    var bottom = top + height;

    //左上1  左下2    右上3 右下4
    if (e.clientX > left && e.clientX < right && e.clientY > top && e.clientY < bottom) {//左半部分 
        return 1;
    }

    return 0;
};
//判断一个点距离 一个容器的上下左右四个控制点哪个近
zjs.pointCutPoints = function (px, py, $div) {
    var os = $div.offset();
    var width = $div.width();
    var height = $div.height();

    var left = os.left;
    var top = os.top;
    var right = left + width;
    var bottom = top + height;

    var centerl = left + (width / 2);
    var centert = top + (height / 2);

    var points = [];//上右下左
    points.push({ x: centerl, y: top, julu: Math.abs(centerl - px) + Math.abs(top - py) });//上
    points.push({ x: right, y: centert, julu: Math.abs(right - px) + Math.abs(centert - py) });//右
    points.push({ x: centerl, y: bottom, julu: Math.abs(centerl - px) + Math.abs(bottom - py) });//下
    points.push({ x: left, y: centert, julu: Math.abs(left - px) + Math.abs(centert - py) });//左
    points.sort(function (a, b) {
        //默认按照距离排序
        return parseFloat(a.julu) > parseFloat(b.julu) ? 1 : -1
    });

    return { x: points[0].x, y: points[0].y };
};
//获取被选中的check变量 不推荐使用了 请使用对话框内隐藏文本框方式传值 或top
zjs.getcheck = function () {
    if (zjs.canparent()) {
        return parent.check;
    }
    else {
        return window.check;
    }
};
//判断能使用parent变量 同上 不推荐使用
zjs.canparent = function () {
    try {
        parent["test"] = 1;
        return true;
    } catch (ex) {//不能访问 就用当前对象
        return false;
    };
};
zjs.dialogwidth = function () {
    //对话框高度 根据当前窗口的高度－100
    try {
        return $(top).width() - 100;
    } catch (ex) {//不能访问 就用当前对象
        return $(window).width() - 100;
    };
};
zjs.dialogheight = function () {
    //对话框高度 根据当前窗口的高度－100
    try {
        return $(top).height() - 100;
    } catch (ex) {//不能访问 就用当前对象
        return $(window).height() - 100;
    };
};
//当dialog关闭后 继续锁屏 为了解决多对话框嵌套BUG 
zjs.topapilock = function () {
    try {
        if (frameElement) {
            $(frameElement).prev(".ui_loading").hide();
            var topapi = frameElement.api;
            setTimeout(function () {
                if (topapi) {
                    topapi.lock();
                }
            }, 100);
        }
    } catch (ex) { }
};
//打开对话框 $t单击的对象 比如a i url要打开的地址 callback回调 整个函数的回调为对话框对象本身ceditorDialogC
zjs.openurl = function ($t, url, callback) {
    var owidth = $t.attr("owidth") || zjs.dialogwidth();//宽
    var oheight = $t.attr("oheight") || zjs.dialogheight();//高
    var title = $t.attr("title") || $t.html() || "设置";//标题 
    if ($t.attr("before"))
        eval($t.attr("before"));//如果有打开前回调before事件 就执行
    if ($t.attr("small")) {//设置小窗口
        owidth = 320;
        oheight = 280;
    }
    if ($t.attr("icon")) {//如果有图标 就显示图标
        title = $t.attr("icon") + title;
    }
    var ceditorDialogC = zjs.dialog({//调用lhgdialog
        id: "openurl" + title,
        content: 'url:' + url,
        width: owidth,
        height: oheight,
        title: title,
        close: function () {
            try {
                if ($t.attr("callback")) {
                    if ($t.attr("callback").indexOf("()") > -1)
                        eval($t.attr("callback").replace("()", "") + "($t)");
                    else if ($t.attr("callback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        eval($t.attr("callback"));
                    else
                        eval($t.attr("callback") + "($t)");
                }
            } catch (ex) { alert(ex.message); }

            if (ceditorDialogC.content.document.getElementById("isclose")) {//如果是确认关闭的 而不是直接关闭 
                if (ceditorDialogC.content.document.getElementById("isclose").value) {//如果是确认关闭的 而不是直接关闭
                    try {
                        if ($t.attr("okcallback")) {
                            if ($t.attr("okcallback").indexOf("()") > -1)
                                eval($t.attr("okcallback").replace("()", "") + "($t)");
                            else if ($t.attr("okcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                eval($t.attr("okcallback"));
                            else
                                eval($t.attr("okcallback") + "($t)");
                        }
                    } catch (ex) { alert(ex.message); }
                }
            }
            zjs.topapilock();//调用锁屏

            try {
                if (callback) {//如果函数有回调 也调
                    callback();
                }
            } catch (ex) { alert(ex.message); }
        }
    });
    return ceditorDialogC;
};
//获取金钱的中文金额描述 比如1200.00 壹仟贰佰元整
zjs.getmoney = function (num) {
    var strOutput = "",
    strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
    num += "00";
    var intPos = num.indexOf('.');
    if (intPos >= 0) {
        num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
    }
    strUnit = strUnit.substr(strUnit.length - num.length);
    for (var i = 0; i < num.length; i++) {
        strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i, 1), 1) + strUnit.substr(i, 1);
    }
    return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元")
};
/*!
* 表格组件
*/
if (!window.zjs.ctable) {
    zjs.ctable = {
        clazz: "zjs.ctable",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {//内部函数 初始化
            var that = this;
            var $id = that.$id;
            that.$Paras = $("#" + $id.attr("id") + "Paras");
            that.$body = $id.children("tbody").length == 0 ? $id : $id.children("tbody");//如果有tbody就以tbody为容器 没有就以它本身为容器
            that.$tfoot = $id.children("tfoot").length == 0 ? $("#" + $id.attr("id") + "tfoot") : $id.children("tfoot");//如果有页角
            that.$thead = $id.children("thead").length == 0 ? $("#" + $id.attr("id") + "thead") : $id.children("thead");//如果有页角
            that.$lockbody = $("#" + $id.attr("id") + "lockbody");//锁表头

            var $body = that.$body;

            that.uipagesize = 10; //如果页容量小于10 就等于10 至少10个
            if ($id.attr("pagesize")) that.uipagesize = $id.attr("pagesize");//如果设置的有 就按设置的来
            if ($id.find("#pagesize").length > 0) that.uipagesize = $id.find("#pagesize").val();//如果设置的有 就按设置的来
            if (that.$tfoot.find("#pagesize").length > 0) that.uipagesize = that.$tfoot.find("#pagesize").val();//如果设置的有 就按设置的来
            that.pagesize = that.uipagesize * zjs.cachePage;          //服务端页容量 是前端页容量的100倍 相当于缓存100页数据

            that.pageindex = 1;//服务器端当前页码
            that.uipageindex = 1;//前端当前页面

            that.maxTotle = 0;
            that.simpleMode = false;//简单模式 默认关闭 简单模式时 只支持后端处理数据 所有翻页请求后端 好处是支持尾页
            if (zjs.cachePage == 1 || $id.attr("simpleMode")) {
                that.simpleMode = true;//如果全局的缓存页数为1 或者单独的表格配置简单模式时启用该模式
            }
            that.Datas = [];//总数据
            that.searchData = [];//搜索的结果集

            that.loadingimg = "<img src='" + zjs.rootdir + "img/loading.gif' class='loading'/>";//默认只显示菊花即可
            if ($id[0].nodeName == "TABLE") {//如果是表格 就得显示成tr td菊花
                var tdlength = $id.find("thead tr").first().children("td").length || 100;
                that.loadingimg = "<tr><td colspan='" + tdlength + "' class='noborder'><img src='" + zjs.rootdir + "img/loading.gif' class='loading'/></td></tr>";
            }

            if (!that.render) {
                that.render = $body.html();
                if ($id.attr("inserttbody")) {
                    that.render = that.render + $id.attr("inserttbody");
                }
                $body.empty().html(that.loadingimg).show();//先清空
                if (that.$lockbody.length > 0) {
                    that.lockrender = that.$lockbody.html();
                    that.$lockbody.empty().show();
                }
            }

            var $tfoot = that.$tfoot;//如果有页角
            if ($id.attr("pullToRefresh")) { //如果是手机端下拉加载 就判断滚动条位置
                var $win = $(window);
                if ($("body.fromFixed").length > 0) {//如果是独立滚动条模式 就不能检测窗口的滚动条了 需要检测自己的
                    var $win = $id.parents(".pageview");
                }
                $win.scroll(function (e) {
                    if ($id.height() > 0) {//如果当前对象是显示的 再执行
                        if (($win.scrollTop() || e.pageY) > ($body.height() - $win.height() - 200)) {
                            if (that.uipageindex < that.uitotlepage) {//如果缓存里有 就下拉刷新 没有了就点击按钮 防止一直无休止的翻页
                                that._nextPage();
                                $tfoot.find(".nextPage").hide();
                            } else {
                                $tfoot.find(".nextPage").show();
                            }
                        }
                    }
                });

                $tfoot.find(".prevPage").hide();
                $tfoot.find(".firstPage").hide();
                $tfoot.find(".downPage").hide();
                $tfoot.find(".nextPage").hide();
            } else {//如果是PC端
                if ($id.attr("scrollToRefresh")) { //如果是下拉刷新 就判断滚动条位置 
                    $(window).scroll(function (e) {
                        if ($id.height() > 0) {//如果当前对象是显示的 再执行
                            if (($(window).scrollTop() || e.pageY) > ($body.height() - $(window).height() - 200)) {
                                that._nextPage();
                            }
                        }
                    });
                    if ($id.attr("lockhead")) { //如果它有锁表头 只是上下锁表头
                        that.$lockthead = that.$thead.clone().addClass("headfixed").hide();
                        that.$thead.after(that.$lockthead);
                        $(window).scroll(function (e) {
                            if (($(window).scrollTop() || e.pageY) > ($body.height() - $(window).height() - 200)) {
                                that.$lockthead.show();
                            } else {
                                that.$lockthead.hide();
                            }
                        });
                    }
                    $tfoot.find(".prevPage").hide();
                    $tfoot.find(".firstPage").hide();
                    $tfoot.find(".downPage").hide();
                };
            }

            if ($tfoot.length > 0) {
                that.$spanTotalRows = $tfoot.find(".TotalRows");
                that.$spanPageIndex = $tfoot.find(".PageIndex");

                $tfoot.find(".firstPage").click(function () {
                    if (that.simpleMode) {
                        that._simpleGoPage(1);
                    } else {
                        if ($id.attr("scrollToRefresh")) { //如果不是下拉刷新 就改变滚动条位置 
                        } else {
                            $(window).scrollTop($id.offset().top - 100);
                        }
                        if ((that.uipageindex - zjs.cachePage) < 1) {//如果当前页的下一批没加载过 就加载下一批
                            that._goPage(1);
                        } else {
                            //否则 加载当前页的下一批 
                            that._goPage(that.uipageindex - zjs.cachePage);
                        }
                    }
                });
                $tfoot.find(".downPage").click(function () {
                    if (that.simpleMode) {
                        that._simpleGoPage(that.sstotlepage);
                    } else {
                        if ($id.attr("scrollToRefresh")) { //如果不是下拉刷新 就改变滚动条位置  
                        } else {
                            $(window).scrollTop($id.offset().top - 100);
                        }

                        if ((that.uipageindex + zjs.cachePage) > that.uitotlepage) {//如果当前页的下一批没加载过 就加载下一批
                            that.uipageindex = that.uitotlepage;
                        } else {
                            //否则 加载当前页的下一批
                            that.uipageindex = that.uipageindex + zjs.cachePage - 1;
                        }
                        that._nextPage(true);
                    }
                });
                $tfoot.find(".prevPage").click(function () {
                    if (that.simpleMode) {
                        if (that.pageindex > 1) {
                            that._simpleGoPage(that.pageindex - 1);
                        }
                    } else {
                        if ($id.attr("scrollToRefresh")) { //如果不是下拉刷新 就改变滚动条位置  
                        } else {
                            $(window).scrollTop($id.offset().top - 100);
                        }
                        that._prevPage();
                    }
                });
                $tfoot.find(".nextPage").click(function () {
                    if (that.simpleMode) {
                        if (that.pageindex < that.sstotlepage) {
                            that._simpleGoPage(that.pageindex + 1);
                        }
                    } else {
                        if ($id.attr("scrollToRefresh") || $id.attr("pullToRefresh")) { //如果不是下拉刷新 就改变滚动条位置 
                        } else {
                            $(window).scrollTop($id.offset().top - 100);
                        }
                        that._nextPage(true);
                    }
                    if ($id.attr("pullToRefresh")) {
                        $tfoot.find(".nextPage").hide();
                    }
                });
                if ($id.attr("pullToRefresh")) { } else {
                    if (that.simpleMode) {
                        $tfoot.find(".firstPage").attr("href", "javascript:void(0)").attr("title", "首页");
                        $tfoot.find(".downPage").attr("href", "javascript:void(0)").attr("title", "末页");
                    } else {
                        $tfoot.find(".firstPage").attr("href", "javascript:void(0)").attr("title", "上" + zjs.cachePage + "页");
                        $tfoot.find(".downPage").attr("href", "javascript:void(0)").attr("title", "下" + zjs.cachePage + "页");
                    }
                    $tfoot.find(".prevPage").attr("href", "javascript:void(0)").attr("title", "上1页");
                    $tfoot.find(".nextPage").attr("href", "javascript:void(0)").attr("title", "下1页");
                }
                var $pagesize = $tfoot.find("#pagesize");//可选择的页码
                if ($pagesize.length > 0) {
                    $pagesize.change(function () {
                        that.uipagesize = $pagesize.val();
                        that.pagesize = that.uipagesize * zjs.cachePage;//服务端页容量 是前端页容量的100倍 相当于缓存100页数据
                        //that.pageindex = 1;//服务器端当前页码
                        //that.uipageindex = 1;//前端当前页面
                        //that._setShowDate(true);//设置要显示的数据
                        that.dosearch();
                    });
                }
                var $batchSelection = $id.find(".batchSelection");//批量选择
                if ($batchSelection.length > 0) {
                    $batchSelection.click(function () {
                        if ($(this).attr("checked")) {//如果选中
                            $body.find(".selection").attr("checked", $(this).attr("checked")).trigger("change");
                            $batchSelection.attr("checked", $(this).attr("checked"));
                        } else {//如果没选中
                            $body.find(".selection").removeAttr("checked").trigger("change");
                            $batchSelection.removeAttr("checked");
                        }
                    });
                };
                $("#" + $id.attr("id") + " .selection").live("change", function () {//复选框事件
                    var $t = $(this);

                    var datai = that._findDatas($t);
                    var datais = that._findSearchData($t);

                    if ($(this).attr("checked")) {//如果选中
                        datai.ischecked = "1";
                        datais.ischecked = "1";
                    } else {
                        datai.ischecked = "";
                        datais.ischecked = "";
                    }
                });//end 复选框事件 
                //this._search(null, true);
                $id.find("a[batchdelete]").click(function () {
                    var $t = $(this);
                    var ids = [];
                    $body.find(".selection:checked").each(function (i, v) {
                        if ($(v).parents(".uls").attr("id")) {
                            ids.push($(v).parents(".uls").attr("id"));
                        }
                    });
                    if (ids.length > 0) {
                        zjs.confirm("确认删除吗？", function () {
                            var dpara = {
                                cmd: $t.attr("batchdelete"),
                                para: { id: ids.join(',') },
                                callback: function () {
                                    that._search(null, true);
                                }
                            };
                            if ($t.attr("contentType")) {
                                dpara.contentType = $t.attr("contentType");
                                dpara.para = ids;
                            }
                            zjs.cmd(dpara);
                        });
                    } else {
                        zjs.tips("未选中记录", 1);
                    }
                });
                $id.find("a[batchdeleteall]").click(function () {
                    var $t = $(this);
                    var idkey = $id.attr("idkey");
                    var datas = that.Datas;
                    if (that.searchData.length > 0) {//如果没有搜索结果 就按正常的走 
                        datas = that.searchData;
                    }
                    var ids = [];
                    for (var di in datas) {
                        var datai = datas[di];
                        if (datai.ischecked) {
                            ids.push(datai[idkey]);
                        }
                    }
                    if (ids.length > 0) {
                        zjs.confirm("确认删除吗？", function () {
                            var dpara = {
                                cmd: $t.attr("batchdelete"),
                                para: { id: ids.join(',') },
                                callback: function () {
                                    that._search(null, true);
                                }
                            };
                            if ($t.attr("contentType")) {
                                dpara.contentType = $t.attr("contentType");
                                dpara.para = ids;
                            }
                            zjs.cmd(dpara);
                        });
                    } else {
                        zjs.tips("未选中记录", 1);
                    }
                });
                //添加按钮事件
                $("#" + $id.attr("id") + " a[add],#" + $id.attr("id") + "Paras a[add],#" + $id.attr("id") + "Paras i[add],#" + $id.attr("id") + "lockbody a[add]").live("click", function () {
                    var $t = $(this);
                    if (zjs.openurl) {
                        var ceditorDialogC = zjs.openurl($t, $t.attr("add"), function () {
                            if (ceditorDialogC.content.document.getElementById("isclose")) {//如果是确认关闭的 而不是直接关闭

                                if (ceditorDialogC.content.document.getElementById("isclose").value) {//如果是确认关闭的 而不是直接关闭
                                    if (that.Datas.length == 0) {//如果压根就没有数据 就直接刷新页面 因为取不到对象结构
                                        that.dosearch();
                                    } else {//如果有 就取第一条数据的结构
                                        var datai = that.Datas[0];

                                        var datanew = {};//新数据
                                        for (var di in datai) {
                                            if (ceditorDialogC.content.document.getElementById(di)) {//如果有对应的值 就更新
                                                datanew[di] = ceditorDialogC.content.document.getElementById(di).value;
                                            }
                                        }

                                        that.Datas.unshift(datanew);//unshift可向数组的开头添加一个或更多元素，并返回新的长度
                                        if (that.searchData.length > 0) {//如果是搜索状态 就同时插入到搜索的第一条 
                                            that.searchData.unshift(datanew);
                                        }

                                        if ($id.attr("beforerenderrow")) {
                                            if ($id.attr("beforerenderrow").indexOf("()") > -1)
                                                eval($id.attr("beforerenderrow").replace("()", "") + "(datanew)");
                                            else
                                                eval($id.attr("beforerenderrow") + "(datanew)");
                                        }
                                        if (that.renderRowcallback) {//搜索后的回调函数
                                            that.renderRowcallback(datanew);
                                        }

                                        that.TotalRows = that.TotalRows + 1;
                                        that.maxTotle = that.maxTotle + 1;
                                        //that.pageindex = 1;//服务器端当前页码
                                        //that.uipageindex = 1;//前端当前页面
                                        //that._setShowDate(true);//设置要显示的数据
                                        that.dosearch();

                                        that._tdfixed();//设置td最大宽度
                                    }//end if 
                                }
                            }
                        });//end openurl
                    }//end if zjs.openurl
                });//end add 
                $("#" + $id.attr("id") + " a[update],#" + $id.attr("id") + "lockbody a[update]").live("click", function () {//打开新窗口
                    var $t = $(this);
                    if (zjs.openurl) {
                        var ceditorDialogC = zjs.openurl($t, $t.attr("update"), function () {
                            if (ceditorDialogC.content.document.getElementById("isclose")) {//如果是确认关闭的 而不是直接关闭
                                if (ceditorDialogC.content.document.getElementById("isclose").value) {//如果是确认关闭的 而不是直接关闭

                                    var datai = that._findDatas($t);
                                    var datais = that._findSearchData($t);

                                    for (var di in datai) {
                                        if (ceditorDialogC.content.document.getElementById(di)) {//如果有对应的值 就更新
                                            datai[di] = ceditorDialogC.content.document.getElementById(di).value;
                                            datais[di] = ceditorDialogC.content.document.getElementById(di).value;
                                        }
                                    }
                                    if ($id.attr("beforerenderrow")) {
                                        if ($id.attr("beforerenderrow").indexOf("()") > -1)
                                            eval($id.attr("beforerenderrow").replace("()", "") + "(datai)");
                                        else
                                            eval($id.attr("beforerenderrow") + "(datai)");
                                    }

                                    if (that.renderRowcallback) {//搜索后的回调函数
                                        that.renderRowcallback(datai);
                                    }
                                    var dateformat = $id.attr("dateformat") || "yyyy-MM-dd";
                                    if (that.lockrender) {//锁表头模式 要更新左侧和右侧
                                        var rowid = $t.parents(".uls").attr("id");//找到这一行数据 
                                        var $oldrow = that.$body.find(".uls[id='" + rowid + "']");
                                        $oldrow.after(zjs.renderRow(datai, that.render, dateformat, $id.attr("htmlbox")));
                                        $oldrow.remove();
                                        var $oldlockrow = that.$lockbody.find(".uls[id='" + rowid + "']");
                                        $oldlockrow.after(zjs.renderRow(datai, that.lockrender, dateformat, $id.attr("htmlbox")));
                                        $oldlockrow.remove();
                                    } else { //普通模式 按以前的处理
                                        $t.parents(".uls").after(zjs.renderRow(datai, that.render, dateformat, $id.attr("htmlbox")));
                                        $t.parents(".uls").remove();
                                    }

                                    that._tdfixed();//设置td最大宽度
                                    that.$body.find("tr.uls").removeClass("evenuls");
                                    that.$body.find("tr.uls").each(function (i, v) {
                                        if (i % 2 != 0) {
                                            $(v).addClass("evenuls");
                                        }
                                    });
                                }
                            }
                        });
                    }//end if zjs.dialog
                });//end update
                $("#" + $id.attr("id") + " a[delete],#" + $id.attr("id") + "lockbody a[delete]").live("click", function () {//执行删除命令
                    var $t = $(this);
                    var para = {};
                    if ($t.attr("deleteid")) {
                        para.id = $t.attr("deleteid");
                    }
                    var delmessage = "确认 " + ($t.attr("title") || $t.html()) + " 吗？";
                    if ($t.attr("delmessage")) {
                        delmessage = $t.attr("delmessage");
                    }
                    zjs.confirm(delmessage, function () {
                        var dpara = {
                            cmd: $t.attr("delete"),
                            para: para,
                            callback: function () {
                                try {
                                    if ($t.attr("okcallback")) {//如果被点击的对象有回调 也调
                                        if ($t.attr("okcallback").indexOf('(') > -1)
                                            eval($t.attr("okcallback"));
                                        else
                                            eval($t.attr("okcallback") + "($t)");
                                    }
                                } catch (ex) { alert(ex.message); }

                                that._deleteRow($t);

                                if (that.lockrender) {//锁表头模式 要更新左侧和右侧
                                    var rowid = $t.parents(".uls").attr("id");//找到这一行数据 
                                    var $oldrow = that.$body.find(".uls[id='" + rowid + "']");
                                    $oldrow.remove();
                                    var $oldlockrow = that.$lockbody.find(".uls[id='" + rowid + "']");
                                    $oldlockrow.remove();
                                } else { //普通模式 按以前的处理 
                                    $t.parents(".uls").remove();
                                }

                                if (that.$body.find(".uls").length == 0) {
                                    that.dosearch();
                                } else {
                                    that.$body.find("tr.uls").removeClass("evenuls");
                                    that.$body.find("tr.uls").each(function (i, v) {
                                        if (i % 2 != 0) {
                                            $(v).addClass("evenuls");
                                        }
                                    });
                                }
                            }
                        };
                        if ($t.attr("contentType")) {
                            dpara.contentType = $t.attr("contentType");
                        }
                        zjs.cmd(dpara);
                    });
                });//end delete
            }//end tfoot

            var serachtimer;
            that.$Paras.find("#search").click(function (e, data) {
                clearTimeout(serachtimer);
                if (data == "wait") {
                    serachtimer = setTimeout(function () {
                        that.dosearch();
                    }, 800);
                } else {
                    that.dosearch();
                }
            });
            if (!$id.attr("donotsearch")) {
                that.$Paras.find("input[id],input[between]").each(function (i, v) {
                    var $v = $(v);
                    if ($v.hasClass("cselector")
                        || $v.hasClass("cselectorRadio")
                        || $v.hasClass("cselectorCheckBox")
                        || $v.hasClass("cselectorCheckList")
                        || $v.hasClass("cselectorTree")
                        || $v.hasClass("cselectorCheckTree")
                        || $v.hasClass("cselectorStar")) {
                        //如果有这些样式 说明是选择器

                        $v.bind("gosearch", function () {//回车切换焦点  
                            that.$Paras.find("#search").trigger("click", "fast");
                        });
                    } else {
                        //普通的输入框
                        if ($.browser.msie) {
                            v.onpropertychange = function () {
                                that.$Paras.find("#search").trigger("click", "wait");
                            };
                        } else {
                            v.oninput = function () {
                                that.$Paras.find("#search").trigger("click", "wait");
                            };
                        }
                        $v.keydown(function (e) {//回车切换焦点
                            if (e.keyCode == 13) {
                                that.$Paras.find("#search").trigger("click", "fast");
                            }
                        });
                    }
                });
                that.dosearch();
            } else {
                $body.empty();//先清空
                that.$lockbody.empty();
            }
        },
        _prevPage: function () {//上一页 
            var that = this;
            if (that.uipageindex > 1) {
                that.uipageindex = that.uipageindex - 1;
                that._setShowDate();//设置要显示的数据
            }
        },
        _nextPage: function (isclick) {//下一页 
            var that = this;
            var $id = that.$id;
            if (that.issearching)
                return false;
            var sstotlepage = that.sstotlepage;        //服务端总页数
            var uitotlepage = that.uitotlepage;   //前端总页数
            if (that.uipageindex < uitotlepage) {//如果缓存里有 就直接读
                that.uipageindex = that.uipageindex + 1;//前端页码加1
                that._setShowDate();//设置要显示的数据
            } else {//如果缓存里没有 就判断服务端还有没有 
                if (that.uipageindex < sstotlepage) {//如果服务端还有 就读服务端的
                    that.uipageindex = that.uipageindex + 1;//前端页码加1
                    that.pageindex = that.pageindex + 1;//后端页码加1

                    var searchpara = {};
                    that.$Paras.find("input[id],select[id]").each(function (i, v) { //以现有文本框的值为参数 
                        searchpara[v.id] = v.value || "";
                    });
                    that._search(searchpara);
                }//如果都没有 就是没有数据了 不做操作
                else {
                    if (isclick) {
                        if ($id.attr("nothingmsg")) {
                            //奇葩模式 nothingmsg="true" 点着按钮没反应 连个提示都不给
                        } else {
                            zjs.tips("已经没有数据了", 1);
                        }
                    }
                    that.uipageindex = parseInt($(".pageNumbers a.hover").text());
                }
            }
        },
        _goPage: function (pindex) {
            var that = this;
            that.uipageindex = parseInt(pindex);
            that._setShowDate();//设置要显示的数据
        },
        _simpleGoPage: function (pindex) {
            var that = this;
            var $id = that.$id;

            that.uipageindex = parseInt(pindex);;//前端页码加1
            that.pageindex = parseInt(pindex);;//后端页码加1

            if ($id.attr("beforesearchclick")) {//点击搜索按钮时的回调
                if ($id.attr("beforesearchclick").indexOf("()") > -1)
                    eval($id.attr("beforesearchclick").replace("()", "") + "($id)");
                else if ($id.attr("beforesearchclick").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("beforesearchclick"));
                else
                    eval($id.attr("beforesearchclick") + "($id)");
            }

            var searchpara = {};
            that.$Paras.find("input[id],select[id]").each(function (i, v) { //以现有文本框的值为参数 
                searchpara[v.id] = v.value || "";
            });
            that._search(searchpara);
        },
        _findDatas: function ($t) {//找到数据中的某一行 
            var that = this;
            var $id = that.$id;
            var $body = that.$body;

            if ($id.attr("idkey")) {//使用id搜索模式
                var idkey = $id.attr("idkey");
                var rowid = $t.parents(".uls").attr("id");//找到这一行数据
                var datai = {};
                for (var i = 0; i < that.Datas.length; i++) {
                    var dsdi = that.Datas[i];
                    if (dsdi[idkey].toString() == rowid) {
                        datai = that.Datas[i];
                    }
                }
                return datai;
            } else {//老模式 使用rowindex 
                var rowindex = parseInt($t.parents(".uls").attr("rowindex"));//找到这一行数据
                var datai = that.Datas[rowindex];
                if (that.searchData.length > 0) {
                    datai = that.searchData[rowindex];
                }
                return datai;
            }
        },
        _findSearchData: function ($t) {//找到搜索结果中的某一行
            var that = this;
            var $id = that.$id;
            var $body = that.$body;

            if (that.searchData.length > 0) {
                if ($id.attr("idkey")) {//使用id搜索模式
                    var idkey = $id.attr("idkey");
                    var rowid = $t.parents(".uls").attr("id");//找到这一行数据
                    var datai = {};
                    for (var i = 0; i < that.searchData.length; i++) {
                        var dsdi = that.searchData[i];
                        if (dsdi[idkey].toString() == rowid) {
                            datai = that.searchData[i];
                        }
                    }
                    return datai;
                }
            }
            return {};
        },
        update: function ($t, rowid, paras) {//更新缓存数据
            var that = this;
            var $id = that.$id;

            var datai = that._findDatas($t);
            var datais = that._findSearchData($t);
            for (var di in paras) {
                datai[di] = paras[di];
                datais[di] = paras[di];
            }
            if ($id.attr("beforerenderrow")) {
                if ($id.attr("beforerenderrow").indexOf("()") > -1)
                    eval($id.attr("beforerenderrow").replace("()", "") + "(datai)");
                else
                    eval($id.attr("beforerenderrow") + "(datai)");
            }

            var $oldrow = that.$body.find(".uls[id='" + rowid + "']");
            $oldrow.after(zjs.renderRow(datai, that.render));
            $oldrow.remove();
        },
        _deleteRow: function ($t) {//删除一行 要同时删除搜索结果的 和总结果的 并同时减少totle和maxtotle
            var that = this;
            var $id = that.$id;
            var $body = that.$body;

            if ($id.attr("idkey")) {//使用id搜索模式
                var idkey = $id.attr("idkey");
                var rowid = $t.parents(".uls").attr("id");//找到这一行数据 
                for (var i = 0; i < that.Datas.length; i++) {
                    var dsdi = that.Datas[i];
                    if (dsdi[idkey].toString() == rowid) {
                        zjs.removeArray(that.Datas, i);
                    }
                }

                if (that.searchData.length > 0) {
                    for (var i = 0; i < that.searchData.length; i++) {
                        var dsdi = that.searchData[i];
                        if (dsdi[idkey].toString() == rowid) {
                            zjs.removeArray(that.searchData, i);
                        }
                    }
                }
                that.TotalRows = that.TotalRows - 1;
                that.maxTotle = that.maxTotle - 1;
                if (that.$spanTotalRows) {//显示页码 
                    that.$spanTotalRows.text(that.TotalRows);
                }
            } else {//老模式 使用rowindex 
                var rowindex = parseInt($t.parents(".uls").attr("rowindex"));

                that.TotalRows = that.TotalRows - 1;
                if (that.$spanTotalRows) {//显示页码 
                    that.$spanTotalRows.text(that.TotalRows);
                }
                if (that.searchData.length > 0) {
                    zjs.removeArray(that.searchData, rowindex);
                } else {
                    zjs.removeArray(that.Datas, rowindex);
                }
            }
        },
        _nosearchData: function () {
            var that = this;
            var $id = that.$id;
            var $body = that.$body;

            if ($id.attr("nomsg") == "true") {//不提示 
                if ($id.attr("nomsgbtn")) {//不提示
                    $($id.attr("nomsgbtn")).show();
                    $($id.attr("lodingbody")).hide();
                    $($id.attr("tfoots")).hide();
                }
            } else {//提示
                if ($id.find("thead").length > 0) {
                    if ($id.find("thead .nomsg").length == 0) {
                        var tdlength = $id.find("thead tr").first().children("td").length || 100;
                        var $nomsg = $("<tr class='nomsg'><td colspan='" + tdlength + "'>未搜索到相关结果</td></tr>");

                        $id.find("thead").append($nomsg);
                    }
                } else {
                    zjs.tips("未搜索到相关结果", 1);
                }
            }
            if ($id.find("tfoot").length > 0) {
                $id.find("tfoot").hide();
            }
            if ($id.attr("associate") == "true") {//如果启动联想模式 就还原全部结果
                that._setShowDate(true);//设置要显示的数据
            } else {//否则 直接清理body
                $body.empty();
                that.$lockbody.empty();
            }
        },
        isdosearching: false,
        dosearch: function () {//执行搜索 如果数据都在前端 就在前端搜索 否则 就发到服务端处理
            var that = this;
            if (that.isdosearching)//防止用户重复点击搜索
                return false;
            that.isdosearching = true;

            var $id = that.$id;

            that.pageindex = 1;//重置服务器端当前页码
            that.uipageindex = 1;//重置前端当前页面

            if (!that.Datas) {//如果主数据容器未定义 就初始化为空数据
                that.Datas = [];
            }
            if (!that.maxTotle) {//如果最大数据量未定义 就初始化为0
                that.maxTotle = 0;
            }

            that.$body.empty().html(that.loadingimg);//先清空Tbody 并变菊花
            $id.find(".nomsg").remove();
            that.$lockbody.empty();//同时清空锁表头容器
            if ($id.attr("nomsgbtn")) {//如果配置了类似购物车的自定义 未搜索到相关结果 就处理
                $($id.attr("nomsgbtn")).hide();
                $($id.attr("lodingbody")).show();
                $($id.attr("tfoots")).hide();
            }

            if ($id.attr("beforesearchclick")) {//点击搜索按钮时的回调
                if ($id.attr("beforesearchclick").indexOf("()") > -1)
                    eval($id.attr("beforesearchclick").replace("()", "") + "($id)");
                else if ($id.attr("beforesearchclick").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("beforesearchclick"));
                else
                    eval($id.attr("beforesearchclick") + "($id)");
            }

            //如果数据都在前端 就在前端搜索 
            //20150305 从that.TotalRows变为 that.maxTotle  解决可能切换一次服务器端以后 无法搜索的BUG
            if (that.maxTotle == that.Datas.length && that.Datas.length > 0 && $id.attr("onlyserver") != "true" && that.simpleMode == false) {
                var id = $id.attr("id");
                var $paras = that.$Paras.find("input[id],select[id]");

                that.searchData = [];//用于存储搜索结果的结果集

                for (var i = 0; i < that.Datas.length; i++) {
                    var di = that.Datas[i];
                    var isHas = true;
                    $paras.each(function (i, v) { //以现有文本框的值为参数  
                        var $v = $(v);
                        if (di[v.id] != undefined) {
                            switch ($v.attr("searchtype")) {
                                case "equals":
                                    if (v.value) {
                                        if (di[v.id].toString() != (v.value)) {
                                            isHas = false;//任意一个条件不满足 即不满足
                                        }
                                    }
                                    break;
                                case "between":
                                    var start = v.value;
                                    var endinput = that.$Paras.find("input[between='" + v.id + "']")[0];
                                    var end = null;
                                    if (endinput)
                                        end = endinput.value;
                                    var dvalue = di[v.id];
                                    if (start && end) {
                                        //if (end <= start)
                                        if (end < start)
                                            end = null;
                                    }
                                    try {
                                        if ($v.attr("isnumber")) {
                                            dvalue = parseFloat(dvalue);
                                            start = parseFloat(start);
                                            if (end)
                                                end = parseFloat(end);
                                        }
                                    } catch (ex) { };

                                    if (start && end) {
                                        if (dvalue < start || dvalue > end) {
                                            isHas = false;//任意一个条件不满足 即不满足
                                        }
                                    } else if (start) {
                                        if (dvalue < start) {
                                            isHas = false;//任意一个条件不满足 即不满足
                                        }
                                    } else if (end) {
                                        if (dvalue > end) {
                                            isHas = false;//任意一个条件不满足 即不满足
                                        }
                                    }
                                    break;
                                case "in":
                                    if (v.value) {
                                        var vvs = v.value.split(" ");//in查询时 所有in条件都不满足 才表示本条不满足
                                        var vhas = 0;
                                        var vvslength = vvs.length;
                                        for (var vi in vvs) {
                                            if (vvs[vi] != "") {
                                                if (di[v.id].toString().indexOf(vvs[vi]) == -1) {
                                                    vhas++;//如果本条件不满足 就++
                                                }
                                            } else {
                                                vvslength--;
                                            }
                                        }
                                        if (vhas == vvslength) {//那么都不满足就跟长度相等
                                            isHas = false;
                                        }
                                    }
                                    break;
                                default://默认搜索为模糊搜索 只要字符串在数据中 就满足
                                    if (v.value) {
                                        if (di[v.id].toString().indexOf(v.value) == -1) {
                                            isHas = false;//任意一个条件不满足 即不满足
                                        }
                                    }
                                    break;
                            }//end  switch ($v.attr("searchtype")) 
                        }//end   if (di[v.id] && v.value) 
                    });
                    if (isHas) {//如果所有条件都满足 才算真满足
                        that.searchData.push(that.Datas[i]);
                    }
                }
                if (that.searchData.length == 0) {
                    that._nosearchData();
                } else {
                    that._setShowDate(true);//设置要显示的数据
                }
                that.isdosearching = false;
            } else {
                var id = $id.attr("id");
                var searchpara = {};
                that.$Paras.find("input[id],select[id]").each(function (i, v) { //以现有文本框的值为参数 
                    searchpara[v.id] = v.value || "";
                });
                this._search(searchpara, true);
            }
        },
        issearching: false,
        _search: function (searchpara, clearCache) {//搜索服务器端
            var that = this;
            var $id = that.$id;

            var $body = that.$body;
            if ($id.attr("cmd-select")) {//页面加载后 如果配置有获取数据URL 就向URL发起请求 
                if ($id.attr("validatorparas")) {//如果搜索表单也需要检验条件
                    var formp = window["cform" + $id.attr("id") + "Paras"];
                    if (formp) {
                        if (!formp.validator()) {
                            that._nosearchData();
                            that.issearching = false;
                            that.isdosearching = false;
                            return false;
                        }
                    }
                }
                if ($id.attr("beforesearch")) {
                    if ($id.attr("beforesearch").indexOf("()") > -1)
                        eval($id.attr("beforesearch").replace("()", "") + "($id)");
                    else if ($id.attr("beforesearch").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        eval($id.attr("beforesearch"));
                    else
                        eval($id.attr("beforesearch") + "($id)");
                }

                if (clearCache)
                    that.$body.empty().html(that.loadingimg);//先清空

                var para = zjs.getQueryStr();//以URL里的参数为主

                if ($id.attr("clearurlpara")) {
                    para = {};
                }
                if ($id.attr("paras")) {
                    para = zjs.getParas($id.attr("paras"));//以URL里的参数为主
                }

                var winpara = window[$id.attr("id") + "para"];
                if (winpara) {//如果传参数了 就按参数为准
                    for (var pi in winpara) {
                        if (typeof winpara[pi] == 'object' && winpara[pi]) {
                            if (typeof winpara[pi].length == 'undefined') {
                                para[pi] = {};
                                for (var p in winpara[pi]) {
                                    para[pi][p] = winpara[pi][p];
                                }
                            } else {
                                para[pi] = winpara[pi];
                            }
                        } else {
                            para[pi] = winpara[pi];
                        }
                    }
                }

                para.pagesize = that.pagesize;
                para.pageindex = that.pageindex;

                if (searchpara) {//如果传参数了 就按参数为准
                    for (var pi in searchpara) {
                        para[pi] = searchpara[pi];
                    }
                }
                if (that.issearching)
                    return false;
                that.issearching = true;
                var spara = {
                    cmd: $id.attr("cmd-select"),
                    url: $id.attr("url"),
                    para: para,
                    callback: function (data) {
                        that.issearching = false;
                        that.isdosearching = false;

                        if (data) {
                            if (clearCache) {//如果是搜索状态 就清空缓存中的所有数据
                                that.Datas = data.Datas || data.datas || data.Data || data;
                                that.pageindex = 1;//重置服务器端当前页码
                                that.uipageindex = 1;//重置前端当前页面
                                //that.maxTotle = 0; //2015-11-25 由于重置了maxTotle所以前端查询失效了 所以注释
                                that.searchData = [];
                            } else {//如果是下拉刷新的下一页 就把数据追加到现有数据集中
                                that.Datas = that.Datas.concat(data.Datas || data.datas || data.Data || data);//数组对数组的追加是用concat
                            }
                            if (that.simpleMode) {//如果是简单模式 就不用缓存数据了 每次请求的就是当前数据
                                that.Datas = data.Datas || data.datas || data.Data || data;
                            }
                            that.TotalPages = data.TotalPages || data.totalPages || 1;
                            that.TotalRows = data.TotalRows || data.totalRows || that.Datas.length;
                            if (that.TotalRows > that.maxTotle)//存储最大的数据量 如果曾经有1000条 切换成服务器端模式后变成100条
                                that.maxTotle = that.TotalRows;//那么下次应该还使用服务器端模板 

                            that.Datas1 = data.Datas1;
                            that.Datas2 = data.Datas2;
                            that.Datas3 = data.Datas3;
                            that.Datas4 = data.Datas4;
                            that.Datas5 = data.Datas5;
                            that.Datas6 = data.Datas6;
                            that.Datas7 = data.Datas7;
                            that.Datas8 = data.Datas8;
                            that.Datas9 = data.Datas9;
                            that.ServerData = data;

                            //处理全文检索
                            for (var rdi in that.Datas) {
                                var rdatai = that.Datas[rdi];
                                rdatai.searchfull = "";
                                for (var rdiv in rdatai) {
                                    if (typeof rdatai[rdiv] == "object") {
                                        rdatai.searchfull = rdatai.searchfull + ($.toJSON(rdatai[rdiv]) || "");
                                    } else {
                                        rdatai.searchfull = rdatai.searchfull + (rdatai[rdiv] || "");
                                    }
                                }
                            }
                            if ($id.attr("callback")) {
                                if ($id.attr("callback").indexOf("()") > -1)
                                    eval($id.attr("callback").replace("()", "") + "($id,data)");
                                else if ($id.attr("callback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                    eval($id.attr("callback"));
                                else
                                    eval($id.attr("callback") + "($id,data)");
                            }

                            that._setShowDate(clearCache);//设置要显示的数据 如果是前后翻页过来的 就不需要清理

                            if (that.Datas.length == 0) {
                                that._nosearchData();
                            }

                            if ($id.attr("getcallback")) {
                                if ($id.attr("getcallback").indexOf("()") > -1)
                                    eval($id.attr("getcallback").replace("()", "") + "($id,data)");
                                else if ($id.attr("getcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                    eval($id.attr("getcallback"));
                                else
                                    eval($id.attr("getcallback") + "($id,data)");
                            }
                        }
                    }
                };
                if ($id.attr("contentType")) {
                    spara.contentType = $id.attr("contentType");
                }
                zjs.cmd(spara);
            }
        },
        _setShowDate: function (clearbody) {//设置要显示的数据
            var that = this;
            var $id = that.$id;

            if ($id.attr("nomsgbtn")) {//不提示
                $($id.attr("nomsgbtn")).hide();
                $($id.attr("lodingbody")).hide();
                $($id.attr("tfoots")).show();
            }
            if ($id.find("tfoot").length > 0) {
                $id.find("tfoot").show();
            }
            that.Data = [];
            if (that.simpleMode) {//如果是简单模式 数据就是完整的 总页数就是服务端的 
                that.Data = that.Datas;
                for (var i = 0; i < that.Datas.length; i++) {
                    var di = that.Datas[i];
                    di.rowindex = i;
                    di.rindex = i + 1;
                }
                that.sstotlepage = that.TotalPages;
                that.$spanTotalRows.text(that.TotalRows);
                that.$spanPageIndex.text(that.uipageindex + "/" + that.sstotlepage);
            } else {//否则还是正常模式
                var start = (that.uipageindex - 1) * that.uipagesize;
                var end = (that.uipageindex) * that.uipagesize;

                if (that.searchData.length == 0) {//如果没有搜索结果 就按正常的走 
                    that.sstotlepage = Math.ceil(that.TotalRows / that.uipagesize);     //服务端总行数/前端页容量=前端总页数
                    that.uitotlepage = Math.ceil(that.Datas.length / that.uipagesize);   //缓存中的数据在前端的总页数

                    for (var i = start; i < end && i < that.Datas.length; i++) {
                        var di = that.Datas[i];
                        di.rowindex = i;
                        di.rindex = i + 1;
                        that.Data.push(di);
                    }
                    if (that.$spanTotalRows) {//显示页码 
                        that.$spanTotalRows.text(that.TotalRows);
                        that.$spanPageIndex.text(that.uipageindex + "/" + that.sstotlepage);
                    }
                } else {//如果有搜索结果 就以搜索结果为翻页依据 
                    that.sstotlepage = Math.ceil(that.searchData.length / that.uipagesize);     //搜索结果总行数/前端页容量=前端总页数
                    that.uitotlepage = Math.ceil(that.searchData.length / that.uipagesize);   //前端总页数

                    for (var i = start; i < end && i < that.searchData.length; i++) {
                        var di = that.searchData[i];
                        di.rowindex = i;
                        di.rindex = i + 1;
                        that.Data.push(di);
                    }
                    if (that.$spanTotalRows) {//显示页码 
                        that.$spanTotalRows.text(that.searchData.length);
                        that.$spanPageIndex.text(that.uipageindex + "/" + that.sstotlepage);
                    }
                }
            }
            var $tfoot = that.$tfoot;//如果有页角
            if ($tfoot.length > 0) {
                $tfoot.find(".firstPage").removeClass("nothingbtn");
                $tfoot.find(".downPage").removeClass("nothingbtn");
                $tfoot.find(".prevPage").removeClass("nothingbtn");
                $tfoot.find(".nextPage").removeClass("nothingbtn");

                if (that.uipageindex == 1) {
                    //如果是第一页 就禁用上一页和上一屏
                    $tfoot.find(".firstPage").addClass("nothingbtn");
                    $tfoot.find(".prevPage").addClass("nothingbtn");
                }
                if (that.uipageindex == that.sstotlepage) {
                    //如果是最后一页 就禁用下一页和下一屏
                    $tfoot.find(".downPage").addClass("nothingbtn");
                    $tfoot.find(".nextPage").addClass("nothingbtn");
                }
            }

            if ($id.attr("beforerender")) {
                if ($id.attr("beforerender").indexOf("()") > -1)//如果有（）说明是空函数 就加上参数
                    eval($id.attr("beforerender").replace("()", "") + "($id,that.Datas)");
                else if ($id.attr("beforerender").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("beforerender"));
                else//如果没有一个（） 就带上（）运行
                    eval($id.attr("beforerender") + "($id,that.Datas)");
            }

            if ($id.attr("beforerenderrow")) {
                for (var rdi in that.Data) {
                    var rdatai = that.Data[rdi];
                    if ($id.attr("beforerenderrow").indexOf("()") > -1)
                        eval($id.attr("beforerenderrow").replace("()", "") + "(rdatai)");
                    else
                        eval($id.attr("beforerenderrow") + "(rdatai)");
                }
            }

            that._render(clearbody);//渲染要显示的数据
            that._tdfixed();//设置td最大宽度

            if ($id.attr("afterrender")) {
                if ($id.attr("afterrender").indexOf("()") > -1)
                    eval($id.attr("afterrender").replace("()", "") + "($id,that.Datas)");
                else if ($id.attr("afterrender").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("afterrender"));
                else
                    eval($id.attr("afterrender") + "($id,that.Datas)");
            }
        },
        _tdfixed: function () {
            var that = this;
            var $id = that.$id;
            zjs.tdfixed($id);
        },
        _render: function (clearbody) {//行渲染模式
            var that = this;
            var $id = that.$id;
            var $body = that.$body;
            var render = that.render;           //HTML模板
            var dateformat = $id.attr("dateformat") || "yyyy-MM-dd";
            var data = that["Data"];    //数据

            $id.find(".nomsg").remove();
            if (!$id.attr("pullToRefresh") && !$id.attr("scrollToRefresh")) { //下拉刷新的不清空容器 scrollToRefresh
                $body.empty();//清空容器
                that.$lockbody.empty();
            } else {
                $body.find("img.loading").remove();//清空容器
            }

            if (clearbody) {
                $body.empty();//清空容器
                that.$lockbody.empty();
            }
            if (that.simpleMode) {//如果是简单模式 
                $body.empty();//清空容器
                that.$lockbody.empty();
            }

            if (data) {
                if (data.length > 0) {
                    if ($id.attr("lockall")) {
                        var $newhtml = $(zjs.render(data, render, dateformat, $id.attr("htmlbox")));
                        $newhtml.find("td").first().append("<a name='pager" + that.uipageindex + "'></a>");
                        $body.append($newhtml);
                    } else {
                        if ($id.attr("scrollToRefresh")) {
                            var pagertext = "<div class='pagerpostion'><a name='pager" + that.uipageindex + "'>" + that.uipageindex + "</a></div>";
                            if (that.uipageindex == 1) {
                                pagertext = "<a name='pager" + that.uipageindex + "'></a>";
                            }
                            if ($id.hasClass("ctable")) {
                                var tdlength = $id.find("thead tr").first().children("td").length || 100;
                                $body.append("<tr><td colspan='" + tdlength + "' class='p0'>" + pagertext + "</td></tr>");
                            }
                            else
                                $body.append("<div class='c12'>" + pagertext + "</div>");
                        }
                        $body.append(zjs.render(data, render, dateformat, $id.attr("htmlbox")));
                        $body.find("tr.uls").each(function (i, v) {
                            if (i % 2 != 0) {
                                $(v).addClass("evenuls");
                            }
                        });
                        $body.find("tr.uls").first().addClass("notop");
                    }
                    if (that.lockrender) {
                        that.$lockbody.append(zjs.render(data, that.lockrender, dateformat, $id.attr("htmlbox")));
                        $body.find("tr").each(function (i, v) {
                            var $tr = $(v);
                            if (!$tr.attr("isheight")) {
                                $tr.attr("isheight", "1");
                                var $ltr = that.$lockbody.find("tr").eq(i);
                                if ($tr.height() > $ltr.height()) {
                                    $ltr.height($tr.height());
                                    $tr.height($tr.height());
                                } else {
                                    $tr.height($ltr.height());
                                    $ltr.height($ltr.height());
                                }
                            }
                        });
                    }
                }
            }

            var $tfoot = that.$tfoot;//如果有页角
            var $pageNumbers = $tfoot.find(".pageNumbers");
            if ($pageNumbers.length > 0) {
                $pageNumbers.empty();

                if ($id.attr("scrollToRefresh") && that.simpleMode == false) {//如果是下拉刷新 就只能加载目前已有的页码 点击为锚点
                    var TotalPages = that.uitotlepage;//总页数 
                    var PageIndex = that.uipageindex;  //当前页码
                    var pagestart = PageIndex - 8 > 0 ? PageIndex - 8 : 1;  //计算页码起始位置
                    var pageend = PageIndex;    //计算页码结束位置
                    if (pagestart > 10) {
                        $pageNumbers.append("<a href='#pager1' class=''>1</a>");
                    }
                    for (var i = pagestart; i <= pageend && i <= TotalPages; i++) {
                        $pageNumbers.append("<a href='#pager" + i + "' class='" + (i == PageIndex ? "hover" : "") + "'>" + i + "</a>");
                    }

                    $pageNumbers.find("a").click(function () {
                        $(this).addClass("hover").siblings().removeClass("hover");
                    });
                }
                else {
                    var TotalPages = that.uitotlepage;//总页数20
                    if (that.simpleMode) {//如果是简单模式 
                        TotalPages = that.sstotlepage;//总页数
                    }
                    var PageIndex = that.uipageindex;  //当前页码15 17
                    var pagestart = PageIndex + 4 < TotalPages ? PageIndex - 4 : TotalPages - 8;  //计算页码起始位置
                    var pageend = PageIndex + 4 < TotalPages ? PageIndex + 4 : TotalPages;    //计算页码结束位置
                    if (pageend < 9) { pageend = 9; pagestart = 1; }//如果页码小于7 就直接1到7
                    if (PageIndex > 10) {
                        $pageNumbers.append("<a href='javascript:void(0)'>1</a>");
                    }
                    for (var i = pagestart; i <= pageend && i <= TotalPages; i++) {
                        $pageNumbers.append("<a href='javascript:void(0)' class='" + (i == PageIndex ? "hover" : "") + "'>" + i + "</a>");
                    }

                    $pageNumbers.find("a").click(function () {
                        if (that.simpleMode) {//如果是简单模式 
                            $(window).scrollTop($id.offset().top - 100);
                            that._simpleGoPage($(this).text());
                        } else {
                            $(window).scrollTop($id.offset().top - 100);
                            that._goPage($(this).text());
                        }
                    });
                }
            }

            //还原复选框的状态 
            $body.find(".selection").each(function (i, v) {//复选框事件
                var $t = $(v);
                var datai = that._findDatas($t);
                if (datai.ischecked) {//如果选中
                    $(this).attr("checked", "checked");
                }
            });//end 复选框事件 
        },
        lazyrender: function (data) {//外部函数 延迟加载 可以直接给数据
            this["Data"] = data;
            this._render();
        },
        showDate: function (clearbody) {//设置要显示的数据
            this._setShowDate(clearbody);
        },
        search: function (searchpara) {//搜索服务器端
            this._search(searchpara, true);
        }
    }
};
zjs.ctable = zjs.extend(function () { }, zjs.ctable);

/*!
* FORM验证组件 表示每一个验证对象
*/
if (!window.zjs.formElement) {
    zjs.formElement = {
        clazz: "zjs.formElement",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var that = this;
            var $id = that.$id;

            var msg = $id.attr("message");      //初始化提示语
            if (msg) {
                that.$span.text(msg).removeClass("error");
            }
            that.$span.click(function () {
                $id.trigger("focus");
            });
            $id.bind("clear", function () {  //获取焦点 一般显示提示信息
                that._focus();
            });
            $id.bind("focus", function () {  //获取焦点 一般显示提示信息
                that._focus();
            });
            $id.bind("blur", function () {   //失去焦点 验证输入有效性
                that.validator();
                if ($id.attr("message") && $id.val() == "") {
                    that.$span.text($id.attr("message"));
                }
            });
            $id.bind("change", function () {   //失去焦点 验证输入有效性 
                if ($id.attr("message") && $id.val() == "") {
                    that.$span.text($id.attr("message"));
                } else {
                    that.$span.text("").removeClass("error");
                }
            });
            if ($id.attr("lengthspan") && $id.attr("lengthvalue")) {
                var v = $id[0];
                if ($.browser.msie) {
                    v.onpropertychange = function () {
                        that._lengthevent();
                    };
                } else {
                    v.oninput = function () {
                        that._lengthevent();
                    };
                }
            }
            setTimeout(function () {
                if ($id.val() != "") {
                    that.$span.text("");
                }
            }, 1000);
        },
        _lengthevent: function () {
            var that = this;
            var $id = that.$id;
            if ($id.attr("lengthspan") && $id.attr("lengthvalue")) {
                var $lengthspan = $($id.attr("lengthspan"));
                if ($lengthspan.length > 0) {
                    var lengthvalue = parseInt($id.attr("lengthvalue"));//可输入最大值
                    var nowlength = zjs.getLen($id.val());//当前输入的长度
                    if (nowlength > lengthvalue) {//如果超长了 就提示超长
                        $lengthspan.html("最多 " + lengthvalue + " 字,已超出 <span class='error'>" + (nowlength - lengthvalue) + "</span> 字");
                    } else {//如果没超长 就提示剩余多少
                        $lengthspan.html("最多 " + lengthvalue + " 字,还剩 <span class='error'>" + (lengthvalue - nowlength) + "</span> 字");
                    }
                }
            }
        },
        _focus: function () {               //获取焦点 
            //this.$id.removeClass("error");
            this.$span.text("").removeClass("error");
        },
        _error: function (ruleid, inputValue) {//错误提示信息
            var $id = this.$id;
            var msg = zjs.validatorRules[ruleid];
            //this.$id.addClass("error");
            if ($id.attr("error")) {
                this.$span.text($id.attr("error")).addClass("error");
            } else {
                if (msg)
                    this.$span.text(msg["alertText"].replace("@v", inputValue)).addClass("error");
            }
        },
        _success: function () {                //成功提示信息
            var $id = this.$id;
            if ($id.attr("success")) {
                //this.$id.removeClass("error");
                this.$span.text($id.attr("success")).removeClass("error");
            }
        },
        validator: function () {
            var $id = this.$id;
            if ($id.hasClass("ceditor") || $id.hasClass("ceditormin")) {
                $id.trigger("getdata");
            }
            var rules = $id.attr("rule");
            if (rules) {
                this._focus();
                var ruleList = rules.split(';');          //多规则以;分割
                for (var ruleid in ruleList) {
                    if (ruleList[ruleid]) {
                        var ruleConfig = ruleList[ruleid].split(':');//规则名和值以:分割
                        var rule = ruleConfig[0];
                        var val = ruleConfig[1];

                        try {
                            switch (rule) {
                                case "required":
                                    if ($id.val().replace(/[ ]/g, "") == "") {
                                        this._error(rule, val);
                                        return false;
                                    }
                                    break;
                                case "equals":
                                    if ($id.val() != $id.parents("form").find("#" + val).val()) {
                                        this._error(rule, val);
                                        return false;
                                    }
                                    break;
                                case "isnumber":
                                    try {
                                        var idvalf = parseFloat($id.val());
                                        if ($id.val() != (idvalf + "")) {
                                            this._error(rule, val);
                                            return false;
                                        }
                                    } catch (ex) { return false; }
                                    break;
                                case "length":
                                    if (ruleConfig.length > 2) {
                                        if (zjs.getLen($id.val()) > val || zjs.getLen($id.val()) < ruleConfig[2]) {
                                            this._error(rule, ruleConfig[2] + " ~ " + val);
                                            return false;
                                        }
                                    } else {//正常的长度判断
                                        if (zjs.getLen($id.val()) > val) {
                                            this._error(rule, val);
                                            return false;
                                        }
                                    }
                                    break;
                                case "between":
                                    try {
                                        if (ruleConfig.length > 2) {
                                            var bt1 = parseFloat(ruleConfig[1]);//最小值
                                            var bt2 = parseFloat(ruleConfig[2]);//最大值
                                            var idvalf = parseFloat($id.val());//现在的值
                                            if (idvalf > bt2 || idvalf < bt1 || $id.val() != (idvalf + "")) {
                                                this._error(rule, bt1 + " ~ " + bt2);
                                                return false;
                                            }
                                        } else { return false; }
                                    } catch (ex) { return false; }
                                    break;
                                default:
                                    var msg = zjs.validatorRules[rule];
                                    if (msg && $id.val() != "") {
                                        if (eval(msg["regex"]).test($id.val()) == false) {
                                            this._error(rule, val);
                                            return false;
                                        }
                                    }
                                    break;
                            }// end switch
                        } catch (e) { return true; }//end try
                    } //end if规则不为空
                } //end for 多规则循环
            } //end if rules

            this._success();//所有规则都验证通过以后

            if ($id.attr("checkcallback")) {
                var re = true;
                if ($id.attr("checkcallback").indexOf("()") > -1)
                    re = eval($id.attr("checkcallback").replace("()", "") + "($id)");
                else if ($id.attr("checkcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    re = eval($id.attr("checkcallback"));
                else
                    re = eval($id.attr("checkcallback") + "($id)");
                return re;
            } else {
                return true;    //直接返回成功
            }
        }//end validator
    };
};
zjs.formElement = zjs.extend(function () { }, zjs.formElement);

/* 表单组件 */
if (!window.zjs.cform) {
    zjs.cform = {
        clazz: "zjs.cform",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var that = this;
            var $id = that.$id;

            $id.find("#submit").click(function () { //绑定保存按钮事件
                that._save();
            });
            $("#" + $id.attr("id") + "submit").click(function () { //绑定不在表单里的保存按钮事件
                that._save();
            });

            if ($id.attr("nokeydown") == "true") { } else {
                var $ops = $id.find("input[type='text']");
                $ops.keydown(function (e) {//回车切换焦点
                    if (e.keyCode == 13) {
                        if ($ops.index(this) == $ops.length - 1)
                            that._save();
                        else {
                            $ops.eq($ops.index(this) + 1).focus();
                            return false;
                        }
                    }
                });
            }

            if ($id.attr("istemplate")) {//如果是前台展示类的form 就把整个form作为模板
                that.template = $id.html();
                $id.html("<img src='" + zjs.rootdir + "img/loading.gif' class='loading'/>").show();
            } else {//如果不是前台展示类的 就初始化校验
                that._initElement();
                $id.append("<div class='customize'><input type='hidden' id='isclose' /></div>");
            }

            var para = zjs.getQueryStr();//以URL里的参数为主
            if (para.id || $id.attr("allcmds")) {//如果参数里有id再查询 否则默认不查询
                that.search();
            }
        },
        _initElement: function () {
            var that = this;
            var $id = that.$id;

            that.Elements = [];
            $id.find("input,textarea").each(function (i, v) {//表单项
                var $v = $(v);
                if ($v.attr("rule")) {//如果需要验证规则 
                    var $span = $("<span class='info'></span>");
                    if ($v.prev("span.info").length == 0) {
                        $v.before($span);//初始化提示
                    } else {
                        $span = $v.prev("span.info");
                    }

                    var ele = new zjs.formElement({
                        $id: $v,
                        $span: $span
                    });
                    that.Elements.push(ele);//放到待验证数组中

                    var gps = zjs.getQueryStr();
                    if (!gps.id) {
                        if ($v.attr("rule").indexOf("required") > -1 && !$v.attr("message")) {
                            $span.addClass("error").text("* 必填");
                        }
                    }
                }
            });
        },
        search: function (searchpara) {//外部函数 刷新表单 一般用于修改时 读取现有数据 
            var that = this;
            var $id = that.$id;

            if ($id.attr("cmd-select") || $id.attr("cmds")) {//页面加载后 如果配置有获取数据URL 就向URL发起请求 
                if ($id.attr("beforesearch")) {
                    if ($id.attr("beforesearch").indexOf("()") > -1)
                        eval($id.attr("beforesearch").replace("()", "") + "($id)");
                    else if ($id.attr("beforesearch").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        eval($id.attr("beforesearch"));
                    else
                        eval($id.attr("beforesearch") + "($id)");
                }

                var para = zjs.getQueryStr();//以URL里的参数为主

                if ($id.attr("clearurlpara")) {
                    para = {};
                }
                if ($id.attr("paras")) {
                    para = zjs.getParas($id.attr("paras"));//以URL里的参数为主
                }
                $id.find("input,textarea,select").each(function (i, v) { //以现有文本框的值为参数
                    if (v.value) {
                        para[v.id] = v.value;
                    }
                });

                if (searchpara) {//如果传参数了 就按参数为准
                    for (var pi in searchpara) {
                        para[pi] = searchpara[pi];
                    }
                }

                var winpara = window[$id.attr("id") + "para"];
                if (winpara) {//如果传参数了 就按参数为准
                    for (var pi in winpara) {
                        if (typeof winpara[pi] == 'object' && winpara[pi]) {
                            if (typeof winpara[pi].length == 'undefined') {
                                para[pi] = {};
                                for (var p in winpara[pi]) {
                                    para[pi][p] = winpara[pi][p];
                                }
                            } else {
                                para[pi] = winpara[pi];
                            }
                        } else {
                            para[pi] = winpara[pi];
                        }
                    }
                }

                if (that.template) {
                    $id.html("<img src='" + zjs.rootdir + "img/loading.gif' class='loading'/>");
                }

                $id.find("#submit").addClass("loading");
                var spara = {
                    cmd: $id.attr("cmd-select") || $id.attr("cmds"),
                    para: para,
                    callback: function (data) {
                        if (data) {
                            var datai = data;
                            if (data.Datas) {
                                datai = data.Datas[0];
                            }
                            that.Data = datai;
                            that.ServerData = data;

                            if ($id.attr("beforerender")) {
                                if ($id.attr("beforerender").indexOf("()") > -1)//如果有（）说明是空函数 就加上参数
                                    eval($id.attr("beforerender").replace("()", "") + "($id,data)");
                                else if ($id.attr("beforerender").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                    eval($id.attr("beforerender"));
                                else//如果没有一个（） 就带上（）运行
                                    eval($id.attr("beforerender") + "($id,data)");
                            }

                            that.render();
                        }

                        if ($id.attr("getcallback")) {
                            if ($id.attr("getcallback").indexOf("()") > -1)
                                eval($id.attr("getcallback").replace("()", "") + "($id,data)");
                            else if ($id.attr("getcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                eval($id.attr("getcallback"));
                            else
                                eval($id.attr("getcallback") + "($id,data)");
                        }

                        $id.find("#submit").removeClass("loading");
                    },
                    alwayscallback: function () {
                        $id.find("#submit").removeClass("loading");
                    }
                };
                if ($id.attr("scontentType")) {
                    spara.contentType = $id.attr("scontentType");
                }
                zjs.cmd(spara);
            }
        },
        render: function () {//渲染表单
            var that = this;
            var $id = that.$id;

            var datai = that.Data;
            if (that.template) {
                for (var di in datai) {
                    if (typeof datai[di] == "object") {
                        for (var odi in datai[di]) {
                            //如果属性本身就是object对象 就转一下字符串 再放进去
                            datai[di + "." + odi] = datai[di][odi];
                        }
                    }
                }
                $id.html(zjs.renderRow(datai, that.template, $id.attr("dateformat"), $id.attr("htmlbox")));
            }
            else {
                if ($id.attr("modoradd")) {
                    //如果是添加修改模式 必须是添加状态的话 就改变一下选择器
                    if (!datai["ID"]) {
                        $id.find(".cselector,.cselectorRadio,.cselectorTree").val("").trigger("change");
                    }
                }
                for (var di in datai) {
                    if ($id.attr("contentType") == "application/json; charset=utf-8") {
                        //20160201如果是JSON方式提交数据 那么object对象里面的属性就在input上加上objectpath
                        //<input id="productname" objectpath="product" /> 这种结构就表示是product.productname关系
                        if (typeof datai[di] == "object") {
                            for (var odi in datai[di]) {
                                //如果属性本身就是object对象 就转一下字符串 再放进去
                                var odvalue = typeof datai[di][odi] == "object" ? $.toJSON(datai[di][odi]) : datai[di][odi];
                                odvalue = (odvalue == null ? "" : odvalue);//如果是null 就置空
                                $id.find("#" + odi).each(function (i, v) {
                                    var $v = $(v);
                                    if ($v.attr("objectpath") == di) {//子属性里 必须有这个objectpath和父属性相等的 才处理赋值 否则不管
                                        $id.find("#" + odi).val(zjs.htmlDecode(odvalue)).trigger("change");
                                    }
                                });
                            }
                        }
                    }
                }
                zjs.renderForm($id, datai);

                $id.find("table[savepath]").each(function (i, v) {
                    var tablename = $(v).attr("savepath");
                    var $trowadd = $(".tbodyadd[target='" + tablename + "']");
                    if (datai[tablename]) {
                        var dataitem = $.evalJSON(datai[tablename]);//先解析行
                        if (dataitem.length > 0) {
                            for (var di in dataitem) {
                                $trowadd.trigger("click");
                            }//先按行数生成HTML

                            $(v).find("tbody.item").each(function (ii, vv) {//再循环HTML 绑定历史数据
                                var item = dataitem[ii];
                                $(vv).find("input[id],textarea[id]").each(function (iii, vvv) {//具体一条记录的每一个字段
                                    var $vvv = $(vvv);
                                    $vvv.val(item[$vvv.attr("id")]).trigger("change");
                                });

                                //再解析行内行
                                $(vv).find("table[subsavepath]").each(function (sti, stv) {
                                    var subtablename = $(stv).attr("subsavepath");
                                    var $subtrowadd = $(stv).find(".subtbodyadd");
                                    if (item[subtablename]) {
                                        var subdataitem = $.evalJSON(item[subtablename]);//先解析行
                                        if (subdataitem.length > 0) {
                                            for (var di in subdataitem) {
                                                $subtrowadd.trigger("click");
                                            }//先按行数生成HTML
                                            $(stv).find("tbody.subitem").each(function (stbii, stbvv) {//再循环HTML 绑定历史数据
                                                var stitem = subdataitem[stbii];
                                                $(stbvv).find("input[id],textarea[id]").each(function (stiii, stvvv) {//具体一条记录的每一个字段
                                                    var $stvvv = $(stvvv);
                                                    $stvvv.val(stitem[$stvvv.attr("id")]).trigger("change");
                                                });
                                            });
                                        }
                                    }
                                });
                            });
                        }
                    }
                });
                $id.find(".table[savepath]").each(function (i, v) {
                    var tablename = $(v).attr("savepath");
                    var $trowadd = $(".tbodyadd[target='" + tablename + "']");
                    if (datai[tablename]) {
                        var dataitem = $.evalJSON(datai[tablename]);
                        if (dataitem.length > 0) {
                            for (var di in dataitem) {
                                $trowadd.trigger("click");
                            }//先按行数生成HTML

                            $(v).find(".tbody.item").each(function (ii, vv) {//再循环HTML 绑定历史数据
                                var item = dataitem[ii];
                                $(vv).find("input[id],textarea[id]").each(function (iii, vvv) {//具体一条记录的每一个字段
                                    var $vvv = $(vvv);
                                    $vvv.val(item[$vvv.attr("id")]).trigger("change");
                                });
                            });
                        }
                    }
                });
            }
        },
        validator: function () {
            var that = this;
            that._initElement();
            var submit = true;
            for (var i = 0; i < that.Elements.length; i++) {//批量验证 
                if (!that.Elements[i].validator()) {
                    submit = false;
                }
            }
            return submit;
        },
        _save: function () {
            var that = this;
            var $id = that.$id;

            if (!that.validator() || $id.find("#submit").hasClass("loading")) {
                if ($("span.info.error").first().next("input").css("display") != "none") {
                    $("span.info.error").first().next("input").focus();
                }
                return false;
            }
            else {
                //验证通过后 发送请求 
                if ($id.attr("beforesubmit")) {
                    var re = true;
                    if ($id.attr("beforesubmit").indexOf("()") > -1)
                        re = eval($id.attr("beforesubmit").replace("()", "") + "($id)");
                    else if ($id.attr("beforesubmit").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        re = eval($id.attr("beforesubmit"));
                    else
                        re = eval($id.attr("beforesubmit") + "($id)");
                    if (!re)
                        return re;
                }

                $id.find("table[savepath]").each(function (i, v) {//20160726 新增可以在表单中打包多行数据的默认支持
                    var tablename = $(v).attr("savepath");
                    var items = [];
                    $(v).find("tbody.item").each(function (ii, vv) {//具体模块的具体一条记录
                        //先打包行内行
                        $(vv).find("table[subsavepath]").each(function (sti, stv) {
                            var subtablename = $(stv).attr("subsavepath");
                            var subitems = [];
                            $(stv).find("tbody.subitem").each(function (stbi, stbv) {//具体模块的具体一条记录
                                var subitem = {};
                                $(stbv).find("input[id],textarea[id]").each(function (stii, stiv) {//具体一条记录的每一个字段
                                    var $stiv = $(stiv);
                                    subitem[$stiv.attr("id")] = $stiv.val();
                                });
                                subitems.push(subitem);
                            });
                            $(vv).find("#" + subtablename).val($.toJSON(subitems));
                        });

                        //再打包行
                        var item = {};
                        $(vv).find("input[id],textarea[id]").each(function (iii, vvv) {//具体一条记录的每一个字段
                            var $vvv = $(vvv);
                            if ($vvv.parents("table[subsavepath]").length == 0) {
                                item[$vvv.attr("id")] = $vvv.val();
                            }
                        });
                        items.push(item);
                    });
                    $id.find("#" + tablename).val($.toJSON(items));
                });
                $id.find(".table[savepath]").each(function (i, v) {//非标准表格模式打包多条 比如财务状况 竖着的表格
                    var tablename = $(v).attr("savepath");
                    var items = [];
                    $(v).find(".tbody.item").each(function (ii, vv) {//具体模块的具体一条记录
                        var item = {};
                        $(vv).find("input[id],textarea[id]").each(function (iii, vvv) {//具体一条记录的每一个字段
                            var $vvv = $(vvv);
                            item[$vvv.attr("id")] = $vvv.val();
                        });
                        items.push(item);
                    });
                    $id.find("#" + tablename).val($.toJSON(items));
                });

                if ($id.attr("cmd-insert") || $id.attr("cmd-update") || $id.attr("cmdi") || $id.attr("cmdu")) {
                    $id.find("#submit").addClass("loading");

                    var cmd = $id.attr("cmd-insert") || $id.attr("cmdi");
                    var para = zjs.getQueryStr();//以URL里的参数为主

                    if ($id.attr("clearurlpara")) {
                        para = {};
                    }
                    if (para.id && ($id.attr("cmd-update") || $id.attr("cmdu"))) { //如果URL中存在主键说明是更新 发送更新请求
                        cmd = $id.attr("cmd-update") || $id.attr("cmdu");
                    }

                    //发送添加请求
                    $id.find("input,select").each(function (i, v) {
                        var $v = $(v);
                        if ($v.parents(".customize").length == 0) {
                            if (v.id) {
                                if ($v.attr("objectpath")) {
                                    //20160201如果是JSON方式提交数据 那么object对象里面的属性就在input上加上objectpath
                                    //<input id="productname" objectpath="product" /> 这种结构就表示是product.productname关系
                                    if (para[$v.attr("objectpath")]) {
                                        para[$v.attr("objectpath")][v.id] = zjs.htmlEncode(v.value);
                                    } else {
                                        para[$v.attr("objectpath")] = {};
                                        para[$v.attr("objectpath")][v.id] = zjs.htmlEncode(v.value);
                                    }
                                } else {
                                    if (v.type == "password") {
                                        para[v.id] = hex_md5(v.value);
                                    }
                                    else {
                                        if ($v.hasClass("htmlbox")) {
                                            para[v.id] = v.value;
                                        } else {
                                            para[v.id] = zjs.htmlEncode(v.value);
                                        }
                                    }
                                }
                            }
                        }
                    });
                    $id.find("textarea").each(function (i, v) {
                        var $v = $(v);
                        var vvalue = "";
                        if ($v.hasClass("ceditor") || $v.hasClass("ceditormin") || $v.hasClass("htmlbox")) {
                            $v.trigger("getdata");
                            vvalue = v.value;
                        } else {
                            vvalue = zjs.htmlEncode(v.value);
                        }
                        if ($v.parents(".customize").length == 0) {
                            if (v.id) {
                                if ($v.attr("objectpath")) {
                                    //20160201如果是JSON方式提交数据 那么object对象里面的属性就在input上加上objectpath
                                    //<input id="productname" objectpath="product" /> 这种结构就表示是product.productname关系
                                    if (para[$v.attr("objectpath")]) {
                                        para[$v.attr("objectpath")][v.id] = vvalue;
                                    } else {
                                        para[$v.attr("objectpath")] = {};
                                        para[$v.attr("objectpath")][v.id] = vvalue;
                                    }
                                } else {
                                    if (v.type == "password") {
                                        para[v.id] = hex_md5(v.value);
                                    }
                                    else {
                                        para[v.id] = vvalue;
                                    }
                                }
                            }
                        }
                    });

                    var winpara = window["cform" + $id.attr("id") + "submitpara"];
                    if (winpara) {//如果传参数了 就按参数为准
                        for (var pi in winpara) {
                            para[pi] = winpara[pi];
                        }
                    }
                    if (zjs.lhgtips) {
                        zjs.lhgtips("请稍候...", 1000, "loading.gif", true);
                    }
                    var savepara = {
                        cmd: cmd,
                        para: para,
                        callback: function (data) {
                            if (data) {
                                for (var di in data) {
                                    if ($id.find("#" + di).length > 0)
                                        $id.find("#" + di).val(data[di]).trigger("change");
                                }
                            }

                            $id.find("#isclose").val("1");

                            if ($id.attr("setcallback")) {
                                if ($id.attr("setcallback").indexOf("()") > -1)
                                    eval($id.attr("setcallback").replace("()", "") + "($id,data)");
                                else if ($id.attr("setcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                                    eval($id.attr("setcallback"));
                                else
                                    eval($id.attr("setcallback") + "($id,data)");
                            }

                            if ($id.attr("target")) {
                                setTimeout(function () {
                                    var tourl = $id.attr("target");
                                    tourl = tourl + (tourl.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
                                    window.location.href = tourl;
                                }, 1500);
                            } else {
                                $id.find("#submit").removeClass("loading");
                            }
                            if ($id.attr("refresh")) {//如果是跳转 就直接跳转 
                                setTimeout(function () {
                                    var tourl = window.location.href;
                                    tourl = tourl + (tourl.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
                                    window.location.href = tourl;
                                }, 1500);
                            }
                        },//end callback
                        alwayscallback: function () {
                            $("img.cimg").trigger("click");
                            $id.find("#submit").removeClass("loading");
                        }
                    };
                    if ($id.attr("contentType")) {
                        savepara.contentType = $id.attr("contentType");
                    }
                    if ($id.attr("isalert")) {
                        savepara.isalert = $id.attr("isalert");
                    }
                    zjs.cmd(savepara);//end zjs.cmd
                }//end if cmd 如果有命令
            }//end 验证通过
        }//end save保存函数
    };
};
zjs.cform = zjs.extend(function () { }, zjs.cform);
//判断是否点击的是自己
zjs.isNotMouseClickSelf = function (e, handler) {
    var reltg = e.target || e.srcElement;
    while (reltg && reltg != handler) {
        reltg = reltg.parentNode;//遍历当前点击的所有父元素 有任意一个和目标相等 就说明点的是目标
    }
    return (reltg != handler);
};
//设置下拉框宽度
zjs.cselector_setWidth = function ($ul, $input, $id) {
    if ($ul.find("a").length * 25 > 369)//如果超出高度 显示滚动条
        $ul.css("overflow-y", "scroll");

    if (!$ul.css("box-sizing")) {
        var pl = 0;
        if ($input.css("padding-left")) {
            pl = parseInt($input.css("padding-left").replace("px", ""));
        }
        var pr = 0;
        if ($input.css("padding-right")) {
            pr = parseInt($input.css("padding-right").replace("px", ""));
        }
        $ul.width($input.width() + pl + pr);
    } else {
        $ul.width($input.parent().width() - 2);
    }
};
//设置提示框的单击事件 单击时显示下拉框
zjs.cselector_click = function ($input, $ul, $id) {
    $input.click(function (e) {//单击A时显示UL  
        if ($id.attr("rule")) {//如果需要验证规则 
            $id.trigger("clear");
        }

        zjs.cselector_setWidth($ul, $input, $id);
        if ($id.attr("isinput")) {
            $ul.show();
        } else {
            $ul.toggle();
        }

        //如果超出屏幕了 就倒过来显示
        $ul.css("top", "auto");
        if (($ul.position().top + $ul.height() + 30) > $(document).height()) {
            var ultop = $ul.position().top - $ul.height() - 30;
            if (ultop > 0)
                $ul.css("top", ultop);
        }

        //隐藏其他下拉框
        var $uls = $(".cselectorUL").not($ul[0]).not(".onlyshowUL");
        $uls.hide();

        function isMe(e) {
            if (zjs.isNotMouseClickSelf(e, $ul[0])) {
                $ul.hide();
            } else {
                $(document).one('click', isMe);
            }
        }
        $(document).one('click', isMe);
        e.stopPropagation();
        return false;
    });
};
//当a变更前 触发的事件
zjs.cselector_conbefore = function ($t, $input, $id) {
    if ($id.attr("conbefore")) {
        var re = "";
        if ($id.attr("conbefore").indexOf("()") > -1)
            re = eval($id.attr("conbefore").replace("()", "") + "($t,$input,$id)");
        else if ($id.attr("conbefore").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
            re = eval($id.attr("conbefore"));
        else
            re = eval($id.attr("conbefore") + "($t,$input,$id)");

        return re;
    } else {//如果没有前置条件 就直接返回正常
        return true;
    }
};
//当a变更后 触发的事件
zjs.cselector_conchange = function ($t, $input, $id) {
    if ($id.attr("conchange")) {
        if ($id.attr("conchange").indexOf("()") > -1)
            eval($id.attr("conchange").replace("()", "") + "($t,$input,$id)");
        else if ($id.attr("conchange").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
            eval($id.attr("conchange"));
        else
            eval($id.attr("conchange") + "($t,$input,$id)");
    }
    $id.trigger("gosearch");
};
//设置ul里的a的单击事件 单击时修改input的值
zjs.cselector_ulclick = function ($input, $ul, $id, nothide, isunbind) {
    if (isunbind) {
        $ul.find("a").unbind("click");
    }
    $ul.find("a").click(function (e, data) {//单击项时赋值并关闭UL 
        var oldvalue = $id.val();//原始值
        var $t = $(this);
        if ($t.hasClass("readonly")) {
            return false;
        }

        if (!zjs.cselector_conbefore($t, $input, $id)) {//如果conbefore校验没有通过 就不赋值 直接返回 
            if (!nothide) {//如果不需要隐藏 就不隐藏下拉框 用于单选和复选
                $ul.hide();
            }
            return false;
        }

        if ($input) {
            if ($input[0].nodeName == "A")
                $input.html($(this).html());
            else
                $input.val($(this).text());
        }
        if (data == "ischange") {
            $id.val($(this).attr("value"));
        } else {
            if ($.browser.msie) {
                $id.val($(this).attr("value")).trigger("onpropertychange");
            }
            else {
                $id.val($(this).attr("value")).trigger("oninput");
            }
        }
        if (!nothide) {//如果不需要隐藏 就不隐藏下拉框 用于单选和复选
            $ul.hide();
        } else {
            $(this).addClass("select").siblings().removeClass("select");
        }

        if ($id.attr("showother")) {
            if ($id.val() == "showother") {
                if (data == "oldvalue") {
                    $id.val(oldvalue).show();
                } else {
                    $id.val("").show();
                }
                $id.parent().addClass("showotherbox");
            } else {
                $id.hide();
                $id.parent().removeClass("showotherbox");
            }
        }

        if (data != "ischange") {
            zjs.cselector_conchange($t, $input, $id);
        }
    });
};
//当文本框的值发生变更时执行的事件
zjs.cselector_change = function ($input, $ul, $id, $isinput) {
    $id.unbind("change").bind("change", function (e, data) {//如果被赋值 就同步变更UL
        if ($id.val() == "")//如果没值
            $ul.find("a").first().trigger("click", ""); //默认选第一个
        else {
            if ($id.attr("cmd-change")) {
                zjs.cselector_cmdchange($ul, $id, $isinput, { value: $id.val() }, function () {
                    $ul.find("a[value='" + $id.val() + "']").trigger("click", data || "");
                });
            } else {
                //如果有值 必须这个值在当前的值列表中 就让他点击
                if ($ul.find("a[value='" + $id.val() + "']").length > 0) {
                    $ul.find("a[value='" + $id.val() + "']").trigger("click", data || "");
                } else {
                    if ($id.attr("showother")) {
                        $ul.find("a[value='showother']").trigger("click", "oldvalue");
                    }
                }
            }
        }
    });

    var $form = $id.parents("form");
    var para = zjs.getQueryStr();
    if ((para.id && $form.attr("cmd-select")) || $form.attr("allcmds")) {//如果参数里有id再查询 否则默认不查询
        //这种情况去查询了 可以先不触发 等查询回来会自动触发  
    } else if ($form.attr("donotsearch")) {
        if ($input) {
            if ($input[0].nodeName == "A")
                $input.text("-请选择-");
            else
                $input.val("-请选择-");
        }
    } else {
        $id.trigger("change");
    }
};
zjs.cselector_cmdchange = function ($ul, $id, $isinput, para, callback) {
    $ul.html("<img src='" + zjs.rootdir + "img/loading.gif' class='loading'/>");
    var paras = para;
    paras.pageindex = 1;
    paras.pagesize = 100;
    zjs.cmd({
        cmd: $id.attr("cmd-change"),
        para: paras,
        callback: function (data) {
            var uldata = data.Datas || data.Data || data;//存放数据 
            var html = zjs.render(uldata, $id.attr("template"));
            $ul.html(html);//追加HTML
            zjs.cselector_ulclick($isinput, $ul, $id, false);//单击UL里a时事件
            if (callback) callback.call();
        }
    });
};
/*!
* 通用单列选择器
*/
if (!window.zjs.cselector) {
    zjs.cselector = {
        clazz: "zjs.cselector",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var that = this;
            var $id = this.text;
            $id.hide();
            this.$input = $('<a class="cselectorInput"></a>');
            this.$ul = $('<div class="cselectorUL"></div>');
            this.$RadioUL = $('<div class="cselectorRadioUL"></div>');
            this.$CheckBoxUL = $('<div class="cselectorCheckBoxUL"></div>');
            this.$StarBoxUL = $('<div class="cselectorStarBoxUL"></div>');

            this.cselectorType = "cselector";//普通下拉列表框
            if ($id.hasClass("cselectorRadio")) {
                this.cselectorType = "cselectorRadio";//单选按钮组
            }
            if ($id.hasClass("cselectorCheckBox")) {
                this.cselectorType = "cselectorCheckBox";//复选按钮组
            }
            if ($id.hasClass("cselectorTree")) {
                this.cselectorType = "cselectorTree";//树型选择框
            }
            if ($id.hasClass("cselectorCheckTree")) {
                this.cselectorType = "cselectorCheckTree";//带复选框的树菜单
                this.$ul.addClass("cselectorCheckListUL");
            }
            if ($id.hasClass("cselectorCheckList")) {
                this.cselectorType = "cselectorCheckList";//带复选框的下拉菜单
                this.$ul.addClass("cselectorCheckListUL");
            }
            if ($id.hasClass("cselectorStar")) {
                this.cselectorType = "cselectorStar";//星级选择框
            }

            if ($id.attr("onlyshow")) {//选择项始终显示 下拉项不再隐藏
                this.$ul.addClass("onlyshowUL");
            }
            if ($id.attr("isinput")) {//加input可以进行模糊查询
                this.$isinput = $("<input type='text' />");
                this.$input.append(this.$isinput);
            }
            if ($id.attr("ispanel")) {//选择项以面板样式显示
                this.$ul.addClass("cselectorPanel");
                if ($id.attr("ispanelbtn")) {//选择项以面板样式显示,并加上ABCD的筛选 记得引用cncode.js
                    this.$ul.append(
                        "<div class='panelbtns'><b>全部</b><b>ABCD</b><b>EFG</b><b>HIJK</b><b>LMN</b><b>OPQ</b><b>RST</b><b>UVW</b><b>XYZ</b></div>");
                }
            }
            if ($id.attr("isall")) {//是否有全选全不选 只有在复选类型才有这个
                this.$ul.addClass("cselectorAll").append("<div class='panelallbtns'><b class='checklistall'>全选/全不选</b></div>");
                this.$CheckBoxUL.addClass("cselectorAll").append("<div class='panelallbtns'><b class='checklistall'>全选/全不选</b></div>");
            }

            if ($id.attr("cmd-select") || $id.attr("parentKey")) {//如果有查询或者缓存KEY 
                var uldata = [];
                var part = zjs.getparent();
                if (part[$id.attr("parentKey")]) {//如果有缓存数据 就不用读了 
                    if ($id.attr("searchtype")) {//如果这个选择器在搜索条件中,就默认追加一个全部 为了方便查询全部数据
                        that.$ul.append("<a value=''>全部</a>");
                        that.$RadioUL.append("<a value=''>全部</a>");
                    }
                    uldata = part[$id.attr("parentKey")];//存放数据 
                } else {
                    var cmdpara = {};//以URL里的参数为主
                    if ($id.attr("urlpara")) {
                        cmdpara = zjs.getQueryStr();//以URL里的参数为主
                    }
                    if ($id.attr("paras")) {
                        cmdpara = zjs.getParas($id.attr("paras"));//以URL里的参数为主
                    }
                    cmdpara.pageindex = 1;
                    cmdpara.pagesize = 5000;
                    if ($id.attr("updatewait") && zjs.getQueryStr().id) {
                        //如果是更新等待模式 就不发起命令 这种情况出现在 添加时加载默认列表 修改时 要根据参数获取列表
                    } else {
                        var spara = {//如果没有缓存 就发起命令读数据
                            async: false,
                            cmd: $id.attr("cmd-select"),
                            para: cmdpara,
                            callback: function (data) {
                                if ($id.attr("parentKey")) {//放入缓存
                                    part[$id.attr("parentKey")] = data.Datas || data.datas || data.Data || data;
                                    part[$id.attr("parentKey") + "ServerData"] = data;
                                }
                                if ($id.attr("searchtype")) {//如果是查询条件 就追加个参数
                                    that.$ul.append("<a value=''>全部</a>");
                                    that.$RadioUL.append("<a value=''>全部</a>");
                                }

                                uldata = data.Datas || data.datas || data.Data || data;//存放数据 
                            }
                        };
                        if ($id.attr("contentType")) {
                            spara.contentType = $id.attr("contentType");
                        }
                        zjs.cmd(spara);//end zjs.cmd
                    }
                }
                var html = zjs.render(uldata, $id.attr("template"));//显示项的html模版
                if ($id.attr("prevtemplate"))//如果选择项需要加提示语之类的,比如请选择,全部
                    html = $id.attr("prevtemplate") + html;
                if ($id.attr("showother"))//如果选择项需手动输入,会加其他项,点其他项出文本框
                    html = html + "<a value='showother'>其他</a>";
                switch (that.cselectorType) {
                    case "cselectorRadio"://单选按钮组
                        that.$RadioUL.append(html);//追加HTML
                        $id.after(that.$RadioUL);
                        that._event();
                        break;
                    case "cselectorCheckBox"://复选按钮组
                        if ($id.attr("emptymessage") && html == "") {//如果数据为空显示该项设置的提示
                            that.$CheckBoxUL.append($id.attr("emptymessage"));//追加HTML
                        } else {
                            that.$CheckBoxUL.append(html);//追加HTML
                        }
                        $id.after(that.$CheckBoxUL);
                        that._event();
                        break;
                    case "cselectorCheckTree"://下拉复选树 
                    case "cselectorTree"://下拉树  
                        if ($id.attr("prevtemplate"))//如果选择项需要加提示语之类的,比如请选择,全部
                            that.$ul.append($id.attr("prevtemplate"));

                        if ($id.attr("jsontree")) {//如果数据结构为json数据
                            that.$ul.append(zjs.jsontree(uldata, $id.attr("template"), 1));//追加HTML
                        } else {
                            that.$ul.append(zjs.tree(uldata, $id.attr("pidvalue") || zjs.treeroot,
                                $id.attr("template"),
                                ($id.attr("idkey") || "id"),
                                ($id.attr("pidkey") || "pid")));//追加HTML
                        }
                        $id.after(that.$ul).after(that.$input);
                        zjs.cselector_setWidth(that.$ul, that.$input, $id);//设置宽度  为了让选择a和div宽度姿势一样
                        that._event();
                        break;
                    default://普通下拉列表框 
                        that.$ul.append(html);//追加HTML
                        $id.after(that.$ul).after(that.$input);
                        zjs.cselector_setWidth(that.$ul, that.$input, $id);//设置宽度  
                        that._event();
                        break;
                }//end switch
            } else {//end 普通模式   固定字典模式
                var m = $id.attr("values");//获取配置值  mode值 
                if ($id.attr("mode")) {
                    m = zjs[$id.attr("mode")];

                    var idmode = $id.attr("mode");
                    if (idmode.substr(0, 2) == "ss") {//如果是搜索类的 就自动加个全部
                        var submode = idmode.substr(2);
                        if (zjs[submode]) {//如果子字典存在 就用子字典
                            m = "|全部," + zjs[submode];
                        }
                    }
                    if (idmode.substr(0, 2) == "xx") {//如果是添加类的 就自动加个请选择
                        var submode = idmode.substr(2);
                        if (zjs[submode]) {//如果子字典存在 就用子字典
                            m = "|-请选择-," + zjs[submode];
                        }
                    }
                }
                var html = "";
                if (m) {
                    if ($id.attr("showother")) {
                        m = m + ",showother|其他";
                    }

                    var template = "<a href='javascript:void(0)' value='{{value}}' cdata='{{cdata}}'>{{text}}</a>";
                    if ($id.attr("template")) {
                        template = $id.attr("template");
                    }
                    var models = [];
                    var li = m.split(','); //分割值列表 添加到UL中   0值|1文本|2样式|3数据|4前图片|5后图片
                    for (var i in li) {
                        var model = { value: "", text: "", cdata: "" };
                        var tmp = li[i].split('|');
                        if (tmp.length == 1) {//只有值
                            model.value = tmp[0];
                            model.text = tmp[0];
                        } else if (tmp.length == 2) {//有值|文本
                            model.value = tmp[0];
                            model.text = tmp[1];
                        }
                        if (zjs.cncode && $id.attr("ispanel")) {//如果配置了汉字对应拼音 并且是面板模式 就自动加上拼音
                            model.cdata = zjs.cncode[model.text[0]];//用汉字首字母换一个拼音
                        }
                        if (li[i] != "") {
                            models.push(model);
                        }
                    }
                    html = zjs.render(models, template);
                }
                switch (this.cselectorType) {
                    case "cselectorRadio"://单选按钮组
                        this.$RadioUL.append(html);//追加HTML
                        $id.after(this.$RadioUL);
                        this._event();
                        break;
                    case "cselectorCheckBox"://复选按钮组
                        this.$CheckBoxUL.append(html);//追加HTML
                        $id.after(this.$CheckBoxUL);
                        this._event();
                        break;
                    case "cselectorStar"://星级选择框
                        var starlist = [{ "name": "0" }, { "name": "1" }, { "name": "2" }, { "name": "3" }, { "name": "4" }, { "name": "5" }];
                        this.$StarBoxUL.append(zjs.render(starlist, "<a class='star star{{name}}' value='{{name}}'></a>"));//追加HTML
                        $id.after(this.$StarBoxUL);
                        this._event();
                        break;
                    default://普通下拉列表框 
                        this.$ul.append(html);//追加HTML
                        $id.after(this.$ul).after(this.$input);
                        zjs.cselector_setWidth(this.$ul, this.$input, $id);//设置宽度
                        this._event();
                        break;
                }//end switch 
            }//end if 正常的配置项结束

            if ($id.attr("conbind")) {
                if ($id.attr("conbind").indexOf("()") > -1)
                    eval($id.attr("conbind").replace("()", "") + "($id)");
                else if ($id.attr("conbind").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("conbind"));
                else
                    eval($id.attr("conbind") + "($id)");
            }
        },
        _event: function () {//绑定各种事件
            var that = this;
            var $id = this.text;
            var $input = this.$input;
            var $isinput = this.$isinput;
            var $ul = this.$ul;
            var $RadioUL = this.$RadioUL;
            var $CheckBoxUL = this.$CheckBoxUL;
            var $StarBoxUL = this.$StarBoxUL;
            var checksplit = " ";
            if ($id.attr("checksplit")) {//配置复选间隔符,默认为空格间隔
                checksplit = $id.attr("checksplit");
            }
            switch (this.cselectorType) {
                case "cselectorStar"://星级选择框
                    $StarBoxUL.children("a").click(function () {//单击项时赋值并切换select选中状态 
                        $(this).addClass("hover").siblings(".hover").removeClass("hover");
                    });
                    zjs.cselector_ulclick(0, $StarBoxUL, $id, true);//true 表示 单击后不关闭UL列表
                    zjs.cselector_change(0, $StarBoxUL, $id);
                    break;
                case "cselectorRadio"://单选按钮组
                    $RadioUL.children("a").click(function () {//单击项时赋值并切换select选中状态 
                        $(this).addClass("select").siblings().removeClass("select");
                    });
                    zjs.cselector_ulclick(0, $RadioUL, $id, true);//true 表示 单击后不关闭UL列表
                    zjs.cselector_change(0, $RadioUL, $id);
                    break;
                case "cselectorCheckBox"://复选按钮组 
                    $CheckBoxUL.children("a").click(function () {//单击项时赋值并关闭UL
                        var $t = $(this);
                        var val = $t.attr("value") + checksplit;
                        var ival = $id.val();

                        if (!zjs.cselector_conbefore($t, $input, $id)) {//如果conbefore校验没有通过 就不赋值 直接返回 
                            return false;
                        }

                        if ($t.hasClass("select")) {
                            $id.val(ival.replace(val, ""));
                        } else {
                            $id.val(ival + val);
                        }

                        $t.toggleClass("select");

                        zjs.cselector_conchange($t, $input, $id);
                    });

                    $id.bind("change", function () {//如果被赋值 就同步变更UL
                        var $t = $(this);
                        var ivals = $t.val().split(checksplit);

                        $CheckBoxUL.find("a").removeClass("select");
                        for (var i in ivals) {
                            if (ivals[i] != "")
                                $CheckBoxUL.find("a[value='" + ivals[i] + "']").toggleClass("select");
                        }
                    });

                    $CheckBoxUL.find(".panelallbtns b").click(function () {//全选按钮
                        var $t = $(this);
                        $t.toggleClass("select");
                        if ($t.hasClass("select")) {
                            var ival = "";
                            var itxt = "";
                            $CheckBoxUL.find("a").each(function (i, v) {
                                var $v = $(v);
                                if (!$v.hasClass("readonly")) {
                                    $v.addClass("select");
                                    itxt += $v.text() + " ";
                                    ival += $v.attr("value") + " ";
                                }
                            });
                            $id.val(ival);
                        } else {
                            $CheckBoxUL.find("a").removeClass("select");
                            $id.val("");
                        }
                        zjs.cselector_conchange($t, $input, $id);
                    });
                    if ($id.val() != "") {
                        $id.trigger("change");
                    }
                    break;
                case "cselectorCheckTree"://复选下拉    
                case "cselectorCheckList"://复选下拉       
                    if ($id.attr("onlyshow")) {
                        $ul.show();
                        $input.hide();
                    } else {
                        zjs.cselector_click($input, $ul, $id);  //单击提示框a时事件 显示选择项
                    }
                    $ul.find("a").click(function (e, data) {//单击项时赋值并关闭UL
                        var $t = $(this);
                        if ($t.hasClass("readonly")) {//不让选择此项,只读
                            return false;
                        }
                        if (!zjs.cselector_conbefore($t, $input, $id)) {//如果conbefore校验没有通过 就不赋值 直接返回 
                            return false;
                        }
                        var val = $t.attr("value") + " ";
                        var ival = $id.val();
                        var txt = $t.text() + " ";
                        var itxt = $input.text();

                        if ($t.hasClass("select")) {
                            $id.val(ival.replace(val, ""));
                            $input.text(itxt.replace(txt, "")).attr("title", itxt.replace(txt, ""));
                        } else {
                            $id.val(ival + val);
                            $input.text(itxt + txt).attr("title", itxt + txt);
                        }
                        $t.toggleClass("select");

                        if (data != "ischange") {//选择完之后触发的事件
                            zjs.cselector_conchange($t, $input, $id);
                        }

                        e.stopPropagation();
                    });

                    $id.bind("change", function () {//如果被赋值 就同步变更UL
                        var $t = $(this);
                        var ivals = $t.val().split(' ');
                        var itxt = "";

                        $ul.find("a").removeClass("select");
                        for (var i in ivals) {
                            if (ivals[i] != "") {
                                $ul.find("a[value='" + ivals[i] + "']").toggleClass("select");
                                itxt += $ul.find("a[value='" + ivals[i] + "']").text() + " ";
                            }
                        }
                        $input.text(itxt).attr("title", itxt);
                    });
                    $ul.find(".panelallbtns b").click(function () {
                        $(this).toggleClass("select");
                        if ($(this).hasClass("select")) {
                            var ival = "";
                            var itxt = "";
                            $ul.find("a").each(function (i, v) {
                                var $v = $(v);
                                if (!$v.hasClass("readonly")) {
                                    $v.addClass("select");
                                    itxt += $v.text() + " ";
                                    ival += $v.attr("value") + " ";
                                }
                            });
                            $id.val(ival);
                            $input.text(itxt);
                        } else {
                            $ul.find("a").removeClass("select");
                            $id.val("");
                            $input.text("");
                        }
                        zjs.cselector_conchange($t, $input, $id);
                    });
                    if ($id.val() != "") {
                        $id.trigger("change");
                    }
                    break;
                default://普通下拉列表框
                    zjs.cselector_click($input, $ul, $id);  //单击提示框a时事件 

                    var hideul = false;
                    if ($id.attr("onlyshow")) {//如果是一直显示状态就把div显示,a隐藏
                        hideul = true;
                        $ul.show();
                        $input.hide();
                    }

                    if ($id.attr("isinput")) {
                        zjs.cselector_ulclick($isinput, $ul, $id, hideul);//单击UL里a时事件

                        if ($.browser.msie) {
                            $isinput[0].onpropertychange = function () {
                                that.isinputchange();
                            };
                        }
                        else {
                            $isinput[0].oninput = function () {
                                that.isinputchange();
                            };
                        }
                        $input.addClass("isinputmode").click(function () {
                            $isinput.val("").focus();
                        });
                        $isinput.click(function () {
                            $isinput.val("").focus();
                        }).focus(function () {
                            if ($ul.css("display") == "none") {
                                $ul.show();
                            }
                        }).blur(function () {//当文本框失去焦点时 如果文本框的值 不是列表中的值 就重置文本框
                            clearTimeout(that.isinputblur);
                            that.isinputblur = setTimeout(function () {
                                var isinputval = $isinput.val();
                                var iseq = false;
                                $ul.find("a").each(function (i, v) {
                                    var $v = $(v);
                                    if ($v.text() == isinputval) {//如果在搜索文本中 就显示
                                        iseq = true;
                                    }
                                });
                                if (iseq == false) {
                                    //$id.trigger("change");//还原上次选择的值
                                    $isinput.val($ul.find("a[value='" + $id.val() + "']").text());
                                    $ul.find("a").show();
                                }
                            }, 100);
                        });
                    }
                    else {
                        zjs.cselector_ulclick($input, $ul, $id, hideul);//单击UL里a时事件
                    }
                    $ul.find(".panelbtns b").click(function () {
                        clearTimeout(that.isinputblur);
                        var isinputval = $(this).text().toUpperCase();
                        if (isinputval == "全部") {
                            $ul.find("a").show();
                        } else {
                            $ul.find("a").each(function (i, v) {
                                var $v = $(v);
                                if ($v.attr("cdata")) {//如果在数据里 也显示  abcd
                                    $v.hide();
                                    for (var si in isinputval) {//匹配任何一个 就显示
                                        if ($v.attr("cdata").toUpperCase().indexOf(isinputval[si]) > -1) {
                                            $v.show();
                                        }
                                    }
                                }//end if ($v.attr("cdate")) 
                            });
                        }//end if (isinputval == "") 
                    });
                    zjs.cselector_change($input, $ul, $id, $isinput); //变更事件处理
                    break;
            }
        },
        refreshulclick: function () {//刷新单击a显示div
            var that = this;
            var $id = this.text;
            var $input = this.$input;
            var $ul = this.$ul;

            var hideul = false;
            if ($id.attr("onlyshow")) {
                hideul = true;
            }
            zjs.cselector_ulclick($input, $ul, $id, hideul, true);//单击UL里a时事件
        },
        isinputchangetimer: 0,
        isinputchange: function () {
            var that = this;
            var $id = this.text;
            var $ul = this.$ul;
            var $isinput = this.$isinput;

            if ($id.attr("cmd-change")) {//20170203 当单击a时触发的变更 就不要再查了 
                var isinputval = $isinput.val();
                var iseq = false;
                $ul.find("a").each(function (i, v) {
                    var $v = $(v);
                    if ($v.text() == isinputval) {//如果在搜索文本中 就显示
                        iseq = true;
                    }
                });
                if (iseq == false) {
                    that.ulchange($isinput.val());
                }
            } else {
                that.ulchange($isinput.val());
            }
        },
        ulchange: function (oisinputval) {
            var that = this;
            var $id = this.text;
            var $input = this.$input;
            var $isinput = this.$isinput;
            var $ul = this.$ul;
            var isinputval = oisinputval.toUpperCase();
            if ($id.attr("cmd-change")) {//
                //20160418 新增输入框的即时查询功能 适用于人员列表 输入关键字 查出来相关人 
                $id.val("");//
                if (isinputval == "") {
                } else {
                    zjs.cselector_cmdchange($ul, $id, $isinput, { key: isinputval });
                }
            } else {
                if (isinputval == "") {
                    $ul.find("a").show();
                } else {
                    $ul.find("a").each(function (i, v) {
                        var $v = $(v);
                        if ($v.text().toUpperCase().indexOf(isinputval) > -1) {//如果在搜索文本中 就显示
                            $v.show();
                        } else {
                            $v.hide();
                        }
                        if ($v.attr("cdata")) {//如果在数据里 也显示  abcd
                            if ($v.attr("cdata").toUpperCase().indexOf(isinputval) > -1) {
                                $v.show();
                            }
                        }//end if ($v.attr("cdate")) 
                    });
                }//end if (isinputval == "") 
            }
        },
        refresh: function (istrigger) {//重置
            var $id = this.text;
            $id.next().remove();
            $id.next().remove();
            $id.next().remove();
            this._init();
            if (istrigger) {//如果不触发就不用了

            } else {
                $id.trigger("change");
            }
        }
    };
};
zjs.cselector = zjs.extend(function () { }, zjs.cselector);
/*!
* 图片选择器 
*/
if (!window.zjs.cselectorImageUpload) {
    zjs.cselectorImageUpload = {
        clazz: "zjs.cselectorImageUpload",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
            this._event();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var c = ['<div class="cselectorImageUL"></div>', '', ''];
            this.$ul = $(c[0]);
            var $id = this.text;
            var $ul = this.$ul;
            this.cformid = "cform_" + $id.attr("id") + new Date().getTime();
            var id = this.cformid;
            var href = zjs.fileurl;
            if ($id.attr("href")) {
                href = zjs.rootdir + $id.attr("href");
                if ($id.attr("cleardir")) {
                    href = $id.attr("href");
                }
            }
            if ($id.attr("para")) {//如果有参数 就加到href后面
                href += "?" + $id.attr("para");
            }
            var btnmsg = "选择";
            if ($id.attr("btnmsg")) {
                btnmsg = $id.attr("btnmsg");
            }
            this.$form = $("<form class='customize' id='fomimg_" + id + "' name='fomimg_" + id + "' target='ifrmimg_" + id + "' action='" + href + "' enctype='multipart/form-data' method='POST'></form>");
            this.$file = $("<input type='file' id='fileimg_" + id + "' name='fileimg_" + id + "'/>");
            if (typeof FormData == "function" && $id.attr("mulaccept")) {//FormData是HTML5新增的函数 如果支持这个函数 就使用HTML5上传方式 
                this.$file = $("<input type='file' id='fileimg_" + id + "' name='fileimg_" + id + "'  multiple='multiple' accept='" + $id.attr("mulaccept") + "'/>");
            }
            this.$submit = $("<input id='fomsubmit_" + id + "' type='submit' style='display:none;'/>");
            this.$upload = $("<a class='btn'>" + btnmsg + "</a>");
            this.$ifrm = $("<iframe id='ifrmimg_" + id + "' name='ifrmimg_" + id + "' style='display:none;'></iframe>");
            this.$divu = $("<div id='uploadImg_" + id + "' class='uploadImage'></div>");

            $ul.append(this.$divu).append(this.$form.append(this.$upload).append(this.$file).append(this.$submit)).append(this.$ifrm);
            $id.after(this.$ul);

            if ($id.attr("bindcallback")) {
                if ($id.attr("bindcallback").indexOf("()") > -1)
                    eval($id.attr("bindcallback").replace("()", "") + "($id)");
                else if ($id.attr("bindcallback").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                    eval($id.attr("bindcallback"));
                else
                    eval($id.attr("bindcallback") + "($id)");
            }
        },
        _event: function () {
            var $id = this.text;
            var id = this.cformid;
            var $ul = this.$ul;
            var $form = this.$form;
            var $file = this.$file;
            var $ifrm = this.$ifrm;
            var $divu = this.$divu;
            var $submit = this.$submit;
            var that = this;
            var timer;
            var loding = false;
            var isuploading = false;

            function filechange() {
                if (loding)
                    return;
                loding = true;
                if ($file.val() == "") {
                    loding = false;
                    return;
                }
                if ($id.attr("beforesubmit")) {
                    if ($id.attr("beforesubmit").indexOf("()") > -1)
                        eval($id.attr("beforesubmit").replace("()", "") + "($id,$form)");
                    else if ($id.attr("beforesubmit").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        eval($id.attr("beforesubmit"));
                    else
                        eval($id.attr("beforesubmit") + "($id,$form)");
                }

                //验证通过后 发送请求 
                if ($id.attr("beforevalidator")) {
                    var re = true;
                    if ($id.attr("beforevalidator").indexOf("()") > -1)
                        re = eval($id.attr("beforevalidator").replace("()", "") + "($id,$form,$file)");
                    else if ($id.attr("beforevalidator").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                        re = eval($id.attr("beforevalidator"));
                    else
                        re = eval($id.attr("beforevalidator") + "($id,$form,$file)");
                    if (!re) {
                        loding = false;
                        return re;
                    }
                }

                var fileName = $file.val();
                if ($id.attr("noextension")) {//如果配置的有不校验
                } else {
                    var message = "格式不正确,只支持 压缩包 图片 文档 视频 等";
                    var extensionArray = ["rar", "jpg", "png", "bmp", "jpeg", "gif", "js", "css", "pdf",
                         "doc", "docx", "xls", "xlsx", "ppt", "pptx", "apk",
                           "mp4", "rm", "rmvb", "flv", "csv", "mp3"];
                    if ($id.attr("extension")) {//如果有自定义文件类型 设置即可
                        extensionArray = $id.attr("extension").split(",");
                        message = "格式不正确,只支持 " + $id.attr("extension") + " 文件";
                    }
                    var fileExtensionArray = fileName.split('.'),
                    fileExtension = fileExtensionArray[fileExtensionArray.length - 1].toLowerCase();
                    if ($.inArray(fileExtension, extensionArray) == -1 && fileName != "") {
                        alert(message);
                        loding = false;
                        return;
                    }
                    try {
                        if ($id.attr("sizelength")) {//如果有要求大小检验
                            if ($file[0].files[0].size > $id.attr("sizelength")) {
                                alert($id.attr("sizemsg"));
                                loding = false;
                                return;
                            }
                        }
                    } catch (ex) { }

                }
                isuploading = true;
                window.imageupload = null;
                if (typeof FormData == "function") {//FormData是HTML5新增的函数 如果支持这个函数 就使用HTML5上传方式 
                    var fd = new FormData();
                    for (var fi = 0; fi < $file[0].files.length; fi++) {
                        fd.append("fileToUpload", $file[0].files[fi]);//设置要上传的文件
                    }
                    var xhr = new XMLHttpRequest();//声明一下上传控制器
                    xhr.upload.addEventListener("progress", function (evt) {//加一个进度条变更事件
                        if (evt.lengthComputable) {
                            var idx = Math.round(evt.loaded * 100 / evt.total).toString() + '%';
                            if ($id.attr("lock")) {//计算上传进度
                                zjs.lhgtips("请稍候,已上传 " + idx + "...", 100, "loading.gif", true);
                            } else {
                                $divu.html("请稍候,已上传 " + idx + "...");
                            }
                        }
                    }, false);
                    xhr.addEventListener("load", function (evt) {//上传完成后的事件
                        try {
                            var jsstr = $(evt.target.responseText).html();
                            jsstr = jsstr.replace(new RegExp("parent", 'g'), "window");
                            eval(jsstr);
                        } catch (ex) {
                            $file.val("");
                            if ($id.attr("lock")) {
                                zjs.lhgtips("上传失败", 1.5, "error.gif", true);
                            } else {
                                $divu.html("上传失败");
                            }
                        }
                        //$ifrm.html(evt.target.responseText);
                        $ifrm.trigger("load");
                    }, false);
                    xhr.addEventListener("error", function (evt) {
                        alert("上传失败");
                    }, false);
                    xhr.open("POST", $form.attr("action").toString());
                    xhr.send(fd);
                } else {//如果不支持HTML5 就还用老的方式
                    var idx = 0;
                    timer = setInterval(function () {
                        idx += (100 - idx) * .01;
                        if ($id.attr("lock")) {
                            zjs.lhgtips("请稍候,已上传 " + idx.toFixed(2) + "%...", 100, "loading.gif", true);
                        } else {
                            $divu.html("请稍候,已上传 " + idx.toFixed(2) + "%...");
                        }
                    }, 500);
                    $submit.trigger("click");
                }
                $("#submit").addClass("loading");
            };
            function fileclear() {
                var $newfile = $file.clone();
                $file.after($newfile);
                $file.remove();
                $file = $newfile;
                $file.bind("change", filechange);
            };
            $file.bind("change", filechange);

            $ifrm.bind("load", function () {
                loding = false;
                fileclear();

                clearInterval(timer);
                if (isuploading) {//如果是主动上传 而不是默认加载模式下 才考虑提示问题
                    if (window.imageMessage) {//如果有系统级错误 就提示
                        zjs.lhgtips(window.imageMessage, 2.5);
                        window.imageMessage = null;
                        $divu.html("");
                    } else {//没有的情况下考虑几种
                        if ($id.attr("lock")) {
                            if (window.imageupload) {//lock情况下 如果有文件就提示成功 没有就提示失败
                                zjs.lhgtips("上传完成", 1.0, "success.gif", true);
                            } else {
                                zjs.lhgtips("上传失败", 1.5, "error.gif", true);
                            }
                        } else {
                            if (!window.imageupload) {//不是lock情况下 如果没有文件就提示失败
                                $divu.html("上传失败");
                            }
                        }
                    }
                }

                if (window.imageupload) {//如果上传完成后 路径就会放在window.imageupload中
                    $id.val(window.imageupload);
                    $id.trigger("change");
                    if ($id.attr("callback")) {
                        if ($id.attr("callback").indexOf("(") > -1)
                            eval($id.attr("callback"));
                        else
                            eval($id.attr("callback") + "()");
                    }
                    window.imageupload = null;
                }

                if (window.imageOtherInfo) {
                    if ($id.attr("OtherInfo")) {
                        if ($id.attr("OtherInfo").indexOf("()") > -1)
                            eval($id.attr("OtherInfo").replace("()", "") + "(window.imageOtherInfo,$id)");
                        else if ($id.attr("OtherInfo").indexOf("(") > -1)//如果没有（）但是有（就说明有自己的函数加自己的参数 就直接执行
                            eval($id.attr("OtherInfo"));
                        else
                            eval($id.attr("OtherInfo") + "(window.imageOtherInfo,$id)");
                    }
                    window.imageOtherInfo = null;
                }
                $("#submit").removeClass("loading");
            });

            $id.hide();

            $id.bind("change", function () {//如果被赋值 就同步变更UL
                var ival = $(this).val();
                if (ival) {
                    if ($id.attr("file"))
                        $divu.empty().append("<a target='_blank' href='" + ival + "'>" + ($id.attr("filemsg") || "查看") + "</a>");
                    else
                        $divu.empty().append("<a class='meitucrop'><img id='img_" + id + "' src='" + ival + "' alt='' /></a>");

                    if (true) {
                        var $del = $("<a class='uploadImage_del icon-remove'></a>");
                        $del.click(function () {
                            fileclear();
                            $id.val("");
                            $id.trigger("change");
                        });
                        $divu.append($del);

                    }
                } else {
                    $divu.empty();
                }
            });
            if ($id.val() != "") {
                $id.trigger("change");
            }
        }
    };
};
zjs.cselectorImageUpload = zjs.extend(function () { }, zjs.cselectorImageUpload);

/*! 幻灯片 */
if (!window.zjs.cfocus) {
    zjs.cfocus = {
        clazz: "zjs.cfocus",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        init: function () {
            this._init();
        },
        _init: function (config) {
            var that = this;
            var i = 0;
            var $id = that.$id;
            var $box = $id.find(".box");    //主容器
            var $page = $id.find(".page");  //页码
            var $items = $id.find(".item");//列表
            var $prev = $id.find(".prev");//上一个
            var $next = $id.find(".next");//下一个
            var maxshow = $id.attr("maxshow") || 0;//最大同时显示数

            if (!$id.attr("fixed")) {//fixed表示固定高度
                $(window).resize(function () {
                    if ($id.attr("full")) {//fixed表示固定高度
                        $id.width($(window).width());//设置高度
                    }

                    if ($id.attr("half")) {
                        $id.height($id.width() / 2);//设置高度
                    } else if ($id.attr("video")) {
                        $id.height($id.width() / 1.77);//设置高度
                    } else {
                        $id.height($id.width());//设置高度
                    }
                });
                $(window).trigger("resize");
                setTimeout(function () {//500毫秒后 重置一下 防止加载不完
                    $(window).trigger("resize");
                }, 300);
            }

            $page.empty();          //清空页码
            clearInterval(that.timer);

            if ($id.attr("thumbnail")) {//启用缩略图模式
                $page.addClass("thumbnail");
                $items.each(function (i, v) {
                    $page.append("<a><img class='thumbnail' src='" + $(v).find("img").first().attr("src") + "' /></a>");//追加页码
                });
            } else {
                $page.removeClass("thumbnail");
                $items.each(function (i, v) {
                    $page.append("<a><i class='iconfont'>" + ($id.attr("iconfont") || "&#xe656;") + "</i></a>");//追加页码
                });
            }
            var $pageItems = $page.find("a");
            if ($items.length > 1) {
                //转到对应项
                function goItem(isback, isfirst) {
                    if ($id.attr("fadein")) {//如果是淡入淡出
                        $items.eq(i).fadeIn("slow").siblings().hide();//显示对应项
                    } else if ($id.attr("showin")) {//如果是淡入淡出
                        $items.eq(i).show().css({ "opacity": "0.5" }).animate({ "opacity": "1" }, 300, "ease-in-out").siblings().hide();//显示对应项
                    } else {
                        if (isfirst) {
                            //如果是第一次执行 就不转场 直接显示第一个 
                            $items.eq(i).removeClass("inanimation backanimation").show().siblings().hide().removeClass("inanimation backanimation");//显示对应项
                        } else {
                            var clazz = isback ? "backanimation" : "inanimation";
                            $items.eq(i).removeClass("inanimation backanimation").show().addClass(clazz).siblings().hide().removeClass("inanimation backanimation");//显示对应项
                        }
                    }
                    $pageItems.removeClass("hover");//显示对应页码
                    $pageItems.eq(i).addClass("hover");//显示对应页码

                    if (maxshow) {//如果有最大显示数 就把其他的隐藏
                        if (i > maxshow) {//如果到最大显示数以外了 比如最大显示3 现在到4了 那么4-3之前的隐藏 5-3之前的隐藏
                            var other = i - parseInt(maxshow);
                            $pageItems.show();
                            $id.find(".page a:lt(" + other + ")").hide();
                        } else {
                            $pageItems.show();
                        }
                        if ($pageItems.eq(i).css("display") == "none") {
                            $pageItems.eq(i).show();
                        }
                    }
                };
                function goPrev() {
                    i--;//i++
                    if (i < 0) {
                        i = $items.length - 1;
                    }//如果i到达最后一个 就重置
                    goItem(true);//显示对应项
                };
                function goNext() {
                    i++;//i++
                    if (i >= $items.length) {
                        i = 0;
                    }//如果i到达最后一个 就重置
                    goItem();//显示对应项
                };
                function inter() {
                    clearInterval(that.timer);
                    that.timer = setInterval(function () {//定时器
                        //if ($id.parents(".ismoveing").length == 0)//如果父元素没有在移动 就动 否则不动
                        goNext();
                    }, 3000);
                };

                $pageItems.click(function () {
                    i = $(this).index();
                    goItem();//显示对应项
                    inter(); //重置定时器
                });
                $prev.bind("click", function (e) {//前一个
                    goPrev();
                    inter(); //重置定时器
                    e.stopPropagation();
                });
                $next.bind("click", function (e) {//后一个
                    goNext();
                    inter(); //重置定时器
                    e.stopPropagation();
                });
                $items.bind("swipeLeft", function (e) {//往左拖 就向前
                    goNext();
                    inter(); //重置定时器
                    e.stopPropagation();
                });
                $items.bind("swipeRight", function (e) {//往右拖 就向后
                    goPrev();
                    inter(); //重置定时器
                    e.stopPropagation();
                });
                $id.mousemove(function () {
                    clearInterval(that.timer);
                });
                $id.mouseout(function () {
                    inter(); //重置定时器 
                });

                goItem(false, true);//加载完先显示第一项
                inter();//加载定时器
            }//end if length>1
        }//end init
    };
};
zjs.cfocus = zjs.extend(function () { }, zjs.cfocus);

/*! 下拉式城市选择器 */
if (!window.zjs.cselectorDownCity) {
    zjs.cselectorDownCity = {
        clazz: "zjs.cselectorDownCity",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var $id = this.$id;
            var $probox = $('<div class="cselectorcitybox"></div>');//省容器
            var $proinput = $('<a class="cselectorInput">请选择省份</a>');//省按钮
            var $proul = $('<div class="cselectorUL"></div>');//省容器

            var $citybox = $('<div class="cselectorcitybox"></div>');//市容器
            var $cityinput = $('<a class="cselectorInput">请选择城市</a>');//市按钮
            var $cityul = $('<div class="cselectorUL"></div>');//市容器

            var $areabox = $('<div class="cselectorcitybox"></div>');//区容器
            var $areainput = $('<a class="cselectorInput">请选择县区</a>');//区按钮
            var $areaul = $('<div class="cselectorUL"></div>');//区容器

            $id.hide();//隐藏本尊
            $id.after($areabox.append($areainput).append($areaul))
                .after($citybox.append($cityinput).append($cityul))
                .after($probox.append($proinput).append($proul));

            //$citybox.hide();//默认隐藏市 等选择以后再显示
            $areabox.hide();//默认隐藏区

            var nodes = zjs["citys"];
            var tmp = [];
            for (var i in nodes) {//默认渲染省份
                var ni = nodes[i];
                tmp.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
            }
            $proul.html(tmp.join(''));//省份值放进去

            $proinput.click(function () {//省按钮点击时 显示容器
                $proul.show();
                $cityul.hide();
                $areaul.hide();
            });
            $cityinput.click(function () {//市按钮点击时 显示容器
                $proul.hide();
                $cityul.show();
                $areaul.hide();
            });
            $areainput.click(function () {//区按钮点击时 显示容器
                $proul.hide();
                $cityul.hide();
                $areaul.show();
            });
            $proul.children("a").click(function () {//省内容点击时 要渲染市
                var $t1 = $(this);
                var nodes1 = zjs.citys[$t1.attr("value")].c;
                var tmp1 = [];
                for (var i in nodes1) {//渲染市
                    var ni = nodes1[i];
                    tmp1.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
                }
                $cityul.html(tmp1.join(''));//市值放进去
                $cityul.children("a").click(function () {//市内容点击时 要渲染区 
                    var $t2 = $(this);
                    var nodes2 = zjs.citys[$t1.attr("value")].c[$t2.attr("value")].c;
                    if (nodes2) {
                        var tmp2 = [];
                        for (var i in nodes2) {//渲染区
                            var ni = nodes2[i];
                            tmp2.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
                        }
                        $areaul.html(tmp2.join(''));//区值放进去
                        $areaul.children("a").click(function () {//区内容点击时
                            var $t3 = $(this);
                            $areaul.hide();//隐藏省
                            $id.val($t3.attr("value"));//把区值放进去
                            $areainput.text($t3.text());//把区文本放进去
                        });
                        $areabox.show();//显示区
                        $areaul.show();//显示区下拉
                        $areainput.text("请选择县区");//把市文本放进去
                    }
                    $cityul.hide();//隐藏省
                    $id.val($t2.attr("value"));//把市值放进去
                    $cityinput.text($t2.text());//把市文本放进去
                });
                $citybox.show();//显示市
                $cityul.show();//显示市下拉
                $cityinput.text("请选择城市");//把市文本放进去
                $proul.hide();//隐藏省
                $areabox.hide();//隐藏区
                $id.val($t1.attr("value"));//把省值放进去
                $proinput.text($t1.text());//把省文本放进去
            });

            $id.bind("change", function () {//如果被赋值 就同步变更UL
                var citydeep = zjs.getcitydeep($id.val());
                if (citydeep.pro) {//如果有省 就设置省的文本
                    $proul.children("a[value='" + citydeep.pro + "']").trigger("click");
                }
                if (citydeep.city) {//如果有省 就设置省的文本
                    $cityul.children("a[value='" + citydeep.city + "']").trigger("click");
                }
                if (citydeep.area) {//如果有省 就设置省的文本
                    $areaul.children("a[value='" + citydeep.area + "']").trigger("click");
                }
                $proul.hide();
                $cityul.hide();
                $areaul.hide();
            });
        }
    };
};
zjs.cselectorDownCity = zjs.extend(function () { }, zjs.cselectorDownCity);

/*! IOS式城市选择器 */
if (!window.zjs.cselectorIOSCity) {
    zjs.cselectorIOSCity = {
        clazz: "zjs.cselectorIOSCity",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var $id = this.$id;
            var $input = $('<a class="cselectorInput">请选择城市</a>');//按钮
            var $box = $('<div class="cselectorioscitybox"></div>');//总容器
            var $ok = $('<a class="btn">确定</a>');//总容器
            var $probox = $('<div class="cselectorioscity"></div>');//省容器
            var $citybox = $('<div class="cselectorioscity"></div>');//市容器
            var $areabox = $('<div class="cselectorioscity"></div>');//区容器

            $id.hide();//隐藏本尊
            $box.hide();//隐藏容器
            $id.after($box.append($probox).append($citybox).append($areabox).append($ok)).after($input);

            $input.click(function () {//按钮点击时 显示容器
                $box.show();
            });
            $ok.click(function () {//按钮点击时 显示容器
                $box.hide();
            });
            var nodes = zjs["citys"];
            var tmp = [];
            for (var i in nodes) {//默认渲染省份
                var ni = nodes[i];
                tmp.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
            }
            $probox.html(tmp.join(''));//省份值放进去

            $probox.children("a").click(function () {//省内容点击时 要渲染市
                var $t1 = $(this);
                $t1.addClass("select").siblings().removeClass("select");
                var nodes1 = zjs.citys[$t1.attr("value")].c;
                var tmp1 = [];
                for (var i in nodes1) {//渲染市
                    var ni = nodes1[i];
                    tmp1.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
                }
                $citybox.html(tmp1.join(''));//市值放进去
                $citybox.children("a").click(function () {//市内容点击时 要渲染区 
                    var $t2 = $(this);
                    $t2.addClass("select").siblings().removeClass("select");
                    var nodes2 = zjs.citys[$t1.attr("value")].c[$t2.attr("value")].c;
                    if (nodes2) {
                        var tmp2 = [];
                        for (var i in nodes2) {//渲染区
                            var ni = nodes2[i];
                            tmp2.push("<a value='" + i + "' title='" + ni.n + "'>" + ni.n + "</a>");
                        }
                        $areabox.html(tmp2.join(''));//区值放进去
                        $areabox.children("a").click(function () {//区内容点击时
                            var $t3 = $(this);
                            $t3.addClass("select").siblings().removeClass("select");
                            $id.val($t3.attr("value"));//把区值放进去
                            $input.text($t1.text() + " " + $t2.text() + " " + $t3.text());//把省文本放进去
                        });
                    }
                    $id.val($t2.attr("value"));//把市值放进去
                    $input.text($t1.text() + " " + $t2.text());//把省文本放进去
                });
                $id.val($t1.attr("value"));//把省值放进去
                $input.text($t1.text());//把省文本放进去
            });

            $id.bind("change", function () {//如果被赋值 就同步变更UL
                var citydeep = zjs.getcitydeep($id.val());
                if (citydeep.pro) {//如果有省 就设置省的文本
                    $probox.children("a[value='" + citydeep.pro + "']").trigger("click");
                }
                if (citydeep.city) {//如果有省 就设置省的文本
                    $citybox.children("a[value='" + citydeep.city + "']").trigger("click");
                }
                if (citydeep.area) {//如果有省 就设置省的文本
                    $areabox.children("a[value='" + citydeep.area + "']").trigger("click");
                }
            });
        }
    };
};
zjs.cselectorIOSCity = zjs.extend(function () { }, zjs.cselectorIOSCity);

/*! 拖拽 */
if (!window.zjs.cdrag) {
    zjs.cdrag = {
        clazz: "zjs.cdrag",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var $id = this.id;
            $id.mousedown(function (e) {
                var p = $id.parent().offset();
                var id = $id.parent()[0];
                var l = e.clientX - p.left;
                var p = e.clientY - p.top;
                $(document).mousemove(function (ev) {
                    var left = ev.clientX;
                    var top = ev.clientY;
                    if (left - l > 0)
                        id.style.left = left - l + "px";
                    if (top - p > 0)
                        id.style.top = top - p + "px";
                });
                $(document).bind("selectstart", function () { return false; });
                $("body").css("-moz-user-select", "none");
            });
            $(document).mouseup(function () {
                $(document).unbind("mousemove");
                $(document).unbind("selectstart");
                $("body").css("-moz-user-select", "");
            });
        }
    };
};
zjs.cdrag = zjs.extend(function () { }, zjs.cdrag);

/* 职位选择器、行业选择器、城市选择器的基础选择器  */
if (!window.zjs.cselectorJob) {
    zjs.cselectorJob = {
        clazz: "zjs.cselectorJob",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
            this._hover();
            this._event();
            this._click();
            this._value();
            this._hot();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var c = ['职位类别', '行业类别', '城市', '<a class="cselectorInput cselectorJob"></a>', '<div class="cselectorDiv"></div>', //0-4
                     '<div class="overlay"></div>', '<div class="cselectorTitle"></div>', "<div class='cselectorBody'></div>", '<div class="cselected"></div>', //5-8
                     '<a class="cselectorOK btn">确定</a>', '<a class="cselectorClose btn">取消</a>', '<div class="cselectorHot"></div>', '推荐职位', '热门行业', '主要城市', //9-14
                     '职位', '行业', '城市', '<div class="cselectorInfo"></div>', '<a class="cselectorClear btn">不限</a>']; //15-19
            var type = this.type || 0;
            var tt = "请选择" + c[this.type || 0];           //0 1 2
            var yt = "已选" + c[this.type + 15 || 15] + "：";       //15 16 17
            var ht = c[this.type + 12 || 12] + "：";                //12 13 14
            var flength = this.flength || 5;                    //字数
            var $id = this.text;                //赋值文本框
            if ($id.val() == "")
                $id.val(0);
            this.checked = 0;
            this.chknum = 5;                    //复选数
            var level = this.level || $id.attr("level") || 3;
            if ($id.attr("level"))
                level = $id.attr("level");
            if ($id.attr("msg"))
                tt = $id.attr("msg");           //提示语
            if ($id.attr("checknum"))
                this.chknum = $id.attr("checknum");           //提示语
            this.$input = $(c[3]).append(tt);   //显示文本文本框
            this.$ul = $(c[4]);                 //列表值框 生成的文本框
            this.$over = $(c[5]);               //蒙层
            this.$title = $(c[6]);              //标题头
            this.$body = $(c[7]);               //值框
            this.$seled = $(c[8]);              //已选项
            this.$ok = $(c[9]);                 //确定按钮
            this.$clear = $(c[19]);             //不限按钮
            this.$close = $(c[10]);             //取消按钮
            this.$hot = $(c[11]);               //推荐内容
            this.$info = $(c[18]);              //超出提示
            this.idval = '';                    //选定值列表
            this.tt = tt;
            var mode = this.mode || $id.attr("mode") || 'jobs'; //选择器类型 默认为职位选择器
            if (mode) {
                var m = zjs[mode]; //取出数据
                if (m) {
                    var dwidth = $(document).width();
                    var dheight = $(document).height();
                    var $ul = this.$ul;
                    var $over = this.$over.width(dwidth).height(dheight); //设置蒙层宽高
                    $ul.append(this.$title.append(this.$close).append(this.$clear).append(this.$ok).append(tt)); //追加标题头
                    if ($id.attr("check") == "true") {
                        this.$body.addClass("cselectorCheck");  //如果是复选 增加复选样式 添加已选提示
                        $ul.append(this.$seled.append(yt));
                    }
                    this.$hot.append(ht);
                    $ul.append(this.$hot); //推荐栏目
                    $ul.append(this.$info.append("（最多可以选择 " + this.chknum + " 项）"));
                    if ($id.attr("check") != "true") {
                        this.$info.hide();
                    }
                    var nodes = m;
                    var $div = this.$body;
                    var tmp = [];
                    tmp.push("<ul>");
                    for (var i in nodes) {//遍历所有选项
                        var ni = nodes[i];
                        tmp.push("<li value='" + i + "' txt='" + ni.n + "'>");
                        if (level == 1) {//显示级别1级时 只处理一级
                            tmp.push("" + ni.n + "</li>");
                            continue;
                        }
                        if (ni.c != null)//如果有下级添加UL
                            tmp.push("<ul>");
                        for (var j in ni.c) {
                            var nj = nodes[i].c[j];
                            var njn = nj.n[0];
                            if (njn.length > flength)//如果超长截取
                                njn = njn.substring(0, flength);
                            tmp.push("<li value='" + j + "' txt='" + njn + "'>" + njn + "");
                            if (level == 2) {//显示级别2级时 只处理二级
                                tmp.push("</li>");
                                continue;
                            }
                            if (nj.c != null)
                                tmp.push("<ul>");
                            for (var k in nj.c) {
                                var nk = nodes[i].c[j].c[k];
                                var nkn = nk.n[0];
                                if (nkn.length > flength)//如果超长截取
                                    nkn = nkn.substring(0, flength);
                                tmp.push("<li value='" + k + "' txt='" + nkn + "'>" + nkn + "</li>");
                            }
                            if (nj.c != null)
                                tmp.push("</ul>");
                            tmp.push("</li>");
                        }
                        if (ni.c != null)
                            tmp.push("</ul>");
                        tmp.push("" + ni.n + "</li>");
                    }
                    tmp.push("</ul>");
                    $div.append(tmp.join(''));
                    $ul.append($div).append("<iframe style='width:0px;height:0px;display:none'></iframe>");
                    $id.after(this.$input);
                    $("body").prepend(this.$ul).prepend($over.append("<iframe style='width:0px;height:0px;display:none'></iframe>"));
                    var left = (dwidth - 800) / 2; //设置对话框居中
                    if (left < 0)
                        left = 0;
                    if ($id.attr("top"))
                        $ul.css({ "left": left, "top": $id.attr("top") });
                    else
                        $ul.css({ "left": left, "top": this.$input.position().top });
                    if ($id.attr("drag") != "false") {//设置可拖拽
                        new zjs.cdrag({ id: this.$title });
                    }
                    switch (type) {//子项是否显示/隐藏切换 一般行业不需要切换
                        case 1:
                            $ul.addClass("cselectorIndustryBody");
                            break;
                        case 0:
                            $ul.addClass("cselectorIndustryBody").addClass("cselectorJobsBody");
                            break;
                        case 2:
                            break;
                    }
                }
            }
        },
        _event: function () {//绑定事件
            var $id = this.text;
            var $input = this.$input;
            var $ul = this.$ul;
            var $ok = this.$ok;
            var $clear = this.$clear;
            var $close = this.$close;
            var $over = this.$over;
            var that = this;
            $id.hide();
            $input.css("padding", "0 8px 0 10px");
            $input.click(function () {
                //$(document).scrollTop($input.offset().top);//定位到文本框位置
                $ul.css({ "left": $input.position().left, "top": $input.position().top }).show();
                $over.show();
            });
            $ok.click(function () {
                that._ok();
            });
            $close.click(function () {
                that._close();
            });
            $clear.click(function () {
                that._clear();
            });
        },
        unbind: function () {
            this.$input.unbind("click");
        },
        _hover: function () {//显示/隐藏切换
            var that = this;
            var type = this.type;
            var $id = this.text;
            var $body = this.$body;
            if (type == 0) {//显示/隐藏切换 职位类切换显示 一级不切换 从二级开始
                $body.children("ul").children("li").find("li").mouseenter(function () {
                    that._bindul(this);
                    $(this).children("ul").show();
                });
                $body.children("ul").children("li").find("li").mouseleave(function () {
                    $(this).children("ul").hide();
                });
            }
            else if (type == 2) {
                $body.find("li").mouseenter(function () {
                    that._bindul(this);
                    $(this).children("ul").show();
                });
                $body.find("li").mouseleave(function () {
                    $(this).children("ul").hide();
                });
            }
        },
        _bindul: function (e) {
            var $li = $(e);
            var level = $(this.text).attr("hoverlevel") || 5;
            if ($li.children("ul").length == 0) {
                var lileve = 1;
                if ($li.parent().parent().parent().parent(".cselectorBody").length == 1) {
                    lileve = 2;
                }
                if ($li.parent().parent().parent().parent().parent().parent(".cselectorBody").length == 1) {
                    lileve = 3;
                }

                if (lileve > level)
                    return;
                var nownode = null;
                var $id = this.text;                //赋值文本框
                var flength = this.flength || 5;                    //字数
                var mode = this.mode || $id.attr("mode") || 'jobs'; //选择器类型 默认为职位选择器
                var m = zjs[mode]; //取出数据
                if ($li.parent().parent(".cselectorBody").length == 1) {
                    nownode = m[$li.attr("value")];
                }
                else if ($li.parent().parent().parent().parent(".cselectorBody").length == 1) {
                    nownode = m[$li.parent().parent("li").attr("value")].c[$li.attr("value")];
                }
                if (nownode) {
                    var tmp = [];
                    for (var k in nownode.c) {
                        var nkn = nownode.c[k].n[0];
                        if (nkn.length > flength)//如果超长截取
                            nkn = nkn.substring(0, flength);
                        tmp.push("<li value='" + k + "' txt='" + nkn + "'>" + nkn + "</li>");
                    }
                    if (tmp.length > 0) {
                        $li.append("<ul>" + tmp.join('') + "</ul>");
                        if ($id.attr("check") == "true") {
                            this._checklihover($li.find("li"));
                        } else {
                            this._radiolihover($li.find("li"));
                        }
                        this._liclick($li.find("li"));
                    }
                }
            }
        },
        _radiolihover: function (e) {
            var that = this;
            var $body = $(e);
            $body.mouseenter(function () {
                that._bindul(this);
                $(this).children("ul").show();
            });
            $body.mouseleave(function () {
                $(this).children("ul").hide();
            });
        },
        _checklihover: function (e) {
            var that = this;
            var $body = $(e);
            $body.mouseenter(function () {
                that._bindul(this);
                $(this).children("ul").show();
            });
            $body.mouseleave(function () {
                $(this).children("ul").hide();
            });
        },
        _hot: function () {//推荐职位 热门城市 热门行业等
            var $id = this.text;                //赋值文本框
            var $ul = this.$ul;
            var $hot = this.$hot;
            var $seled = this.$seled;
            var mode = this.mode || $id.attr("mode") || 'jobs';
            var modehot = mode + "hot";
            var that = this;
            if (zjs[modehot]) {
                var mh = zjs[modehot];
                for (var i in mh) {
                    $hot.append("<a val='" + i + "'>" + mh[i].n + "</a>");
                }
                $hot.children("a").click(function () {
                    if ($id.attr("check") == "true") {//复选时
                        $ul.find("li[value='" + $(this).attr("val") + "']").trigger("click");
                    }
                    else {//单选时
                        $seled.text($(this).text());
                        that.idval = $(this).attr("val");
                        that._ok(); //只要当前值 即调用OK事件 
                    }
                });
            }
            else {
                $hot.hide();
            }
        },
        _liclick: function (li) {//选项单击事件
            var $id = this.text;
            var $body = this.$body;
            var $seled = this.$seled;
            var $input = this.$input;
            var that = this;
            var chknum = this.chknum;
            var $info = this.$info;
            $(li).click(function (e) {
                if (!li)
                    return true;
                //$info.hide();
                var val = $(this).attr("value") + ",";
                if ($id.attr("check") == "true") {//复选时
                    if ($(this).find(".select").length > 0) {//如果选的是父级 而子级有已选过的 就清除子级选过的 换成父级全选 如选了金水区 再选郑州市 就全选郑州市 剔除金水区单独选择
                        $(this).find(".select").each(function () {//这一行this表示当前点击的LI
                            $(this).toggleClass("select"); //这里this表示子项中select的LI
                            $seled.children("a[val='" + $(this).attr("value") + "']").remove();
                            that.idval = that.idval.replace($(this).attr("value") + ",", '');
                            that.checked--;
                        });
                    }
                    if ($(this).parents(".select").length == 0) {//如果选的是子级 而父级未选中就继续
                        if (that.checked < chknum) {//如果还达到最大选择数 就可以正常操作
                            $(this).toggleClass("select");
                            var txt = "<a val='" + $(this).attr("value") + "'>" + $(this).attr("txt") + "</a>"; //提示已选 
                            var $txt = $(txt);
                            if ($seled.children("a[val='" + $(this).attr("value") + "']").length == 0) {//如果没选过就选中
                                $seled.append($txt);
                                that.idval = that.idval + val;
                                that.checked++;
                                $txt.click(function () {
                                    //$info.hide();
                                    $(this).remove();
                                    $body.find("li[value='" + val.substr(0, val.length - 1) + "']").toggleClass("select");
                                    that.idval = that.idval.replace(val, '');
                                    that.checked--;
                                });
                            }
                            else {//如果已选过 就删除
                                $seled.children("a[val='" + $(this).attr("value") + "']").remove();
                                that.idval = that.idval.replace(val, '');
                                that.checked--;
                            }
                        } else { //如果达到最大数 可以减少不能再加了
                            if ($seled.children("a[val='" + $(this).attr("value") + "']").length == 1) {
                                $(this).toggleClass("select");
                                $seled.children("a[val='" + $(this).attr("value") + "']").remove();
                                that.idval = that.idval.replace(val, '');
                                that.checked--;
                            } else {
                                $info.show();
                            }
                        }
                    }
                    else {
                        alert("已选择当前全部分类，如果需要只选其中一项，请先单击父项取消全选！")
                    }
                }
                else {//单选时
                    $seled.text($(this).attr("txt"));
                    var $t = $(this);
                    var txt = $t.attr("txt");
                    if ($t.parent().parent("li").length > 0)
                        txt = $t.parent().parent("li").attr("txt") + " - " + txt;
                    if ($t.parent().parent().parent().parent("li").length > 0)
                        txt = $t.parent().parent().parent().parent("li").attr("txt") + " - " + txt;
                    if ($id.attr("more") == "true")
                        $seled.text(txt);
                    that.idval = $(this).attr("value");
                    that._ok(); //只要当前值 即调用OK事件
                }
                e.stopPropagation();
            });
            $body.find("ul").click(function (e) {
                e.stopPropagation();
            });
        },
        _click: function () {//选项单击事件 
            var $body = this.$body;
            this._liclick($body.find("li"));
        },
        _ok: function () {
            var $ul = this.$ul;
            var $over = this.$over;
            var $seled = this.$seled;
            var $input = this.$input;
            var $id = this.text;
            if (this.idval == "") {//赋值并返回
                $input.text(this.tt).attr("title", "");
                $id.val(this.idval);
            } else {
                var txt = "";
                if ($id.attr("check") == "true") {//复选时
                    $seled.children("a").each(function (i, v) {
                        txt += $(v).text() + ",";
                    });
                    if (txt != "")
                        txt = txt.substring(0, txt.length - 1);
                } else {
                    txt = $seled.text();
                }
                $input.text(txt).attr("title", txt);
                $id.val(this.idval);
            }
            $ul.hide();
            $over.hide();
            this._callBack();
        },
        _clear: function () {
            var $ul = this.$ul;
            var $over = this.$over;
            var $seled = this.$seled;
            var $input = this.$input;
            var $id = this.text;
            $seled.children("a").each(function (i, v) {
                $(v).trigger("click");
            });
            this.idval = "";
            $input.text(this.tt).attr("title", "");
            $id.val(this.idval);
            $ul.hide();
            $over.hide();
        },
        _close: function () {//直接返回
            var $ul = this.$ul;
            var $over = this.$over;
            $ul.hide();
            $over.hide();
        },
        _value: function () {
            var $id = this.text;
            var $ul = this.$ul;
            var $input = this.$input;
            var that = this;
            var mode = this.mode || $id.attr("mode") || 'jobs'; //选择器类型 默认为职位选择器_bindul
            $id.bind("change", function () {//如果被赋值 就同步变更UL
                if ($id.val() != "0" && $id.val() != "") {
                    var vs = $id.val().split(',');
                    for (var v in vs) {
                        var tmp = zjs.getvals(mode, vs[v], 1);
                        if (tmp) {
                            switch (tmp.length) {
                                case 1:
                                    $ul.find("li[value='" + vs[v] + "']").trigger("click");
                                    break;
                                case 2:
                                    that._bindul($ul.find("li[value='" + tmp[1] + "']"));
                                    $ul.find("li[value='" + vs[v] + "']").trigger("click");
                                    break;
                                case 3:
                                    that._bindul($ul.find("li[value='" + tmp[2] + "']"));
                                    that._bindul($ul.find("li[value='" + tmp[1] + "']"));
                                    $ul.find("li[value='" + vs[v] + "']").trigger("click");
                                    break;
                            }
                        }
                    }
                    if ($id.attr("check") == "true") {//复选时
                        that._ok();
                    }
                } else {
                    $input.text(that.tt).attr("title", "");
                }
            });
            if ($id.val() != "" && $id.val() != "0")
                $id.trigger("change");
        },
        _callBack: function () {
            var $id = this.text;
            if ($id.attr("conchange")) {
                eval($id.attr("conchange").replace("()", "") + "('" + this.formid + "')");
            }
        }
    };
};
zjs.cselectorJob = zjs.extend(function () { }, zjs.cselectorJob);

/*获取城市列表*/
zjs.getCitys = function (citys) {
    var nodes = citys || zjs.citys;
    var tmp = [];
    tmp.push("<ul>");
    for (var i in nodes) {//遍历所有选项
        var ni = nodes[i];
        tmp.push("<li value='" + i + "' txt='" + ni.n + "'>");
        tmp.push("" + ni.n + "</li>");
    }
    tmp.push("</ul>");
    return (tmp.join(''));
};

/*微城市选择器*/
if (!window.zjs.cselectorWeiCity) {
    zjs.cselectorWeiCity = {
        clazz: "zjs.cselectorWeiCity",
        constructor: function (options) {
            this._setConfig(options);
            this._init();
        },
        _setConfig: function (config) {
            if (config && typeof config == 'object') {
                for (var p in config) {
                    this[p] = config[p]
                }
            }
        },
        _init: function (config) {
            var c = ['<a class="cselectorInput">-请选择-</a>', '<div class="weicitybox"></div>'];
            var $id = this.text;
            var $input = $(c[0]);
            var $ul = $(c[1]);
            $id.after($ul).after($input);
            $id.hide();
            $ul.hide().css("min-height", $(document).height() + 100);

            this.$ul = $ul;
            this.$input = $input;
            this._event();
        },
        _event: function () {
            var cityid = "";
            var cityid1 = "";
            var cityid2 = "";
            var cityid3 = "";
            var $id = this.text;
            var $ul = this.$ul;
            var $input = this.$input;
            $input.click(function (e) {//input
                cityid1 = "";
                cityid2 = "";
                cityid3 = "";
                $ul.html(zjs.getCitys());
                bindli();
                $ul.show();
            });
            function bindli() {
                $(".weicitybox li").click(function () {//input 
                    if (cityid1 == "") {
                        //一级
                        cityid = cityid1 = $(this).attr("value");
                        if (zjs.citys[cityid1].c) {
                            $ul.html(zjs.getCitys(zjs.citys[cityid1].c));
                        } else {
                            $ul.hide();
                            $id.val(cityid).trigger("change");
                            if ($id.attr("conchange")) {
                                eval($id.attr("conchange"));
                            }
                        }
                    } else if (cityid2 == "") {
                        //二级
                        cityid = cityid2 = $(this).attr("value");
                        if (zjs.citys[cityid1].c[cityid2].c) {
                            $ul.html(zjs.getCitys(zjs.citys[cityid1].c[cityid2].c));
                        } else {
                            $ul.hide();
                            $id.val(cityid).trigger("change");
                            if ($id.attr("conchange")) {
                                eval($id.attr("conchange"));
                            }
                        }
                    } else {
                        //三级
                        cityid = cityid3 = $(this).attr("value");
                        $ul.hide();
                        $id.val(cityid).trigger("change");
                        if ($id.attr("conchange")) {
                            eval($id.attr("conchange"));
                        }
                    }
                    $(window).scrollTop(0);
                    bindli();
                });
            }
            $id.bind("change", function () {//如果被赋值 就同步变更UL
                $input.text(zjs.getvals("citys", $id.val()));
            });
        }
    };
};
zjs.cselectorWeiCity = zjs.extend(function () { }, zjs.cselectorWeiCity);

//绑定表单项
zjs.bindformItems = function ($id) {
    window["cform" + $id.attr("id") + "InitHtml"] = $id.html();
    $id.find(".cselector,.cselectorRadio,.cselectorCheckBox,.cselectorCheckList,.cselectorTree,.cselectorCheckTree,.cselectorStar").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window[$id.attr("id") + "_" + $(vv).attr("id")] = new window.zjs.cselector({
                text: $(vv)
            });
            $(vv).attr("edit", "1");
        }
    });
    $id.find(".cselectorImageUpload").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window[$id.attr("id") + "_" + $(vv).attr("id")] = new window.zjs.cselectorImageUpload({
                text: $(vv)
            });
            $(vv).attr("edit", "1");
        }
    });
    $id.find(".cselectorWeiCity").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window[$id.attr("id") + "_" + $(vv).attr("id")] = new window.zjs.cselectorWeiCity({
                text: $(vv)
            });
            $(vv).attr("edit", "1");
        }
    });
    $id.find(".cselectorCity").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window["city_" + $(vv).attr("id")] = new window.zjs.cselectorJob({
                text: $(vv),
                type: 2,
                level: 1,
                mode: 'citys',
                formid: $id.attr("id")
            });
            $(vv).attr("edit", "1");
        }
    });
    $id.find(".cselectorDownCity").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window["downcity_" + $(vv).attr("id")] = new window.zjs.cselectorDownCity({
                $id: $(vv)
            });
            $(vv).attr("edit", "1");
        }
    });
    $id.find(".cselectorIOSCity").each(function (ii, vv) {
        if ($(vv).attr("edit") != "1") {
            window["ioscity_" + $(vv).attr("id")] = new window.zjs.cselectorIOSCity({
                $id: $(vv)
            });
            $(vv).attr("edit", "1");
        }
    });
    if ($id.attr("edit") != "1") {//防止重复执行
        $id.attr("edit", "1");
        //绑定特殊INPUT

        window["cform" + $id.attr("id")] = new window.zjs.cform({
            $id: $id
        });
    }
};
//绑定表格和表单
zjs.documentReady = function () {
    $("form").each(function (i, v) {//初始化表单
        var $id = $(v);
        if ($id.attr("cmd-select") == "") {
            $id.removeAttr("cmd-select");
        }
        if ($id.attr("cmd-insert") == "") {
            $id.removeAttr("cmd-insert");
        }
        if ($id.attr("cmd-update") == "") {
            $id.removeAttr("cmd-update");
        }
        if ($id.attr("cmd-select") || $id.attr("cmd-insert") || $id.attr("cmd-update") || $id.hasClass("cform")) { //如果这个表单用任何一个命令需要执行 就初始化 否则不管
            zjs.bindformItems($id);
        }
    });

    $("table,ul[cmd-select],div[cmd-select]").each(function (i, v) {//初始化表格
        var $id = $(v);
        if ($id.attr("cmd-select") == "") {
            $id.removeAttr("cmd-select");
        }
        if ($id.attr("cmd-select")) { //如果这个表单用任何一个命令需要执行 就初始化 否则不管
            if ($id.attr("edit") != "1") {//防止重复执行 
                $id.attr("edit", "1");

                var id = $id.attr("id");
                window["ctable" + id] = new window.zjs.ctable({ $id: $id });
            }
        }
    });

    $("i[dateformat]").each(function (i, v) {//日期格式化
        $(v).html(zjs.dateformat($(v).text(), $(v).attr("dateformat"))).removeAttr("dateformat");
    });

    $(".cfocus").each(function (i, v) {
        var $id = $(v);
        if (!$id.attr("id")) {
            $id.attr("id", "cfocus" + new Date().getTime());
        }
        if ($id.attr("edit") != "1") {//防止重复执行 
            $id.attr("edit", "1");

            window["cfocus" + $id.attr("id")] = new zjs.cfocus({
                $id: $id
            });
        }
    });
};
//默认的导出回调函数 导出后返回的是EXCEL路径 所以直接打开就可以了
zjs.outportcallback = function ($id, data) {
    window.open(data.url);
};
$(function () {//dom加载完成后 初始化表单 表格等
    zjs.documentReady();//初始化表单和表格
    zjs.topapilock();

    //20160726 新增默认的多行数据处理支持 添加行事件
    $(".tbodyadd").live("click", function () {
        var $t = $(this);
        var tablename = $t.attr("target");
        var $table = $("table[savepath='" + tablename + "']");
        if ($table.length > 0) {//如果不是table格式 就用div格式
            if ($t.attr("maxlength")) {
                if ($table.find("tbody").length >= $t.attr("maxlength")) {
                    alert("最多创建 " + $t.attr("maxlength") + " 条");
                    return false;
                }
            }
            var theadhtml = $table.find("thead.hide").html().replace(new RegExp("classpath", 'g'), "class").replace(new RegExp("rulepath", 'g'), "rule");
            var $tbody = $("<tbody class='item'>" + theadhtml + "</tbody>");
            $table.append($tbody);
            zjs.documentReady();
            $tbody.find(".cselector").trigger("change");
            $tbody.find("input").first().focus();
        } else {
            var $div = $(".table[savepath='" + tablename + "']");
            if ($t.attr("maxlength")) {
                if ($div.find(".tbody").length >= $t.attr("maxlength")) {
                    alert("最多创建 " + $t.attr("maxlength") + " 条");
                    return false;
                }
            }
            var theadhtml = $div.find(".thead.hide").html().replace(new RegExp("classpath", 'g'), "class").replace(new RegExp("rulepath", 'g'), "rule");
            var nodename = $div.find(".thead.hide")[0].nodeName;
            var $tbody = $("<" + nodename + " class='tbody item'>" + theadhtml + "</" + nodename + ">");
            $div.append($tbody);
            zjs.documentReady();
            $tbody.find(".cselector").trigger("change");
            $tbody.find("input").first().focus();
        }
    });
    //20170830 默认支持多行嵌套多行模式
    $(".subtbodyadd").live("click", function () {
        var $t = $(this);
        var $table = $t.parents("table[subsavepath]");
        if ($t.attr("maxlength")) {
            if ($table.find("tbody").length >= $t.attr("maxlength")) {
                alert("最多创建 " + $t.attr("maxlength") + " 条");
                return false;
            }
        }
        var theadhtml = $table.find("thead.hide").html().replace(new RegExp("classpath", 'g'), "class").replace(new RegExp("rulepath", 'g'), "rule");
        var $tbody = $("<tbody class='subitem'>" + theadhtml + "</tbody>");
        $table.append($tbody);
        zjs.documentReady();
        $tbody.find(".cselector").trigger("change");
        $tbody.find("input").first().focus();
    });
    //删除行事件
    $(".tbodydel").live("click", function () {
        var $t = $(this);
        if ($t.attr("minlength")) {
            var $table = $t.parents("table[savepath]");
            if ($table.length > 0) {//如果不是table格式 就用div格式
                if ($table.find("tbody").length <= $t.attr("minlength")) {
                    alert("最少保留 " + $t.attr("minlength") + " 条");
                    return false;
                }
            } else {
                var $div = $t.parents(".table[savepath]");
                if ($div.find(".tbody").length <= $t.attr("minlength")) {
                    alert("最少保留 " + $t.attr("minlength") + " 条");
                    return false;
                }
            }
        }
        var $p = $(this).parents("tbody.item,.tbody.item");
        zjs.confirm("确认删除?", function () {
            $p.remove();
        });
    });
    //删除行内行事件
    $(".subtbodydel").live("click", function () {
        var $t = $(this);
        if ($t.attr("minlength")) {
            var $table = $t.parents("table[subsavepath]");
            if ($table.find("tbody").length <= $t.attr("minlength")) {
                alert("最少保留 " + $t.attr("minlength") + " 条");
                return false;
            }
        }
        var $p = $(this).parents("tbody.subitem");
        zjs.confirm("确认删除?", function () {
            $p.remove();
        });
    });
    //向上移动
    $(".tbodytop").live("click", function () {
        if ($(this).parents("tbody.item").prev("tbody.item").length > 0) {
            $(this).parents("tbody.item").prev("tbody.item").before($(this).parents("tbody.item"));
        }
        if ($(this).parents(".tbody.item").prev(".tbody.item").length > 0) {
            $(this).parents(".tbody.item").prev(".tbody.item").before($(this).parents(".tbody.item"));
        }
    });

    $("a[execcmd]").live("click", function () {//执行命令
        var $t = $(this);
        var para = zjs.getQueryStr();

        if ($t.attr("paras")) {//参数名称 参数值
            var res = $t.attr("paras").split(',');
            for (var re in res) {
                if ($t.attr(res[re])) {
                    para[res[re]] = $t.attr(res[re]);
                }
            }
        }
        if ($t.attr("urlparas")) {
            para = zjs.getParas($t.attr("urlparas"));//以URL里的参数为主
        }
        function dothing() {
            if (!$t.hasClass("loading")) {
                $t.addClass("loading");//防止不停的重复点击
                if ($t.attr("execcmd") == "base_ClearForOutport") {//如果是导出命令 就锁屏 
                    zjs.lhgtips("正在导出,请稍候...", 1000, "loading.gif", true);
                    zjs.topapilock();
                }
                zjs.cmd({
                    cmd: $t.attr("execcmd"),
                    para: para,
                    callback: function (data) {
                        $t.removeClass("loading");
                        if ($t.attr("callback")) {
                            if ($t.attr("callback").indexOf("()") > -1)
                                eval($t.attr("callback").replace("()", "") + "($t,data)");
                            else
                                eval($t.attr("callback") + "($t,data)");
                        }
                        if ($t.attr("target")) {//如果是跳转 就直接跳转 
                            if ($t.attr("target") != "_blank") {//如果是跳转 就直接跳转 
                                var tourl = $t.attr("target");
                                tourl = tourl + (tourl.indexOf("?") > 0 ? "&" : "?") + "tm=" + (new Date()).getTime();
                                window.location.href = tourl;
                            }
                        }
                        if ($t.attr("refresh")) {//如果是跳转 就直接跳转
                            window.location.href = window.location.href;
                        }
                        if ($t.attr("delete")) {//如果是跳转 就直接跳转
                            $t.parents(".uls").remove();
                        }
                    },
                    alwayscallback: function () {
                        $t.removeClass("loading");
                    }
                });//end zjs.cmd
            }
        };
        if ($t.attr("confirm"))
            zjs.confirm($t.attr("confirm"), dothing);//end zjs.confirm
        else
            dothing();
    });//end execcmd 
    //$(".icon-minus,.icon-plus").live("tap", function () {
    //    $(this).trigger("click");
    //});
    var carttime;
    $(".cart-minus").live("click", function () {//购物车 -减号 保证码紧跟他后面
        var $t = $(this).next("input");
        clearTimeout(carttime);
        carttime = setTimeout(function () {
            if ($t.length > 0) {
                var val = 0;
                try {
                    val = parseInt($t.val());
                } catch (ex) {
                    val = 0;
                }
                if (val > 1) {
                    $t.val((val - 1)).trigger("change");
                } else {
                    $t.val("0").trigger("change");
                }
            }
        }, 100);
    });
    $(".cart-plus").live("click", function () {//购物车 +加号 保证码紧跟他后面
        var $t = $(this).prev("input");
        clearTimeout(carttime);
        carttime = setTimeout(function () {
            if ($t.length > 0) {
                var val = 0;
                try {
                    val = parseInt($t.val());
                } catch (ex) {
                    val = 0;
                }
                if (val < 99999) {
                    $t.val((val + 1)).trigger("change");
                } else {
                    $t.val("99999").trigger("change");
                }
            }
        }, 100);
    });//end icon-plus

    /* kindeditor */
    $(".ceditor").each(function (i, v) {
        if ($(v).attr("edit") != "1") {
            $(v).attr("edit", "1");

            var editor = null;
            //KindEditor.ready(function (K) { 
            editor = KindEditor.create('textarea.ceditor', {
                emoticonsPath: "/js/qq/",
                allowImageUpload: false,
                items: [
                    'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'cut', 'copy', 'paste',
                    'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                    'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                    'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                    'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                    'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'knetimage', 'knetaudio',
                    'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                    'anchor', 'link', 'unlink'
                ]
            });

            $(v).attr("edit", "1");

            $(v).change(function () {
                editor.html($(v).val());
            });
            $(v).bind("getdata", function () {
                $(v).val(editor.html());
            });
            //});
        }
    });//end ceditor 

    /* kindeditor */
    $(".ceditormin").each(function (i, v) {
        if ($(v).attr("edit") != "1") {
            $(v).attr("edit", "1");

            var editor = null;
            //KindEditor.ready(function (K) {
            //editor = K.create('textarea.ceditormin', {
            editor = KindEditor.create('textarea.ceditormin', {
                emoticonsPath: "/js/qq/",
                allowImageUpload: false,
                items: [
                    'justifyleft', 'justifycenter', 'justifyright',
                    'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', '|',
                    'clearhtml', 'removeformat', '|',
                    'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                    'italic', 'underline', 'strikethrough', 'lineheight', '|',
                    'emoticons', 'baidumap'
                ]
            });

            $(v).attr("edit", "1");

            $(v).change(function () {
                editor.html($(v).val());
            });
            $(v).bind("getdata", function () {
                $(v).val(editor.html());
            });
            //});
        }
    });//end ceditor 

    if (zjs.meitu) {//如果启动了美图秀秀功能 就绑定事件 有些手机端的是不需要绑定美图秀秀的
        $(".meitucrop").live("click", function () {//美图秀秀功能
            var $t = $(this);
            if (!$t.attr("imageurl")) {
                $t.attr("imageurl", $t.children("img").attr("src"));
                $t.attr("title", "裁剪");
            }
            zjs.openurl($t, zjs.meitu + "?url=" + $t.attr("imageurl") + "", function () {
                zjs.refreshimage($t);
            });
        });//end meitucrop
    }

    $("input.cselectorImageSelect,img.cselectorImageSelect").live("dblclick", function () {
        var $t = $(this);
        var ctype = $t.attr("ctype") || "";
        var cid = $t.attr("cid") || "";
        var ceditorDialogC;
        var dial = {
            id: "ceditorDialog",
            lock: true,
            fixed: true,
            min: false,
            max: false,
            width: 960,
            height: 600,
            title: "图片选择器",
            content: 'url:/cfinder.aspx?type=' + ctype + '&id=' + cid,
            close: function () {
                if (ceditorDialogC.content.document.getElementById('url').value) {
                    zjs.topapilock();

                    var urlval = ceditorDialogC.content.document.getElementById('url').value;
                    if (urlval == "clear") {
                        if ($t[0].nodeName == "IMG")
                            $t[0].src = "/img/b.png";
                        else
                            $t.val("");
                    } else {
                        if ($t[0].nodeName == "IMG")
                            $t[0].src = urlval;
                        else
                            $t.val(urlval);
                    }
                    $t.trigger("blur");
                    if ($t.attr("callback"))
                        eval($t.attr("callback"));
                }
            }
        };
        ceditorDialogC = zjs.dialog(dial);
    });
    $("input.cselectorIcon").live("dblclick", function () {
        var $t = $(this);
        var ceditorDialogC;
        var dial = {
            id: "cselectIcon",
            lock: true,
            fixed: true,
            min: false,
            max: false,
            width: 960,
            height: zjs.dialogheight(),
            title: "图标选择器",
            content: 'url:/icons.html?t=' + new Date(),
            close: function () {
                if (ceditorDialogC.content.document.getElementById('url').value) {
                    zjs.topapilock();

                    var urlval = ceditorDialogC.content.document.getElementById('url').value;
                    if (urlval == "clear")
                        $t.val("");
                    else
                        $t.val(urlval);
                    $t.trigger("blur");
                    if ($t.attr("callback"))
                        eval($t.attr("callback"));
                }
            }
        };
        ceditorDialogC = zjs.dialog(dial);
    });
    $("input.cselectorIconFont").live("dblclick", function () {
        var $t = $(this);
        var ceditorDialogC;
        var dial = {
            id: "cselectorIconFont",
            lock: true,
            fixed: true,
            min: false,
            max: false,
            width: 960,
            height: zjs.dialogheight(),
            title: "图标选择器",
            content: 'url:/iconfont.html?t=' + new Date(),
            close: function () {
                if (ceditorDialogC.content.document.getElementById('url').value) {
                    zjs.topapilock();

                    var urlval = ceditorDialogC.content.document.getElementById('url').value;
                    if (urlval == "clear")
                        $t.val("");
                    else
                        $t.val(urlval);
                    $t.trigger("blur");
                    if ($t.attr("callback"))
                        eval($t.attr("callback"));
                }
            }
        };
        ceditorDialogC = zjs.dialog(dial);
    });
    $("a[openurl]").live("click", function () {//打开新窗口
        var $t = $(this);
        zjs.openurl($t, $t.attr("openurl"));
    });

    //$(".cselectorLink").hide().after('<a class="btn btn-hui cselectorLinkbtn">选择链接地址</a>');
    $(".cselectorLink").live("dblclick", function () {
        var $t = $(this);
        var ceditorDialogC;
        var dial = {
            id: "linkurlDialog",
            lock: true,
            fixed: true,
            min: false,
            max: false,
            width: 960,
            height: zjs.dialogheight(),
            title: "链接选择器",
            content: 'url:/linkurl.aspx',
            close: function () {
                if (ceditorDialogC.content.document.getElementById('url').value) {
                    zjs.topapilock();
                    var urlval = ceditorDialogC.content.document.getElementById('url').value;
                    if (urlval == "clear")
                        $t.val("");
                    else
                        $t.val(urlval);
                    $t.trigger("blur");
                    if ($t.attr("callback"))
                        eval($t.attr("callback"));
                }
            }
        };
        ceditorDialogC = zjs.dialog(dial);
    });
    $(".Nav").each(function (i, v) {
        var $as = $(v).find("li a[href='" + window.location.pathname + "']");
        if ($as.length > 0)
            $as.first().addClass("hover");
        else
            $(v).find("li").first().find("a").addClass("hover");
    });
});