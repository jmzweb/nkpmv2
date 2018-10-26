//关闭弹窗
function CloseLayer() {
    setTimeout(function () { layer.close(LayerTemp) }, 300);
}
var LayerTemp = 0;
$(function () {
    $.ajax({
        type: 'post',
        url: 'HomePM.aspx',
        data: { 'tt': "list" },
        success: function (data) {
            var azcode = {};
            var sdata = eval('(' + data + ')');
            $(".prolistbox,.projd,.profx,.prolx,.prozm").empty();
            var projdhtml = ["<font>项目阶段：</font><span class='showtitle'>全部</span><div class='values' style='display:none;'><a class='select'><span>全部</span><b>(" + sdata.prolist.length + ")</b></a>"];
            var profxhtml = ["<font>项目风险等级：</font><span class='showtitle'>全部</span><div class='values' style='display:none;'><a class='select'><span>全部</span><b>(" + sdata.prolist.length + ")</b></a>"];
            var prolxhtml = ["<font>项目类别：</font><span class='showtitle'>全部</span><div class='values' style='display:none;'><a class='select'><span>全部</span><b>(" + sdata.prolist.length + ")</b></a>"];
            var prozmhtml = ["<font>所属地域：</font><span class='showtitle'>全部</span><div class='values' style='display:none;'><a class='select'><span>全部</span><b>(" + sdata.prolist.length + ")</b></a>"];

            var projd = { "拟投": 0, "已投": 0 };
            var profx = { "正常": 0, "关注": 0, "次级": 0, "可疑": 0, "损失": 0 };
            var prolx = { "股权类": 0, "担保类": 0, "融资租赁类": 0 };

            for (var proi in sdata.prolist) {
                var prodatai = sdata.prolist[proi];
                if (!azcode[prodatai.CITYD]) {
                    azcode[prodatai.CITYD] = { "list": ["<div class='prolist'><b class='atz'>", prodatai.CITYD, "</b>"], "count": 0 };
                }
                azcode[prodatai.CITYD].list.push("<div class='proitem' RISKGRADE='", prodatai.RISKGRADE, "' PROJECTSTAGE='", prodatai.PROJECTSTAGE,
                    "' PROJECTTYPE='", prodatai.PROJECTTYPE, "'><a href='javascript:void(0)' class='proname' cautoid='", prodatai.C_AUTOID, "' CORPCODE='", prodatai.CORPCODE, "' autoid='",
                    prodatai.K_AUTOID, "' PROJECTSTAGE='", prodatai.PROJECTSTAGE, "' PROJECTTYPE='", prodatai.PROJECTTYPE, "' proname='", prodatai.PROJECTNAME, "'>",
                    "<i class='iconfont fdir'>&#xe64c;</i>", prodatai.PROJECTNAME.replace("-", "<br />"),
                    "<i class='iconfont star star", prodatai.RISKGRADE, "'>&#xe6d7;</i><span>",
                    prodatai.PROJECTSTAGE, "</span></a></div>");

                azcode[prodatai.CITYD].count++;
                if (projd[prodatai.PROJECTSTAGE] != undefined) projd[prodatai.PROJECTSTAGE]++;
                if (profx[prodatai.RISKGRADE] != undefined) profx[prodatai.RISKGRADE]++;
                if (prolx[prodatai.PROJECTTYPE] != undefined) prolx[prodatai.PROJECTTYPE]++;
            }

            for (var azi in azcode) {//实际渲染
                var azdata = azcode[azi];
                azdata.list.push("</div>");
                $(".prolistbox").append(azdata.list.join(''));
                prozmhtml.push("<a><span>" + azi + "</span><b>(" + azdata.count + ")</b></a>");
            }
            prozmhtml.push("</div><i class='iconfont showmore'>&#xe674;</i>");
            $(".prozm").html(prozmhtml.join(''));
            for (var azi in projd) {//实际渲染
                var azdata = projd[azi];
                projdhtml.push("<a><span>" + azi + "</span><b>(" + azdata + ")</b></a>");
            }
            projdhtml.push("</div><i class='iconfont showmore'>&#xe674;</i>");
            $(".projd").html(projdhtml.join(''));

            for (var azi in profx) {//实际渲染
                var azdata = profx[azi];
                profxhtml.push("<a><span>" + azi + "</span><b>(" + azdata + ")</b></a>");
            }
            profxhtml.push("</div><i class='iconfont showmore'>&#xe674;</i>");
            $(".profx").html(profxhtml.join(''));

            for (var azi in prolx) {//实际渲染
                var azdata = prolx[azi];
                prolxhtml.push("<a><span>" + azi + "</span><b>(" + azdata + ")</b></a>");
            }
            prolxhtml.push("</div><i class='iconfont showmore'>&#xe674;</i>");
            $(".prolx").html(prolxhtml.join(''));
        }
    });
    $(document).on("click", "a.proname",
        function () {
            $(".clearline").remove();
            $(".ssfocus").removeClass("ssfocus");
            var $t = $(this);
            var autoid = $t.attr("autoid");
            var ultop = $t.offset().top + $t.height() + 10;
            var $next = $t.next(".linepoint");
            var $tp = $t.parent();
            var $tplist = $t.parents(".prolist");
            var isclearline = false;
            if ($next.length == 0) {
                $(".linepoint.opening").hide().removeClass("opening");
                $(".proname.select").removeClass("select");

                $.ajax({//如果没有加载过 就加载项目轴
                    type: 'post',
                    async: false,
                    url: 'HomePM.aspx',
                    data: { 'tt': "detail", 'autoid': autoid },
                    success: function (data) {
                        var ProjectStage = $t.attr("PROJECTSTAGE");
                        var funCode = "";
                        switch (ProjectStage) {
                            case "拟投":
                                funCode = "NTK";
                                break;
                            case "已投":
                                funCode = "YTK";
                                break;
                        };
                        var url = 'ProBizFrame.aspx?funCode=' + funCode + '&CorrelationName=' + $t.attr("proname") + '&CorrelationCode=' + autoid;

                        var sdata = eval('(' + data + ')');
                        var lphtml = ["<div class='linepoint linepoint" + $t.attr("PROJECTSTAGE") + "'><i class='iconfont imgsj'>&#xe6a3;</i><div class='probtns protop'><b>风险事件记录：</b>",
                        "<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_RiskInfo&cpro=CorrelationCode=" + autoid + "^1|CorrelationName=" + $t.attr("proname") + "^1&sindex=1'>添加风险事件</a></div>"];
                        //"<div class='probtns protop'><b>关键信息记录：</b>\
                        //<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_T_ManagerTeam&cpro=CorrelationCode=" + autoid + "^1'>添加管理团队</a>\
                        //<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_RiskInfo&cpro=CorrelationCode=" + autoid + "^1|CorrelationName=" + $t.attr("proname") + "^1&sindex=1'>添加风险事件</a>"];

                        //if ($t.attr("PROJECTTYPE") == "股权类") {
                        //    lphtml.push("<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_Valuation&cpro=CorrelationCode=" + autoid + "^1'>添加项目估值</a>\
                        //    <a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_Compact&cpro=CorrelationCode=" + autoid + "^1'>添加投资协议</a>\
                        //    <a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_A_Earning&cpro=CorrelationCode=" + autoid + "^1'>添加项目收益</a>\
                        //    <a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?TblName=T_PM_P_A_DJG&cpro=CorrelationCode=" + autoid + "^1'>添加委派董监高</a>");
                        //}
                        //lphtml.push("<a href='javascript:void(0)' openlayer='" + url + "'>编辑项目详情</a>\
                        //    <a href='javascript:void(0)' openlayer='BizFrame.aspx?funCode=CBK&CorpID=" + $t.attr("CORPCODE") + "&CorrelationCode=" + $t.attr("cautoid") + "'>编辑企业详情</a>");

                        if (ProjectStage == "拟投") {
                            lphtml.push("<ul class='lineul'>");
                            lphtml.push(render(sdata.proinfo, "<li class='select{{REVIEWERSTATE}}'><p class='plinel'></p><p class='pliner'></p><i class='iconfont'>&#xe6f5;</i>\
                            <a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?{{TBLPARA}}&biz=1&maincol=CorrelationCode&cpro=CorrelationCode=" + autoid +
                                    "^1|Node={{FUNCTIONALNODE}}^1' title='点击添加 {{FUNCTIONALNODE}} 事件记录'>{{FUNCTIONALNODE}}</a>\
                            <span>{{STARTTIME}}</span></li>"));
                            lphtml.push("</ul></div>");
                            $t.after(lphtml.join(''));

                            $next = $t.next(".linepoint");
                            $next.find("li.select通过,li.select暂缓,li.select终止").last().prevAll("li.select").addClass("select跳过");
                        } else if (ProjectStage == "已投") {
                            var thtitle = "投后";
                            if ($t.attr("PROJECTTYPE") == "担保类") {
                                thtitle = "保后";
                            } else if ($t.attr("PROJECTTYPE") == "融资租赁类") {
                                thtitle = "租中";
                            }
                            lphtml.push("<div class='probtns'><b>", thtitle, "事件记录：</b>");
                            lphtml.push(render(sdata.proinfoa, "<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?{{TBLPARA}}&biz=1&maincol=CorrelationCode&cpro=CorrelationCode=" + autoid +
                                    "^1|Node={{FUNCTIONALNODE}}^1' title='点击添加 {{FUNCTIONALNODE}} 记录'>{{FUNCTIONALNODE}}</a>"));
                            lphtml.push("</div>");

                            //lphtml.push("<div class='clear'></div><ul class='lineul'>");
                            //lphtml.push(render(sdata.proinfo, "<li class='select{{REVIEWERSTATE}}'><p class='plinel'></p><p class='pliner'></p><i class='iconfont'>&#xe6f5;</i>\
                            //<a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?{{TBLPARA}}&biz=1&maincol=CorrelationCode&cpro=CorrelationCode=" + autoid +
                            //        "^1|Node={{FUNCTIONALNODE}}^1' title='点击补充 {{FUNCTIONALNODE}} 事件记录'>{{FUNCTIONALNODE}}</a>\
                            //<span>{{STARTTIME}}</span></li>"));
                            //lphtml.push("</ul>");

                            lphtml.push("</div>");

                            $t.after(lphtml.join(''));
                            $next = $t.next(".linepoint");
                            $next.find("li.select通过,li.select暂缓,li.select终止").last().prevAll("li.select").addClass("select跳过");
                        }
                    }
                });
                $next = $t.next(".linepoint");
                var liwidth = 100 / $next.find("li").length;
                $next.find("li").width(liwidth + "%");

                var imgleft = $t.offset().left + ($t.width() / 2) - 15;
                $next.show().addClass("opening").css({ "top": ultop });
                $t.addClass("select");
                $next.children(".imgsj").css({ "left": imgleft });
                isclearline = true;
            } else {//如果没加载过 就加载轴 
                if ($next.hasClass("opening")) {
                    $next.hide().removeClass("opening");
                    $t.removeClass("select");
                } else {
                    $(".linepoint.opening").hide().removeClass("opening");
                    $(".proname.select").removeClass("select");
                    $next.show().addClass("opening");
                    $t.addClass("select");
                    isclearline = true;
                }
            }
            if (isclearline) {
                var rowcount = parseInt(($(window).width() - 30) / ($tp.width() + 30));
                var tgdiv = ((parseInt(($tp.index() - 1) / rowcount) + 1) * rowcount) - 1;

                if (tgdiv > ($tplist.find(".proitem").length - 1)) {
                    $tplist.find(".proitem").last().after("<div class='clearline clearline" + $t.attr("PROJECTSTAGE") + "'></div>");
                } else {
                    $tplist.find(".proitem").eq(tgdiv).after("<div class='clearline clearline" + $t.attr("PROJECTSTAGE") + "'></div>");
                }
                $(window).scrollTop(ultop - 300);
            }
        }).on("click", "a[openlayer]",
    function () {
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
                //待处理逻辑 关闭后刷新轴
                if ($t.parents(".lineul").length > 0) {
                    var $proname = $t.parents(".proitem").removeClass("opening").find(".proname");
                    $t.parents(".linepoint").remove();
                    $proname.trigger("click");
                }
            }
        });
    });

    var searchkey = "";
    var searchlength = 0;
    var searchindex = 0;
    $('.searchbtn').click(function () {//查找关键字
        if (searchkey != $("#searchkey").val()) {
            searchkey = $("#searchkey").val();
            searchlength = $(".proname:contains('" + searchkey + "')").length;
            searchindex = 0;
        }
        if (searchkey) {
            if (searchindex < searchlength) {
                var $tg = $(".proname:contains('" + searchkey + "')").eq(searchindex);
                $(".ssfocus").removeClass("ssfocus");
                $tg.addClass("ssfocus");
                var stop = $tg.position().top;
                $(window).scrollTop(stop - 130);
                searchindex++;
            }
        }
    });
    $("#searchkey").keydown(function (e) {//回车切换焦点
        if (e.keyCode == 13) {
            $('.searchbtn').trigger("click");
        }
    });
    $(document).on('click', '.prozm a', function () {//AZ控制 
        $(".ssfocus").removeClass("ssfocus");
        $(this).addClass("select").siblings().removeClass("select");
        var txt = $(this).children("span").text();
        var $t = $(".atz:contains('" + txt + "')");
        if ($(this).children("span").text() == "全部") {
            $(".prolist").show();
        }
        else {
            $t.parent().show().siblings().hide();
        }
        $(this).parent().hide();
        $(this).parent().siblings(".showtitle").text(txt);
    });
    $(document).on('click', '.projd a,.profx a,.prolx a', function () {//进度类型风险筛选  
        $(this).addClass("select").siblings().removeClass("select");
        setproitem();

        var txt = $(this).children("span").text();
        $(this).parent().hide();
        $(this).parent().siblings(".showtitle").text(txt);
    }).on('click', '.showmore,.showtitle', function () {//进度类型风险筛选  
        $(this).siblings(".values").toggle();
    });
});

function setproitem() {
    $(".linepoint.opening").hide().removeClass("opening");
    $(".clearline").remove();
    $(".ssfocus").removeClass("ssfocus");
    var whereattr = "";
    var jdtxt = $('.projd a.select').children("span").text();
    var fxtxt = $('.profx a.select').children("span").text();
    var lxtxt = $('.prolx a.select').children("span").text();
    if (jdtxt != "全部") {
        whereattr += "[PROJECTSTAGE='" + jdtxt + "']";
    }
    if (fxtxt != "全部") {
        whereattr += "[RISKGRADE='" + fxtxt + "']";
    }
    if (lxtxt != "全部") {
        whereattr += "[PROJECTTYPE='" + lxtxt + "']";
    }
    $(".proitem").hide();
    $(".proitem" + whereattr).show();
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