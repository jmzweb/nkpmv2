<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Finish.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.Admin_Finish" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>历史流程查询</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    
    <script type="text/javascript" src="../../grid/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
</head>
<body style="margin:2px">
    <form id="form1" runat="server">
        <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
    <form style="display:none;" id="frmExport" action="../AppFrame/AppExport.aspx" method="post" target="_blank">
        <input id="condition" name="condition" value="<%=base.GetParaValue("condition") %>"/>
        <input id="fieldList" name="fieldList" value=""/>
    </form>
</body>
</html>
<script type="text/javascript">
<!--

    var _curClass = EZ.WebBase.SysFolder.WorkFlow.Admin_Finish;
    $("#flex1").flexigrid
	({
	    url: '../../getdata.ashx?ds=Flow_Admin',
		params: [{ name: "queryid", value: "flow_admin_finish" }
			, { name: "condition", value: "1=1" }
            , { name: "defaultvalue", value: "\"@employeeId\":\"<%=EmployeeID %>\"" }
			],
		colModel: [
		{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center', hideExport: true },
		{ display: '任务名称', name: 'InstanceName', width: 200, sortable: true, align: 'left', renderer: fnTitle },
		{ display: '处理', name: 'InstanceId', width: 50, sortable: false, align: 'center', renderer: transfld, hideExport: true },
		{ display: '状态', name: 'InstanceState', width: 50, sortable: true, align: 'center', renderer: getstate },
		{ display: '发起人', name: 'EmployeeName', width: 50, sortable: true, align: 'left' },
		{ display: '部门名称', name: 'DeptName', width: 100, sortable: false, align: 'left' },
        { display: '公司名称', name: 'CompanyName', width: 100, sortable: false, align: 'left' },
        { display: '流程名称', name: 'WorkflowName', width: 100, sortable: false, align: 'left' },
		{ display: '发起时间', name: '_CreateTime', width: 100, sortable: true, align: 'left' },
		{ display: '完成时间', name: 'FinishTime', width: 100, sortable: true, align: 'left' },
        { display: '用时', name: 'Hours', width: 40, sortable: true, align: 'left', renderer: fnTime }
		],
		buttons: [
		{ name: '撤回', bclass: 'return', onpress: app_back },
        { name: '删除任务', bclass: 'delete', onpress: app_delete, title: '仅删除流程数据' },
        { name: '删除', bclass: 'delete', onpress: app_delete, title: '删除流程数据和业务数据' },
		{ separator: true },
		{ name: '查询', bclass: 'view', onpress: app_query },
		{ name: '清空', bclass: 'clear', onpress: app_reset },
		{ separator: true },
        { name: '导出', bclass: 'excel', onpress: app_export }
		],
		searchitems: [
		{ display: '任务名称', name: 'InstanceName', type: 1 },
        { display: '流程名称', name: 'WorkflowName', type: 1 },
		{ display: '发起人', name: 'EmployeeName', type: 1 },
        { display: '公司名称', name: 'CompanyName', type: 1 },
		{ display: '发起时间', name: '_CreateTime', type: 4 },
        { display: '任务状态', name: 'InstanceState', type: 1, edit: 'radio', data: '完成|完成,归档|归档,终止|终止,', defvalue: '' },
        { display: '小时数', name: 'Hours', type: 2 }
		],
		sortname: "",
		sortorder: "",
		usepager: true,
		singleSelect: true,
		useRp: true,
		rp: 12,
		multisel: false,
		showTableToggleBtn: false,
		resizable: false,
		height: "auto",
		onError: showError
	}
	);

    function fnTitle(v, row) {
        var insId = $(row).attr("id");
        return ("<a class='normal' href=\"javascript:dealTask('" + insId + "');\" >" + v + "</a>");

    }
	function transfld(fldval,row)
	{
		var arr = [];
		arr.push("<a class='normal' href='../AppFrame/AppWorkflowPrint.aspx?InstanceId=" + fldval + "' target='_blank'>打印</a>");
		return arr.join("");

    }

	function fnTime(v, row) {
	    var h = parseInt(v);
	    if (h < 24)
	        return h + " 小时";
	    else if (h < 24 * 30)
	        return Math.ceil(h / 24) + " 天";
	    else
	        return Math.floor(h / (24 * 30)) + " 月";
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
	    }

	    return arr.join("");
	}

	function showError(data)
	{
	}

	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}

    function app_back(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            if (confirm('确定撤回这个流程吗?')) {
                $('.trSelected', grid).each
			    (
			        function () {
			            var ret = _curClass.FetchInstance(this.id.substr(3));
			            if (ret.error) {
			                alert(ret.error.Message);
			            }
			            else {
			                alert("成功撤回");
			            }
			        }
			    );
                $("#flex1").flexReload();
            }
        }
        else {
            alert("请选中一条记录");
        }
    }

	function app_delete(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
		    if (confirm('确定删除这 ' + $('.trSelected', grid).length + ' 条记录吗，删除以后数据将无法恢复?')) {
		        var arr = [];
		        $('.trSelected', grid).each(function () {
		            arr.push(this.id.substr(3));
		        });

		        var ret = _curClass.RemoveInstanceExt(arr.join(","), cmd == "删除");
		        if (ret.error) {
		            alert(ret.error.Message);
		        }

		        $("#flex1").flexReload();
		    }
		}
		else
		{
			alert("请选中一条记录");
		}
	}
	function app_query()
	{
		$("#flex1").flexReload();
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
        var url = "../AppFrame/AppExport.aspx?ds=Flow_Admin&queryId=flow_admin_finish&query=" + op.condition
                            + "&sortname=" + op.sortname + "&sortorder=" + op.sortorder;
        jQuery("#frmExport").attr("action", url);
        jQuery("#frmExport").submit();
    }
    function getField(p, fldName) {

        var len = p.colModel.length;
        for (var i = 0; i < len; i++) {
            if (p.colModel[i].name == fldName)
                return p.colModel[i];
        }
        return null;
    }
	function dealTask(insId) {
	    var url = "../AppFrame/AppWorkFlowInfo.aspx?InstanceId=" + insId;
		window.open(url, "_blank");
	}

	function viewChart(instanceId) {
		var url = "../Workflow/InstanceChart.aspx?instanceId=" + instanceId;
		openCenter(url, "_blank", 1000, 700);
	}
	function openCenter(url,name,width,height)
    {
	    var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
	    if (window.screen)
	    {
		    var ah = screen.availHeight - 30;
		    var aw = screen.availWidth - 10;
		    var xc = (aw - width) / 2;
		    var yc = (ah - height) / 2;
		    if (yc < 0) yc = 0;
		    str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
		    str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
	    }
	    return window.open(url, name, str);
    }
//-->
</script>