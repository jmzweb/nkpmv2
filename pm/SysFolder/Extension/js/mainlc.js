function CloseLayer() {
    setTimeout(function () {
        layer.close(LayerTemp);
    }, 300);
};
function OpenLayer(url, $t) {
    var spacew = 80;
    var spaceh = 80;
    if ($t) {
        if ($t.attr("owidth")) {
            if (parseInt($t.attr("owidth")) < $(window).width()) {
                spacew = $(window).width() - parseInt($t.attr("owidth"));
            }
        }
        if ($t.attr("oheight")) {
            if (parseInt($t.attr("oheight")) < $(window).height()) {
                spaceh = $(window).height() - parseInt($t.attr("oheight"));
            }
        }
    }
    var width = $(window).width() - spacew;
    var height = $(window).height() - spaceh;
    var offsetw = spacew / 2;
    var offseth = spaceh / 2;
    LayerTemp = layer.open({
        title: false,
        closeBtn: true,
        resize: true,
        isOutAnim: true,
        offset: [offseth + 'px', offsetw + 'px'],
        type: 2,
        area: [width + 'px', height + 'px'],
        fixed: false, //不固定
        maxmin: false,
        content: url
    });
};
var LayerTemp = 0;
var myChart;
var option;
var optioncn;
var maptype = "1";
$(function () {
    $(document).on("click", "a[openlayer]", function () {
        var $t = $(this);
        var url = $t.attr("openlayer");
        OpenLayer(url, $t);
    });

    $(window).resize(initlayout);//加载页面布局
    initlayout();//加载页面布局

    if (ajaxtt == "db") {
        //担保的显示为 在保 代偿 
        $(".mainlcbox").append("<div class='changemap'><a value='1' href='javascript:void(0)' class='hover'>在保</a><a value='11' href='javascript:void(0)'>代偿</a></div>");
    } else {
        $(".mainlcbox").append("<div class='changemap'><a value='1' href='javascript:void(0)' class='hover'>省内</a><a value='2' href='javascript:void(0)'>全国</a></div>");
    }
    $(document).on("click", ".changemap a", function () {
        var $t = $(this);
        maptype = $t.attr("value");
        $t.addClass("hover").siblings().removeClass("hover");
        initlayout();
    });


    if ($("#PosList option").length > 2) {
        $("#PosList").on("change", function () {
            var url = getLocationUrl().indexOf("?") > -1 ? getLocationUrl() + "&relationId=" + $(this).val() : getLocationUrl() + "?relationId=" + $(this).val();
            window.location.href = url;
        });
    } else {
        $("#PosList").hide();
    }
});
function initlayout() {//加载页面布局
    var ww = $(window).width();
    var wh = $(window).height();
    if ($(".mainechartbox").length > 0) {
        var wh6 = wh - 280;//60%的主界面
        var hfw = (ww - wh6 - 60) / 2;
        if (maptype == "2") {
            $("#main").width(wh6).height(wh6 * 0.8).css({ "padding": "" + (wh6 - (wh6 * 0.8)) / 2 - 10 + "px 0px" });//全国
        } else {
            $("#main").width(wh6).height(wh6 - 20).css({ "padding": "0px" });//省内 
        }
        $(".mainechartbox").css({ "width": wh6 + 20 + "px", "height": (wh6 - 20) + "px", "margin-left": "-" + (wh6 / 2) - 10 + "px" });
        $(".hfbox").width(hfw - 10).height(wh6);//两侧

        $(".fxinfo .titlelcbox").width(wh6 + 20).css("left", (hfw + 2) + "px");//风险总览宽为主宽
        $(".fxshow").width(hfw - 30);//风险总览宽为一半的2/3
        $(".fxlist").width(wh6 + 80);//风险列表
        $(".jjlist").height(wh6 - 237);//基金列表
        $(".xmlist").height(wh6 - 237);//项目列表173
        $(".showother a").width(((hfw - 80) / $(".showother a").length));//风险列表
    } else {
        var wh6 = wh - 120;//60%的主界面
        var ww4 = (ww - 440);
        if (maptype == "2") {
            $("#main").width(wh6 * 1.25).height(wh6).css({ "margin-left": "" + (ww4 - (wh6 * 1.25)) / 2 + "px" });//全国
        } else {
            $("#main").width(wh6).height(wh6).css({ "margin-left": "" + (ww4 - wh6) / 2 + "px" });//省内 
        }
        $(".mainechartboxzq").css({ "width": ww4 + "px", "height": (wh6) + "px" });
        $(".hfbox").width(400).height(wh6);//两侧
        $(".xmlist").height(wh6 - 217);//项目列表173
    }
    initdatas();//加载数据
};
var maxpage = "GQProReportmax";
var relationId = "relationId=" + GetQueryString("relationId");
function initdatas() {//加载数据 
    $.ajax({
        type: 'post',
        url: 'MainLc.aspx',
        data: { 'tt': ajaxtt, 'relationId': GetQueryString("relationId") },
        success: function (data) {
            var ret = eval('(' + data + ')');
            var xmlb = "";
            if (ajaxtt == "ss") {//股权类
                xmlb = "股权类";
                $(".jjsldata").text(ret.jjinfo.jjsl || "0");//基金数量
                $(".jjgmdata").text(ret.jjinfo.jjgm || "0");
                $(".sjdwdata").text(ret.jjinfo.sjdw || "0");
                $(".ytjedata").text(ret.jjinfo.ytje || "0");
                $(".jjfpdata").text(ret.jjinfo.jjfp || "0");
                for (var jji in ret.jjinfo.jjlist) {
                    var datajji = ret.jjinfo.jjlist[jji];
                    if (datajji.YTBL > 100) {
                        datajji.YTBLW = "100";
                    } else {
                        datajji.YTBLW = datajji.YTBL;
                    }
                }
                $(".jjlistdata").html(render(ret.jjinfo.jjlist, "<tr><td><a href='javascript:void(0)' openlayer='SysFolder/Extension/BizFrame.aspx?funCode=JJKCK&CorrelationCode={{K_AUTOID}}&FundID={{FUNDCODE}}'>{{FUNDABBR}}</a></td><td><div class='ratiobox'><div class='ratiovalue' style='width:{{YTBLW}}%'><span class='ratio'>{{YTBL}}</span></div></div> </td></tr>"));
                var jjcanshow = parseInt(($(".jjlist").height() - 40) / 38) - 1;
                $(".jjlistdata tr").eq(jjcanshow).nextAll().hide();
            } else if (ajaxtt == "db") {//担保类
                xmlb = "担保类";
                maxpage = "DBProReportmax";
                $(".dballdata").text(ret.bminfo.dball || "0");
                $(".dballphdata").text(ret.bminfo.dballph || "0");
                if ($(".dbxmlistdata").length > 0) {//总部看担保
                    $(".bmlistdata").html(render(ret.bminfo.bmlist, "<li><a href='javascript:void(0)' openlayer='WorkAsp/Report/DBProReportmax.aspx?depname={{BELONGDEPTNAME}}&" + relationId + "'><b style=''><font class='comdify2'>{{GUARANTEEMONEY}}</font>亿</b><p>{{BELONGDEPTNAME}}</p></a></li>"));
                    $(".dbxmlistdata").html(render(ret.bminfo.dbxmlist, "<tr><td><a href='javascript:void(0)' openlayer='SysFolder/Extension/BizFrame.aspx?funCode=XMKCK&CorrelationCode={{K_AUTOID}}&readonly=1' >{{PROJECTNAME}}</a></td><td><span class='comdify'>{{GUARANTEEMONEY}}</span></td></tr>"));
                } else {//担保公司
                    $(".bmlistdata").html(render(ret.bminfo.bmlist, "<li><a href='javascript:void(0)' openlayer='WorkAsp/Report/DBProReportmax.aspx?depname={{BELONGDEPTNAME}}&" + relationId + "'><b style=''><font class='comdify2'>{{GUARANTEEMONEY}}</font>亿</b><p>{{BELONGDEPTNAME}}</p></a></li>"));
                    $(".xmjllistdata").html(render(ret.bminfo.xmjllist, "<tr><td><a href='javascript:void(0)' openlayer='WorkAsp/Report/DBProReportmax.aspx?proname={{PROMANAGE}}&" + relationId + "'>{{PROMANAGE}}</a></td><td><span class='comdify'>{{GUARANTEEMONEY}}</span></td></tr>"));
                }
                $(".bmlistdata li").width((100 / $(".bmlistdata li").length) + "%");
                var jjcanshow = parseInt(($(".jjlist").height() - 40) / 38) - 1;
                $(".xmjllistdata tr").eq(jjcanshow).nextAll().hide();
            } else if (ajaxtt == "zl") {//租赁类
                xmlb = "融资租赁类";
                maxpage = "ZLProReportmax";
                $(".dballdata").text(ret.bminfo.zlall || "0");
                if ($(".zlxmlistdata").length > 0) {//总部看担保
                    $(".bmlistdata").html(render(ret.bminfo.bmlist, "<li><a href='javascript:void(0)' openlayer='WorkAsp/Report/" + maxpage + ".aspx?depname={{BELONGDEPTNAME}}&" + relationId + "'><b style=''><font class='comdify2'>{{LEASEMONEY}}</font>亿</b><p>{{BELONGDEPTNAME}}</p></a></li>"));
                    $(".zlxmlistdata").html(render(ret.bminfo.zlxmlist, "<tr><td><a href='javascript:void(0)' openlayer='SysFolder/Extension/BizFrame.aspx?funCode=XMKCK&CorrelationCode={{K_AUTOID}}&readonly=1' >{{PROJECTNAME}}</a></td><td><span class='comdify'>{{LEASEMONEY}}</span></td></tr>"));
                } else {//担保公司
                    $(".bmlistdata").html(render(ret.bminfo.bmlist, "<li><a href='javascript:void(0)' openlayer='WorkAsp/Report/" + maxpage + ".aspx?depname={{BELONGDEPTNAME}}&" + relationId + "'><b style=''><font class='comdifymin'>{{LEASEMONEY}}</font>万</b><p>{{BELONGDEPTNAME}}</p></a></li>"));
                    $(".xmjllistdata").html(render(ret.bminfo.xmjllist, "<tr><td><a href='javascript:void(0)' openlayer='WorkAsp/Report/" + maxpage + ".aspx?proname={{PROMANAGE}}&" + relationId + "'>{{PROMANAGE}}</a></td><td><span class='comdify'>{{LEASEMONEY}}</span></td></tr>"));
                }
                $(".bmlistdata li").width((100 / $(".bmlistdata li").length) + "%");
                var jjcanshow = parseInt(($(".jjlist").height() - 40) / 38) - 1;
                $(".xmjllistdata tr").eq(jjcanshow).nextAll().hide();
            }
            $(".xmlistdata").html(render(ret.xminfo.xmlist, "<tr><td><a href='javascript:void(0)' openlayer='SysFolder/Extension/BizFrame.aspx?funCode=XMKCK&CorrelationCode={{K_AUTOID}}&readonly=1' title='{{PROJECTNODE}} {{K_UPDATETIME}}'>{{PROJECTNAME}}</a></td><td>{{BELONGCORPNAME}}</td><td dateformat='MM-dd'>{{K_UPDATETIME}}</td></tr>"));
            //项目信息
            $(".cbkdata").text(ret.xminfo.cbxm || "0");
            $(".ntkdata").text(ret.xminfo.ntxm || "0");
            $(".ytkdata").text(ret.xminfo.ytxm || "0");
            $(".ytkdcdata").text(ret.xminfo.ytxmdc || "0");
            $(".tckdata").text(ret.xminfo.tcxm || "0");
            $(".xmkdata").text(parseInt(ret.xminfo.ntxm || "0") + parseInt(ret.xminfo.ytxm || "0") + parseInt(ret.xminfo.tcxm || "0"));
            var xmcanshow = parseInt(($(".xmlist").height() - 40) / 38) - 1;
            $(".xmlistdata tr").eq(xmcanshow).nextAll().hide();

            //风险信息
            $(".fxshow").html(render(ret.fxinfo.fxlb, "<li><a href='javascript:void(0)' openlayer='SysFolder/AppFrame/AppQuery.aspx?TblName=Q_PM_P_RiskInfo&condition=ProjectStage!=[QUOTES]退出[QUOTES] and PROJECTTYPE=[QUOTES]" + xmlb + "[QUOTES] and RiskType like [QUOTES]%{{name}}%[QUOTES]&checkoutshow=1&" + relationId + "'><b style=''><font class='fxcount'>{{count}}</font>个</b><p><font class='fxlb'>{{name}}</font></p></a></li>"));
            $(".fxlist").html(render(ret.fxinfo.fxsj, "<li><a href='javascript:void(0)' openlayer='SysFolder/AppFrame/AppDetail.aspx?TblName=T_PM_P_RiskInfo&mainId={{K_AUTOID}}' title='{{RISKNAME}} {{CORRELATIONNAME}}'><span class='star{{RISKGRADE}}'>★</span> <b>【{{RISKTYPE}}】</b> <i class='fxtime'>{{RISKEVENTTIME}}</i> {{RISKNAME}} <span>{{CORRELATIONNAME}}</span></a></li>"));

            var $lis = $(".fxlist li");
            var maxshow = 3;
            var linow = 0;
            var lilength = $lis.length;
            if (lilength > maxshow) {
                setInterval(function () {
                    if (linow <= lilength - maxshow) {//如果到最大长度 就重置
                        $lis.eq(linow).prevAll().height(0);
                        linow++;
                    } else {
                        $lis.hide().height(37).show();
                        linow = 0;
                    }
                }, 3000);
            }

            //处理时间
            $(".fxtime").each(function (ci, cv) {
                $(cv).text(crtTimeFtt($(cv).text()));
            });
            //处理千分位 
            $(".comdify").each(function (ci, cv) {
                $(cv).text(comdify($(cv).text()));
            });
            //处理千分位 紧凑型
            $(".comdifymin").each(function (ci, cv) {
                $(cv).text(comdifymin($(cv).text()));
            });

            //转化单位为亿元
            $(".comdify2").each(function (ci, cv) {
                $(cv).text(comdify2($(cv).text()));
            });

            //转化单位为亿元
            $("td[dateformat]").each(function (ci, cv) {
                $(cv).text(todateformat($(cv).text(), $(cv).attr("dateformat")));
            });
            //处理比例
            $(".ratio").each(function (ci, cv) {
                var txt = $(cv).text();
                if (txt) {
                    if (txt == "0" || txt == "非数字" || txt == "正无穷大") {
                        $(cv).text("");
                    } else {
                        $(cv).text($(cv).text() + "%");
                    }
                }
            });
            var dymax = 0;
            for (var dmi in ret.xminfo.dyfb) {
                var datami = ret.xminfo.dyfb[dmi];
                if (parseInt(datami.value) > dymax)
                    dymax = parseInt(datami.value);
            }
            var dymaxdc = 0;
            for (var dmi in ret.xminfo.dyfbdc) {
                var datami = ret.xminfo.dyfbdc[dmi];
                if (parseInt(datami.value) > dymax)
                    dymaxdc = parseInt(datami.value);
            }
            var dymaxcn = 0;
            for (var dmi in ret.xminfo.dyfbcn) {
                var datami = ret.xminfo.dyfbcn[dmi];
                switch (datami.name) {
                    case "内蒙古自治区":
                        datami.name = "内蒙古";
                        break;
                    case "黑龙江省":
                        datami.name = "黑龙江";
                        break;
                    default:
                        datami.name = datami.name.substr(0, 2);
                        break;
                }
                if (parseInt(datami.value) > dymaxcn)
                    dymaxcn = parseInt(datami.value);
            }
            var mapfontsize = 20;
            if ($(window).width() < 1600) {
                mapfontsize = 16;
            }
            if ($(window).width() < 1400) {
                mapfontsize = 12;
            }
            option = {
                tooltip: {
                    trigger: 'item'
                },
                visualMap: {
                    min: 0,
                    max: dymax,
                    left: 'left',
                    top: 'bottom',
                    text: ['高', '低'], // 文本，默认为数值文本
                    calculable: true,
                    textStyle: {
                        color: '#ffffff'
                    }
                },
                series: [
                    {
                        name: '项目地域分布',
                        type: 'map',
                        mapType: '河南',
                        left: '10px',
                        right: '10px',
                        top: '10px',
                        bottom: '10px',
                        roam: false,
                        label: {
                            normal: {
                                show: true,
                                fontSize: mapfontsize,
                                formatter: function (params) {
                                    var ns = "";
                                    var bfk = "";
                                    var afk = "";
                                    switch (params.name) {
                                        case "三门峡市":
                                            ns = "\n\n\n\n\n";
                                            afk = "　　　";
                                            break;
                                        case "济源市":
                                            ns = "\n";
                                            afk = "　";
                                            break;
                                        case "焦作市":
                                            ns = "\n\n";
                                            afk = "　";
                                            break;
                                        case "安阳市":
                                            ns = "\n";
                                            afk = "　　　";
                                            break;
                                        case "鹤壁市":
                                            ns = "\n";
                                            break;
                                        case "濮阳市":
                                            bfk = "　";
                                            break;
                                        case "新乡市":
                                            ns = "\n";
                                            bfk = "　　";
                                            break;
                                        case "商丘市":
                                            ns = "\n";
                                            break;
                                        case "洛阳市":
                                            ns = "\n\n\n\n";
                                            afk = "　　　　";
                                            break;
                                        case "郑州市":
                                            ns = "\n\n";
                                            afk = "　";
                                            break;
                                        case "开封市":
                                            ns = "\n\n";
                                            bfk = "　　";
                                            break;
                                        case "平顶山市":
                                            ns = "";
                                            afk = "　　　";
                                            break;
                                        case "许昌市":
                                            afk = "　";
                                            break;
                                        case "周口市":
                                            bfk = "　　";
                                            break;
                                        case "信阳市":
                                            bfk = "　　　　　　　　";
                                            break;
                                    }
                                    return ns + bfk + params.name.replace("市", "") + afk + "\n" + bfk + "（" + (params.value || "0") + "）" + afk;
                                }
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        animation: false,
                        data: ret.xminfo.dyfb
                    }
                ]
            };
            optiondc = {
                tooltip: {
                    trigger: 'item'
                },
                visualMap: {
                    min: 0,
                    max: dymaxdc,
                    left: 'left',
                    top: 'bottom',
                    text: ['高', '低'], // 文本，默认为数值文本
                    calculable: true,
                    textStyle: {
                        color: '#ffffff'
                    }
                },
                series: [
                    {
                        name: '项目地域分布',
                        type: 'map',
                        mapType: '河南',
                        left: '10px',
                        right: '10px',
                        top: '10px',
                        bottom: '10px',
                        roam: false,
                        label: {
                            normal: {
                                show: true,
                                fontSize: mapfontsize,
                                formatter: function (params) {
                                    var ns = "";
                                    var bfk = "";
                                    var afk = "";
                                    switch (params.name) {
                                        case "三门峡市":
                                            ns = "\n\n\n\n\n";
                                            afk = "　　　";
                                            break;
                                        case "济源市":
                                            ns = "\n";
                                            afk = "　";
                                            break;
                                        case "焦作市":
                                            ns = "\n\n";
                                            afk = "　";
                                            break;
                                        case "安阳市":
                                            ns = "\n";
                                            afk = "　　　";
                                            break;
                                        case "鹤壁市":
                                            ns = "\n";
                                            break;
                                        case "濮阳市":
                                            bfk = "　";
                                            break;
                                        case "新乡市":
                                            ns = "\n";
                                            bfk = "　　";
                                            break;
                                        case "商丘市":
                                            ns = "\n";
                                            break;
                                        case "洛阳市":
                                            ns = "\n\n\n\n";
                                            afk = "　　　　";
                                            break;
                                        case "郑州市":
                                            ns = "\n\n";
                                            afk = "　";
                                            break;
                                        case "开封市":
                                            ns = "\n\n";
                                            bfk = "　　";
                                            break;
                                        case "平顶山市":
                                            ns = "";
                                            afk = "　　　";
                                            break;
                                        case "许昌市":
                                            afk = "　";
                                            break;
                                        case "周口市":
                                            bfk = "　　";
                                            break;
                                        case "信阳市":
                                            bfk = "　　　　　　　　";
                                            break;
                                    }
                                    return ns + bfk + params.name.replace("市", "") + afk + "\n" + bfk + "（" + (params.value || "0") + "）" + afk;
                                }
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        animation: false,
                        data: ret.xminfo.dyfbdc
                    }
                ]
            };
            optioncn = {
                tooltip: {
                    trigger: 'item'
                },
                visualMap: {
                    min: 0,
                    max: dymaxcn,
                    left: 'left',
                    top: 'bottom',
                    text: ['高', '低'], // 文本，默认为数值文本
                    calculable: true,
                    textStyle: {
                        color: '#ffffff'
                    }
                },
                series: [
                    {
                        name: '项目地域分布',
                        type: 'map',
                        mapType: 'china',
                        left: '10px',
                        right: '10px',
                        top: '10px',
                        bottom: '10px',
                        roam: false,
                        label: {
                            normal: {
                                show: true,
                                fontSize: 12,
                                formatter: function (params) {
                                    var ns = "";
                                    var ans = "";
                                    var bfk = "";
                                    var afk = "";
                                    switch (params.name) {
                                        case "河南":
                                            ns = "\n\n";
                                            break;
                                        case "宁夏":
                                            ns = "\n\n";
                                            break;
                                        case "浙江":
                                            ns = "\n\n";
                                            break;
                                        case "江西":
                                            ns = "\n\n";
                                            break;
                                        case "海南":
                                            afk = "    ";
                                            ns = "\n\n\n";
                                            break;
                                        case "台湾":
                                            ns = "\n\n\n";
                                            break;
                                        case "香港":
                                            ns = "\n\n";
                                            break;
                                        case "澳门":
                                            ns = "\n\n";
                                            break;
                                        case "内蒙古":
                                            ans = "\n\n";
                                            break;
                                        case "黑龙江":
                                            ans = "\n\n";
                                            break;
                                        case "青海":
                                            afk = "          ";
                                            break;
                                        case "湖北":
                                            afk = "     ";
                                            break;
                                        case "湖南":
                                            afk = "     ";
                                            break;
                                        case "福建":
                                            afk = "          ";
                                            break;
                                        case "河北":
                                            bfk = "     ";
                                            break;
                                        case "山东":
                                            bfk = "     ";
                                            break;
                                        case "江苏":
                                            bfk = "    ";
                                            ans = "\n\n\n";
                                            break;
                                        case "上海":
                                            afk = "     ";
                                            ans = "\n";
                                            break;
                                    }
                                    return ns + bfk + params.name + afk + "\n" + bfk + "（" + (params.value || "0") + "）" + afk + ans;
                                }
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        animation: false,
                        data: ret.xminfo.dyfbcn
                    }
                ]
            };
            // 基于准备好的dom，初始化echarts实例
            if (!myChart) {
                myChart = echarts.init(document.getElementById('main'), 'westeros');
                // 使用刚指定的配置项和数据显示图表。
                myChart.on('click', function eConsole(param) {
                    //这个params可以获取你要的饼图中的当前点击的项的参数
                    //城市名称 点击后可穿透到项目列表页 传城市名称的参数(param.name);
                    clearTimeout(maptimer);
                    maptimer = setTimeout(function () {
                        var url = "WorkAsp/Report/" + maxpage + ".aspx?cityd=" + param.name + "&" + relationId;
                        if (maptype == "2")
                            url = "WorkAsp/Report/" + maxpage + ".aspx?provinced=" + param.name + "&" + relationId;
                        OpenLayer(url);
                    }, 100);
                });
            } else {
                myChart.resize();
            }
            if (maptype == "1")
                myChart.setOption(option, true);
            else if (maptype == "11")
                myChart.setOption(optiondc, true);
            else
                myChart.setOption(optioncn, true);
        }
    });
};

var maptimer;

//格式化时间
function crtTimeFtt(val) {
    if (val != null) {
        var date = new Date(val);
        return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
    }
}


function comdify(n) {//处理千分位 
    if (!n || n == "0")//如果n为空 就直接返回0
        return "";

    var wn = parseFloat(n + "");
    wn = (wn / 10000.00).toFixed(2);//转换为万元单位

    var re = /\d{1,3}(?=(\d{3})+$)/g;
    return (wn + "").replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });

    return n1;
};

function comdifymin(n) {//处理千分位 紧凑型
    if (!n || n == "0")//如果n为空 就直接返回0
        return "";

    var wn = parseFloat(n + "");
    wn = (wn / 10000.00).toFixed(0);//转换为万元单位 

    return wn;
};
function comdify2(n) {//转换为亿单位
    if (!n || n == "0")//如果n为空 就直接返回0
        return "";

    var wn = parseFloat(n + "");
    wn = (wn / 100000000.00).toFixed(2);//转换为亿单位

    var re = /\d{1,3}(?=(\d{3})+$)/g;
    return (wn + "").replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });

    return n1;
};
/*单行渲染*/
function renderRow(datai, render) {
    var row = render;
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), datai[attr]);
    }
    return row;
};
/*数组渲染*/
function render(data, render) {
    var tmp = [];
    for (var i = 0; i < data.length; i++) {
        var datai = data[i];//当前行 
        datai.datai = i;
        tmp.push(renderRow(datai, render));
    }
    return (tmp.join(''));
};
function todateformat(value, dateformat) {
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
            return dateformat;
        } else if (regdate.test(value) && value.toString().length < 20) {
            var result = value.match(regdate);
            dateformat = dateformat.replace("yyyy", result[1]); //代表年
            dateformat = dateformat.replace("MM", result[2]);   //代表月
            dateformat = dateformat.replace("dd", result[3]);   //代表日  
            return dateformat;
        }
    }
    return value;
};



function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return (r[2]); return "";
}


function getLocationUrl() {
    var url = "MainLcgq.aspx";
    var Request = GetRequest();
    for (var Key in Request) {
        if (Key != "relationId") {
            url += (url.indexOf("?") > -1 ? ("&" + Key + "=" + Request[Key]) : ("?" + Key + "=" + Request[Key]));
        }

    }
    return url;
}

function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串  
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return (r[2]); return "";
}