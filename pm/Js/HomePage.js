
jQuery(function () {
    LaodTodo();
    LaodNoXC();
    LaodYD();
    LaodDCL();
    LaodQJ('');
    LaodYGXS();
    $('.ChangeQj').each(function (i, e) {
        $(e).click(function () {
            var obj = $(this);
            $('.ChangeQj').each(function (index, el) {
                $(el).css('background-color', 'white');
            });
            if (obj.attr('data-type') == i)
                obj.css('background-color', '#09A3EC');
          
            var sqlwhere = '';
            var NewDate = new Date();
            var NewYear = NewDate.getFullYear();
            var NewMonth = NewDate.getMonth();
            if (NewMonth < 11) NewMonth = NewMonth + 1;
            else NewMonth = 1;
            var NewDay = NewDate.getDay();
            var SqlDate = NewYear + '-' + NewMonth + '-' + NewDay;
            if (obj.attr('data-type') == '1') {               
                sqlwhere = '(DATEPART(dd, StartTime)= DATEPART(dd,convert(varchar(10),[QUOTES]' + SqlDate + '[QUOTES],120)) or DATEPART(dd, EndTime)= DATEPART(dd,convert(varchar(10),[QUOTES]' + SqlDate + '[QUOTES],120)))';
            } else if (obj.attr('data-type') == '2') {
                sqlwhere = '(convert(varchar(7),StartTime,120)=convert(varchar(7),[QUOTES]' + SqlDate + '[QUOTES],120) or convert(varchar(7),EndTime,120)=convert(varchar(7),[QUOTES]' + SqlDate + '[QUOTES],120))';
            } else if (obj.attr('data-type') == '3') {
                sqlwhere = '1=1';
            }
            LaodQJ(sqlwhere);
        });
    });
});
LaodTodo = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'HomePage.aspx?t=todo',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.Data;
                    var Html_XC = '';
                    for (var i = 0; i < dt.length; i++) {
                        Html_XC = Html_XC + ' <tr>' +
                                            ' <td><font><font><a href="sysfolder/workflow/dealflow.aspx?taskId=' + dt[i].uTaskId + '" target="_blank">' + dt[i].instanceName + '</a></font></font></td>' +
                                            ' <td><font><font>' + dt[i].CreateUser + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].ArriveTime + '</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#ToDo').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}
LaodNoXC = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_HR_XC_GWXCYC',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var Html_XC = '';
                    for (var i = 0; i < dt.length; i++) {
                        Html_XC = Html_XC + ' <tr>'+
                                            '<td><font><font>'+(i+1)+'</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EmployeeName + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].Sex + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].IDcard + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].ComeDate + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].DepName + '</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#XCUser').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}
LaodRZ = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_HR_XC_GWXCYC',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var Html_XC = '';
                    for (var i = 0; i < dt.length; i++) {
                        Html_XC = Html_XC + ' <tr>' +
                                            '<td><font><font>' + (i + 1) + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EmployeeName + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].Sex + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].IDcard + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].ComeDate + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].DepName + '</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#XCUser').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}
LaodDCL = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_DCLSX',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var Html_XC = '';
                    var HtmlUrl = '';
                    for (var i = 0; i < dt.length; i++) {
                        HtmlUrl = '';
                        if (dt[i].typename == '入职')
                            HtmlUrl = 'SysFolder/AppFrame/AppQuery.aspx?TblName=Q_HR_StaffEntryBook';
                        else if (dt[i].typename == '离职')
                            HtmlUrl = 'SysFolder/AppFrame/AppDefault.aspx?tblName=T_HR_RSXX_YGJS&Condition=_CompanyID=[QUOTES][!CompanyID!][QUOTES]';
                        else if (dt[i].typename == '合同')
                            HtmlUrl = '';
                        Html_XC = Html_XC + ' <tr onclick="wopen(\'' + HtmlUrl + '\')">' +
                                            ' <td><font><font>' + dt[i].typename + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].num + '</font></font></td>' +
                                            ' <td><font><font>待处理</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#DCL').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}

LaodYD = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_HR_StaffEntryBook',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var Html_XC = '';
                    for (var i = 0; i < dt.length; i++) {
                        Html_XC = Html_XC + ' <tr>' +
                                            ' <td><font><font>' + dt[i].DeptName + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].ypName + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].Sexid + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EndRdu + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EndMajor + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EndSchool + '</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#UserYD').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}
