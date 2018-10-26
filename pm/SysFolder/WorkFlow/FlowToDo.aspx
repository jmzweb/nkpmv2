<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowToDo.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowToDo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待办任务</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/ymPrompt_green/ymPrompt.css"/>
    
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../../js/ymPrompt.js"></script>
</head>
<body style="margin:2px">
    <form id="form1" runat="server">
        <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
        </div>
        <input type="hidden" value="" id="delegatePosId" />
        <input type="hidden" value="" id="delegateUserId" />
    </form>
    <form style="display:none;" id="frmExport" action="../AppFrame/AppExport.aspx" method="post" target="_blank">
        <input id="condition" name="condition" value="<%=base.GetParaValue("condition") %>"/>
        <input id="fieldList" name="fieldList" value=""/>
    </form>
    <form style="display:none;" id="frmBatch" action="DealBatch.aspx" method="post" target="_blank">
        <input id="TaskIdList" name="TaskIdList" value=""/>
    </form>
</body>
</html>
<script type="text/javascript">
<!--
    var _curClass = EZ.WebBase.SysFolder.WorkFlow.FlowToDo;
    var _funId = '<%=base.GetParaValue("funId ") %>';
    var multiRow =[];
	$("#flex1").flexigrid
	({
	    url: '../../getdata.ashx?ds=flow_todo',
	    params:[{name:"queryid",value:"flowtodo"}
			    , { name: "condition", value: "<%=base.GetParaValue("condition") %>" }
			    , { name: "defaultvalue", value: "\"@employeeId\":\"<%=EmpId %>\"" }
			    ],
	    colModel : [
		    { display: '选择', name: 'utaskid', width: 30, sortable: false, align: 'center', renderer: chkCol,hideExport:true},
		    { display: '任务名称', name: 'instancename', width: 260, sortable: true, align: 'left', renderer:transTask},
		    { display: '操作', name: 'utaskid', width: 150, sortable: false, align: 'left', renderer: transfld, hideExport:true},
		    { display: '到达时间', name: 'arrivetime', width: 100, sortable: true, align: 'left'},
		    { display: '流程名称', name: 'workflowname', width: 120, sortable: true, align: 'left'},
		    { display: '步骤名称', name: 'taskname', width: 80, sortable: true, align: 'center'},
		    { display: '发起人', name: 'createuser', width: 60, sortable: true, align: 'center'},
		    { display: '发起时间', name: 'createtime', width: 100, sortable: true, align: 'left',dbname:'_createtime',hide:true},
		    { display: '任务代理人', name: 'agentName', width: 60, sortable: true, align: 'center'}
		    ],
	    buttons : [

		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
		    { separator: true },
            //{ name: '修改标题', bclass: 'edit', onpress: app_edit },
            //{ name: '终止任务', bclass: 'delete', onpress: app_stop },
		    //{ separator: true },
            { name: '转交', bclass: 'arrow', onpress: app_transfer},
            { name: '委托', bclass: 'arrow', onpress: app_delegate},
            { name: '批量审批', bclass: 'check', onpress: app_batch},
            { separator: true },
            { name: '导出', bclass: 'excel', onpress : app_export}
		    ],
	    searchitems :[
		    { display: '任务名称', name: 'instancename', type: 1 },
		    { display: '流程名称', name: 'workflowname', type: 1 },
		    { display: '发起公司', name: 'companyname', type: 1 },
		    { display: '发起人', name: 'createuser', type: 1 }
		    //{ display: '到达时间', name: 'arrivetime', type: 4 }
		    ],
	        sortname: "arrivetime",
	        sortorder: "desc",
	        usepager: true,
	        singleSelect:true,
	        useRp: true,
	        rp: 15,
            singleSelect:false,
            showToggleBtn:false,
	        resizable:false,
            height:'auto',
            onLoad:fnLoad,
	        onError:showError,
	        preProcess: processData,
            onRowSelect:fnRowSelect
	    }
	);
    function fnLoad(){
        $(".hDivBox th:first").html("<div style='width:30px;text-align: center;padding-top:2px;padding-bottom:2px;' title='全选'><input type=\"checkbox\" name=\"checkAll\" onclick=\"CheckAll();\" id=\"checkAll\" ></div>");
    }
    var xmldata;
	function processData(data)
	{
        $("#checkAll").prop("checked",false);
		return xmldata=jQuery(data);
	}
    function showError(data)
	{
    }
    function CheckAll(){  
        var checkAll = $("#checkAll").prop("checked");
        $(".selcheck").each(function(){
            $(this).prop("checked",checkAll);
            setvalue(this);
        });
    }
    function chkCol(fldval,row,td)
	{
		var key=$(row).attr("id");
        var chk = hasChecked(key);
        if(chk!="")
            $(td).parent().addClass("trSelected");
        return "<input type='checkbox' "+ hasChecked(key) +" class='chkcol selcheck' name='selcheck' key='"+key+"' onclick='setvalue(this)' />";
	}
    function setvalue(obj){
        var srcEl = $(obj);
		var key=srcEl.attr("key");
        var valArr=[];
        var checked = srcEl.prop("checked");
        if(checked){
            $("#row"+key).addClass("trSelected");
            addChecked(key,valArr);
        }
        else{
            $("#row"+key).removeClass("trSelected");
            delChecked(key);
        }
        
    }
    function fnRowSelect(row,selected) {
        var rowId = row.attr("id").substr(3);
        var valArr=[];
        $(".selcheck",row).prop("checked",selected);
        if(selected)
            addChecked(rowId,valArr);
        else
            delChecked(rowId);
    }

    function hasChecked( key){
        for (var i = 0; i < multiRow.length; i++) {
            if(multiRow[i].id == key)
                return "checked";
        }
        return "";
    }

    function addChecked( key,valArr){
        for (var i = 0; i < multiRow.length; i++) {
            if(multiRow[i].id == key)
                return ;
        }
        multiRow.push({"id":key,"data":valArr});
    }

    function delChecked( key,valArr){
        for (var i = 0; i < multiRow.length; i++) {
            if(multiRow[i].id == key){
                multiRow.splice(i,1);
                return;
            }
        }
    }

    function transTask(fldval,row,td){
        var instanceId = $("instanceid", row).text();
        var utaskId = $("utaskid", row).text();
		if ("<%=EmpId %>" == "<%=EmployeeID %>") {
			return "<a class='normal' href=\"javascript:dealTask('" + utaskId + "');\">" + fldval + "</a>";
		}
		else {
			return "<a class='normal' href=\"javascript:viewTask('" + instanceId + "');\">" + fldval + "</a>";
        }
    }
	function transfld(fldval,row,td)
	{
		var instanceId = $("instanceid", row).text();
        var state = $("taskstate", row).text();
		if ("<%=EmpId %>" == "<%=EmployeeID %>") {
            var arr=[];
            if(state == "4"){
                arr.push("<a class='normal' href=\"javascript:dealTask('" + fldval + "');\">【加签情况】</a>");                
            }
            else{
                arr.push("<a class='normal' href=\"javascript:dealTask('" + fldval + "');\">【办理】</a>");
                arr.push("<a class='normal green' href=\"javascript:app_edit('" + instanceId + "');\">修改标题</a>&nbsp;");
            }
            arr.push("<a class='normal red' href=\"javascript:app_stop('" + instanceId + "');\">终止</a>");
			return arr.join("&nbsp;");
		}
		else {
			return "<a class='normal' href=\"javascript:viewTask('" + instanceId + "');\">查看</a>";
        }
			    

	}

    function app_batch(cmd,grid){
        var TaskIdList=[];
        if(multiRow.length==0)
        {
            alert("请先选择任务");
            return;
        }

        for (var i = 0; i < multiRow.length; i++) {
            TaskIdList.push(multiRow[i].id);
        }
        //openCenter('DealBatch.aspx?TaskIdList='+TaskIdList.join(","), "_blank", 600, 300);

        jQuery("#TaskIdList").val(TaskIdList.join(","));
        jQuery("#frmBatch").submit();
    }
	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}
	function app_edit(editid) {
		openCenter("Admin_UpdateTitle.aspx?instanceId=" + editid, "_blank", 600, 400);
	}
	function app_stop(editid) {

		openCenter("Admin_StopInstance.aspx?instanceId=" + editid, "_blank", 600, 400);
	}

    function _getRowId(){
        if($('.trSelected',"#flex1").length>0)
		{
			var editId = $('.trSelected',"#flex1")[0].id.substr(3);
            return editId;
        }
        return "";
    }

    //转交
    function app_transfer(cmd, grid) {

        if(multiRow.length == 0)
        {
            alert("请先选择任务");
            return;
        }

        jQuery("#delegateUserId").val("");
        jQuery("#delegatePosId").val("");
        jQuery("#txtDelegate").val("");
        var arr = [];
        arr.push("<table><tr><td colspan='2'>")
        arr.push("你确认把选中的任务转交他人处理吗？", "<br/><br/>");
        arr.push("</td>")
        arr.push("<tr><td>")
        arr.push("任务接收人：")
        arr.push("</td><td>")
        arr.push("<input type=text value='' style='height:20px;width:80px;' class='textbox' id='txtDelegate'>");
        arr.push("&nbsp;<input type=button value='选择' onclick='selUser();'/>");
        arr.push("</td><tr>")
        ymPrompt.confirmInfo({ 
			message: arr.join(""),
            width: 360,
            height: 200,
            title: '任务转交',
            maxBtn: false,
            minBtn: false,
            handler: transferTask
        });

    }

    function transferTask(cmd) {
        var empId = jQuery("#delegateUserId").val();
        var posId = jQuery("#delegatePosId").val();
        if (cmd == "ok" && empId!="") {
            var list = [];
            for (var i = 0; i < multiRow.length; i++) {
                list.push(multiRow[i].id);
            }
            var ret = _curClass.updateTaskOwner(list, empId, posId);
            if (ret.error) {
                alert("出错："+ret.error.Message);
            }
            else {
                alert("保存成功");
                $("#flex1").flexReload();
            }

        }
    }
    //委托
	function app_delegate(cmd, grid) {
        
        if(multiRow.length == 0)
        {
            alert("请先选择任务");
            return;
        }
		var arr = [];
		arr.push("<table><tr><td colspan='2'>")
		arr.push("你确认把选中的任务委托他人处理吗？", "<br/><br/>");
		arr.push("</td>")
		arr.push("<tr><td>")
        arr.push("任务接收人：")
        arr.push("</td><td>")
        arr.push("<input type=text value='' style='height:20px;width:80px;' class='textbox' id='txtDelegate'>");
        arr.push("&nbsp;<input type=button value='选择' onclick='selUser();'/>");
        arr.push("</td><tr>")
		ymPrompt.confirmInfo({ 
				message: arr.join(""),
			    width: 360,
			    height: 200,
			    title: '任务委托',
			    maxBtn: false,
			    minBtn: false,
			    handler: delegateTask
			});

		}

	function selUser() {
		openCenter('../Common/UserTree.aspx?method=1&queryfield=empid,empname,posid&cid=delegateUserId,txtDelegate,delegatePosId', "_blank", 640, 500);
	}

	function delegateTask(cmd) {
		var empId = jQuery("#delegateUserId").val();
		if (cmd == "ok" && empId != "") {
			var list = [];
            for (var i = 0; i < multiRow.length; i++) {
                list.push(multiRow[i].id);
            }
			var ret = _curClass.updateTaskAgent(list, empId);
			if (ret.error) {
			    alert("出错：" + ret.error.Message);
			}
			else {
			    alert("保存成功");
			    $("#flex1").flexReload();
			}

		}
    }
	function app_query()
	{
		$("#flex1").flexReload();
	}
    function getField(p,fldName){

        var len = p.colModel.length;
        for (var i = 0; i < len; i++) {
            if(p.colModel[i].name == fldName)
                return p.colModel[i];
        }
        return null;
    }
    function app_export(cmd,grid)
    {
		var op =$("#flex1")[0].p;
        var fldlist=[];
		$('th',grid).each(function(){
            var fieldId=$(this).attr("field");
            var fld = getField(op,fieldId);
			if(fieldId && (!fld.hideExport)){
                var ename= fld.dbname || fld.name;
			    fldlist.push(ename+"="+fld.width+"="+fld.display);
            }
		});
        $("#fieldList").val(fldlist.join("|"));
        var url = "../AppFrame/AppExport.aspx?queryId=flowtodo&ds=flow_todo&fileName="+escape("我的待办列表")+"&sheetName="+escape("我的待办列表")+"&query="+op.condition
            +"&sortname="+op.sortname+"&sortorder="+op.sortorder
            +"&DefaultValue=@employeeId=<%=EmpId %>";

        jQuery("#frmExport").attr("action",url);
        jQuery("#frmExport").submit();
    }

	function dealTask(taskId) {
		var url = "DealFlow.aspx?taskId="+taskId;
		window.open(url,"_blank");
	}

	function viewTask(insId) {
		var url = "../AppFrame/AppWorkFlowInfo.aspx?InstanceId=" + insId;
		window.open(url,"_blank");
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
		    str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
		    str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
	    }
	    return window.open(url, name, str);
    }
//-->
</script>       