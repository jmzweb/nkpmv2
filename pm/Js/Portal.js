var fadeFlashNow = new Array();
var fadeFlashTime = new Array();
var fadeFlashNum = 0;
for (i = 0; i < 50; i++) {
    fadeFlashNow[i] = 0;
}
function fadeFlashFun(i) {
    $('.fadeFlash').eq(i).find('.btnDiv').find('span').removeClass('spanNow');
    $('.fadeFlash').eq(i).find('li').eq(fadeFlashNow[i]).fadeOut(500);
    if (fadeFlashNow[i] < $('.fadeFlash').eq(i).find('li').length - 1)
        fadeFlashNow[i]++;
    else
        fadeFlashNow[i] = 0;

    $('.fadeFlash').eq(i).find('li').eq(fadeFlashNow[i]).fadeIn(500);
    $('.fadeFlash').eq(i).find('.btnDiv').find('span').eq(fadeFlashNow[i]).addClass('spanNow');
}

function fadeFlash(flashDiv) {
    var i = fadeFlashNum++;
    fadeFlashTime[i] = setInterval("fadeFlashFun(" + i + ")", 5000);
    flashDiv.find('.btnDiv').find('span').each(function (ii) {
        $(this).hover(function () {
            clearInterval(fadeFlashTime[i]);
            $('.fadeFlash').eq(i).find('.btnDiv').find('span').removeClass('spanNow');
            $(this).addClass('spanNow');
            $('.fadeFlash').eq(i).find('li').eq(fadeFlashNow[i]).fadeOut(500);
            fadeFlashNow[i] = ii;
            $('.fadeFlash').eq(i).find('li').eq(fadeFlashNow[i]).fadeIn(500);
            fadeFlashTime[i] = setInterval("fadeFlashFun(" + i + ")", 5000);
        },
		function () { });
    });

    flashDiv.find('li:first').fadeIn(500);
}

function chunk(array, process, context) {
    setTimeout(function() {
        var item = array.shift();
        process.call(context, item);
        if (array.length > 0) {
              setTimeout(arguments.callee, 100);
        }
    }, 100);
}

jQuery(function () {

    $(".pbody:visible").each(function () {
        $(".widget", this).each(function () {
            loadWidget(this);
        });
        $(this).attr("load", "1");
    });

    $(".widget .unread").live("click", function () {
        $(this).removeClass("unread").addClass("readed");
    });
    $(".menuItem").hover(function () {
        if ($(this).hasClass("on"))
            return;
        $(this).addClass("hover");
    }, function () {
        if ($(this).hasClass("on"))
            return;
        $(this).removeClass("hover");
    });
    $(".menuItem .div").click(function () {
        var dlg = new jQuery.dialog({ title: $(this).text(), page: $(this).attr("rel")
                , btnBar: false, cover: true, lockScroll: true, width: 1000, height: 600, bgcolor: 'black', link: true
        });
        dlg.ShowDialog();
    });
    $(".menuItem").click(function (e) {
        if ($(e.srcElement).hasClass("outLink")) {
            return true;
        }
        var ix = $(this).index();
        $(".menuItem").removeClass("hover");
        $(".menuItem").removeClass("on");
        $(this).addClass("on");
        $(".pbody").hide();
        var tobody = $(".pbody:eq(" + ix + ")");
        tobody.show();

        if (tobody.attr("load") == "1") {

            $(".widget:visible", tobody).each(function () {
                var arr = $(this).attr("ref").split("|");
                if (arr[1] == "03") {
                    var model = layout[arr[0]];
                    var h = parseInt(model.PicHeight);

                }
                else if (arr[1] == "02") {
                    var model = layout[arr[2]];
                    var h = parseInt(model.PicHeight);

                }
            });
            return;
        }
        $(".widget:visible", tobody).each(function () {
            loadWidget(this);
        });
        tobody.attr("load", "1");
    });

});

