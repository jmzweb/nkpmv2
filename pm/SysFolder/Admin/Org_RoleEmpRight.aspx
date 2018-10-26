<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QXList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Limit.QXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>角色员工设置</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <!--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />-->
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/appList.css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
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
    var para = "";
    var _iframe = true;
    var multi = false;
    var _enforceDel = false;
	var isSysAdmin = "<%=SysAdmin%>"=="1";
    var _curClass = EIS.WebBase.SysFolder.Limit.QXList;
    $(function(){
        $("#flex1>tbody>tr").live("dblclick",function(){
            clearSelection();
            if($(".edit").length == 0)
                return;
            var editId = this.id.substr(3);
            if(editId){

			    var url="<%=base.ResolveUrl("~")%>SysFolder/Admin/Org_RoleEmpSet.aspx?mainId=" + editId;
                if(_iframe){
                    if(window.top.$("#lhgfrm_lhgdgId").length>0){
                        window.top.$("#lhgfrm_lhgdgId").attr("src",url);
                    }
                    else{
                        var dlg = new $.dialog({ title: '角色员工设置', page: url
                            , btnBar: false, cover: true, rang: true, width: 500, height: 560, bgcolor: 'gray'

    	                });
    	                dlg.ShowDialog();
                    }
                }
                else{
			        window.open(url,"_blank");
                }
            }

        });
    });
	$("#flex1").flexigrid
	({
	    url: '../getdata.ashx?ds=org_data',
	    params:[{name:"queryid",value:"Org_RoleEmpList"}
			    ,{name:"condition",value:"RoleId='<%= Request["RoleId"] %>' and (<%=RoleOrgFilter %>)"}
                ,{name:"defaultvalue",value:""}
			    ],
	    colModel : [
            {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:false},
            {display: '对象名称', name : 'EmployeeName', width : 120, sortable :true, align: 'center',hide:false,renderer:fnName},
            {display: '类型', name : 'RoleEmployeeType', width : 60, sortable :true, align: 'center',hide:false,renderer:fnType},
            {display: '单位名称', name : 'CompanyName', width : 80, sortable :true, align: 'left',hide:false,renderer:false},
            {display: '组织范围', name : 'OrgNameList', width : 160, sortable :true, align: 'left',hide:false,renderer:fnOrg}
		    ],
	    buttons : [
		    {name: '添加人员', bclass: 'user_add', onpress : app_add , hidden : false},
		    {name: '添加组织', bclass: 'org', onpress : app_org , hidden : false},
		    //{name: '编辑', bclass: 'edit', onpress : app_edit , hidden : false},
		    {name: '删除', bclass: 'delete', onpress : app_delete , hidden : false},
		    {separator: true},
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
            {separator: true},
            {name: '导出', bclass: 'excel', title:'', onpress : app_export , hidden: false}

		    ],
	    searchitems :[{display: '对象名称', name : 'EmployeeName', type: 1, defvalue:'',match:''}],
	    sortname: "",
	    sortorder: "",
	    usepager: true,
	    singleSelect:!multi,
	    useRp: true,
	    rp: 15,
	    showTableToggleBtn: false,
        showToggleBtn:false,
	    resizable:false,
	    height: 'auto',
        onLoad: __fnLoad,
	    onError:showError,
        onRowSelect:fnRowSelect,
	    preProcess:processData,
	    onColResize:fnColResize
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

    function fnName(roleObj,row){
        var roleType = $("RoleEmployeeType",row).text();
        if(roleType == "1")
            return "<span style='color:#dc143c;'>"+roleObj+"</span>";
        else
            return roleObj;
    }
    function fnType(roleType,row){
        if(roleType == "1")
            return "组织";
        else
            return "人员";
    }
    function fnOrg(v,row){
        var roleType = $("RoleEmployeeType",row).text();
        var rowId = $(row).attr("id");
        if(roleType == "1"){
            return v;
        }
        else{
            if( v == "") v = "[ 组织范围 ]";
            return "<a href=\"javascript:roleEdit('"+rowId+"');\">"+v+"</a>";
        }
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
        var url = "<%=base.ResolveUrl("~")%>SysFolder/Admin/Org_RoleEmpSet.aspx?RoleId=<%= Request["RoleId"] %>&_rnd=" + Math.random();
        if(_iframe){
            
            var dlg = new $.dialog({ title: '角色员工设置', page: url
                , btnBar: false, cover: true, rang: true, width: 500, height: 560, bgcolor: 'gray'

    	    });
    	    dlg.ShowDialog();
                
            return;
        }
		window.open(url,"_blank");
	}

    function app_org(cmd,grid)
	{
        var url = "<%=base.ResolveUrl("~")%>SysFolder/Admin/Org_RoleOrgSet.aspx?RoleId=<%= Request["RoleId"] %>&_rnd=" + Math.random();
        if(_iframe){
            
            var dlg = new $.dialog({ title: '添加组织机构', page: url
                , btnBar: false, cover: true, rang: true, width: 500, height: 560, bgcolor: 'gray'

    	    });
    	    dlg.ShowDialog();
                
            return;
        }
		window.open(url,"_blank");
	}

	function fnColResize(fieldname,width)
	{
			   
	}

    function app_export(cmd,grid)
    {
		var param=$("#flex1")[0].p;
		var query="&query="+param.condition+"&sortname="+param.sortname+"&sortorder="+param.sortorder;
        window.open("../AppFrame/AppExport.aspx?<%=Request.QueryString %>"+query,"_blank");
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
            roleEdit(editId);
		}
		else
		{
			alert("请选中一条记录");
		}
	}
    function roleEdit(editId){
        var url="<%=base.ResolveUrl("~")%>SysFolder/Admin/Org_RoleEmpSet.aspx?mainId=" + editId;
        if(_iframe){
            if(window.top.$("#lhgfrm_lhgdgId").length>0){
                window.top.$("#lhgfrm_lhgdgId").attr("src",url);
            }
            else{
                var dlg = new $.dialog({ title: '角色员工设置', page: url
                    , btnBar: false, cover: true, rang: true, width: 500, height: 560, bgcolor: 'gray'

    	        });
    	        dlg.ShowDialog();
            }
        }
        else{
			window.open(url,"_blank");
        }
    }
	function app_delete(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
			if(confirm('确定删除这' + $('.trSelected',grid).length + '条记录吗?'))
			{
			    $('.trSelected',grid).each
			    (
			        function()
			        {
			            var editId = this.id.substr(3);
                        if(editId){

			                var ret = _curClass.RemoveRoleEmployee(editId);
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
			        }
			    );
				         
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
        return fldval;
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

//-->
</script>