<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppDefault.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppDefault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>[<%=TblNameCn%>] 默认查询</title>
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
    <%=customScript%>
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
    var _iframe = '<%=GetParaValue("iframe") %>'=='1';
    var multi = '<%=GetParaValue("multi") %>'=="1";
    var _enforceDel = '<%=GetParaValue("enforceDel") %>'=='1';
    var _curClass =EZ.WebBase.SysFolder.AppFrame.AppDefault;
    $(function(){
        $("#flex1>tbody>tr").live("dblclick",function(){
            clearSelection();
            if($(".edit").length == 0)
                return;
            var editId = this.id.substr(3);
            if(editId){
                var checkFlag = true;
                if (typeof (_sysBeforeEdit) == "function"){ 
                    var row = xmlData.find("#"+editId);
                    checkFlag = _sysBeforeEdit(editId,row);
                }

                if(!checkFlag) return;

			    para="para=" +_curClass.CryptPara("<%=para %>&mainId=" + editId ).value;
                var url = '<%=base.ResolveUrl("~")%>SysFolder/AppFrame/AppInput.aspx?' + para;
                if(_iframe){
                    if(window.top.$("#lhgfrm_lhgdgId").length>0){
                        window.top.$("#lhgfrm_lhgdgId").attr("src",url);
                    }
                    else{
                        var dlg = new $.dialog({ title: '业务编辑', page: url
                            , btnBar: false, cover: false, rang: true, width: 900, height: 600, bgcolor: 'gray'

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
	    url: '../getxml.ashx',
        initCond:"<%=InitCond %>",
	    params:[{name:"queryid",value:"<%=tblname %>"}
			    ,{name:"cryptcond",value:""}
			    ,{name:"sindex",value:"<%=sindex %>"}
			    ,{name:"condition",value:"<%= condition %>"}
                ,{name:"defaultvalue",value:"<%=base.GetParaValue("defaultvalue") %>"}
			    ],
	    colModel : [
	    {display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:_fnCheck},
            <%=colmodel %>
		    ],
	    buttons : [
		    {name: '<%=addBtnText %>', bclass: 'add', onpress : app_add , hidden : <%=addLimit %>},
		    {name: '编辑', bclass: 'edit', onpress : app_edit , hidden : <%=editLimit %>},
		    {name: '复制', bclass: 'copy', onpress : app_copy , hidden : <%=copyLimit %>},
		    {name: '删除', bclass: 'delete', onpress : app_delete , hidden : <%=delLimit %>},
		    {separator: true},
		    {name: '查询', bclass: 'view', onpress : app_query},
		    {name: '清空', bclass: 'clear', onpress : app_reset},
		    {name: '查询定制', bclass: 'setting', onpress : app_setquery, hidden : <%=condLimit %>},
		    {name: '保存布局', bclass: 'layout', onpress : app_layout, hidden : <%=layoutLimit %>},
            {separator: true},
            {name: '导出', bclass: 'excel', title:'', onpress : app_export , hidden: <%=exportLimit %>},
            {name: '导入', bclass: 'excel', title:'从EXCEL文件导入数据', onpress : app_import , hidden: <%=importLimit %>},
            {name: '归档', bclass: 'folder', onpress : app_archive , hidden: <%=gdLimit %>},
            {separator: true},
            {name: '弹出', bclass: 'open', onpress : function(){window.open(window.location,'_blank');} , hidden: (window.top==window.self?1:0)}
            <%=btnList %>
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
	    showTableToggleBtn: false,
        showToggleBtn:"<%=layoutLimit %>"=="0",
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

    function _getCheckedRows(){
        return multiRow;
    }

	function app_add(cmd,grid)
	{
        var url = "";
        if("<%=addAction %>"=="2"){
            if("<%=workflowCode %>"=="")
                url = "../workflow/SelectWorkFlow.aspx?para=<%=cryptPara %>&_rnd=" + Math.random();
            else
                url = "../workflow/NewFlow.aspx?para=<%=cryptPara %>&_rnd=" + Math.random();
        }
        else{
            url = "<%=base.ResolveUrl("~")%>SysFolder/AppFrame/AppInput.aspx?para=<%=cryptPara %>&_rnd=" + Math.random();
            if(_iframe){
            
                var dlg = new $.dialog({ title: '业务编辑', page: url
                    , btnBar: false, cover: false, rang: true, width: 900, height: 600, bgcolor: 'gray'

    	        });
    	        dlg.ShowDialog();
                
                return;
            }
        }
		window.open(url,"_blank");
	}
	function fnColResize(fieldname,width)
	{
			   
	}
    function gdStateRender(val,row)
    {
        var recid=$("_AutoID",row).text();
        var arr=[];
        if(recid)
        {
            switch( val)
            {
                case "":
                case "待归档":
                    arr.push("<a class='tdbtn' title='点击归档' href=\"javascript:app_startgd('",recid,"');\">【待归档】</a>");
                    break;
                default:
                    arr.push("<a class='tdbtn green' href=\"javascript:app_gdinfo('",recid,"')\">【",val,"】</a>");
                    break;
            }
        }

        return arr.join("");
    }
    function app_startgd(appId){
        openCenter("../../Doc/DaEdit.aspx?appName=<%=tblname %>&appId="+appId,"_blank",1000,700);
    }
    function app_archive(cmd,grid){
        if($('.trSelected',grid).length>0)
		{
			var editid=$('.trSelected',grid)[0].id.substr(3);
            openCenter("../../Doc/DaEdit.aspx?appName=<%=tblname %>&appId="+editid,"_blank",1000,700);
		}
		else
		{
			alert("请选中一条记录");
		}
    }
    function app_gdinfo(appId){
            
    }
    function wfStateRender(val,row)
    {
        var recid=$("_AutoID",row).text();
        var arr=[];
        if(recid)
        {
            switch( val)
            {
                case "":
                    arr.push("<a class='tdbtn wf_empty' title='点击发起审批' href=\"javascript:app_startwf('",recid,"');\">未发起</a>");
                    break;
                case "未发起":
                    arr.push("<a class='tdbtn wf_ready' title='点击发起审批' href=\"javascript:app_startwf('",recid,"');\">&nbsp;&nbsp;暂存&nbsp;&nbsp;</a>");
                    break;
                case "处理中":
                    arr.push("<a class='tdbtn wf_ondeal' title='点击查看审批信息' href=\"javascript:app_wfinfo('",recid,"');\">处理中</a>");
                    break;
                case "完成":
                    arr.push("<a class='tdbtn wf_done' title='点击查看审批信息' href=\"javascript:app_wfinfo('",recid,"')\">&nbsp;&nbsp;" + val + "&nbsp;&nbsp;</a>");
                    break;
                case "归档":
                    arr.push("<a class='tdbtn wf_guidang' title='点击查看审批信息' href=\"javascript:app_wfinfo('",recid,"')\">&nbsp;&nbsp;" + val + "&nbsp;&nbsp;</a>");
                    break;
                case "终止":
                    arr.push("<a class='tdbtn wf_stoped' title='点击查看审批信息' href=\"javascript:app_wfinfo('",recid,"')\">&nbsp;&nbsp;" + val + "&nbsp;&nbsp;</a>");
                    break;
                default:
                    arr.push("<a class='tdbtn wf_done' title='点击查看审批信息' href=\"javascript:app_wfinfo('",recid,"')\">&nbsp;&nbsp;" + val + "&nbsp;&nbsp;</a>");
                    break;
            }
        }

        return arr.join("");
    }
    function app_startwf(appId)
    {
        var url = "";
        if("<%=workflowCode %>" == "")
            url = "../workflow/SelectWorkFlow.aspx?tblName=<%=tblname %>&mainId="+appId;
        else
            url = "../workflow/NewFlow.aspx?workflowCode=<%=workflowCode %>&appId="+appId;

        window.open(url,"_blank");
    }
    function app_export(cmd,grid)
    {
		var param=$("#flex1")[0].p;
		var query="&query="+param.condition+"&sortname="+param.sortname+"&sortorder="+param.sortorder;
        window.open("AppExport.aspx?<%=Request.QueryString %>"+query,"_blank");
    }
    function app_import(cmd,grid)
    {
		var param=$("#flex1")[0].p;
        var url = "<%=Page.ResolveUrl("~") %>SysFolder/AppFrame/AppImport.aspx?tblName=<%=tblname %>&sIndex=<%=sindex %>";
        var dlg = new jQuery.dialog({ title: '数据导入', maxBtn: true, page: url
            , btnBar: true, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black',cancelBtnTxt:'关闭'
        });
        dlg.ShowDialog();
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
		var ret=_curClass.saveLayout(fldlist,"<%=tblname %>","<%=sindex %>",sortdir);
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

    function _getRowId(){
        if($('.trSelected',"#flex1").length>0)
		{
			var editId = $('.trSelected',"#flex1")[0].id.substr(3);
            return editId;
        }
        return "";
    }
    function app_copy(cmd,grid)
	{
        var editId = _getRowId();
		if(editId != "")
		{
			para="para="+_curClass.CryptPara("<%=para %>&copyId="+editId).value;
			window.open("AppInput.aspx?"+para,"_blank");
		}
		else
		{
			alert("请选中一条记录");
		}
	}
	function app_edit(cmd,grid)
	{
        var editId = _getRowId();
		if(editId != "")
		{
            var checkFlag = true;
            if (typeof (_sysBeforeEdit) == "function"){ 
                var row = xmlData.find("#"+editId);
                checkFlag = _sysBeforeEdit(editId,row);
            }

            if(!checkFlag) return;

			var url="<%=base.ResolveUrl("~")%>SysFolder/AppFrame/AppInput.aspx?para="+_curClass.CryptPara("<%=para %>&mainId="+editId).value;
            if(_iframe){
                if(window.top.$("#lhgfrm_lhgdgId").length>0){
                    window.top.$("#lhgfrm_lhgdgId").attr("src",url);
                }
                else{
                    var dlg = new $.dialog({ title: '业务编辑', page: url
                        , btnBar: false, cover: false, rang: true, width: 900, height: 600, bgcolor: 'gray'

    	            });
    	            dlg.ShowDialog();
                }
            }
            else{
			    window.open(url,"_blank");
            }
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
			if(confirm('确定删除这' + $('.trSelected',grid).length + '条记录吗?'))
			{
			    $('.trSelected',grid).each
			    (
			        function()
			        {
			            var editId = this.id.substr(3);
                        if(editId){
                            var checkFlag = true;
                            if (typeof (_sysBeforeDel) == "function"){ 
                                var row = xmlData.find("#"+editId);
                                checkFlag = _sysBeforeDel(editId,row);
                            }

                            if(!checkFlag) return;

			                var ret={};
                            if(!!_enforceDel){
                                ret = _curClass.DelEnforce("<%=tblname %>",editId);
                            }
                            else{
                                ret = _curClass.DelRecord("<%=tblname %>",editId);
                            }
			                if(ret.error)
			                {
                                
			                    alert("删除出错："+ret.error.Message);
			                }
			                else
			                {
                                $.noticeAdd({ text: '删除成功！'});
			                    $("#flex1").flexReload();

                                if (typeof (_sysAfterDel) == "function") {
                                    var row = xmlData.find("#"+editId);
                                    _sysAfterDel(editId,row);
                                }
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

    //强制撤回到发起人
    function frechTask(AutoID) {
        var ret = _curClass.FetchTaskEnforce("<%=tblname%>",AutoID);
        if (ret.error) {
            alert(ret.error.Message);
        }
        else {
            alert("撤回任务成功");
            $("#flex1").flexReload();
        }
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
    var _sIndex="<%=sindex %>";
    var _funId="<%=funId %>";

    //-----------------------自定义代码段--------------------------------
    <%=listfn %>
    //-------------------------------------------------------------------

//-->
</script>