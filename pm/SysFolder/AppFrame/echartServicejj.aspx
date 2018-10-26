<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script src="../Extension/js/echarts.min.js"></script>
</head>
<body>
    <style type="text/css">
        html, body { height: 100%; background: #fff; padding:0;overflow:hidden;}
        #main { width: 98%; height: 90%; margin: 0 auto 0; }
    </style>
    <div id="main"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例 
        var myChart = echarts.init(document.getElementById('main'));
        var option = {
            tooltip: {
                trigger: 'item',
                formatter: "{b} {c}",
                triggerOn: 'mousemove'
            },
            series: [
                {
                    type: 'tree',
                    data: [{
                        "name": "", "value": "河南省农业综合开发公司",
                        "children": [
                            {
                                "name": "豫农\n产投", "value": "100%",
                                "children": [
                                    {
                                        "name": "农发\n基金", "value": "33%"
                                    } 
                                ]
                            },
                            {
                                "name": "基金\n投资", "value": "100%",
                                "children": [
                                    {
                                        "name": "中原\n文化", "value": "100%"
                                    },
                                    {
                                        "name": "雨韵\n新材料", "value": "100%"
                                    },
                                    {
                                        "name": "产业\n促进", "value": "100%"
                                    }
                                ]
                            },
                            {
                                "name": "中原\n联创", "value": "100%",
                                "children": [
                                    {
                                        "name": "先进\n制造业", "value": "100%"
                                    },
                                    {
                                        "name": "现代\n农业", "value": "100%"
                                    },
                                    {
                                        "name": "农业\n综合", "value": "100%"
                                    },
                                    {
                                        "name": "中原\n科创", "value": "100%"
                                    },
                                    {
                                        "name": "中小\n企业", "value": "100%"
                                    },
                                    {
                                        "name": "粮油\n深加工", "value": "100%"
                                    }
                                ]
                            },
                            {
                                "name": "现代\n服务业", "value": "100%",
                                "children": [
                                    {
                                        "name": "现代\n服务业", "value": "100%"
                                    },
                                    {
                                        "name": "远海\n物流", "value": "100%"
                                    },
                                    {
                                        "name": "国新\n启迪", "value": "100%"
                                    },
                                    {
                                        "name": "和谐\n锦豫", "value": "100%"
                                    },
                                    {
                                        "name": "中原\n丝路", "value": "100%"
                                    },
                                    {
                                        "name": "军民\n融合", "value": "100%"
                                    }
                                ]
                            },
                            {
                                "name": "返乡\n创业", "value": "100%"
                            }
                        ]
                    }],
                    left: '3%',
                    right: '3%',
                    top: '13%',
                    bottom: '13%',
                    symbol: 'emptyCircle',
                    orient: 'vertical',
                    expandAndCollapse: true,
                    label: {//标签
                        normal: {
                            formatter: "{c}\n\n\n{b}",
                            position: ['50%', 10],
                            verticalAlign: 'middle',
                            align: 'middle',
                            fontSize: 16, 
                            color: "#000",
                            textBorderColor: "#fff",
                            textBorderWidth:3
                        }
                    },
                    leaves: {//叶子节点特殊设置
                        label: {
                            normal: {  
                                fontSize: 14
                            }
                        }
                    },
                    lineStyle: {//边框设置
                        normal: { 
                            color: '#ccc',//颜色
                            curveness: 0.15//曲度
                        }
                    }, 
                    animationDurationUpdate: 750
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</body>
</html>
