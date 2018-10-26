//关闭弹窗
function CloseLayer() {
    setTimeout(function () { layer.close(LayerTemp) }, 300);
}
var LayerTemp = 0;
$(function () {
    var liwidth = (($(window).width() - 20) / $(".h3box1 li").length);
    var liheight = liwidth;
    var minwinheight = 120;
    if (liheight > minwinheight) {
        liheight = minwinheight;
    }
    $(".addpro").css({ "left": (liheight / 2 - 30) + "px", "top": (liheight) + "px" });
    $(".h3box1").css({ "height": ((liheight * 2) + 180) + "px" });
    $(".h3box1 h3").css({ "height": (liheight + 100) + "px" });
    $(".h3box1 li").css({ "width": liwidth + "px" });
    $(".h3box1 li a").css({ "width": liheight + "px", "height": liheight + "px", "line-height": liheight + "px", "margin-left": "-" + (liheight / 2) + "px" });

    var liwidth2 = (($(window).width() - 20 - $(".h3box2 li").length * 80) / $(".h3box2 li").length);
    if (liwidth2 > minwinheight) {
        liwidth2 = minwinheight;
    }
    $(".h3box2 li a").css({ "width": liwidth2 + "px" }); 
    $(".h3box3 li a").css({ "width": liwidth2 + "px" }); 
    $(document).on("click", "a[openlayer]", function () {
        var $t = $(this);
        var url = $t.attr("openlayer");

        var width = $(window).width() - 20;
        var height = $(window).height() - 20;
        LayerTemp = layer.open({
            title: false,
            closeBtn: false,
            resize: true,
            isOutAnim: true,
            offset: ['10px', '10px'],
            type: 2,
            area: [width + 'px', height + 'px'],
            fixed: false, //不固定
            maxmin: false,
            content: url,
            end: function () {
                getprolist();
            }
        });
    });
    getprolist();
});
function getprolist() {
    $.ajax({
        type: 'post',
        url: 'HomePM.aspx',
        data: { 'tt': "list" },
        success: function (data) { 
            var sdata = eval('(' + data + ')');
            var prohtml = [];
            for (var si in sdata.prolist) {
                var sdatai = sdata.prolist[si]; 
                var funCode = "";
                switch (sdatai.PROJECTSTAGE) {
                    case "拟投":
                        funCode = "NTK";
                        break;
                    case "已投":
                        funCode = "YTK";
                        break;
                };
                prohtml.push(renderRow(sdatai, '<li><p></p><a openlayer="ProBizFrame.aspx?funCode=' + funCode + '&CorrelationName={{PROJECTNAME}}&CorrelationCode={{K_AUTOID}}"><img src="img/fdir.png"/><p>' + sdatai.PROJECTNAME.replace("-", "<br />") + '</p></a></li>'));
            }
            $(".prolist").html(prohtml.join(''));
        }
    });
};
/*单行渲染*/
renderRow = function (datai, render) {
    var row = render;
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), datai[attr]);
    }
    return row;
};
/*数组渲染*/
render = function (data, render) {
    var tmp = [];
    for (var i = 0; i < data.length; i++) {
        var datai = data[i];//当前行 
        datai.datai = i;
        tmp.push(renderRow(datai, render));
    }
    return (tmp.join(''));
};