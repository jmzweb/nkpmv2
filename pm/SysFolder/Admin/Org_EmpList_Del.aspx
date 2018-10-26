<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QXList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Limit.QXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>逻辑删除员工列表</title>
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
    var para="";
    var _curClass = EIS.WebBase.SysFolder.Limit.QXList;
	var grid = $("#flex1").flexigrid
	({
	    url: '../getdata.ashx?ds=org_data',
	    params:[{name:"queryid",value:"Org_EmpListDel"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"condition",value:"<%= RoleOrgFilter.Replace("_OrgCode","DepWbs") %>"}
			    ],
	    colModel : [
	        {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:false},
            {display: '姓名', name : 'EmployeeName', width : 57, sortable :true, align: 'center',hide:false,renderer:fnEmpName},
            {display: '性别', name : 'Sex', width : 29, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '工号', name : 'EmployeeCode', width : 70, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '登录帐号', name: 'LoginName', width: 80, sortable: true, align: 'left', hide: false, renderer: false },
            {display: '锁定', name: 'IsLocked', width: 30, sortable: true, align: 'center', hide: false, renderer: fnState},
            {display: '排序', name : 'OrderID', width : 31, sortable :true, align: 'center',hide:true,renderer:false},
            {display: '所属部门', name : 'DepName', width : 78, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '岗位', name : 'PosName', width : 78, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '单位名称', name : 'CorpName', width : 146, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '操作', name: 'EmployeeId', width: 100, sortable: true, align: 'center', hide: false, renderer: opCol }
		    ],

		buttons: [
		{ name: '彻底删除', bclass: 'delete', onpress: app_delete2 },
		{ separator: true },
		{ name: '查询', bclass: 'view', onpress: app_query },
		{ name: '清空', bclass: 'clear', onpress: app_reset }
		],
		searchitems: [
        { display: '员工姓名', name: 'EmployeeName', type: 1 },
        { display: '工号', name: 'EmployeeCode', type: 1 },
        { display: '帐号', name: 'LoginName', type: 1 }
        
		],
	    sortname: "",
	    sortorder: "",
	    usepager: true,
	    singleSelect:true,
	    useRp: true,
	    rp: 15,
	    showTableToggleBtn: false,
        showToggleBtn:false,
	    resizable:false,
	    height: 'auto',
	    onError:showError,
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

    function opCol(empId, row) {
        var arr = [];
        arr.push("<a href=\"javascript:app_recover('"+empId+"');\">撤销删除</a>");
        return arr.join("");
    }
    function app_recover(empId) {

        if (confirm('确定撤销这条记录吗?')) {
			var ret = _curClass.RecoverEmployee(empId);
			if (ret.error) {
			    alert("撤销删除出错：" + ret.error.Message);
			}
			else {
			    alert("撤销成功！");
			    $("#flex1").flexReload();
			}
        }
    }
    function fnState(v,row,td){
  	    if(v == "是"){
            $(td).parent().css('color','#aaa');
      	    return "<div class='forbid' title='已锁定'>&nbsp;&nbsp;</div>";
        }
        else
		    return "<div title='未锁定'>&nbsp;--&nbsp;</div>";
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

	function app_delete2(cmd,grid)
	{
		if($('.trSelected',grid).length>0)
		{
			if(confirm('确定删除这条记录吗?'))
			{
			    $('.trSelected',grid).each
			    (
			        function()
			        {
			            var editId = this.id.substr(3);
                        if(editId){

			                var ret=_curClass.RemoveEmployee(editId);
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
        return "<a href=\"Org_EmpInfo.aspx?empId="+autoid+"\" target='_blank'>"+fldval+"</a>";
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

    function fnEmpName(v,row,td){
      var empId=$(row).attr("id");
      var deptId=$("DeptID",row).text();
      var isDel=$("IsDel",row).text();
      if(isDel == "1")
      $(td).parent().css('text-decoration','line-through');

      $(td).parent().attr("empName", v);
      return "<a href=\"javascript:emp_edit('"+empId+"','"+deptId+"');\">"+v+"</a>";
    }

    function emp_edit(empId,deptId){
        var url = "<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_EmpEdit.aspx?employeeId="+empId+"&deptId="+deptId+"&t="+Math.random();
        var dlg = new $.dialog({ title: '编辑员工信息', page: url, btnBar: false, cover: true, width: 800, height: 560, bgcolor: 'black' });
        dlg.ShowDialog();
    }

//-->
</script>