LaodQJ = function (sqlwhere) {
    var NewDate = new Date();
    var NewYear = NewDate.getFullYear();
    var NewMonth = NewDate.getMonth();
    if (NewMonth < 11) NewMonth = NewMonth + 1;
    else NewMonth = 1;
    var NewDay = NewDate.getDay();
    var SqlDate = NewYear + '-' + NewMonth + '-' + NewDay;
    if (sqlwhere == '') sqlwhere = '(convert(varchar(10),StartTime,120)=convert(varchar(10),[QUOTES]' + SqlDate + '[QUOTES],120) or convert(varchar(10),EndTime,120)=convert(varchar(10),[QUOTES]' + SqlDate + '[QUOTES],120) )';
    $('#UserQJ').find('tr').each(function (i,e) {
        if (i > 0)
            $(e).remove();
    });

    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?ds=T_HR_KQGL_JQSQ&condition=_wfstate=[QUOTES]完成[QUOTES] and ' + sqlwhere,
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var Html_XC = '';
                    for (var i = 0; i < dt.length; i++) {
                        Html_XC = Html_XC + ' <tr onclick="wopen(\'SysFolder/AppFrame/AppDetail.aspx?tblName=T_HR_KQGL_JQSQ&sindex=&mainid=' + dt[i]._AutoID + '\')">' +
                                            ' <td><font><font>' + dt[i].EmpName + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].JQLXMC + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].StartTime + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].EndTime + '</font></font></td>' +
                                            ' <td><font><font>' + dt[i].SQTS + '</font></font></td>' +
                                            ' </tr>';
                    }
                    $('#UserQJ').append(Html_XC);
                }
            }
        });
    } catch (e) { }
}
LaodYGXS= function () {

    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_YGXS',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');
                    var dt = retValue.rows;
                    var textdata = [];
                    var seriesdata = []
                    for (var i = 0; i < dt.length; i++) {
                        seriesdata.push({ 'value': dt[i].num, 'name': dt[i].WorkType });
                        textdata.push(dt[i].WorkType);

                    }
                    PieChart('pieChart', textdata, seriesdata);
                }
            }
        });
    } catch (e) { }
}

Showline = function () {
    try {
        var tepp = 1;
        $.ajax({
            type: "POST",
            dataType: "text",
            url: 'SysFolder/Common/getjson.ashx?t=2&ds=Q_WorkFlow_AllNum',
            success: function (data) {
                if (data != '') {
                    var retValue = eval('(' + data + ')');

                    var dt = retValue.rows;
                    var legenddata = ['流程实例'];
                    var seriesdata_sub1 = [];
                    var seriesdata_sub4 = [];
                    for (var i = 0; i < dt.length; i++) {
                        seriesdata_sub1.push(dt[i].start)
                        seriesdata_sub4.push(dt[i].WorkflowName)
                        allWorkFlowSL = allWorkFlowSL + parseInt(dt[i].start);
                    }

                    $('#TaskNum').html(allWorkFlowSL + '<small>条</small');
                    var dataZoom = {
                        show: true,
                        realtime: true,
                        start: 0,
                        end: 20
                    }
                    var seriesdata = [{
                        name: '流程实例',
                        type: 'bar',
                        data: seriesdata_sub1
                    }];
                    var yAxisdate = [
                               {
                                   type: 'value'
                               }

                    ];

                    showlines('pieLine', legenddata, yAxisdate, seriesdata, seriesdata_sub4, dataZoom);
                }
            }
        });
    } catch (e) { }
}
wopen = function (url) {
    window.open(url, '_blank');
}
PieChart = function (objectid, textdata, legenddata) {
    // 基于准备好的dom，初始化echarts图表
    var myChart = echarts.init(document.getElementById(objectid));
    // var k = seriesdata;
    option = {
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: textdata
        },
        series: [
            {
                name: '',
                type: 'pie',
                radius: '75%',
                center: ['50%', '60%'],
                data: legenddata
            }
        ]

    };


    // 为echarts对象加载数据 
    myChart.setOption(option, true);
}
showlines = function (objectid, legenddata, yAxisdate, seriesdata, xAxisdata, dataZoom) {
    var dom = document.getElementById(objectid);
    var myChart = echarts.init(dom, 'macarons');
    option = {
        calculable: true,
        legend: {
            data: legenddata
        },
        dataZoom: dataZoom,
        tooltip: {
            showDelay: 100,//显示延时，添加显示延时可以避免频繁切换
            hideDelay: 500,//隐藏延时
            enterable: true,
            trigger: 'axis'
            //, formatter: function (params, ticket, callback) {
            //    console.log(params)
            //    var res = params[0].seriesName + ' : <a style="text-decoration:underline;" href="javascript:ShowMX(\'' + params[0].seriesName + '\',\'' + params[0].name + '\',\'' + objectid + '\',\'成本\')">' + params[0].value + '</a><br/>';
            //    res += params[1].seriesName + ' : <a style="text-decoration:underline;" href="javascript:ShowMX(\'' + params[1].seriesName + '\',\'' + params[1].name + '\',\'' + objectid + '\',\'收入\')">' + params[1].value + '</a><br/>';
            //    res += params[2].seriesName + ' :' + params[2].value + '';         
            //    return res;//'loading';//显示loading感觉更好
            //}
        },
        xAxis: [
            {
                type: 'category',
                data: xAxisdata
            }
        ],
        yAxis: yAxisdate,
        series: seriesdata
    };
    // 为echarts对象加载数据 
    myChart.setOption(option);
}