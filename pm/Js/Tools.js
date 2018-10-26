function openCenter(url, name, width, height) {
    var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
    if (window.screen) {
        var ah = screen.availHeight - 30;
        var aw = screen.availWidth - 10;
        var xc = (aw - width) / 2;
        var yc = (ah - height) / 2;
        str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
        str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
    }
    return window.open(url, name, str);
}

function openpage(url) {
    openCenter(url, "_blank", 640, 500);
}
jQuery(function () {
    jQuery(":text,textarea").live("focus", function () {
        _inputBg = { "backgroundColor": $(this).css("background-color"), "backgroundImage": $(this).css("background-image") };
        $(this).css({ "backgroundColor": "#fff280", "backgroundImage": "url()" });
    });

    jQuery(":text,textarea").live("blur", function () {
        $(this).css(_inputBg);
    });

    $(".btn01").hover(function () {
        this.className = "btn02";
    }, function () {
        this.className = "btn01";
    });

});
var _inputBg = {};

//扩展String对象
String.prototype.format = function (args) {
    var result = this;
    if (arguments.length > 0) {
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if (args[key] != undefined) {
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        }
        else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
                    var reg = new RegExp("({)" + i + "(})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result;
}
