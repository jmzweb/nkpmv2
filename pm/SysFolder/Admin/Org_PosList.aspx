<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_PosList.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_PosList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Pragma" content="no-cache" />
    <title>岗位列表</title>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css" />
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css" />
    
    <script type="text/javascript" src="../../grid/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
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
    var curClass = EIS.WebBase.SysFolder.Org.Org_PosList;
    var para = "";
    $(function () {
    });
    $("#flex1").flexigrid
			({
			    url: '../../getdata.ashx?ds=Org_Data',
			    params: [{ name: "queryid", value: "Org_PosList" }
			        , { name: "cryptcond", value: "" }
			        , { name: "sindex", value: "" }
			        , { name: "condition", value: "<%=Request["condition"] %>" }
			        ],
			    colModel: [
			{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center' },
                 { display: '岗位名称', name: 'PositionName', width: 100, sortable: true, align: 'left', hide: false, renderer: fnEdit},
                 { display: '本岗位人员', name: '_AutoID', width: 80, sortable: true, align: 'left', hide: false, renderer: addEmpRender },
                 { display: '岗位编码', name: 'PositionCode', width: 60, sortable: true, align: 'left', hide: false, renderer: false},
                 { display: '公司名称', name: 'CompanyName', width: 120, sortable: true, align: 'left', hide: false, renderer: false},
                 { display: '部门名称', name: 'DeptName', width: 80, sortable: true, align: 'left', hide: false, renderer: false},
                {display: '状态', name : '_IsDel', width : 40, sortable :true, align: 'center',hide:false,renderer:fnState},
                {display: '生效日期', name : 'StartDate', width : 80, sortable :true, align: 'center',hide:false,renderer:false},
                {display: '失效日期', name : 'EndDate', width : 80, sortable :true, align: 'center',hide:false,renderer:fnEnd},
                 { display: '排序', name: 'OrderID', width: 30, sortable: true, align: 'center', hide: false, renderer: false}
				],
			    buttons: [
				{ name: '新建岗位', bclass: 'add', onpress: app_add },
				{ name: '编辑', bclass: 'edit', onpress: app_edit },
				{ name: '删除', bclass: 'delete', onpress: app_delete },
				{ separator: true },
				{ name: '查询', bclass: 'view', onpress: app_query },
				{ name: '清空', bclass: 'clear', onpress: app_reset }

				],
			    searchitems: [
			    { display: '岗位编码', name: 'PositionCode', type: 1 }, 
                { display: '岗位名称', name: 'PositionName', type: 1 },
                { display: '状态', name:'_IsDel', type:1, edit:'select',data:'生效|0,失效|1',defvalue:'0'}
			    ],
			    sortname: "OrderID",
			    sortorder: "asc",
			    usepager: true,
			    singleSelect: true,
			    useRp: true,
			    rp: 15,
			    multisel: false,
			    showTableToggleBtn: false,
			    resizable: false,
			    height: 'auto',
			    onError: showError,
			    preProcess: false,
			    onColResize: fnColResize
			}
	);
    function fnEdit(v,row){
        var pid=$(row).attr("id");
        return "<a href='javascript:' onclick=\"RecEdit('"+pid+"');\" >"+v+"</a>"
    }
    function RecEdit(pid){

        var url = '<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_PosEdit.aspx?PositionId='+pid;
        var dlg = new $.dialog({ title: '岗位编辑', page: url, btnBar: false, cover: true, width: 600, height: 400, bgcolor: 'black'});
        dlg.ShowDialog();
    }
    function addEmpRender(fldval , row)
    {
      var empNum = $("EmpNum", row).text();
      var positionId=fldval;
      var arr=[];
      arr.push("&nbsp;&nbsp;<a href=\"javascript:viewEmp('"+positionId+"');\">查看");
      if (empNum != "0")
          arr.push("（", empNum, "）");
      arr.push("</a>");
      return arr.join("");
    }
 
    function viewEmp(positionId)
    {
        var url = "../../SysFolder/AppFrame/AppDefault.aspx?tblName=T_E_Org_DeptEmployee&condition=positionId=[QUOTES]" + positionId + "[QUOTES]&ext=600|300|000";
        openCenter(url,"_blank",700,480);
    }

	function showError(data) {
        alert("加载数据出错");
    }
    function app_add(cmd, grid) {
        var url = '<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_PosEdit.aspx?DeptID=<%=DeptID %>';
        var dlg = new $.dialog({ title: '添加新岗位', page: url, btnBar: false, cover: true, width: 600, height: 400, bgcolor: 'black'});
        dlg.ShowDialog();

    }
    function fnColResize(fieldname, width) {

    }
    function app_layout(cmd, grid) {
        //暂时有点儿问题，应该把fieldname 换成fieldid
        var fldlist = [];
        $('th', grid).each(function () {

            fldlist.push((this.fieldid || this.field) + "=" + ($(this).width() - 10) + "=" + $(this).css("display"));
        });
        var ret = curClass.saveLayout(fldlist, "T_E_Org_Position", "");
        if (ret.error) {
            alert("保存出错：" + ret.error.Message);
        }
        else {
            alert("保存成功！");
        }
    }

    function app_reset(cmd, grid) {
        $("#flex1").clearQueryForm();
    }
    function app_edit(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            var editid = $('.trSelected', grid)[0].id.substr(3);
            var url = '<%=base.ResolveUrl("~")%>/Sysfolder/Admin/Org_PosEdit.aspx?PositionId='+editid;
            var dlg = new $.dialog({ title: '岗位编辑', page: url, btnBar: false, cover: true, width: 600, height: 400, bgcolor: 'black'});
            dlg.ShowDialog();
        }
        else {
            alert("请选中一条记录");
        }
    }

    function app_delete(cmd, grid) {
        if ($('.trSelected', grid).length > 0) {
            if (confirm('为了保证数据的连续性和完整性，系统不建议删除数据。如果本岗位失效，建议设置结束日期，确定删除这本岗位吗?')) {
                $('.trSelected', grid).each(function () {
			        var ret = curClass.RemovePosition(this.id.substr(3));
			        if (ret.error) {
			            alert("删除出错：" + ret.error.Message);
			        }
			        else {
			            alert("删除成功！");
			            $("#flex1").flexReload();
			        }
			    });

            }
        }
        else {
            alert("请选中一条记录");
        }
    }

    function addCallBack() {
        $("#flex1").flexReload();
    }

    function app_query() {
        $("#flex1").flexReload();
    }

    function openCenter(url, name, width, height) {
        var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
        if (window.screen) {
            var ah = screen.availHeight - 30;
            var aw = screen.availWidth - 10;
            var xc = (aw - width) / 2;
            var yc = (ah - height) / 2;
            str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
            str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
        }
        return window.open(url, name, str);
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
          var url = 'Sysfolder/Admin/Org_PosEdit.aspx?end=1&PositionId='+recId;
          var dlg = new $.dialog({ title: '设置岗位失效日期', page: url, btnBar: false, cover: true, width: 600, height: 400, bgcolor: 'black'});
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