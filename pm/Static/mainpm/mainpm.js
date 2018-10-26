if (!window.zjs) { zjs = {}; };
zjs.renderRow = function (datai, render) {
    var row = render;
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), datai[attr]);
    }
    return row;
};
//JSON格式树 接收数组
zjs.jsontrees = function (datas, template, deep) {
    var $ul = $("<ul class='nav1'></ul>");
    for (var di in datas) {
        var data = datas[di];
        var $row = $(zjs.renderRow(data, template)); //这里是li
        $row.append(zjs.jsontreechildren(data.ChildNodes, template, 2));//从这个函数开始统一返回ul格式
        $ul.append($row);
    }
    return $ul;
};
//JSON格式树渲染 data是子对象数组　从此函数递归后　data都是数组 开始返回ul li ul li格式
zjs.jsontreechildren = function (data, template, deep) {
    if (data && data.length > 0) {
        var $ul = $("<ul class='nav" + (deep) + "'></ul>");
        for (var di in data) {
            var datai = data[di];
            var $row = $(zjs.renderRow(datai, template));
            $row.append(zjs.jsontreechildren(datai.ChildNodes, template, (deep) + 1));
            $ul.append($row);
        }
        return $ul;
    } else {
        return "";
    }
};
$(function () {
    setTimeout(function () {
        $("#mainiframe").removeAttr("src");
    }, 100);
    $(".ad-right").height($(window).height() - 54);//右侧
    $(".ad-report .echartbox .echarts").height(($(window).height() - 80) / 2);//图表高度
    $(window).resize(function () {
        $(".ad-right").height($(window).height() - 54);
    });

    //渲染总菜单 
    var treehtml = zjs.jsontrees(func_Tree[0].ChildNodes, "<li><a value='{{value}}'><i class='iconfont'>&#{{icon}};</i><span>{{text}}</span></a></li>");
    $(".ad-menus").html(treehtml);
    $(".ad-menus a").each(function (i, v) {
        if ($(v).children(".iconfont").text().indexOf("&#;") > -1) {
            $(v).children(".iconfont").html("&#xe61d;");
        }
        if ($(v).next("ul").length > 0) {
            $(v).prepend("<i class='iconfont fr'>&#xe66f;</i>");
        }
    });
    $(".hidemenus .ad-left a").live("mousemove", function (e) {
        var $t = $(this);
        $(".hidetips span").text($t.children("span").text());
        $(".hidetips").css("top", $t.offset().top).show();
    }).live("mouseout", function (e) {
        $(".hidetips").hide();
    });
    var focusindex = 0;
    $("a").live("click", function () {
        $(".ad-menus a.select").removeClass("select");
        var $t = $(this);
        if ($t.hasClass("show-aditem1")) {
            //显示我的桌面
            $(".aditem1").show();
            $(".aditem2").hide();
            if ($("body").hasClass("ismenushow")) {
                $("body").removeClass("ismenushow");
            }
        } else if ($t.hasClass("focusprev")) {
            if (focusindex > 0) {
                focusindex--;
            }
            $(".focusbox").children().eq(focusindex).show().siblings().hide();
        } else if ($t.hasClass("focusnext")) {
            if (focusindex < $(".focusbox").children().length) {
                focusindex++;
            }
            $(".focusbox").children().eq(focusindex).show().siblings().hide();
        } else if ($t.hasClass("ad-togglemenus")) {
            if ($("body").hasClass("hidemenus")) {
                $("body").removeClass("hidemenus").addClass("showmenus");
            } else {
                $("body").addClass("hidemenus").removeClass("showmenus");
            }
        } else if ($t.next("ul").length > 0) {
            //说明它是父菜单 让它显示隐藏子菜单
            if ($t.next("ul").hasClass("isshow")) {
                $t.next("ul").slideUp(100).removeClass("isshow");
                $t.removeClass("select").children(".fr").html("&#xe66f;");
            } else {
                $t.next("ul").slideDown(200).addClass("isshow");
                $t.addClass("select").children(".fr").html("&#xe66d;");
            }
        } else if ($t.attr("value")) {
            //如果有path但是没值 就跳默认的菜单中心
            $("#mainiframe").attr("src", $t.attr("value"));
            $t.addClass("select");
            $(".aditem2").show();
            $(".aditem1").hide();
            if ($(window).width() < 800) {
                $("body").addClass("hidemenus").removeClass("showmenus");
            }
            if (!$("body").hasClass("ismenushow")) {
                $("body").addClass("ismenushow");
            }
        }
    });

    //echarts
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    var option = {
        title: {
            text: '投资能力（亿）',
            subtext: ''
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            right: '1%',
            data: ['2016年', '2017年']
        },
        grid: {
            left: '1%',
            right: '5%',
            bottom: '1%',
            containLabel: true
        },
        xAxis: {
            type: 'value',
            boundaryGap: [0, 0.01]
        },
        yAxis: {
            type: 'category',
            data: ['高创公司', '联创公司', '中原联创', '基金投资', '豫农产投', '农开']
        },
        series: [
            {
                name: '2016年',
                type: 'bar',
                data: [234, 123, 112, 341, 765, 2000]
            },
            {
                name: '2017年',
                type: 'bar',
                data: [345, 178, 231, 456, 890, 3200]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);


    // 基于准备好的dom，初始化echarts实例
    var myChart1 = echarts.init(document.getElementById('main1'));
    var option1 = {
        title: {
            text: '投资比例',
            subtext: ''
        },
        tooltip: {
            formatter: "{a} <br/>{b} : {c}%"
        },
        series: [
            {
                name: '基金投资比例',
                type: 'gauge',
                detail: { formatter: '{value}%' },
                data: [{ value: 81, name: '' }]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart1.setOption(option1);


    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('main2'));
    function randomData() {
        return Math.round(Math.random() * 1000);
    }

    var option2 = {
        title: {
            text: '投资额度',
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
            data: ['豫农产投', '基金投资', '中原联创', '联创公司', '高创公司', '融资租赁', '农开担保', '畜牧担保']
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
                data: ['一季度', '二季度', '三季度', '四季度']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '豫农产投',
                type: 'bar',
                data: [320, 332, 301, 640]
            },
            {
                name: '基金投资',
                type: 'bar',
                data: [120, 132, 101, 134]
            },
            {
                name: '中原联创',
                type: 'bar',
                data: [220, 182, 191, 234]
            },
            {
                name: '联创公司',
                type: 'bar',
                data: [150, 232, 201, 154]
            },
            {
                name: '高创公司',
                type: 'bar',
                data: [862, 1018, 964, 1570]
            },
            {
                name: '融资租赁',
                type: 'bar',
                data: [620, 732, 701, 734]
            },
            {
                name: '农开担保',
                type: 'bar',
                data: [120, 132, 230, 220]
            },
            {
                name: '畜牧担保',
                type: 'bar',
                data: [862, 1679, 1600, 1570]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart2.setOption(option2);


    // 基于准备好的dom，初始化echarts实例
    var myChart3 = echarts.init(document.getElementById('main3'));
    var option3 = {
        title: {
            text: '风险分布'
        },
        radar: {
            name: {
                textStyle: {
                    color: '#000',
                    borderRadius: 3,
                    padding: [3, 5]
                }
            },
            indicator: [
                { name: '战略', max: 6500 },
                { name: '经营', max: 16000 },
                { name: '财务', max: 30000 },
                { name: '法律', max: 38000 },
                { name: '催收', max: 52000 },
                { name: '其他', max: 25000 }
            ]
        },
        series: [{
            name: '风险分布',
            type: 'radar',
            // areaStyle: {normal: {}},
            data: [
                {
                    value: [4300, 10000, 28000, 35000, 50000, 19000],
                    name: '风险分布'
                }
            ]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart3.setOption(option3);


    // 基于准备好的dom，初始化echarts实例
    var myChart4 = echarts.init(document.getElementById('main4'));
    var option4 = {
        title: {
            text: '项目地域分布',
            subtext: '',
            left: 'left'
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
                    { name: '郑州市', value: randomData() },
                    { name: '安阳市', value: randomData() },
                    { name: '驻马店市', value: randomData() },
                    { name: '南阳市', value: randomData() },
                    { name: '洛阳市', value: randomData() },
                    { name: '商丘市', value: randomData() },
                    { name: '许昌市', value: randomData() },
                    { name: '三门峡市', value: randomData() },
                    { name: '周口市', value: randomData() },
                    { name: '信阳市', value: randomData() }
                ]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart4.setOption(option4);


    // 基于准备好的dom，初始化echarts实例
    var myChart5 = echarts.init(document.getElementById('main5'));
    var option5 = {
        title: {
            text: '项目进度分布',
            subtext: '',
            left: 'left'
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        series: [
            {
                name: '项目进度分布',
                type: 'pie',
                radius: '55%',
                center: ['50%', '50%'],
                data: [
                    { value: 335, name: '投前项目库' },
                    { value: 310, name: '投后项目库' },
                    { value: 135, name: '退出项目库' },
                    { value: 548, name: '储备项目库' }
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
    myChart5.setOption(option5);


    // 基于准备好的dom，初始化echarts实例
    var myChart10 = echarts.init(document.getElementById('main10'));
    var option10 = {
        title: {
            text: '储备项目数量'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            right: '4%',
            data: ['储备项目']
        },
        grid: {
            left: '3%',
            right: '8%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['一季度', '二季度', '三季度', '四季度']
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: '储备项目',
                type: 'line',
                stack: '总量',
                data: [120, 132, 101, 134]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart10.setOption(option10);


    // 基于准备好的dom，初始化echarts实例
    var myChart11 = echarts.init(document.getElementById('main11'));
    var option11 = {
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
                data: ['一季度', '二季度', '三季度', '四季度']
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
                type: 'bar',
                data: [5, 8, 10, 12]
            }
        ]
    };



    // 使用刚指定的配置项和数据显示图表。
    myChart11.setOption(option11);


    // 基于准备好的dom，初始化echarts实例
    var myChart12 = echarts.init(document.getElementById('main12'));

    var option12 = {
        title: {
            text: '项目数量'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                label: {
                    backgroundColor: '#6a7985'
                }
            }
        },
        legend: {
            right: '4%',
            data: ['投前', '投后', '退出']
        },
        grid: {
            left: '3%',
            right: '6%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: ['一季度', '二季度', '三季度', '四季度']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '投前',
                type: 'line',
                stack: '总量',
                areaStyle: { normal: {} },
                data: [120, 132, 101, 134]
            },
            {
                name: '投后',
                type: 'line',
                stack: '总量',
                areaStyle: { normal: {} },
                data: [220, 182, 191, 234]
            },
            {
                name: '退出',
                type: 'line',
                stack: '总量',
                areaStyle: { normal: {} },
                data: [150, 232, 201, 154]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart12.setOption(option12);


    // 基于准备好的dom，初始化echarts实例
    var myChart13 = echarts.init(document.getElementById('main13'));
    var option13 = {
        title: {
            text: '风险数量',
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
            data: ['战略', '经营', '财务', '法律', '催收', '其他']
        },
        grid: {
            left: '3%',
            right: '3%',
            top: "30%",
            bottom: '1%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: ['一季度', '二季度', '三季度', '四季度']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '战略',
                type: 'bar',
                data: [320, 332, 301, 540]
            },
            {
                name: '经营',
                type: 'bar',
                data: [120, 132, 101, 134]
            },
            {
                name: '财务',
                type: 'bar',
                data: [220, 182, 191, 234]
            },
            {
                name: '法律',
                type: 'bar',
                data: [150, 232, 201, 154]
            },
            {
                name: '催收',
                type: 'bar',
                data: [250, 272, 211, 134]
            },
            {
                name: '其他',
                type: 'bar',
                data: [63, 432, 101, 254]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart13.setOption(option13);


    // 基于准备好的dom，初始化echarts实例
    var myChart14 = echarts.init(document.getElementById('main14'));
    var option14 = {
        title: {
            text: '投资者数量',
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
            data: ['内部机构', '外部机构', '自然人']
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
                data: ['一季度', '二季度', '三季度', '四季度']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '内部机构',
                type: 'bar',
                data: [320, 332, 301, 540]
            },
            {
                name: '外部机构',
                type: 'bar',
                data: [120, 132, 101, 134]
            },
            {
                name: '自然人',
                type: 'bar',
                data: [220, 182, 191, 234]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart14.setOption(option14);


    // 基于准备好的dom，初始化echarts实例
    var myChart15 = echarts.init(document.getElementById('main15'));
    var option15 = {
        title: {
            text: '项目规模',
            subtext: '',
            left: 'left'
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
                data: [
                    { value: 335, name: '500万以下' },
                    { value: 310, name: '500~2000万' },
                    { value: 680, name: '2000~5000万' },
                    { value: 231, name: '5000~1亿' },
                    { value: 99, name: '1亿以上' }
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
    myChart15.setOption(option15);

    $("a.focusprev").trigger("click");//都渲染完以后 默认单击一下第一页
});