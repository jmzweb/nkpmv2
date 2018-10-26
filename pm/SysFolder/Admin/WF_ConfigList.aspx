<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QXList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Limit.QXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>查询</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css?v=2016"/>
    <link rel="stylesheet" type="text/css" href="../../Css/appList.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
</head>
<body style="margin:1px;" scroll="no">
    <form id="form1" runat="server">
    <div id="griddiv" >
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
<!--

    var multi = '<%=GetParaValue("multi") %>'=="1";
    var para = "";
	$("#flex1").flexigrid
	({
	    url: '../getxml.ashx',
	    params:[{name:"queryid",value:"Q_WF_Config"}
			    ,{name:"condition",value:"<%=RoleOrgFilter%>"}
			    ],
	    colModel : [
	    {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center'},
            {display: '流程编码', name : 'WorkflowCode', width : 91, sortable : true, align: 'left',hide:false,renderer:false},
			{display: '流程名称', name : 'WorkflowName', width : 197, sortable : true, align: 'left',hide:false,renderer:false},
			{display: '版本号', name : 'Version', width : 38, sortable : true, align: 'center',hide:false,renderer:false},
			{display: '配置参数', name : 'ConfigId', width : 68, sortable : true, align: 'center',hide:false,renderer:fnConfig},
			{display: '会签单配置', name : 'ConfigId', width : 79, sortable : true, align: 'center',hide:false,renderer:fnSign},
			{display: '填报指引', name : 'DirectId', width : 66, sortable : true, align: 'center',hide:false,renderer:fnDirect},
			{display: '步骤操作指引', name : 'WorkflowID', width : 79, sortable : true, align: 'center',hide:false,renderer:fnNode},
			{display: '业务表名', name : 'AppNames', width : 121, sortable : true, align: 'left',hide:false,renderer:false},
			{display: '流程说明', name : 'Description', width : 100, sortable : true, align: 'left',hide:false,renderer:false},
			{display: '流程最后修改时间', name : '_UpdateTime', width : 110, sortable : true, align: 'left',hide:false,renderer:false}

		    ],
	    buttons : [
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
		    {separator: true},
		    {name: '导出', bclass: 'excel', onpress : app_export, hidden: 0},
            {separator: true},
            {name: '弹出', bclass: 'open', onpress : function(){window.open(window.location,'_blank');} , hidden: (window.top==window.self?1:0)}
		    ],
	    searchitems :[
		    {display: '流程编码', name : 'WorkflowCode', type: 1,defvalue:'',match:''},
			{display: '流程名称', name : 'WorkflowName', type: 1,defvalue:'',match:''},
			{display: '业务表名', name : 'AppNames', type: 1,defvalue:'',match:''}
		    ],

	    sortname: "",
	    sortorder: "",
	    usepager: true,
	    singleSelect:!multi,
	    useRp: true,
	    rp: 15,
	    multisel:false,
	    showTableToggleBtn: false,
	    resizable:false,
	    height: 'auto',
        onLoad: __fnLoad,
	    onError:showError,
        onRowSelect:fnRowSelect,
	    preProcess:processData,
	    onColResize:fnColResize
	});
    function _fnLoad(){}
	function showError(data)
	{
		alert(data.responseText);
	}
    var xmlData;
	function processData(data)
	{
		return xmlData=jQuery(data);
	}

    var multiRow =[];
    function __fnLoad(){
        if(multi) $(".hDivBox th:first").html("<div style='width: 30px; text-align: center; padding-top: 2px; padding-bottom: 2px;' title='全选'><input type=\"checkbox\" name=\"checkAll\" onclick=\"CheckAll();\" id=\"checkAll\" ></div>");

        if($.isFunction(window["_fnLoad"]))
            window["_fnLoad"]();
    }
    function CheckAll(){  
        var checkAll = $("#checkAll").prop("checked");
        $(".selcheck").each(function(){
            $(this).prop("checked",checkAll);
            setvalue(this);
        });
    }

    function _fnCheck(v,row,td)
	{
		var key=$(row).attr("id");
        if(multi){
            var chk = hasChecked(key,row);
            if(chk!="")
            {
                $(td).parent().addClass("trSelected");
            }
            return "<input type='checkbox' "+ hasChecked(key,row) +" class='selcheck' name='selcheck' key='"+key+"' onclick='setvalue(this)' />";
        }
        else
        {
            return v;
        }
	}

    function fnRowSelect(row,selected) {
        var rowId = row.attr("id").substr(3);
        var dr=$("row[id='"+rowId+"']",xmlData);
        var valArr=[];
        if(multi){
            $(".selcheck",row).prop("checked",selected);
            if(selected)
                addChecked(rowId,valArr);
            else
                delChecked(rowId);
        }
    }

    function setvalue(obj){
        var srcEl = $(obj);
		var key=srcEl.attr("key");
        var dr=$("row[id='"+key+"']",xmlData);
        var valArr=[];
        var checked = srcEl.prop("checked");
        if( multi ){
            if(checked){
                $("#row"+key).addClass("trSelected");
                addChecked(key,valArr);
            }
            else{
                $("#row"+key).removeClass("trSelected");
                delChecked(key);
            }
        }
    }

    function hasChecked( key,row){
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
    function _getRowId(){
        if($('.trSelected',"#flex1").length>0)
		{
			var editId = $('.trSelected',"#flex1")[0].id.substr(3);
            return editId;
        }
        return "";
    }

    function _getCheckedRows(){
        return multiRow;
    }

	function fnColResize(fieldname,width)
	{
			   
	}
    function app_export(cmd,grid)
    {
		var param=$("#flex1")[0].p;
		var query="&query="+param.condition+"&sortname="+param.sortname+"&sortorder="+param.sortorder;
        window.open("AppExport.aspx?<%=Request.QueryString %>"+query,"_blank");
    }
	function app_layout(cmd,grid)
	{

	}
	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}

	function app_setquery()
	{
        openCenter("AppConditionDef.aspx?tblname=Q_WF_Config","_blank",400,500);
	}
	function app_query()
	{
		$("#flex1").flexReload();
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

	    jQuery(function(){
		  jQuery(".redLink").live("mouseover",function(){$(this).css("color","white");}).live("mouseout",function(){$(this).css("color","red");});
		  jQuery(".greenLink").live("mouseover",function(){$(this).css("color","white");}).live("mouseout",function(){$(this).css("color","green");});
		})
		function fnNode(v,row){
			return "<a href=\"../Workflow/Admin/Admin_NodeDoc.aspx?WorkflowID="+v+"\" target='_blank'>配置</a>";  
		}

		function fnConfig(v,row){
		  var wfcode=$("WorkflowCode",row).text();
		  var wfname=$("WorkflowName",row).text();
		  if(v==""){
			return "<a href=\"javascript:wfConfig('','"+wfcode+"','"+wfname+"');\" style='color:red;' class='redLink'>添加配置</a>";
		  }
		  else{
			return "<a href=\"javascript:wfConfig('"+v+"');\" style='color:green;' class='greenLink'>调整配置</a>";  
		  }
		}

		function wfConfig(configId,wfcode,wfname){
		  if(configId){
			openCenter("../AppFrame/AppInput.aspx?tblName=T_E_WF_Config&mainId="+configId,"_blank",900,600);
		  }
		  else{
			openCenter("../AppFrame/AppInput.aspx?tblName=T_E_WF_Config&cpro=WFId="+wfcode+"^1|WFName="+escape(wfname)+"^1","_blank",900,600);
		  }
		}

		function fnDirect(v,row){
		  var wfcode=$("WorkflowCode",row).text();
		  var wfname=$("WorkflowName",row).text();
		  if(v==""){
			return "<a href=\"javascript:wfDirect('','"+wfcode+"','"+wfname+"');\" style='color:red;' class='redLink'>添加指引</a>";
		  }
		  else{
			return "<a href=\"javascript:wfDirect('"+v+"');\" style='color:green;' class='greenLink'>调整指引</a>";  
		  }
		}

		function wfDirect(configId,wfcode,wfname){
		  if(configId){
			openCenter("../AppFrame/AppInput.aspx?tblName=T_E_WF_Direction&mainId="+configId,"_blank",900,600);
		  }
		  else{
			openCenter("../AppFrame/AppInput.aspx?tblName=T_E_WF_Direction&cpro=WFId="+wfcode+"^1|WFName="+escape(wfname)+"^1","_blank",900,600);
		  }
		}

		function fnSign(configId, row){
		  if(!!configId){
			return "<a href='../Workflow/Admin/Admin_SignSheet.aspx?mainId=" + configId + "' target='_blank'>配置会签单</a>";
		  }
		  else{
			return "--";
		  }
		}

//-->
</script>