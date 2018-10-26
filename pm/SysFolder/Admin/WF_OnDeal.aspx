<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_OnDeal.aspx.cs" Inherits="EIS.WebBase.SysFolder.WorkFlow.Admin_OnDeal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>处理中流程查询</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
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
    var _curClass = EIS.WebBase.SysFolder.WorkFlow.Admin_OnDeal;
    $("#flex1").flexigrid
	({
	    url: '../../getdata.ashx?ds=Flow_Admin',
		params: [{ name: "queryid", value: "flow_admin_ondeal" }
			, { name: "condition", value: "<%=RoleOrgFilter %>" }
			],
		colModel: [
		{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center', hideExport: true },
		{ display: '任务名称', name: 'InstanceName', width: 200, sortable: true, align: 'left',renderer:fnTitle },
		{ display: '处理', name: 'InstanceId', width: 50, sortable: false, align: 'center', renderer: transfld, hideExport: true },
		{ display: '公司名称', name: 'CompanyName', width: 60, sortable: true, align: 'left' },
		{ display: '发起人', name: 'EmployeeName', width: 40, sortable: true, align: 'left' },
		{ display: '部门名称', name: 'DeptName', width: 60, sortable: false, align: 'center' },
		{ display: '发起时间', name: '_CreateTime', width: 100, sortable: true, align: 'left' },
		{ display: '时长', name: 'Hours', width: 40, sortable: true, align: 'left', renderer: fnTime },
		{ display: '到达时间', name: 'ArriveTime', width: 100, sortable: true, align: 'left' },
		{ display: '当前步骤', name: 'ActiveNode', width: 100, sortable: true, align: 'left' },
		{ display: '当前处理人', name: 'ActiveEmployee', width: 80, sortable: true, align: 'left' },
		{ display: '流程名称', name: 'WorkflowName', width: 100, sortable: true, align: 'left' }
		],
		buttons: [
		{ name: '完成', bclass: 'check', onpress: app_finish },
		{ name: '维护', bclass: 'wrench', onpress: app_mtain },
		{ name: '修改标题', bclass: 'edit', onpress : app_edit },
		{ name: '终止任务', bclass: 'stop', onpress: app_stop },
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
		{ display: '发起人', name: 'EmployeeName', type: 1 },
		{ display: '发起时间', name: '_CreateTime', type: 4 },
		{ display: '公司名称', name: 'CompanyName', type: 1 },

        { display: '流程名称', name: 'WorkflowName', type: 1 },
        { display: '当前步骤', name: 'ActiveNode', type: 1 },
        { display: '当前处理人', name: 'ActiveEmployee', type: 1 },
        { display: '小时数', name: 'Hours', type: 2 }
		],
		sortname: "_CreateTime",
		sortorder: "desc",
		usepager: true,
		singleSelect: false,
		useRp: true,
		rp: 10,
		showTableToggleBtn: false,
		resizable: false,
		height: "auto",
		onError: showError
	}
	);
    function fnTitle(v, row) {
        var insId = $(row).attr("id");
        return ("<a title='" + v + "' class='normal' href=\"javascript:dealTask('" + insId + "');\" >" + v + "</a>");
        
    }
	function transfld(fldval,row)
	{
		var arr = [];
		arr.push("<a class='normal' href='../AppFrame/AppWorkflowPrint.aspx?InstanceId=" + fldval + "' target='_blank'>打印</a>");
		return arr.join("");
	}
	function fnTime(v, row) { 
        var h = parseInt(v);
        if(h < 24)
            return h+" 小时";
        else if(h<24*30)
            return Math.ceil(h/24)+" 天";
        else
            return Math.floor(h /(24*30)) + " 月";
    }
	function showError(data)
	{
	}
	function app_mtain(cmd, grid) {
	    if ($('.trSelected', grid).length > 0) {
	        var insId = $('.trSelected', grid)[0].id.substr(3);
	        var url = "../Workflow/admin/Admin_Maintain.aspx?InstanceId=" + insId;
	        window.open(url, "_blank");
	    }
	    else {
	        alert("请选中一条记录");
	    }
    }
	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}
	function app_edit(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
			var editid=$('.trSelected',grid)[0].id.substr(3);
			openCenter("../Workflow/Admin_UpdateTitle.aspx?instanceId=" + editid, "_blank", 600, 400);
		}
		else
		{
			alert("请选中一条记录");
		}
	}

	function app_finish(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
		    if (confirm('您确定结束这 ' + $('.trSelected', grid).length + ' 个流程任务吗?'))
			{
			    $('.trSelected',grid).each
			    (
			        function() {
			            var ret = _curClass.FinishInstance(this.id.substr(3));
			            if(ret.error)
			            {
			                alert(ret.error.Message);
			            }
			        }
			    );
				$("#flex1").flexReload();
			}
		}
		else
		{
			alert("请选中一条记录");
		}
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
        var url = "../AppFrame/AppExport.aspx?ds=Flow_Admin&queryId=flow_admin_ondeal" + "&query=" + op.condition
                        + "&sortname=" + op.sortname + "&sortorder=" + op.sortorder;
        jQuery("#frmExport").attr("action", url);
        jQuery("#frmExport").submit();
    }

	function app_stop(cmd,grid)
	{
		var editid=$('.trSelected',grid)[0].id.substr(3);
		openCenter("../Workflow/Admin_StopInstance.aspx?instanceId="+editid,"_blank",600,400);
	}

	function app_delete(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
			if(confirm('确定删除这 ' + $('.trSelected',grid).length + ' 条记录吗，删除以后数据将无法恢复?')) {
			    var arr = [];
			    $('.trSelected', grid).each(function () {
			        arr.push(this.id.substr(3));
			    });

			    var ret = _curClass.RemoveInstanceExt(arr.join(","), cmd=="删除");
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