

function winLoadsize() {  //页面尺寸
    var height = document.documentElement.clientHeight;
    var width = document.body.clientWidth;
    var header_h = $('#head').height();
    var footer_h = $('#foot').height();
    var middle_h = height - header_h - footer_h - 10;

    $('.top-content').height(middle_h + 'px');
}
$(function () {
    winLoadsize();
})
var temp = 0;
$(function () {
    $('#sh_rdiv').find('a').each(function (index, ele) {
        if ($(ele).attr('id') == "sh_qr") {
            $(ele).on('mouseover', function () {
                $(ele).find('div').eq(0).css('background-position-x', '40px');
                $('.bingAppQRHide').show();
            });
            $(ele).on('mouseout', function () {
                $(ele).find('div').eq(0).css('background-position-x', '0px');
                $('.bingAppQRHide').hide();
            });
        } else if ($(ele).attr('id') == "sh_shl") {
            $(ele).on('mouseover', function () {
                temp = 1;
                $(ele).find('div').eq(1).css({ 'width': '42px', 'height': '42px', 'margin': '-1px 9px', 'background-position-x': '-252px' });
                $('#sh_shqzl').find('div').eq(0).show();
                $('#sh_shwbl').find('div').eq(0).show();
                $('#sh_shwcl').find('div').eq(0).show();
            });
            $(ele).on('mouseout', function () {
                temp = 0;
                if (temp == 0) {
                    $(ele).find('div').eq(1).css({ 'width': '40px', 'height': '40px', 'margin': '0px 10px', 'background-position-x': '0px' });
                    $('#sh_shqzl').find('div').eq(0).hide();
                    $('#sh_shwbl').find('div').eq(0).hide();
                    $('#sh_shwcl').find('div').eq(0).hide();
                }
            });
        } else if ($(ele).attr('id') == "sh_shqzl" || $(ele).attr('id') == "sh_shwbl" || $(ele).attr('id') == "sh_shwcl") {
            $(ele).on('mouseover', function () {
                temp = 1;
                $(ele).find('div').eq(0).css({ 'width': '42px', 'height': '42px', 'margin': '-1px 9px', 'background-position-x': '-252px' });
                $('#sh_shqzl').find('div').eq(0).show();
                $('#sh_shwbl').find('div').eq(0).show();
                $('#sh_shwcl').find('div').eq(0).show();
            });
            $(ele).on('mouseout', function () {
                temp = 0;
                if (temp == 0) {
                    $(ele).find('div').eq(0).css({ 'width': '40px', 'height': '40px', 'margin': '0px 10px', 'background-position-x': '0px' });
                    $('#sh_shqzl').find('div').eq(0).hide();
                    $('#sh_shwbl').find('div').eq(0).hide();
                    $('#sh_shwcl').find('div').eq(0).hide();
                }
            });

        } else {
            $(ele).on('mouseover', function () {
                if ((imgTemp != 1 && $(ele).attr('id') == "sh_igl") || (imgTemp != 7 && $(ele).attr('id') == "sh_igr"))
                    $(ele).find('div').find('div').eq(0).css({ 'width': '42px', 'height': '42px', 'margin': '-1px 9px', 'background-position-x': '-252px' });
            });
            $(ele).on('mouseout', function () {
                $(ele).find('div').find('div').eq(0).css({ 'width': '40px', 'height': '40px', 'margin': '0px 10px', 'background-position-x': '0px' });
            });
        }
    });
    $('#sh_shqzl').click(function () {
        var share1 = new ShareTip();
        share1.sharetoqqzone(document.title, document.location.href, "");
    });

    $('#sh_shwbl').click(function () {
        var share1 = new ShareTip();
        share1.sharetosina(document.title, document.location.href, "");
    });

    $("#UserName").on('focus', function () {
        $('.login').css('opacity', '1');
    });
    $("#UserName").on('blur', function () {
        $('.login').css('opacity', '0.9');
    });
    $("#loginPwd").on('focus', function () {
        $('.login').css('opacity', '1');
    });
    $("#loginPwd").on('blur', function () {
        $('.login').css('opacity', '0.9');
    });
    $("#loginVid").on('focus', function () {
        $('.login').css('opacity', '1');
    });
    $("#loginVid").on('blur', function () {
        $('.login').css('opacity', '0.9');
    });

})
jQuery(function () {
    //img();
    $('#loginBtn').click(function () {
        LoginSubmit();
    });
    LoadCookie();
    document.onkeydown = function (e) {
        var ev = document.all ? window.event : e;
        if (ev.keyCode == 13) {
            LoginSubmit();
        }
    }
    $('#sh_igl').click(function () {
        ChangImg('pre')
    });
    $('#sh_igr').click(function () {
        ChangImg('next')
    });
});function LoginSubmit() {
    var user = $("#UserName").val();
    var pass = $("#loginPwd").val();
    var vid = $('#loginVid').val();
    if (user == "" || pass == "") {
        $("#loginmsg2").html("用户名或者密码不能为空");
        return false;
    }
    var ret = false;
    $.ajax({
        type: "post",
        async: false,
        url: "unsafe/service.ashx?t=LoginV3&s=1",
        data: { "u": user, "p": pass, "v": 1, "c": vid },
        dataType: "html",
        success: function (res) {
            var result = eval('(' + res + ')');
            if (result.success) {
                $("#loginmsg2").html(''); 
                if (result.page) {
                    window.open(result.page+'?tm=' + new Date().getTime(), '_self');
                } else {
                    window.open('mainframe.aspx?tm='+new Date().getTime(), '_self');
                }
            }
            else {
                $("#loginmsg2").html(result.msg);
            }
        },
        error: function(e) {
            $("#loginmsg2").html("连接验证服务时异常：" + e.message);
        }
    });
}
function LoadCookie() {
    if ($.cookie("rmbUser") == "true") {
        $("input[name='isRemember']").prop("checked", true);
        $("#pwdEmail").val($.cookie("pwdEmail"));
        $("#pwdCode").val($.cookie("pwdCode"));
    }
}
function CookieLogin() {
    if ($("input[name='isRemember']").prop("checked")) {
        var username = $("#pwdEmail").val();
        var password = $("#pwdCode").val();
        $.cookie("rmbUser", "true", { expires: 30 }); //存储一个带7天期限的cookie 
        $.cookie("pwdEmail", username, { expires: 30 });
        $.cookie("pwdCode", password, { expires: 30 });
    } else {
        $.cookie("rmbUser", "false", { expire: -1 });
        $.cookie("pwdEmail", "", { expires: -1 });
        $.cookie("pwdCode", "", { expires: -1 });
    }
}
var imageAddress = new Array();
var imgTemp = 1;
function img() {
    for (var i = 5; i <= 5; i++) {
        var src = 'url(img/desktop/' + i + '.jpg)';
        imageAddress.push(src);
    }
    //产生一个0－9的随机数
    var num = Math.round(Math.random() * 9 + 1);
    if (num < 8) {
        imgTemp = num;
        $('body').css({
            'background-image': imageAddress[num]
        });

    } else {
        $('body').css({
            'background-image': imageAddress[7]
        });
        imgTemp = 7;
    }
    ChangImg('');
}
function ChangImg(type) {
    if (type == 'pre') {
        if (imgTemp > 1) {
            imgTemp = imgTemp - 1;
        } else {
            $('#sh_lt').css('opacity', '.7');
        }
        $('body').css({
            'background-image': imageAddress[imgTemp]
        });
    } else if (type == 'next') {
        if (imgTemp <= 6) {
            imgTemp = imgTemp + 1;
        } else {
            $('#sh_rt').css('opacity', '.7');
        }
        $('body').css({
            'background-image': imageAddress[imgTemp]
        });
    }
    if (imgTemp == 1) {
        $('#sh_lt').css('opacity', '.7');
        $('#sh_rt').css('opacity', '1');
    }
    else if (imgTemp == 7) {
        $('#sh_lt').css('opacity', '1');
        $('#sh_rt').css('opacity', '.7');
    }

}