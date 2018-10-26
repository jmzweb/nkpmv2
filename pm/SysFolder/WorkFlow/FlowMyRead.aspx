<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowMyPart.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowMyPart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>传阅给我的任务</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/DateExt.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <style type="text/css">
        .flag{width:16px;margin:3px 2px 0px 0px;height:14px;float:left;overflow:hidden;padding:0px;}
        .unread{background:url(../../img/email/mail03423d.png) no-repeat -48px 0px}
        .read{background:url(../../img/email/mail03423d.png) no-repeat -48px -16px}
    </style>
</head>
<body style="margin:2px">
    <form id="form1" runat="server">
        <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
        </div>
    </form>
    <form style="display:none;" id="frmExport" action="../AppFrame/AppExport.aspx" method="post" target="_blank">
        <input id="condition" name="condition" value="<%=condition %>"/>
        <input id="fieldList" name="fieldList" value=""/>
    </form>
</body>
</html>

<script type="text/javascript">
<!--
    var _curClass = EZ.WebBase.SysFolder.WorkFlow.FlowMyPart;
    var _funId = '<%=base.GetParaValue("funId ") %>';
    var today=new Date();
    var dealTimeDefs = today.clone().addMonths(-1).toString("yyyy-MM-dd")+","+today.toString("yyyy-MM-dd") ;
    $("#flex1").flexigrid
	({
		url: '../../getdata.ashx?ds=flow_myread',
		params: [{ name: "queryid", value: "flowmyread" }
			, { name: "condition", value: "<%=condition %>" }
            , { name: "defaultvalue", value: "\"@employeeId\":\"<%=QueryEmpId %>\"" }
			],
		colModel: [
		{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center',hideExport:true},
        { display: '', name: 'ReadState', width: 20, sortable: true, align: 'center', hide: false, renderer: readCol },
		{ display: '任务名称', name: 'InstanceName', width: 260, sortable: true, align: 'left', renderer: transName },
		{ display: '任务状态', name: 'InstanceState', width: 60, sortable: true, align: 'center', renderer: getstate },
		{ display: '发起人', name: 'EmployeeName', width: 50, sortable: true, align: 'center' },
		{ display: '部门名称', name: 'DeptName', width: 70, sortable: true, align: 'center' },
        { display: '查阅时间', name: 'ReadTime', width: 100, sortable: true, align: 'center' },
		{ display: '传阅人', name: 'SenderName', width: 70, sortable: true, align: 'center' },
        { display: '传送时间', name: 'SendTime', width: 100, sortable: true, align: 'center' }
		],
		buttons: [
		{ name: '查询', bclass: 'view', onpress: app_query },
		{ name: '清空', bclass: 'clear', onpress: app_reset },
        { name: '导出', bclass: 'layout', onpress : app_export}
		],
		searchitems: [
		{ display: '任务名称', name: 'InstanceName', type: 1 },
		{ display: '传阅人', name: 'SenderName', type: 1 },
		{ display: '传送时间', name: 'SendTime', type: 4 },
        { display: '查阅状态', name: 'ReadState', type: 1, edit: 'select', data: '已读|已读,未读|未读', defvalue: '' }

		],
		sortname: "SendTime",
		sortorder: "desc",
		usepager: true,
		singleSelect: true,
		useRp: true,
		rp: 12,
		multisel: false,
		showTableToggleBtn: false,
		resizable: false,
		height: 'auto',
		onError: showError
	});
	function transName(fldval, row) {
	    var instanceId = $(row).attr("id");
	    var readId = $("ReadId", row).text();
        var htmlArr = [];
        htmlArr.push("<a href='../AppFrame/AppWorkFlowInfo.aspx?InstanceId=", instanceId, "&func=myread&readId=", readId, "' target='_blank'>" + fldval + "</a>&nbsp;");
        return htmlArr.join("");
    }

    function readCol(fldval, row) {
        if (fldval == "已读") {
            return "<div class='flag read'></div>";
        }
        else {
            return "<div class='flag unread'></div>";
        }
    }
    function transfld(fldval, row) {

        var htmlArr = [];
        htmlArr.push("<a class='normal' href=\"javascript:frechTask('" + fldval + "');\">撤回</a>&nbsp;");
        htmlArr.push("<a class='normal' target='_blank' href=\"../AppFrame/AppWorkflowPrint.aspx?InstanceId=" + fldval + "\">打印</a>");
        return htmlArr.join("");

    }


    function getstate(fldval, row) {
        if (fldval == "完成" || fldval == "处理中")
            return "<span style='color:green'>" + fldval + "</span>";
        else
            return "<span style='color:red'>" + fldval + "</span>";
    }


    function showError(data) {
    }
    function app_add(cmd, grid) {
        openCenter("DefBizEdit.aspx?nodewbs=", "_blank", 600, 400);
    }
    function app_reset(cmd, grid) {
        $("#flex1").clearQueryForm();
    }

    function app_query() {
        $("#flex1").flexReload();
    }
    function getField(p, fldName) {

        var len = p.colModel.length;
        for (var i = 0; i < len; i++) {
            if (p.colModel[i].name == fldName)
                return p.colModel[i];
        }
        return null;
    }
    function app_export(cmd, grid) {
        var op = $("#flex1")[0].p;
        var fldlist = [];
        $('th', grid).each(function () {
            var fieldId = $(this).attr("field");
            var fld = getField(op, fieldId);
            if (fieldId && (!fld.hideExport)) {
                var ename = fld.dbname || fld.name;
                fldlist.push(ename + "=" + fld.width + "=" + fld.display);
            }
        });
        $("#fieldList").val(fldlist.join("|"));
        var url = "../AppFrame/AppExport.aspx?queryId=flowmyread&ds=flow_myread" + "&query=" + op.condition
                    + "&sortname=" + op.sortname + "&sortorder=" + op.sortorder
                    + "&DefaultValue=@employeeId=<%=EmployeeID %>";

        jQuery("#frmExport").attr("action", url);
        jQuery("#frmExport").submit();
    }


    function frechTask(insId) {
        var ret = _curClass.FetchTask(insId);
        if (ret.error) {
            alert(ret.error.Message);
        }
        else {
            alert("撤回任务成功");
            $("#flex1").flexReload();
        }
    }
    function viewChart(instanceId) {
        var url = "InstanceChart.aspx?instanceId=" + instanceId;
        openCenter(url, "_blank", 1000, 700);
    }
    function openCenter(url, name, width, height) {
        var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
        if (window.screen) {
            var ah = screen.availHeight - 30;
            var aw = screen.availWidth - 10;
            var xc = (aw - width) / 2;
            var yc = (ah - height) / 2;
            if (yc < 0)
                yc = 0;
            str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
            str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
        }
        return window.open(url, name, str);
    }
//-->
</script>