<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePMRP.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.HomePMRP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script src="js/echarts.min.js"></script>
    <script src="js/echarts-henan.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <style type="text/css">
            html { }
            body { background: #e8edf6; margin: 0; padding: 0; }
            .echartbox { overflow: hidden; padding: 0; position: absolute; top: 0; bottom: 0; left: 0; right: 0; }
            .echartbox .echarts { background: #fff;width: 33.3333%;box-sizing:border-box; height: 290px; float: left;border:solid 5px #e8edf6; border-width: 0 5px 5px 0; }
            .echartbox .echarts:nth-child(3n) { border-right: 0; }
            .echartbox .echarts .echart {width: 100%; height: 100%;}
        </style>
        <div class="echartbox">
            <div class="echarts">
                <div class="echart" id="main1"></div>
            </div>
            <div class="echarts">
                <div class="echart" id="main2"></div>
            </div>
            <div class="echarts">
                <div class="echart" id="main3"></div>
            </div>
            <div class="echarts">
                <div class="echart" id="main4"></div>
            </div>
            <div class="echarts">
                <div class="echart" id="main5"></div>
            </div>
            <div class="echarts">
                <div class="echart" id="main6"></div>
            </div>
        </div>
        <script type="text/javascript">
            $(".echartbox .echarts").height(($(window).height() - 5) / 2);
            //$(".echartbox .echarts").width(($(".echartbox").width() - 10) / 3);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart1 = echarts.init(document.getElementById('main1'));
            var option1 = {
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
                    data: ['储备项目', '拟投项目', '已投项目', '退出项目', '风险项目']
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
                        data: [<%=XMKSLDateYear%>]
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [<%=XMKSLseries%>]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart1.setOption(option1);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart2 = echarts.init(document.getElementById('main2'));
            var option2 = {
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
                            emphasis: {
                                show: true
                            }
                        },
                        data: [
                            <%=XMDYFBseries%>
                        ]
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart2.setOption(option2);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart3 = echarts.init(document.getElementById('main3'));
            var option3 = {
                title: {
                    text: '项目投资金额分布',
                    subtext: ''
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '项目规模',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: [<%=TZJEFBlseries%>
                        ],
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

                // 使用刚指定的配置项和数据显示图表。
                myChart3.setOption(option3);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart4 = echarts.init(document.getElementById('main4'));
            var option4 = {
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
                        data: [<%=JJSLDateYear%>]
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
                    type: 'line', label: { normal: { show: true, position: 'top' } },
                    data: [<%=JJSLseries%>]
                }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart4.setOption(option4);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart5 = echarts.init(document.getElementById('main5'));
            var option5 = {
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
                        data: [<%=JJGMDateYear%>]
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
                        data: [<%=JJGMseries%>]
                    }
                ]
            };


                // 使用刚指定的配置项和数据显示图表。
                myChart5.setOption(option5);
        </script>
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart6 = echarts.init(document.getElementById('main6'));
            var option6 = {
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
                        data: [<%=JJGMFBlseries%>
                        ],
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

                // 使用刚指定的配置项和数据显示图表。
                myChart6.setOption(option6);
        </script>
    </form>
</body>
</html>
