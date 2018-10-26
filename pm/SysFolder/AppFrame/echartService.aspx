<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="echartService.aspx.cs" Inherits="NTJT.Web.SysFolder.AppFrame.echartService" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script src="../Extension/js/echarts.min.js"></script>
    <script src="../Extension/js/echarts-henan.js"></script>
    <script src="../Extension/js/echarts-sk-westeros.js"></script>
</head>
<body>
    <style type="text/css">
        html, body { height: 100%; background: #fff; }
        #main { width: 80%; height: 60%; margin: 30px auto; }
        .ctable { width: 80%; border-collapse: collapse; border-spacing: 0; empty-cells: show; margin: 0 auto 20px; }
        .ctable tr td { border: solid 1px #dce6f2; padding: 0px 7px; font-size: 14px; line-height: 40px; text-align: center;  }
        .ctable thead tr td { font-weight: bold; background: #dce6f2;font-size: 16px; line-height: 50px; }
        .ctable tbody tr td { }
        .ctable tfoot tr td { font-weight: bold; font-size: 16px; line-height: 50px; }
        .ctable tr td.txtr { text-align:right;}
    </style>
    <div id="main"></div>
    <div id="table"></div>
    <script type="text/javascript">
        var t = '<%=GetParaValue("t")%>';
        var relationId='<%=GetParaValue("relationId")%>';
        $.ajax({
            type: 'post',
            url: 'echartService.aspx',
            data: { 'tt': t, 'relationId': relationId },
            success: function (data) {
                var ret = eval('(' + data + ')');

                var option = {};
                switch (t) {
                    case "11":
                        option = getoption11(ret);
                        break;
                    case "12":
                        option = getoption12(ret);
                        break;
                    case "13":
                        option = getoption13(ret);
                        break;
                    case "14":
                        option = getoption14(ret);
                        break;
                    case "15":
                        option = getoption15(ret);
                        break;
                    case "21":
                        option = getoption21(ret);
                        break;
                    case "22":
                        option = getoption22(ret);
                        break;
                    case "23":
                        option = getoption23(ret);
                        break;
                    case "24":
                        option = getoption24(ret);
                        break;
                    case "25":
                        option = getoption25(ret);
                        break;
                    case "31":
                        option = getoption31(ret);
                        break;
                    case "32":
                        option = getoption32(ret);
                        break;
                    case "33":
                        option = getoption33(ret);
                        break;
                    case "41":
                        option = getoption41(ret);
                        break;
                    case "42":
                        option = getoption42(ret);
                        break;
                }

                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'), 'westeros');
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }
        });
        function getoption11(ret) {
            var jjsl = ret.jjsl;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td><td>基金数量</td></tr></thead><tbody>"];
            var jjslhj = 0;
            for (var i in jjsl.xdata) {
                var xi = jjsl.xdata[i];
                var si = jjsl.series[i];
                tablehtml.push("<tr><td>" + xi + "</td><td>" + si + "</td></tr>");
                jjslhj += parseFloat(si);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + jjslhj.toFixed(0) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));
            return {
                title: {
                    text: '基金数量',
                    subtext: ''
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
                    data: ['基金数量']
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
                        data: jjsl.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                {
                    name: '基金数量',
                    type: 'bar', label: { normal: { show: true, position: 'top' } },
                    data: jjsl.series
                }
                ]
            };
        };
        function getoption12(ret) {
            var jjgm = ret.jjgm;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td><td>基金规模（亿）</td></tr></thead><tbody>"];
            var jjgmhj = 0;
            for (var i in jjgm.xdata) {
                var xi = jjgm.xdata[i];
                var si = jjgm.series[i];
                tablehtml.push("<tr><td>" + xi + "</td><td>" + si + "</td></tr>");
                jjgmhj += parseFloat(si);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + jjgmhj.toFixed(2) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));
            return {
                title: {
                    text: '基金规模（亿）'
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
                    data: ['基金规模']
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
                        data: jjgm.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '基金规模',
                        type: 'bar', label: { normal: { show: true, position: 'top' } },
                        data: jjgm.series
                    }
                ]
            };
        };
        function getoption13(ret) {
            var jjgmfb = ret.jjgmfb;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td><td>基金规模分布</td></tr></thead><tbody>"];
            var jjgmfbhj = 0;
            for (var i in jjgmfb.series) {
                var si = jjgmfb.series[i];
                tablehtml.push("<tr><td>" + si.name + "</td><td>" + si.value + "</td></tr>");
                jjgmfbhj += parseFloat(si.value);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + jjgmfbhj.toFixed(0) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '基金规模分布',
                    subtext: ''
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '基金规模分布',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: jjgmfb.series,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
        };
        function getoption14(ret) {
            var jjyt = ret.jjyt;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>基金名称</td><td>实际到位资金</td><td>已投资金额</td><td>已投比例</td></tr></thead><tbody>"];
            var OUTINVESTMhj = 0;
            var ININVESTMhj = 0;
            for (var i in jjyt.list) {
                var si = jjyt.list[i];
               
                var sb = ((parseFloat(si.OUTINVESTM || "0") / parseFloat(si.ININVESTM || "0")) * 100).toFixed(2) + "%";
                if (!si.OUTINVESTM || !si.ININVESTM) {
                    sb = "";
                }
                tablehtml.push("<tr><td>" + (si.FUNDNAME) + "</td><td class='txtr'>" + comdify(si.ININVESTM) + "</td><td class='txtr'>" + comdify(si.OUTINVESTM) + "</td><td>" + sb + "</td></tr>");
                OUTINVESTMhj += parseFloat(si.OUTINVESTM || "0");
                ININVESTMhj += parseFloat(si.ININVESTM || "0");
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td class='txtr'>" + comdify(ININVESTMhj) + "</td><td class='txtr'>" + comdify(OUTINVESTMhj) + "</td><td>" + (OUTINVESTMhj / ININVESTMhj * 100).toFixed(2) + "%</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '基金已投比例（当前）',
                    subtext: ''
                },
                tooltip: {
                    formatter: "{a} <br/>{b} : {c}%"
                },
                series: [
                    {
                        name: '基金已投比例',
                        type: 'gauge',
                        detail: { formatter: '{value}%' },
                        data: [{ value: jjyt.series, name: '' }]
                    }
                ]
            };
        };
        function getoption15(ret) {
            var jjfpje = ret.jjfpje;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>年份</td><td>基金分配金额</td></tr></thead><tbody>"];
            var jjfpjehj = 0;
            for (var i in jjfpje.xdata) {
                var xi = jjfpje.xdata[i];
                var si = jjfpje.series[i];
                tablehtml.push("<tr><td>" + xi + "</td><td class='txtr'>" + comdify(si) + "</td></tr>");
                jjfpjehj += parseFloat(si || "0");
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td class='txtr'>" + comdify(jjfpjehj) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '基金分配金额'
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
                    data: ['基金分配金额']
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
                        data: jjfpje.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '基金分配金额',
                        type: 'line', label: { normal: { show: true, position: 'top' } },
                        data: jjfpje.series
                    }
                ]
            };
        };
        function getoption21(ret) {
            var xmsl = ret.xmsl;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td><td>储备库数量</td><td>拟投项目数量</td><td>已投项目数量</td><td>退出项目数量</td><td>小计</td></tr></thead><tbody>"];
            var xmslhj0 = 0;
            var xmslhj1 = 0;
            var xmslhj2 = 0;
            var xmslhj3 = 0;
            var xmslhjcb = 0;
            var xmslhjxm = 0;
            for (var i in xmsl.xdata) {
                var xi = xmsl.xdata[i];
                var si = xmsl.series[0].data[i];
                var xmkxj = parseFloat(xmsl.series[1].data[i]) + parseFloat(xmsl.series[2].data[i]) + parseFloat(xmsl.series[3].data[i]);
                tablehtml.push("<tr><td>" + xi + "</td><td>" + xmsl.series[0].data[i] + "</td><td>" + xmsl.series[1].data[i] + "</td><td>" + xmsl.series[2].data[i] + "</td><td>" + xmsl.series[3].data[i] + "</td><td>" + xmkxj + "</td></tr>");
                xmslhjcb += parseFloat(xmsl.series[0].data[i]);
                xmslhjxm += xmkxj;

                xmslhj0 += parseFloat(xmsl.series[0].data[i]);
                xmslhj1 += parseFloat(xmsl.series[1].data[i]);
                xmslhj2 += parseFloat(xmsl.series[2].data[i]);
                xmslhj3 += parseFloat(xmsl.series[3].data[i]);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + xmslhj0 + "</td><td>" + xmslhj1 + "</td><td>" + xmslhj2 + "</td><td>" + xmslhj3 + "</td><td>" + xmslhjxm + "</td></tr>" +
                "</tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '项目数量'
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
                    data: xmsl.ldata
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
                        data: xmsl.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: xmsl.series
            };
        };
        function getoption22(ret) {
            var ytzje = ret.ytzje;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td>"];
            for (var i in ytzje.xdata) {
                var xi = ytzje.xdata[i];
                tablehtml.push("<td>" + xi + "</td>");
            }
            tablehtml.push("</tr></thead><tbody>");//拼装表头 年份为头

            var ytzjehj0 = 0;
            var ytzjehj1 = 0;
            var ytzjehj2 = 0;
            var ytzjehjzj = 0;
            for (var i in ytzje.series) {
                var si = ytzje.series[i];
                tablehtml.push("<tr><td>" + si.name + "</td><td class='txtr'>" + comdify(si.data[0]) + "</td><td class='txtr'>" + comdify(si.data[1]) + "</td><td class='txtr'>" + comdify(si.data[2]) + "</td></tr>");

                ytzjehjzj += parseFloat(si.data[0]) + parseFloat(si.data[1]) + parseFloat(si.data[2]);

                ytzjehj0 += parseFloat(si.data[0]);
                ytzjehj1 += parseFloat(si.data[1]);
                ytzjehj2 += parseFloat(si.data[2]);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td class='txtr'>" + comdify(ytzjehj0) + "</td><td class='txtr'>" + comdify(ytzjehj1) + "</td><td class='txtr'>" + comdify(ytzjehj2) + "</td></tr>" +
                "<tr><td>总计</td><td colspan='3' align='center'>" + comdify(ytzjehjzj) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '已投资金额(万元)',
                    subtext: ''
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
                    data: ytzje.ldata
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
                        data: ytzje.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: ytzje.series
            };
        };
        function getoption23(ret) {
            var tzje = ret.tzje;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td><td>投资金额分布</td></tr></thead><tbody>"];
            var tzjehj = 0;
            for (var i in tzje.series) {
                var si = tzje.series[i];
                tablehtml.push("<tr><td>" + si.name + "</td><td>" + si.value + "</td></tr>");
                tzjehj += parseFloat(si.value);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + tzjehj.toFixed(0) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '投资金额分布',
                    subtext: ''
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '投资金额分布',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: tzje.series,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
        };
        function getoption24(ret) {
            var ytcje = ret.ytcje;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>子公司</td>"];
            for (var i in ytcje.xdata) {
                var xi = ytcje.xdata[i];
                tablehtml.push("<td>" + xi + "</td>");
            }
            tablehtml.push("</tr></thead><tbody>");//拼装表头 年份为头

            var ytcjehj0 = 0;
            var ytcjehj1 = 0;
            var ytcjehj2 = 0;
            var ytcjehjzj = 0;
            for (var i in ytcje.series) {
                var si = ytcje.series[i];
                tablehtml.push("<tr><td>" + si.name + "</td><td class='txtr'>" + comdify(si.data[0]) + "</td><td class='txtr'>" + comdify(si.data[1]) + "</td><td class='txtr'>" + comdify(si.data[2]) + "</td></tr>");

                ytcjehjzj += parseFloat(si.data[0]) + parseFloat(si.data[1]) + parseFloat(si.data[2]);

                ytcjehj0 += parseFloat(si.data[0]);
                ytcjehj1 += parseFloat(si.data[1]);
                ytcjehj2 += parseFloat(si.data[2]);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td class='txtr'>" + comdify(ytcjehj0) + "</td><td class='txtr'>" + comdify(ytcjehj1) + "</td><td class='txtr'>" + comdify(ytcjehj2) + "</td></tr>" +
                "<tr><td>总计</td><td colspan='3' align='center'>" + comdify(ytcjehjzj) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));

            return {
                title: {
                    text: '已退出金额',
                    subtext: ''
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
                    data: ytcje.ldata
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
                        data: ytcje.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: ytcje.series
            };
        };
        function getoption25(ret) {
            var dyfb = ret.dyfb;

            var tablehtml = ["<table class='ctable' cellspacing='0' cellpadding='0' border='0'><thead><tr><td>城市</td><td>项目数量</td></tr></thead><tbody>"];
            var dyfbhj = 0;
            for (var i in dyfb.series) {
                var si = dyfb.series[i];
                tablehtml.push("<tr><td>" + si.name + "</td><td>" + si.value + "</td></tr>");
                dyfbhj += parseFloat(si.value);
            }
            tablehtml.push("</tbody><tfoot><tr><td>合计</td><td>" + dyfbhj.toFixed(0) + "</td></tr></tfoot></table>");
            $("#table").html(tablehtml.join(''));


            return {
                title: {
                    text: '项目地域分布'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    top: 'bottom',
                    data: ['项目地域分布']
                },
                series: [
                    {
                        name: '项目地域分布',
                        type: 'map',
                        mapType: '河南',
                        roam: false,
                        label: {
                            normal: {
                                show: true,
                                position: ['0', "8"],
                                formatter: function (params) {
                                    return params.value || "";
                                }
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        data: dyfb.series
                    }
                ]
            };
        };
        function getoption31(ret) {
            $("#main").height("80%");
            var fxsl = ret.fxsl;
            return {
                title: {
                    text: '风险事件数量'
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
                    data: fxsl.ldata
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
                        data: fxsl.xdata
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: fxsl.series
            };
        };
        function getoption32(ret) {
            $("#main").height("80%");
            var fxfb = ret.fxfb;
            return {
                title: {
                    text: '风险事件分布',
                    subtext: '',
                    left: 'left'
                },
                tooltip: {
                    trigger: 'item'
                },
                radar: {
                    name: {
                        textStyle: {
                            color: '#000',
                            borderRadius: 3,
                            padding: [3, 5]
                        }
                    },
                    indicator: fxfb.indicator
                },
                series: [{
                    name: '风险事件分布',
                    type: 'radar',
                    // areaStyle: {normal: {}},
                    data: [
                        {
                            value: fxfb.series,
                            name: '风险事件分布'
                        }
                    ]
                }]
            };
        };
        function getoption33(ret) {
            $("#main").height("80%");
            var fxxm = ret.fxxm;
            return {
                title: {
                    text: '风险项目分布'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    top: 'bottom',
                    data: ['风险项目分布']
                },
                series: [
                    {
                        name: '风险项目分布',
                        type: 'map',
                        mapType: '河南',
                        roam: false,
                        label: {
                            emphasis: {
                                show: true
                            }
                        },
                        data: fxxm.series
                    }
                ]
            };
        };
        function getoption41(ret) {
            $("#main").height("80%");
            var tzztfb = ret.tzztfb;
            return {
                title: {
                    text: '投资主体分布',
                    subtext: ''
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '投资主体分布',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: tzztfb.series,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
        };
        function getoption42(ret) {
            $("#main").height("80%");
            var dsfjgfb = ret.dsfjgfb;
            return {
                title: {
                    text: '第三方机构分布',
                    subtext: ''
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '第三方机构分布',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: dsfjgfb.series,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
        };
        function comdify(n) {//处理千分位 
            var re = /\d{1,3}(?=(\d{3})+$)/g;
            return (n + "").replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });

            return n1;
        };
    </script>
</body>
</html>
