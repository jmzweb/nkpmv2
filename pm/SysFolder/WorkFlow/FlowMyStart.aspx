<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowMyStart.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowMyStart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>我发起的流程</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    
    <script type="text/javascript" src="../../grid/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
</head>
<body style="margin:2px">
    <form id="form1" runat="server">
        <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
<!--
    var _funId = '<%=base.GetParaValue("funId ") %>';
    var _curClass = EZ.WebBase.SysFolder.WorkFlow.FlowMyStart;
    $("#flex1").flexigrid
	({
		url: '../../getdata.ashx?ds=flow_mystart',
		params: [{ name: "queryid", value: "flowmystart" }
			, { name: "condition", value: "<%=condition %>" }
			],
		colModel: [
		{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center' },
		{ display: '任务名称', name: 'InstanceName', width: 200, sortable: true, align: 'left', renderer: transTask },
		{ display: '状态', name: 'InstanceState', width: 50, sortable: true, align: 'center', renderer: getstate },
		{ display: '操作', name: 'InstanceId', width: 180, sortable: false, align: 'center', renderer: transfld },
		{ display: '流程名称', name: 'WorkflowName', width: 140, sortable: true, align: 'left' },
		{ display: '发起时间', name: '_CreateTime', width: 100, sortable: true, align: 'center' },
        { display: '当前步骤', name: 'ActiveNode', width: 70, sortable: true, align: 'center' },
		{ display: '当前处理人', name: 'ActiveEmployee', width: 80, sortable: true, align: 'center' },
		{ display: '完成时间', name: 'FinishTime', width: 100, sortable: true, align: 'left' },
		{ display: '办理截止日期', name: 'Deadline', width: 100, sortable: true, align: 'left' }
		],
		buttons: [
		//{ name: '查看', bclass: 'add', onpress: app_add },
		{ name: '删除暂存任务', bclass: 'delete', onpress: app_delete },
		//{ name: '修改标题', bclass: 'edit', onpress : app_edit },
        //{ name: '终止任务', bclass: 'delete', onpress: app_stop },
        { name: '设置公开范围', bclass: 'setting', onpress: app_scope },
		{separator: true },
		{ name: '查询', bclass: 'view', onpress: app_query },
		{ name: '清空', bclass: 'clear', onpress: app_reset }
		],
		searchitems: [
		{ display: '任务名称', name: 'InstanceName', type: 1 },
		{ display: '流程名称', name: 'WorkflowName', type: 1 },
		{ display: '发起时间', name: '_CreateTime', type: 4 },
        { display: '任务状态', name: 'InstanceState', type: 1, edit: 'select', data: '处理中|处理中,完成|完成,终止|终止,归档|归档,', defvalue: '' }
		],
		sortname: "_CreateTime",
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
    function transTask(fldval, row) {
        var instanceId = $("InstanceId", row).text();
        var htmlArr = [];
        htmlArr.push("<a class='normal' href='../AppFrame/AppWorkFlowInfo.aspx?InstanceId=" + instanceId + "' target='_blank'>", fldval, "</a>");
        return htmlArr.join("");
    }
    function transfld(fldval, row) {
        var htmlArr = [];
        var state = $("InstanceState", row).text();
        var onDeal = state == "处理中";
        if (onDeal) {
            htmlArr.push("<a class='normal green' href=\"javascript:frechTask('" + fldval + "');\">撤回</a>&nbsp;");
            htmlArr.push("<a class='normal blue' href=\"javascript:duTask('" + fldval + "');\">催办</a>&nbsp;");
            htmlArr.push("<a class='normal red' href=\"javascript:app_stop('" + fldval + "');\">终止</a>&nbsp;");
            htmlArr.push("<a class='normal' href=\"javascript:app_edit('" + fldval + "');\">修改标题</a>");
        }
        return htmlArr.join("");

    }
    function duTask(insId) {
        var url = '<%=ResolveUrl("~/SysFolder/Workflow/FlowDuBan.aspx")%>?instanceId=' + insId;
        var dlg = new $.dialog({ title: '任务催办', page: url
          , btnBar: false, cover: true, lockScroll: false, width: 700, height: 400, bgcolor: 'gray'

        });
        dlg.ShowDialog();
    }

    function getstate(val, row) {
        var arr = [];
        switch (val) {
            case "":
                arr.push("<a class='tdbtn' style='background-color:#bc8f8f;color:white;' >未发起</a>");
                break;
            case "未发起":
                arr.push("<a class='tdbtn' style='background-color:#00ced1;color:white;' >&nbsp;&nbsp;暂存&nbsp;&nbsp;</a>");
                break;
            case "处理中":
                arr.push("<a class='tdbtn'  style='background-color:#9acd32;color:white;' >处理中</a>");
                break;
            case "完成":
                arr.push("<a class='tdbtn'  style='background-color:#3cb371;color:white;' >&nbsp;&nbsp;完成&nbsp;&nbsp;</a>");
                break;
            case "归档":
                arr.push("<a class='tdbtn'  style='background-color:#3cb371;color:white;' >&nbsp;&nbsp;归档&nbsp;&nbsp;</a>");
                break;
            case "终止":
                arr.push("<a class='tdbtn'  style='background-color:#cd5c5c;color:white;' >&nbsp;&nbsp;终止&nbsp;&nbsp;</a>");
                break;
            default:
                arr.push("<a class='tdbtn'  style='background-color:#3cb371;color:white;' >&nbsp;&nbsp;" + val + "&nbsp;&nbsp;</a>");
                break;
        }

        return arr.join("");
    }
    function app_stop(editid) {
				
		openCenter("Admin_StopInstance.aspx?instanceId="+editid,"_blank",600,400);
	}

	function app_scope(cmd, grid) {
	    var editid = $('.trSelected', grid)[0].id.substr(3);
	    openCenter("QueryLimitSet.aspx?open=1&insId=" + editid, "_blank", 800, 400);
    }

    function showError(data) {
    }
    function app_add(cmd, grid) {
        openCenter("DefBizEdit.aspx?nodewbs=", "_blank", 600, 400);
    }
    function app_reset(cmd, grid) {
        $("#flex1").clearQueryForm();
    }
    function app_edit(editid) {
        openCenter("Admin_UpdateTitle.aspx?instanceId=" + editid , "_blank", 600, 400);
    }
    function app_delete(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            if (confirm('您确认删除该任务吗?')) {
                $('.trSelected', grid).each
			    (function () {
			            var ret = EZ.WebBase.SysFolder.WorkFlow.FlowMyStart.RemoveInstance(this.id.substr(3));
			            if (ret.error) {
			                alert(ret.error.Message);
			            }
			            else { 
                            $("#flex1").flexReload();
                        }
			     });
            }
        }
        else {
            alert("请选中一条记录");
        }
    }
    function app_query() {
        $("#flex1").flexReload();
    }
    function app_setquery() {
        window.showModalDialog("AppConditionDef.aspx", "", "dialogHeight=600px;dialogWidth=800px;status=no;center=yes;resizable=yes;");
    }
    function dealTask(insId) {
        var url = "../AppFrame/AppWorkFlowInfo.aspx?InstanceId=" + insId;
        window.open(url, "_blank");
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