
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppOutSelect.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppOutSelect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>请选择</title>
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid.css" />
    <link rel="stylesheet" type="text/css" href="../../Css/DefStyle.css" />
    <link rel="stylesheet" type="text/css" href="../../Css/datePicker.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <%=customScript%>
    <style type="text/css">
    .selradio{
        height:20px;
        margin:0px;
    }
    </style>
</head>
<body scroll="no" style="overflow:hidden;margin:1px;">
    <form id="form1" runat="server">
    <div id="griddiv">
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
<!--
    var multi = '<%=Request["multi"] %>' > "1";
    var seltype = '<%=Request["multi"] %>';
    var retctl = '<%=Request["cid"] %>'.split(",");
    var qList = '<%=Request["queryfield"] %>'.split(",");
    var _curClass = EZ.WebBase.SysFolder.AppFrame.AppOutSelect;
    var multiRow =[];
	$("#flex1").flexigrid
	({
		url: '../getxml.ashx',
        initCond:"<%=InitCond %>",
		params:[{name:"queryid",value:"<%=tblName%>"}
			    ,{name:"cryptcond",value:""}
                ,{name:"condition",value:"<%=base.GetParaValue("condition") %>"}
                ,{name:"defaultvalue",value:"<%=base.GetParaValue("defaultvalue") %>"}
			    ],
		colModel : [
			{display: '选择', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:tranSel},
            <%=colmodel %>
			],
		buttons : [
			{name: '查询', bclass: 'view', onpress : app_query},
			{name: '清空', bclass: 'clear', onpress : app_reset},
		    { separator: true },
            {name: '确认选择', bclass: 'check', onpress : app_confirm}
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
		showToggleBtn: false,
		showTableToggleBtn: false,
		resizable:false,
		height: 'auto',
		onError:showError,
		preProcess:processData,
		onColResize:fnColResize,
        onRowSelect:fnRowSelect,
        onLoad:fnLoad
	});

    function fnRowSelect(row,selected) {
        var rowId = row.attr("id").substr(3);

        var dr=$("row[id='"+rowId+"']",xmldata);
        var valArr=[];
		$.each(qList,function(i,v){
            valArr.push(dr.find(v).text());
		});

        if(multi){
            $(".selcheck",row).prop("checked",selected);
            if(selected)
                addChecked(rowId,valArr);
            else
                delChecked(rowId);
        }
        else{
            $(".selradio",row).prop("checked",selected);
            if(selected) fnRet(rowId);
        }
    }

    function CheckAll(){  
        var checkAll = $("#checkAll").prop("checked");
        $(".selcheck").each(function(){
            $(this).prop("checked",checkAll);
            setvalue(this);
        });
    }
    function setvalue(obj){
        var srcEl = $(obj);
		var key=srcEl.attr("key");
        var valArr=[];
        var checked = srcEl.prop("checked");
        if(checked){
            $("#row"+key).addClass("trSelected");
            addChecked(key,valArr);
        }
        else{
            $("#row"+key).removeClass("trSelected");
            delChecked(key);
        }
        
    }
    function hasChecked( key){
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

	function showError(data){}
    var xmldata;
	function processData(data)
	{
        $("#checkAll").prop("checked",false);
		return xmldata=jQuery(data);
	}
	function fnColResize(fieldname,width)
	{
			   
	}

	function tranSel(fldval,row,td)
	{
		var key=$(row).attr("id");
        if(multi){
            var chk = hasChecked(key);
            if(chk!="")
            {
                $(td).parent().addClass("trSelected");
            }
            return "<input type='checkbox' "+ hasChecked(key) +" class='selcheck' name='selcheck' key='"+key+"' onclick='setvalue(this)' />";
        }
        else{
            return "<input type='radio' "+ hasChecked(key)+" class='selradio' name='selradio' key='"+key+"' onclick='retvalue()'/>";
        }
	}
    function fnLoad(){
        if(multi)
            $(".hDivBox th:first").html("<div style='width:30px;text-align: center;' title='全选'><input type=\"checkbox\" name=\"checkAll\" onclick=\"CheckAll();\" id=\"checkAll\" ></div>");
    }
    //确认返回
    function app_confirm(){
		var pw = window.parent.opener;
        if(typeof(pw["_afterMultiSelect"])!="undefined"){
            pw["_afterMultiSelect"](retctl,multiRow,"<%=tblName%>");
        }
        else{
            if(seltype=="2"){
                $.each(qList,function(i,v){
                    var valArr=[];
                    var c = pw.document.getElementById(retctl[i]);
			        if(c != null){
                        for (var ix = 0; ix < multiRow.length; ix++) {
                            valArr.push(multiRow[ix].data[i]);
                        }
			            c.value=valArr;
                        try {$(c).change();} catch (e) {}
                    }
			    });
            }
            else if(seltype == "3"){ //返回多行
                pw["_afterMultiRowsSel"](retctl,multiRow);
            }
            else if(seltype == "4"){
                pw["_afterMultiRowsSel"](retctl,multiRow,'<%=Request["subName"]%>');
            }
        }
		window.parent.close();
    }

    function setvalue(obj){
        var srcEl = $(obj);
		var key=srcEl.attr("key");
        var dr=$("row[id='"+key+"']",xmldata);
        var valArr=[];
		$.each(qList,function(i,v){
            valArr.push(dr.find(v).text());
		});
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
	function retvalue()
	{
        var srcEl = $(event.srcElement);
		var key=srcEl.attr("key");
        fnRet(key);
    }
    function fnRet(key){
        var dr=$("row[id='"+key+"']",xmldata);
        var valArr=[];
		$.each(qList,function(i,v){
            valArr.push(dr.find(v).text());
		});
		var pw = window.parent.opener;
		if(typeof(pw["_afterOutSelect"])!="undefined"){
            pw["_afterOutSelect"](retctl,valArr,"<%=tblName%>");
        }
        else{
            $.each(qList,function(i,v){
                var c = pw.document.getElementById(retctl[i]);
			    if(c!=null){
			        c.value=valArr[i];
                    try {
                        $(c).change();
                    } catch (e) {
    
                    }
                }
			});
        }
		window.parent.close();
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
		var ret=EZ.WebBase.SysFolder.AppFrame.AppOutSelect.saveLayout(fldlist,"<%=tblName %>",sortdir);
		if(ret.error)
		{
			alert("保存出错："+ret.error.Message);
		}
		else
		{
			alert("保存成功！");
		}
	}
	function app_reset(cmd,grid)
	{
        $("#flex1").clearQueryForm();
	}

	function addcallback()
	{
		$("#flex1").flexReload();
	}
	function app_setquery()
	{
        openCenter("AppConditionDef.aspx?tblname=<%=tblName %>","_blank",400,500);
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
    <%=listfn %>
//-->
</script>
