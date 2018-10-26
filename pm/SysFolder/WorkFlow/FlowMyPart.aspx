<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowMyPart.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowMyPart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>我参与的流程</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/DateExt.js"></script>
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
    <form style="display:none;" id="frmExport" action="../AppFrame/AppExport.aspx" method="post" target="_blank">
        <input id="condition" name="condition" value="<%=condition %>"/>
        <input id="fieldList" name="fieldList" value=""/>
    </form>
</body>
</html>
<script src="../../Js/jquery.zbox.js" type="text/javascript"></script>
<script type="text/javascript">
    jQuery(function () {
        $("#DeptId").live("click", function () {
            var pos = $(this).offset();
            var _ov = $(this).val();
            var t = pos.top + $(this).height() + 5;
            var frm = $("#orgFrame");
            if (frm.length == 0) {
                frm = $('<iframe id="orgFrame" frameborder="0" width="260" height="300" src="../common/DeptTreeFrame.aspx?cid=DeptId,DeptId_hid&queryfield=deptname,deptid"></iframe>');
            }
            $.zbox(frm, { title: "组织机构选择", bg: false, drag: true, left: pos.left, top: t, onclose:
                function () {
                    var _nv = $("#DeptName").val();
                    if (_ov != _nv)
                        app_query();
                    $("body").unbind("click");
                }
            });
            $("body").one("click", function () { $.zbox.hide(); });
        });
    });
</script>

<script type="text/javascript">
<!--
    var today = new Date();
    var _funId = '<%=base.GetParaValue("funId ") %>';
    var _curClass = EZ.WebBase.SysFolder.WorkFlow.FlowMyPart;
    var dealTimeDefs = today.clone().addMonths(-1).toString("yyyy-MM-dd")+","+today.toString("yyyy-MM-dd") ;
    $("#flex1").flexigrid
			(
			{
			    url: '../../getdata.ashx?ds=flow_mypart',
			    params: [{ name: "queryid", value: "flowmypart" }
			        , { name: "condition", value: "<%=condition %>" }
                    , { name: "defaultvalue", value: "\"@employeeId\":\"<%=QueryEmpId %>\"" }
			        ],
			    colModel: [
				{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center',hideExport:true},
				{ display: '任务名称', name: 'InstanceName', width: 200, sortable: true, align: 'left', renderer: transName },
				{ display: '状态', name: 'InstanceState', width: 50, sortable: true, align: 'center', renderer: getstate },
				{ display: '处理', name: 'InstanceId', width: 100, sortable: false, align: 'center', renderer: transfld, hideExport: true },
				{ display: '发起人', name: 'EmployeeName', width: 50, sortable: true, align: 'center' },
				{ display: '部门名称', name: 'DeptName', width: 70, sortable: true, align: 'center' },
		        { display: '流程名称', name: 'WorkflowName', width: 140, sortable: true, align: 'left' },
                { display: '处理时间', name: 'DealTime', width: 100, sortable: true, align: 'center' },
				{ display: '发起时间', name: '_CreateTime', width: 100, sortable: true, align: 'center' },
                { display: '当前步骤', name: 'ActiveNode', width: 80, sortable: true, align: 'center' },
				{ display: '当前处理人', name: 'ActiveEmployee', width: 100, sortable: true, align: 'center' }
				],
			    buttons: [
				{ name: '查询', bclass: 'view', onpress: app_query },
				{ name: '清空', bclass: 'clear', onpress: app_reset },
                { name: '导出', bclass: 'layout', onpress : app_export}
				],
			    searchitems: [
			    { display: '任务名称', name: 'InstanceName', type: 1 },
		        { display: '流程名称', name: 'WorkflowName', type: 1 },
			    { display: '发起部门', name: 'DeptId', shadow: true, type: 1 },
			    { display: '发起人', name: 'EmployeeName', type: 1 },
			    { display: '处理时间', name: 'DealTime', type: 4, defvalue: dealTimeDefs },
                { display: '任务状态', name: 'InstanceState', type: 1, edit: 'select', data: '处理中|处理中,完成|完成,终止|终止,归档|归档,', defvalue: '' }

			    ],
			    sortname: "DealTime",
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
			}
			);
	function transName(fldval, row) {
        var instanceId = $(row).attr("id");
        var htmlArr = [];
        htmlArr.push("<a href=\"javascript:dealTask('" + instanceId + "');\">" + fldval + "</a>&nbsp;");
        return htmlArr.join("");
    }
    function transfld(fldval, row) {

        var htmlArr = [];
        htmlArr.push("<a class='normal' href=\"javascript:frechTask('" + fldval + "');\">撤回</a>&nbsp;");
        htmlArr.push("<a class='normal green' href=\"javascript:duTask('" + fldval + "');\">催办</a>&nbsp;");
        htmlArr.push("<a class='normal' target='_blank' href=\"../AppFrame/AppWorkflowPrint.aspx?InstanceId=" + fldval + "\">打印</a>");
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


    function showError(data) {
    }
    function app_add(cmd, grid) {
        openCenter("DefBizEdit.aspx?nodewbs=", "_blank", 600, 400);
    }
    function app_reset(cmd, grid) {
        $("#flex1").clearQueryForm();
    }
    function app_edit(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            var editid = $('.trSelected', grid)[0].id.substr(3);
            openCenter("DefBizEdit.aspx?editid=" + editid + "&nodewbs=", "_blank", 600, 400);
        }
        else {
            alert("请选中一条记录");
        }
    }
    function app_delete(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            if (confirm('确定删除这' + $('.trSelected', grid).length + '条记录吗?')) {
                $('.trSelected', grid).each
			            (
			                function () {
			                    var ret = EZ.WebBase.SysFolder.DefFrame.DefBizList.DelRecord(this.id.substr(3));
			                    if (ret.error) {
			                        alert(ret.error.Message);
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
        var url = "../AppFrame/AppExport.aspx?queryId=flowmypart&ds=flow_mypart" + "&query=" + op.condition
                    + "&sortname=" + op.sortname + "&sortorder=" + op.sortorder
                    + "&DefaultValue=@employeeId=<%=EmployeeID %>";

        jQuery("#frmExport").attr("action", url);
        jQuery("#frmExport").submit();
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