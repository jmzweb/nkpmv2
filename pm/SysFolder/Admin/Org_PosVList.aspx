<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppDefault.aspx.cs" Inherits="EIS.WebBase.SysFolder.AppFrame.AppDefault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>[兼职岗位] 默认查询</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <!--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />-->
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
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
    var para="";
    var multi = '<%=GetParaValue("multi") %>'=="1";
    var _curClass =EIS.WebBase.SysFolder.AppFrame.AppDefault;
    $(function(){
        $("#flex1>tbody>tr").live("dblclick",function(){
            clearSelection();
            if($(".edit").length == 0)
                return;
            var editId = this.id.substr(3);
            if(editId){
              var url = 'Sysfolder/Admin/Org_DeEdit.aspx?mainId='+editId;
              var dlg = new $.dialog({ title: '添加兼职', page: url, btnBar: false, cover: true, width: 600, height: 430, bgcolor: 'black'});
              dlg.ShowDialog();
            }

        });
    });
	$("#flex1").flexigrid
	({
	    url: '../getdata.ashx?ds=Org_org',
	    params:[{name:"queryid",value:"Org_Org_DeList"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"condition",value:"<%= condition %>"}
			    ],
	    colModel : [
	        {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:false},
            {display: '姓名', name : 'EmployeeName', width : 48, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '公司名称', name : 'CompanyName', width : 100, sortable :true, align: 'left',hide:false,renderer:false},
            {display: '部门名称', name : 'DeptName', width : 69, sortable :true, align: 'left',hide:false,renderer:false},
            {display: '岗位名称', name : 'PositionName', width : 100, sortable :true, align: 'left',hide:false,renderer:false},
            {display: '兼职', name : 'DeptEmployeeType', width : 40, sortable :true, align: 'center',hide:false,renderer:fnJZ},
            {display: '状态', name : '_IsDel', width : 40, sortable :true, align: 'center',hide:false,renderer:fnState},
            {display: '生效日期', name : 'StartDate', width : 80, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '失效日期', name : 'EndDate', width : 80, sortable :true, align: 'center',hide:false,renderer:false}

		    ],
	    buttons : [
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
            {separator: true},
            {name: '导出', bclass: 'excel', title:'', onpress : app_export , hidden: <%=exportLimit %>},
            {name: '返回', bclass: 'return', title:'', onpress : function(){window.history.back();} , hidden:0}
		    ],
	    searchitems :[
            { display: '岗位名称', name: 'PositionName', type: 1 },
            { display: '状态', name:'_IsDel', type:1, edit:'select',data:'生效|0,失效|1',defvalue:'0'}
		    ],
	    sortname: "_CreateTime",
	    sortorder: "desc",
	    usepager: true,
	    singleSelect:!multi,
	    useRp: true,
	    rp: 15,
	    showTableToggleBtn: false,
	    resizable:false,
	    height: 'auto',
        onLoad: __fnLoad,
	    onError:showError,
        onRowSelect:fnRowSelect,
	    preProcess:processData
	    }
	);

    var xmlData;
	function processData(data)
	{
        $("#checkAll").prop("checked",false);
		return xmlData=jQuery(data);
	}
    function showError(data)
	{
		alert(data.responseText);
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
    function fnJZ(v,row){
      return v=="1"?"是":"-";
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
            return colIndex(v,row);
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

	function app_add(cmd,grid)
	{
      var url = 'Sysfolder/Admin/Org_DeEdit.aspx?employeeId=<%=Request["employeeId"] %>';
      var dlg = new $.dialog({ title: '添加兼职', page: url, btnBar: false, cover: true, width: 600, height: 430, bgcolor: 'black'});
      dlg.ShowDialog();
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

	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}

    function _getRowId(){
        if($('.trSelected',"#flex1").length>0)
		{
			var editId = $('.trSelected',"#flex1")[0].id.substr(3);
            return editId;
        }
        return "";
    }

	function app_edit(cmd,grid)
	{
        var editId = _getRowId();
		if(editId != "")
		{
          var url = 'Sysfolder/Admin/Org_DeEdit.aspx?mainId='+editId;
          var dlg = new $.dialog({ title: '添加兼职', page: url, btnBar: false, cover: true, width: 600, height: 430, bgcolor: 'black'});
          dlg.ShowDialog();
		}
		else
		{
			alert("请选中一条记录");
		}
	}
	function app_delete(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
			if(confirm('为了保证数据的连续性和完整性，系统不建议删除数据。如果本条兼职失效，建议设置结束日期，确定删除这本条兼职记录吗? '))
			{
			    $('.trSelected',grid).each(function(){
			            var editId = this.id.substr(3);
                        if(editId){
			                var ret=_curClass.DelRecord("<%=tblname %>",editId);
			                if(ret.error)
			                {
			                    alert("删除出错："+ret.error.Message);
			                }
			                else
			                {
                                $.noticeAdd({ text: '删除成功！'});
			                    $("#flex1").flexReload();
			                }
                        }
			      });
				         
			}
		}
		else
		{
			alert("请选中一条记录");
		}
	}
    function colIndex(fldval,row)
    {
        var autoid=$(row).attr("id");
        return "<a href=\"AppDetail.aspx?tblName=<%=tblname %>&sindex=<%=sindex %>&mainid="+autoid+"\" target='_blank'>"+fldval+"</a>";
    }
    function app_view()
    {
                
    }
    function app_wfinfo(mainId)
    {
        var url = "AppWorkFlowInfo.aspx?tblName=<%=tblname %>&mainId=" + mainId;
		window.open(url,"_blank");
    }

	function app_setquery()
	{
		openCenter("AppConditionDef.aspx?tblname=<%=tblname %>&sindex=<%=sindex %>","_blank",400,500);
	}

	function app_query()
	{
		$("#flex1").flexReload();
	}

    function clearSelection() {
        if(document.selection && document.selection.empty) {document.selection.empty();}else if(window.getSelection) {window.getSelection().removeAllRanges();}
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
            if (yc < 0)
		        yc = 0;
		    str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
		    str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
	    }
	    return window.open(url, name, str);
    }
    function fnDefault(v,row)
    {
      var recid=$(row).attr("id");
      var empid=$("EmployeeID",row).text();
      if(v == 1)
        return "&nbsp;是&nbsp;";
      else
        return "&nbsp;否&nbsp;";
    }
    function setDefault(empid,recid,flag){
	    var ret = _curClass.ExecSQL("T_E_Org_DeptEmployee_SetDefault","@empid="+empid+"|@recid="+recid+"|@flag="+flag);
      if(ret.error){
          alert(ret.error.Message);
      }
      else{
          $.noticeAdd({ text: '保存成功！'});
   	      app_query();   
      }
    }
    function fnEnd(v,row){
        var rowId = $(row).attr("id");
        if(v==""){
            return "<a href=\"javascript:setEnd('" + rowId + "')\">设置失效</a>";
        }
        else{
            return v;
        }
    }
    function setEnd(recId){
          var url = 'Sysfolder/Admin/Org_DeEdit.aspx?end=1&mainId='+recId;
          var dlg = new $.dialog({ title: '设置兼职失效日期', page: url, btnBar: false, cover: true, width: 600, height: 430, bgcolor: 'black'});
          dlg.ShowDialog();
    }

    function fnState(v,row,td){
  	    if(parseInt(v)>0)
      	    return "<div class='forbid' title='无效'>&nbsp;&nbsp;</div>";
        else
		    return "<div class='right' title='有效'>&nbsp;&nbsp;</div>";
    }

//-->
</script>