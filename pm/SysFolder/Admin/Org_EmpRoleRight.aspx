<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QXList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Limit.QXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>员工角色设置</title>
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
	    url: '../getData.ashx?ds=org_data',
	    params:[{name:"queryid",value:"Org_EmpRoleList"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"sindex",value:""}
			    ,{name:"condition",value:"(<%=RoleOrgFilter %> or IsPublic='是')"}
                ,{name:"defaultvalue",value:'"@EmployeeId":"<%= Request["EmpId"] %>"'}
			    ],
	    colModel : [
            {display: '授权', name : 'RelationId', width : 30, sortable : false, align: 'center',renderer:fnCheck},
            {display: '角色名称', name : 'RoleName', width : 140, sortable :true, align: 'left',hide:false,renderer:fnName},
            {display: '角色编码', name : 'RoleCode', width : 100, sortable :true, align: 'left',hide:true,renderer:false},
            {display: '类型', name : 'RoleType', width : 60, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '公共角色', name : 'IsPublic', width : 60, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '组织范围', name : 'OrgNameList', width : 200, sortable :true, align: 'left',hide:false,renderer:fnOrgSet}
		    ],
	    buttons : [
            { name: "角色列表 - <b style='color:blue;font-weight:normal;'><%= Request["EmpName"] %></b>", bclass: 'home' },
            { separator: true },
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset}

		    ],
	    searchitems :[
            {display: '角色名称', name : 'RoleName', type: 1, defvalue:'',match:''},
            {display: '授权状态', name : 'HasRight', type: 1, edit:'select',defvalue:'',data:'已授权|是,未授权|否',match:''}],
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
        var dlg = new $.dialog({ title: '获取数据时报错', html: "<div style='padding:10px;'>"+data.responseText+"</div>"
            , btnBar: true, cover: false, rang: true, width: 900, height: 560, bgcolor: 'gray'

    	});
    	dlg.ShowDialog();
	}
    function fnName(v,row){
        var reId = $("RelationId",row).text();
        if(reId=="")
            return v;
        else
            return "<span style='color:green;'>"+v+"</span>";
    }
    var arrInRole = "<%=arrRole %>".split(",");
    function fnCheck(key,row){
        var roleId = $(row).attr("id");
        var chk = key==""?"":"checked";
        if(jQuery.inArray(roleId,arrInRole)>-1)
            return "<input type='checkbox' checked class='selcheck' name='selcheck' key='"+key+"' roleId='"+roleId+"' disabled='true' />";
        else
            return "<input type='checkbox' "+ chk +" class='selcheck' name='selcheck' key='"+key+"' roleId='"+roleId+"' onclick='fnRoleSet(this)' />";
    }
    function fnRoleSet(obj){
        var state= $(obj).prop("checked")?1:0;
        var roleId = $(obj).attr("roleId");
        var ret = _curClass.UpdateRole(state,roleId,'<%=Request["EmpId"] %>');
        if(ret.error)
		{
			alert(ret.error.Message);
		}
		else
		{
            $.noticeAdd({ text: '保存成功！'});app_query();
		}
    }
    
    function fnOrgSet(v,row){
        var reId = $("RelationId",row).text();
        var orgList = $("OrgCodeList",row).text();
        if(reId != ""){
            if(orgList == "")
                return "<a href=\"javascript:orgSet('" + reId + "');\">【设置组织范围】</a>";
            else
                return "<a title=\""+v+"\" href=\"javascript:orgSet('" + reId + "');\">"+v+"</a>";
        }
        else{
            return "";
        }
    }
    
    function orgSet(editId)
	{
		var url="<%=base.ResolveUrl("~")%>SysFolder/Admin/Org_RoleEmpSet.aspx?mainId=" + (editId==""?"xxx":editId);
        var dlg = new $.dialog({ title: '角色员工设置', page: url
            , btnBar: false, cover: true, rang: true, width: 500, height: 560, bgcolor: 'gray'

    	});
    	dlg.ShowDialog();
        
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
	function fnColResize(fieldname,width)
	{
			   
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

    function app_view()
    {
                
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