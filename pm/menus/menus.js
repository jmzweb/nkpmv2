$(function () {
    $(".syscolumns a").click(function () {
        $(this).addClass("hover").siblings().removeClass("hover");
        $(".sysboxs .sysitem").eq($(this).index()).show().siblings().hide();
    });
    $(".syscolumns a").first().trigger("click");
     
    $(".sysboxs dl.col2 li").click(function () {
        $(this).addClass("hover").siblings().removeClass("hover");
    });
});