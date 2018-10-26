<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefEmployeeOrder.aspx.cs" Inherits="EIS.Studio.SysFolder.Permission.DefEmployeeOrder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>查询条件设置</title>
    <link rel="stylesheet" type="text/css" href="../../Css/appStyle.css"/>
    <link type="text/css" href="../../Css/jquery-ui/lightness/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="../../js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../js/jquery-ui-1.8.23.custom.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
	<style type="text/css">
	html{overflow:hidden;}
	body{overflow:hidden;height:98%;background:#fefefe url(../../img/common/body_bg.gif) repeat-x;}
	a{text-decoration:none;}
	a:hover{text-decoration:underline;}
	ul.connectedSortable 
	{
	    list-style-type: none; 
	    margin: 0; 
	    padding: 0; 
	    background: #eee; 
	    padding: 3px; 
	    width:210px;
	    }
	.connectedSortable li
	{
	    margin: 0px 3px 2px 3px; 
	    padding: 2px 15px; 
	    font-size: 1.0em; 
	    width: 160px;
	    cursor:default;
	    text-align:left;
		word-break:keep-all;/* 不换行 */
		white-space:nowrap;/* 不换行 */
		overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow:ellipsis;}
	#tablesel,#tablefld
	{
	    min-height:25px;
        height:100%;
        _height:25px;
    }
        
    #maindiv  
	{
	    margin-left:auto; 
	    margin-right:auto; 
	    padding: 2px; 
		overflow:auto;
		border-bottom:1px solid gray;
	}  
    table.frametbl
    {
	    border-collapse: collapse;
        margin-left:auto;
	    margin-right:auto;
	    font-size: 12px;
	    line-height:20px;
        width:510px;
	    border:#808080 1px solid;
	    color:#393939;
	    background:#FAF8F8;
	    table-layout:fixed;
    }
    table.frametbl td{padding:2px;}
    .ui-state-default i{color:Gray;font-size:12px;font-style:normal;font-weight:normal;padding-left:3px;}
	</style>
    <script type="text/javascript">
	$(function() {
		$("#tablefld, #tablesel").sortable({
			connectWith: '.connectedSortable'
			,placeholder: 'ui-state-highlight'
			,dropOnEmpty: true
		}).disableSelection();
		
		$(window).resize(function () {
            $("#maindiv").height($(document.body).height() - 60);
        });
        $("#maindiv").height($(document.body).height() - 60);

        $("#tablefld>li").live("dblclick",function () {
            $(this).appendTo("#tablesel");
        });
        $("#tablesel>li").live("dblclick", function () {
            $(this).appendTo("#tablefld");
        });

        $("#maindiv li").attr("title", function () { return this.innerText });

	});
	function save() {
	    var _curClass = EIS.Studio.SysFolder.Permission.DefEmployeeOrder;
	    var tablelist = $('#tablefld').sortable('toArray');
	    var querylist = $('#tablesel').sortable('toArray');
	    var ret = _curClass.UpdateOrder("<%=DeptId %>", tablelist, querylist);
	    if (ret.error) {
	        alert(ret.error.Message);
	    }
	    else {
	        $.noticeAdd({ text: '保存成功！', stay: false });
	        frameElement.lhgDG.curWin.app_query();
	        frameElement.lhgDG.cancel();
	    }

	}
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="menubar">
        <div class="topnav">
            <ul>
            <li style="color:#333;">当前部门：<%=DeptPath %></li>
            <li><a href="javascript:" onclick="save();">确认</a></li>
            <li><a href="javascript:" onclick="frameElement.lhgDG.cancel();">关闭</a> </li>
            </ul>
        </div>
    </div>
    <div id="maindiv">
    <table align="center" class="frametbl" width="100%" border="1">
    <tr>
        <td align="center" height="30">领导序列</td>
        <td align="center">普通员工</td>
    </tr>
    <tr>
        <td width="50%" valign="top" align="center">
            <ul id="tablefld" class="connectedSortable">
                <%=sbList1%>
            </ul>
        </td>
        <td  valign="top" align="center">
            <ul id="tablesel" class="connectedSortable">
                <%=sbList2%>
            </ul>
        </td>
    </tr>
    </table>
    <br />
    </div>
    <div style="text-align:center;padding-top:5px;">
          左侧列表按排序显示，右侧列表人员系统会自动按姓名升序显示（即便设置也无效）
    </div>
    </form>
</body>

</html>