function loadWidget(obj) {
    var arr = $(obj).attr("ref").split("|");
    var arrHtml = [];
    if (arr[1] == "01") {

        var ret = _curClass.GetData(arr[0]).value;
        if (ret != null) {
            var model = layout[arr[0]];
            var max = 10;
            var m = parseInt(model.ItemNum);
            if (!isNaN(m));
            max = m;
            for (var i = 0; i < ret.Rows.length && i < max; i++) {
                if (model.ReadShow == "是" && model.ReadField != "") {
                    var r = ret.Rows[i][model.ReadField];
                    arrHtml.push("<div class='li ", r == "1" ? "readed" : "unread", "'>");

                }
                else {
                    arrHtml.push("<div class='li'>");
                }
                var iLink = replacePara(model.ItemLink, ret.Rows[i]);
                arrHtml.push("<a href='" + iLink + "' target='_blank'>" + replacePara(model.ItemTitle, ret.Rows[i]) + "</a>");
                arrHtml.push("</div>");
            }
        }

        $(".wBody", obj).html(arrHtml.join(""));
    }
    else if (arr[1] == "02") {

        var ret = _curClass.GetData(arr[0]).value;
        var model = null;
        if (ret != null) {
            model = layout[arr[0]];
            var max = 10;
            var m = parseInt(model.ItemNum);
            if (!isNaN(m));
            max = m;
            for (var i = 0; i < ret.Rows.length && i < max; i++) {
                if (model.ReadShow == "是" && model.ReadField != "") {
                    var r = ret.Rows[i][model.ReadField];
                    arrHtml.push("<div class='li ", r == "1" ? "readed" : "unread", "'>");

                }
                else {
                    arrHtml.push("<div class='li'>");
                }
                var iLink = replacePara(model.ItemLink, ret.Rows[i]);
                arrHtml.push("<a href='" + iLink + "' target='_blank'>" + replacePara(model.ItemTitle, ret.Rows[i]) + "</a>");
                arrHtml.push("</div>");

            }

        }

        var arrImg = [];
        var picModel = layout[arr[2]];
        var pics = _curClass.GetData(arr[2]).value;
        if (pics != null) {
            arrImg.push("<div class='fadeFlash'><ul>");

            var imgNum = 0;
            var max = 10;
            var m = parseInt(picModel.ItemNum);
            if (!isNaN(m));
            max = m;
            for (var i = 0; i < pics.Rows.length && i < max; i++) {

                //处理图片
                var src = replacePara(picModel.ItemImg, pics.Rows[i]);
                if (src.length > 0) {

                    var src = "SysFolder/Common/FileDown.aspx?appId=" + src;
                    arrImg.push("<li>");
                    arrImg.push("<div class='imgDiv'>");
                    var srcLink = replacePara(picModel.ItemLink, pics.Rows[i]);
                    var imgTitle = replacePara(picModel.ItemTitle, pics.Rows[i]);
                    if (srcLink.length == 0)
                        arrImg.push("<a style='border-width:0px;color:white;' href='SysFolder/AppFrame/AppDetail.aspx?tblName=T_OA_TopBanner&mainId=" + pics.Rows[i]._AutoID + "' target='_blank'>");
                    else
                        arrImg.push("<a style='border-width:0px;color:white;' href='" + srcLink + "' target='_blank'>");

                    arrImg.push("<img style='border-width:0px;width:100%;height:100%;' src='" + src + "' alt='" + imgTitle + "' />");
                    arrImg.push("</a>");

                    arrImg.push("</div>");
                    var shrTitle = imgTitle.length > 10 ? (imgTitle.substr(0, 10) + '…') : imgTitle;
                    arrImg.push('<div class="name"><a href="', srcLink, '" title="', imgTitle, '">', shrTitle, '</a></div>');
                    arrImg.push("</li>");

                    imgNum++;
                }

            }

            arrImg.push("</ul><div class='btnDiv'>");
            for (var i = 0; i < imgNum; i++) {
                if (i == 0)
                    arrImg.push('<span class="spanNow"></span>');
                else
                    arrImg.push("<span></span>");

            }
            arrImg.push("</div></div>");

        }

        var w = parseInt(model.PicWidth);
        var h = parseInt(model.PicHeight);


        var html = "<table border=0 style='width:100%;'><tbody><tr><td style='width:" + w + "px;'>" + arrImg.join("") + "</td><td valign='top' style='padding-left:5px;'>" + arrHtml.join("") + "</td></tr></tbody></table>"
        $(".wBody", obj).html(html);

        $(".fadeFlash", obj).height(h);
        $(".fadeFlash li", obj).height(h);

        fadeFlash($(".fadeFlash", obj));

    }
    else if (arr[1] == "03") {
        //图片幻灯片

        arrHtml.push("<div class='fadeFlash'><ul>");
        var imgNum = 0;
        var ret = _curClass.GetData(arr[0]).value;
        if (ret != null) {
            var model = layout[arr[0]];
            var max = 10;
            var m = parseInt(model.ItemNum);
            if (!isNaN(m));
            max = m;
            for (var i = 0; i < ret.Rows.length && i < max; i++) {

                var src = "SysFolder/Common/FileDown.aspx?appId=" + replacePara(model.ItemImg, ret.Rows[i]);

                arrHtml.push("<li>");
                arrHtml.push("<div class='imgDiv'>");
                var srcLink = replacePara(model.ItemLink, ret.Rows[i]);
                var imgTitle = replacePara(model.ItemTitle, ret.Rows[i]);

                if (srcLink.length == 0)
                    arrHtml.push("<a style='border-width:0px;color:white;' href='javascript:'>");
                else
                    arrHtml.push("<a style='border-width:0px;color:white;' href='" + srcLink + "' target='_blank'>");

                arrHtml.push("<img style='border-width:0px;width:100%;height:100%;' src='" + src + "' alt='" + imgTitle + "' />");
                arrHtml.push("</a>");

                arrHtml.push("</div>");
                arrHtml.push('<div class="name"><a href="', srcLink, '">', imgTitle, '</a></div>');
                arrHtml.push("</li>");

                imgNum++;
            }
        }

        arrHtml.push("</ul><div class='btnDiv'>");
        for (var i = 0; i < imgNum; i++) {
            if (i == 0)
                arrHtml.push('<span class="spanNow"></span>');
            else
                arrHtml.push("<span></span>");

        }
        arrHtml.push("</div></div>");

        $(".wBody", obj).html(arrHtml.join(""));

        var w = parseInt(model.PicWidth);
        var h = parseInt(model.PicHeight);
        $(".fadeFlash", obj).height(h);
        $(".fadeFlash li", obj).height(h);

        fadeFlash($(".fadeFlash", obj));

    }
    else if (arr[1] == "04") {
        var model = layout[arr[0]];
        if (model.WidgetLink.length > 0) {
            arrHtml.push("<iframe src='" + model.WidgetLink + "' style='width:100%;height:" + model.WidgetHeight + "px;' frameBorder='0'></iframe>")
            $(".wBody", obj).html(arrHtml.join(""));
        }
    }
    else if (arr[1] == "05") {
        var model = layout[arr[0]];
        var ret = _curClass.GetData(arr[0]).value;
        var html = window["_fn_" + model.Hash](ret);
        $(".wBody", obj).html(html);
    }
    setTimeout(function () { return; }, 10);
}

function loadImg(obj,arr) { 

}

//参数替换
function replacePara(source,data) {
    var reg = /{([\w_1-9-:]+)}/gi;
    var matches = source.match(reg);
    if (matches != null) {
        for (var i = 0; i < matches.length; i++) {
            var fldName = matches[i].substr(1, matches[i].length - 2);
            var fvObject = data[fldName];
            var fv = "";
            if(fvObject!=null)
                fv = fvObject.toString();
            if (jQuery.type(fvObject) == "date")
                fv = fvObject.format("yyyy-MM-dd");
            source = source.replace(matches[i], fv);
        }
    }
    return source;
}


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

var _class2type = {};
var _arrType = "Boolean Number String Function Array Date RegExp Object".split(" ");
jQuery.each(_arrType,
    function (i, name) {
        _class2type["[object " + name + "]"] = name.toLowerCase();
    });
var _core_toString = Object.prototype.toString;
jQuery.extend({
    type: function (obj) {
        return obj == null ?
            String(obj) :  // 如果传入的值为null或者是undefined直接调用String()方法 
            _class2type[_core_toString.call(obj)] || "object";
    }
}); 