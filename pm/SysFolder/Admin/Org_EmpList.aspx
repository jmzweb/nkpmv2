<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyEmployeeList.aspx.cs" Inherits="EIS.Sudio.SysFolder.Permission.CompanyEmployeeList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>员工基本信息</title>
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
    var _curClass =EIS.Sudio.SysFolder.Permission.CompanyEmployeeList;
	var grid = $("#flex1").flexigrid
	({
	    url: '../getdata.ashx?ds=org_data',
	    params:[{name:"queryid",value:"Org_EmpList"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"condition",value:"<%= Condition %>"}
			    ],
	    colModel : [
	        {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:false},
            {display: '姓名', name : 'EmployeeName', width : 57, sortable :true, align: 'center',hide:false,renderer:fnEmpName},
            {display: '性别', name : 'Sex', width : 29, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '工号', name : 'EmployeeCode', width : 70, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '登录帐号', name: 'LoginName', width: 80, sortable: true, align: 'left', hide: false, renderer: false },
            {display: '锁定', name: 'IsLocked', width: 30, sortable: true, align: 'center', hide: false, renderer: fnState},
            {display: '排序', name : 'OrderID', width : 31, sortable :true, align: 'center',hide:true,renderer:false},
            {display: '兼职', name : 'JzNum', width : 52, sortable :true, align: 'center',hide:false,renderer:fnJZ},
            {display: '所属部门', name : 'DeptName', width : 78, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '岗位', name : 'PositionName', width : 78, sortable :true, align: 'center',hide:false,renderer:false},
            {display: '单位名称', name : 'CompanyName', width : 146, sortable :true, align: 'center',hide:false,renderer:false}
		    ],

		buttons: [
		{ name: '添加员工', bclass: 'user_add', onpress: app_add },
		{ name: '调整主岗', bclass: 'group', onpress: app_move},
		{ name: '重置密码', bclass: 'key', onpress: app_pass },
		{ name: '信息维护', bclass: 'user', onpress: app_user},
		{ name: '批量导入', bclass: 'add', onpress: app_add, hidden:1 },
		{ separator: true },
		{ name: '排序', bclass: 'sort', onpress: app_sort },
		{ name: '删除', bclass: 'delete', onpress: app_delete },
		{ name: '彻底删除', bclass: 'delete', onpress: app_delete, hidden:1 },
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

	function app_add(cmd,grid)
	{
        var url = "<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_EmpEdit.aspx?deptId=<%=DeptID %>&t="+Math.random();
        var dlg = new $.dialog({ title: '添加员工', page: url, btnBar: false, cover: true, width: 800, height: 560, bgcolor: 'black' });
        dlg.ShowDialog();
	}
    function app_other(cmd,grid){
        var editId = _getRowId();
		if(editId != "")
		{
            window.open("Org_EmpEdit.aspx?empId="+editId,"_blank");
        }
    }
    function app_sort(){
        setOrder("<%=DeptID %>");
    }
    function app_pass(){
        if ($('.trSelected', grid).length > 0) {
            var editid = $('.trSelected', grid)[0].id.substr(3);
            var empName = $('.trSelected:eq(0)', grid).attr("empName");

            if(!confirm("您确认重置【"+empName+"】的密码吗？"))
                return;

            var ret = _curClass.InitPassWord(editid);
            if (ret.error) {
                alert("重置密码出错：" + ret.error.Message);
            }
            else {
                alert("密码已经重置为："+ret.value);
            }
        }
        else {
            alert("请选中一条记录");
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
	function app_user(cmd,grid){
	    var editId = _getRowId();
		if(editId != "")
		{
          var url = '<%=base.ResolveUrl("~")%>/WorkAsp/Personal/PersonalInfo.aspx?EmployeeId=' + editId;
		  window.open(url,"_blank");
		}
		else
		{
			alert("请选中一条记录");
		}	
	}
    function app_move(cmd,grid){
        var editId = _getRowId();
		if(editId != "")
		{
          var url = '<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_EmpMove.aspx?employeeId=' + editId;
          var dlg = new $.dialog({ title: '调整主岗', page: url, btnBar: false, cover: true, width: 500, height: 360, bgcolor: 'black'});
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
			if(confirm('确定删除这条记录吗?'))
			{
			    $('.trSelected',grid).each
			    (
			        function()
			        {
			            var editId = this.id.substr(3);
                        if(editId){

			                var ret=_curClass.DelRecord(editId);
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

    function setOrder(deptId) {
      var url = '<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_EmpOrder.aspx?deptId=' + deptId;
      var dlg = new $.dialog({ title: '人员排序', page: url, btnBar: false, cover: true, width: 600, height: 600, bgcolor: 'black'});
      dlg.ShowDialog();
    }

    function fnJZ(fldval, row) {
      var arr = [];
      var empId = $(row).attr("id");
      var empName = $("EmployeeName", row).text();
      arr.push("<a href='javascript:' onclick=\"jzList('" + empId + "','" + empName + "');\" >");
      if (fldval == "0")
        arr.push("兼职");
      else
        arr.push("（", fldval, "）");
      arr.push("</a>");
      return arr.join("");
    }

    function jzList(empId,empName) {
      var url = "Org_DeList.aspx?tblName=T_E_Org_DeptEmployee&EmployeeId="+ empId ;
      window.location.href = url;
    }

    function fnCardID(v,row,td){
      var cardid = v;
      var c1 =v.substr(0,6);
      var c3 = v.substr(14,4);
      var c = c1 + "********" + c3;
      return"<span>"+c+"</span>";
 
    }

//-->
</script>