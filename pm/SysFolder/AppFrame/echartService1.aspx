<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script src="../Extension/js/echarts.min.js"></script>
</head>
<body>
    <style type="text/css">
        html, body { height: 100%; background: #fff; padding:0;overflow:hidden;}
        #main { width: 98%; height: 70%; margin: 0 auto 0; }
    </style>
    <div id="main"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例 
        var myChart = echarts.init(document.getElementById('main'));
        var option = {
            tooltip: {
                trigger: 'item',
                formatter: "{b} ({c})",
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
                                        "name": "兰考\n农开", "value": "80%"
                                    },
                                    {
                                        "name": "农发\n基金", "value": "51%"
                                    },
                                    {
                                        "name": "裕泰\n生物", "value": "41.26%"
                                    }
                                ]
                            },
                            {
                                "name": "基金\n投资", "value": "100%"
                            },
                            {
                                "name": "联创\n公司", "value": "63.27%",
                                "children": [
                                    {
                                        "name": "联创\n融久", "value": "35.2%"
                                    },
                                    {
                                        "name": "小额\n贷款", "value": "30%"
                                    },
                                    {
                                        "name": "华凯\n创投", "value": "40%"
                                    }
                                ]
                            },
                            {
                                "name": "高创\n公司", "value": "70.40%",
                                "children": [
                                ]
                            },
                            {
                                "name": "融资\n租赁", "value": "49%",
                                "children": [
                                ]
                            },
                            {
                                "name": "中原\n联创", "value": "90%",
                                "children": [
                                    {
                                        "name": "新乡\n联创", "value": "56.25%"
                                    },
                                    {
                                        "name": "中民\n联创", "value": "45%"
                                    },
                                    {
                                        "name": "宏科\n投资", "value": "51%"
                                    }
                                ]
                            },
                            {
                                "name": "现代\n服务业", "value": "50%",
                                "children": [
                                ]
                            },
                            {
                                "name": "农开\n担保", "value": "55%",
                                "children": [
                                ]
                            },
                            {
                                "name": "畜牧\n担保", "value": "50%",
                                "children": [
                                ]
                            },
                            {
                                "name": "扶贫\n公司", "value": "100%",
                                "children": [
                                ]
                            },
                            {
                                "name": "豫农\n置业", "value": "100%",
                                "children": [
                                    {
                                        "name": "金领\n时代", "value": "100%"
                                    }
                                ]
                            },
                            {
                                "name": "农投\n置业", "value": "100%",
                                "children": [
                                ]
                            },
                            {
                                "name": "豫财\n宾馆", "value": "100%",
                                "children": [
                                    {
                                        "name": "豫财\n实业", "value": "100%"
                                    }
                                ]
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
                            color: "#5b9bd5",
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
                            color: '#5b9bd5',//颜色
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
