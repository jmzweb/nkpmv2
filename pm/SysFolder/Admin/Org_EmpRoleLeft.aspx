<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QXList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Limit.QXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>员工查询</title>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css"/>
    <script type="text/javascript" src="../../grid/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <style type="text/css">
        .red{color:red;text-decoration:none;font-weight:normal;border:0px solid #eee;padding:2px;}
        .red:hover{color:white;text-decoration:none;background-color:#aaa;border:0px solid gray;}
        .green{color:green;text-decoration:none;font-weight:normal;border:0px solid #eee;padding:2px;}
        .green:hover{color:white;text-decoration:none;background-color:#aaa;border:0px solid gray;}
        
    </style>
</head>
<body style="margin:1px">
    <form id="form1" runat="server">
    <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
<!--
    $("#flex1").flexigrid
	({
	    url: '../../getdata.ashx?ds=org_data',
	    params: [{ name: "queryid", value: "Org_EmpRole" }
			    , { name: "condition", value: "<%=RoleOrgFilter %>" }
			    ],
	    colModel: [
			{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center' },
			{ display: '姓名-工号', name: 'EmployeeName', width: 120, sortable: true, align: 'left', renderer: false },
            { display: '设置角色', name: 'Num', width: 70, sortable: true, align: 'left', hide: false, renderer: setRole },
			{ display: '部门', name: 'DeptName', width: 120, sortable: false, align: 'center' },
			{ display: '公司', name: 'CompanyName', width: 120, sortable: false, align: 'left' },
			{ display: '岗位', name: 'PositionName', width: 120, sortable: false, align: 'center', hide: true }
			],
	    buttons: [
            { name: '人员列表', bclass: 'home' },
            { separator: true },
			{ name: '查询', bclass: 'view', onpress: app_query },
			{ name: '清空', bclass: 'clear', onpress: app_reset }

			],
	    searchitems: [{ display: '工号 / 姓名', name: 'EmployeeName', type: 1}
                    ,{ display: '公司', name: 'CompanyName', type: 1}],
	    sortname: "",
	    sortorder: "",
	    usepager: true,
	    singleSelect: true,
	    onToggleCol: false,
	    useRp: false,
	    rp: 15,
	    multisel: false,
	    showToggleBtn: false,
	    resizable: false,
	    height: 'auto'
	}
	);

	function setRole(v, row) {
        var empId = $(row).attr("id");
        var empName = $("EmployeeName", row).text();
        var arr=[];
        arr.push("<a href=\"javascript:nodeClick('" + empId + "','" + empName + "');\">设置");
        if (v != "0")
            arr.push("（", v, "）");
        arr.push("</a>");
        return arr.join("");
    }



    function nodeClick(empId, empName) {
        var d = new Date();
        $("tr.trSelected").removeClass("trSelected");
        $("#row" + empId).addClass("trSelected");
        window.parent.frames["main"].location = "Org_EmpRoleRight.aspx?tblName=T_E_Org_RoleEmployee&empId=" + empId + "&empName=" + escape(empName) + "&t=" + d.getMilliseconds();
    }

	function app_select() {
		jQuery(".chkcol").attr("checked",true);
	}

	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}
			
	function app_query()
	{
		$("#flex1").flexReload();
	}
//-->
</script>
