﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppSearch.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=tblModel.TableNameCn%></title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid_s.css?v=2016"/>
    <link rel="stylesheet" type="text/css" href="../../Css/appList.css"/>
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid_s.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <%=customScript%>
</head>
<body>
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
    var _appRoot = '<%=ResolveUrl("~") %>';
    var _funId = '<%=base.GetParaValue("funId") %>';
    var _curClass = EZ.WebBase.SysFolder.AppFrame.AppQuery;
    var multi = '<%=GetParaValue("multi") %>'=="1";
	$("#flex1").flexigrid
	({
	    url: '../getxml.ashx',
        initCond:"<%=InitCond %>",
	    params:[{name:"queryid",value:"<%=tblname %>"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"condition",value:"<%=base.GetParaValue("condition") %>"}
                ,{name:"defaultvalue",value:"<%=base.GetParaValue("defaultvalue") %>"}
			    ],
	    colModel : [
	    {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:_fnCheck},
            <%=colmodel %>
		    ],
	    buttons : [
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
		    {separator: true},
		    {name: '查询定制', bclass: 'setting', onpress : app_setquery, hidden : <%=condLimit %>},
		    {name: '保存布局', bclass: 'layout', onpress : app_layout, hidden : <%=layoutLimit %>},
		    {name: '导出', bclass: 'excel', onpress : app_export, hidden: <%=exportLimit %>},
            {separator: true},
            {name: '返回', bclass: 'return', title:'返回', onpress : _goBack , hidden: '<%=Request["back"] %>'=="1"?0:1},
            {name: '弹出', bclass: 'open', onpress : function(){window.open(window.location,'_blank');} , hidden: (window.top==window.self?1:0)}
		    ],
	    searchitems :[
		    <%=querymodel %>
		    ],
	    sortname: "<%=sortname %>",
	    sortorder: "<%=sortorder %>",
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
    function _goBack() {
        var retUrl = "<%=Request.UrlReferrer %>";
        if(retUrl != ""){
            if(retUrl.indexOf("restore") == -1)
            {
                if(retUrl.indexOf("?") > 0)
                    retUrl = retUrl + "&restore=1"
                else
                    retUrl = retUrl + "?restore=1"
            }
            window.open(retUrl, "_self");
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
		//暂时有点儿问题，应该把fieldname 换成fieldid
		var fldlist=[];
		$('th',grid).each(function(){
            var fieldId=$(this).attr("fieldid");
			if(fieldId)
			fldlist.push(fieldId+"="+($(this).width()-10)+"="+$(this).css("display"));
		});
        var param=$("#flex1")[0].p;
        var sortdir="";
        if(param.sortname.length>0){
            sortdir =(param.sortname+" "+param.sortorder);
        }
		var ret = _curClass.saveLayout(fldlist,"<%=tblname %>","<%=sindex %>",sortdir);
		if(ret.error)
		{
			alert("保存出错："+ret.error.Message);
		}
		else
		{
			$.noticeAdd({ text: '保存成功！'});
		}
	}
	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}

	function app_setquery()
	{
        openCenter("AppConditionDef.aspx?tblname=<%=tblname %>&sindex=<%=sindex %>","_blank",400,500);
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
    var _sIndex="<%=sindex %>";

    //-----------------------自定义代码段--------------------------------
    <%=listfn %>
    //-------------------------------------------------------------------
//-->
</script>