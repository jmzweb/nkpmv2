<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FnEdit.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.FnEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="/iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>
    <script type="text/javascript" src="../../js/echarts.min.js"></script>

    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

</head>
<body>
    <script src="../../js/p.WdatePicker.js"></script>
    <form id="cwqkzcAdd" class="cform formtable">
        <div class="menubar" style="height: 170px;">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" id="search">统计</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                    <em class="split">|</em>
                    <a class='linkbtn changetu' type="bar" href="javascript:">柱状图</a>
                    <a class='linkbtn changetu' type="line" href="javascript:">拆线图</a>
                </span>
            </div>
        </div>
        <div class="fixtop">
            <table border="0" cellpadding="0" cellspacing="12" class="" style="width: auto; float: left; margin: 10px 0 15px 10px;">
                <tr>
                    <td style="width: 80px; text-align: right;">财报类型：</td>
                    <td style="width: 230px">
                        <input id="cblx" type="text" rule="length:25" class="cselectorRadio" mode=""
                            values="年报,半年报,季报,月报" conchange="lxconchange()" />

                    </td>
                    <td class="wfs4" style="width: 55px; text-align: right;">年度：</td>
                    <td class="" style="width: 200px">
                        <input id="nian" type="text" rule="length:25" onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                    <td class="jdhide nb1">~</td>
                    <td class="jdhide nb1" style="width: 200px">
                        <input id="nian2" type="text" rule="length:25" onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                </tr>
            </table>
            <div class="subtitlespt hide">
                <div class="tabbtns subbtns sub2"><a>财务概况</a><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div>
            </div>
        </div>
    </form>
    <div class="reportbox hide">
        <div class="tabbox">
            <div class="tabitem tabitem2">
                <h3>成长性指标</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 30%;">
                                <div class="wBody" style="height: 300px;" id="Data1">
                                </div>
                            </td>
                            <td style="width: 30%;">
                                <div class="wBody" style="height: 300px;" id="Data2">
                                </div>
                            </td>
                            <td style="width: 30%;">

                                <div class="wBody" style="height: 300px;" id="Data3">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>盈利能力指标</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data4">
                                </div>
                            </td>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data5">
                                </div>
                            </td>

                        </tr>
                    </table>
                </div>
                <h3>偿债能力</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data6">
                                </div>
                            </td>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data7">
                                </div>
                            </td>

                        </tr>
                    </table>
                </div>
            </div>
            <div class="tabitem tabitem2 tabhtml1">
            </div>
            <div class="tabitem tabitem2 tabhtml2">
            </div>
            <div class="tabitem tabitem2 tabhtml3">
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function lxconchange($t, $input, $id) {
            $(".hide").hide();
            if ($id.val() == "年报" || $id.val() == "半年报") {
                $('.nb1').show();
                $('.nb2').show();
            } else {
                $('.nb1').hide()
            }
        };
        $(function () {
            $(".sub2 a").click(function () {
                $(this).addClass("select").siblings().removeClass("select");
                $(".tabitem2").eq($(this).index()).show().siblings().hide();
            });
            $(".sub2 a").first().trigger("click");
            $('#search').click(function () {
                SearchData();
            });
            $('.changetu').click(function () {
                chattype = $(this).attr("type");
                SearchData();
            });
        });
        //关闭窗口
        function _appClose() {
            if (!!frameElement) {
                if (!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else {
                    if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                        window.parent.CloseLayer();
                    } else if (window.parent.parent.CloseLayer) {
                        window.parent.parent.CloseLayer();
                    }
                }
                window.close();
            }
            else {
                if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                    window.parent.CloseLayer();
                } else if (window.parent.parent.CloseLayer) {
                    window.parent.parent.CloseLayer();
                }
                // window.close();
            }
        }
        var chattype = "line";
        var TempJson;
        function comdify(n) {//处理千分位
            var re = /\d{1,3}(?=(\d{3})+$)/g;
            var n1 = n.replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });
            if (n1 == "0") {
                return "&nbsp;";
            } else {
                if (n < 0) {
                    return "<span class='error'>" + n1 + "</span>";
                } else {
                    return n1;
                }
            }
        };
        function SearchData() {
            if ($('#cblx').val() == "") {
                alert("财报类型不能为空");
                return false;
            }
            else if ($('#cblx').val() != "") {
                if (($('#cblx').val() == "年报" || $('#cblx').val() == "半年报") && ($('#nian').val() == "" || $('#nian2').val() == "")) {
                    alert("年度不能为空");
                    return false;
                }
                if ($('#nian').val() == "") {
                    alert("年度不能为空");
                    return false;
                }
            }
            var gps = zjs.getQueryStr();
            $.ajax({
                type: 'post',
                url: 'FnDetail.aspx',
                data: { 't': 'rep', "Code": gps.code, "Type": $('#cblx').val(), "Year": $('#nian').val(), "Year2": $('#nian2').val() },
                success: function (data) {
                    var ret = eval('(' + data + ')');
                    if (ret.success) {
                        $(".sub2 a").first().trigger("click");
                        $(".reportbox,.subtitlespt").show();

                        showlines("Data1", "资产总额", ret.echartdata.legenddata, ret.echartdata.Data1);
                        showlines("Data2", "营业收入", ret.echartdata.legenddata, ret.echartdata.Data2);
                        showlines("Data3", "净利润", ret.echartdata.legenddata, ret.echartdata.Data3);
                        showlines("Data4", "销售净利率", ret.echartdata.legenddata, ret.echartdata.Data4);
                        showlines("Data5", "净资产收益率", ret.echartdata.legenddata, ret.echartdata.Data5);
                        showlines("Data6", "资产负债率", ret.echartdata.legenddata, ret.echartdata.Data6);
                        showlines("Data7", "速动比例", ret.echartdata.legenddata, ret.echartdata.Data7);

                        var subcodeobj1 = {};//资产负债表
                        var subcodeobj2 = {};//利润表
                        var subcodeobj3 = {};//现金流量表
                        var subcode1 = [];//资产负债表
                        var subcode2 = [];//利润表
                        var subcode3 = [];//现金流量表
                        for (var yi in ret.yearlist) {//先数据预处理
                            var EditDatas1 = $.evalJSON(ret.yearlist[yi].EditDatas1);
                            for (var ei1 in EditDatas1) {
                                var dataei1 = EditDatas1[ei1];
                                if (!subcodeobj1[dataei1.SUBCODE]) {//如果不存在 就加上
                                    subcodeobj1[dataei1.SUBCODE] = 1;

                                    insertarr(subcode1, ei1, dataei1.SUBCODE);
                                }
                            }

                            var EditDatas2 = $.evalJSON(ret.yearlist[yi].EditDatas2);
                            for (var ei2 in EditDatas2) {
                                var dataei2 = EditDatas2[ei2];
                                if (!subcodeobj2[dataei2.SUBCODE]) {//如果不存在 就加上
                                    subcodeobj2[dataei2.SUBCODE] = 2;

                                    insertarr(subcode2, ei2, dataei2.SUBCODE);
                                }
                            }
                             
                            var EditDatas3 = $.evalJSON(ret.yearlist[yi].EditDatas3);
                            for (var ei3 in EditDatas3) {
                                var dataei3 = EditDatas3[ei3];
                                if (!subcodeobj3[dataei3.SUBCODE]) {//如果不存在 就加上
                                    subcodeobj3[dataei3.SUBCODE] = 3;

                                    insertarr(subcode3, ei3, dataei3.SUBCODE);
                                }
                            }
                        }

                        var subcodehtml1 = ["<table border='0' cellpadding='0' cellspacing='0' class='ctable'>",
                        "<thead><tr><td width='360'>项目</td>"];//资产负债表 
                        var subcodehtml2 = ["<table border='0' cellpadding='0' cellspacing='0' class='ctable'>",
                        "<thead><tr><td width='360'>项目</td>"];;//利润表
                        var subcodehtml3 = ["<table border='0' cellpadding='0' cellspacing='0' class='ctable'>",
                        "<thead><tr><td width='360'>项目</td>"];;//现金流量表

                        for (var yi in ret.yearlist) {//先处理年份
                            subcodehtml1.push("<td>" + ret.yearlist[yi].year + "</td>");
                            subcodehtml2.push("<td>" + ret.yearlist[yi].year + "</td>");
                            subcodehtml3.push("<td>" + ret.yearlist[yi].year + "</td>");
                        }
                        subcodehtml1.push("</tr></thead><tbody>");
                        subcodehtml2.push("</tr></thead><tbody>");
                        subcodehtml3.push("</tr></thead><tbody>");

                        for (var sbi1 in subcode1) {
                            var title = "";
                            var tds = [];
                            for (var yi in ret.yearlist) {//先数据预处理
                                var EditDatas1 = $.evalJSON(ret.yearlist[yi].EditDatas1);
                                var edobj = zjs.getmyobject(EditDatas1, subcode1[sbi1], "SUBCODE");
                                if (edobj.SUBNAME) {
                                    title = edobj.SUBNAME;
                                    tds.push("<td class='comdify'>" + edobj.SUBDATA + "</td>");
                                } else {
                                    tds.push("<td class='comdify'></td>");
                                }
                            }
                            subcodehtml1.push("<tr><td class='coldesc'>" + title + "</td>" + tds.join('') + "</tr>");
                        }
                        subcodehtml1.push("</tbody></table>");
                        $(".tabhtml1").html(subcodehtml1.join(''));
                         
                        for (var sbi2 in subcode2) {
                            var title = "";
                            var tds = [];
                            for (var yi in ret.yearlist) {//先数据预处理
                                var EditDatas2 = $.evalJSON(ret.yearlist[yi].EditDatas2);
                                var edobj = zjs.getmyobject(EditDatas2, subcode2[sbi2], "SUBCODE");
                                if (edobj.SUBNAME) {
                                    title = edobj.SUBNAME;
                                    tds.push("<td class='comdify'>" + edobj.SUBDATA + "</td>");
                                } else {
                                    tds.push("<td class='comdify'></td>");
                                }
                            }
                            subcodehtml2.push("<tr><td class='coldesc'>" + title + "</td>" + tds.join('') + "</tr>");
                        }
                        subcodehtml2.push("</tbody></table>");
                        $(".tabhtml2").html(subcodehtml2.join(''));


                        for (var sbi3 in subcode3) {
                            var title = "";
                            var tds = [];
                            for (var yi in ret.yearlist) {//先数据预处理
                                var EditDatas3 = $.evalJSON(ret.yearlist[yi].EditDatas3);
                                var edobj = zjs.getmyobject(EditDatas3, subcode3[sbi3], "SUBCODE");
                                if (edobj.SUBNAME) {
                                    title = edobj.SUBNAME;
                                    tds.push("<td class='comdify'>" + edobj.SUBDATA + "</td>");
                                } else {
                                    tds.push("<td class='comdify'></td>");
                                }
                            }
                            subcodehtml3.push("<tr><td class='coldesc'>" + title + "</td>" + tds.join('') + "</tr>");
                        }
                        subcodehtml3.push("</tbody></table>");
                        $(".tabhtml3").html(subcodehtml3.join(''))

                        $(".reportbox .comdify").each(function (i, v) {
                            $(v).html(comdify($(v).text()));
                        });
                    } else {
                        if (ret.msg != "") {
                            alert(ret.msg);
                        }
                    }
                }
            });
        };
        function insertarr(array, eindex, value) {
            for (var i = array.length; i > eindex; i--) {
                array[i] = array[i - 1];
            }
            array[eindex] = value;
        };
        function showlines(objectid, title, xdata, seriesdata) {
            var dom = document.getElementById(objectid);
            var myChart = echarts.init(dom, 'macarons');
            option = {
                title: {
                    text: title
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    top: "10%",
                    right: "1%",
                    data: [title]
                },
                grid: {
                    left: '1%',
                    right: '3%',
                    top: "30%",
                    bottom: '1%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        data: xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            formatter: function (v) {
                                if (v > 10000 || v < -10000) {
                                    if (v > 100000000 || v < -100000000)
                                        return (v / 100000000) + '亿';
                                    else
                                        return (v / 10000) + '万';
                                } else {
                                    return v;
                                }
                            }
                        }
                    }
                ],
                series: [
                    {
                        name: title,
                        type: chattype, label: { normal: { show: true, position: 'top' } },
                        data: seriesdata
                    }
                ]
            };
            // 为echarts对象加载数据 
            myChart.setOption(option);
        }
    </script>
</body>
</html>



