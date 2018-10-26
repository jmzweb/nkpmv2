<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocList.aspx.cs" Inherits="EIS.Web.Doc.DocList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>最新文档</title>
    <link rel="stylesheet" type="text/css" href="../css/defstyle.css" />    
    <link rel="stylesheet" type="text/css" href="../css/doc.css" />
    <link rel="stylesheet" type="text/css" href="../css/smartMenu.css" />
    <link rel="stylesheet" type="text/css" href="../grid/css/flexigrid.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.min.js" ></script>
    <script type="text/javascript" src="../DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="../grid/flexigrid.js"></script>
    <script type="text/javascript" src="../js/lhgdialog.min.js?t=self"></script>
    <script type="text/javascript" src="../js/jquery.smartMenu.js"></script>
     <style type="text/css">
	    body{
	    	margin:0px;padding:0px;
	    	}
	    div.iDialog{
	    	    margin-left:30px;
	    	    margin-top:30px;
	    	}
        .smart_menu_box{width:80px;}
        .smart_menu_a{padding-left:20px;}
        .flexigrid a.path{background:url(../img/doc/folder.gif) no-repeat;padding-left:20px;}
        .flexigrid a.path:hover{background:url(../img/doc/folder.gif) no-repeat;color:#dc143c;border-width:0px;}
     </style>    
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <div id="griddiv" >
            <table id="flex1"  style="display:none"></table>    
        </div>
        <script type="text/javascript">

	        function changeName(objid, objname)//修改名称
	        {
	            window.parent.frames["left"].changeName(objid, objname);
	        }
	        function newFolder(objid, objname) {
	            window.parent.frames["left"].newFolder([objid, objname, ""]);
            }

        </script>
		</form>
	</body>
</html>
<script type="text/javascript">
<!--
        var limit = "1";
        var treeId = "<%=GetParaValue("treeNo") %>";
        treeId = treeId==""?"0":treeId;
        var _curClass = EIS.Web.Doc.DocList;
        var gridData;
        $("#flex1").flexigrid
			(
			{
			    showToggleBtn: false,
			    url: 'getList.ashx?ds=doc',
			    params: [{ name: "queryid", value: "recent_list" }
			            , { name: "condition", value: "folderWbs Like '"+treeId+".%'" }
			        ],
			    colModel: [
				{ display: '序号', name: 'rowindex', width: 30, sortable: false, align: 'center' },
				{ display: '', name: 'filetype', width: 20, sortable: false, align: 'left', renderer: transtype },
				{ display: '文件名', name: 'filename', width: 200, sortable: true, align: 'left', renderer: transname },
				{ display: '路径', name: 'path', width: 200, sortable: true, align: 'left', renderer: fnPath },
				{ display: '所有者', name: 'owner', width: 50, sortable: true, align: 'center' },
                { display: '类型', name: 'filetype', width: 50, sortable: true, align: 'center' },
                { display: '大小', name: 'filesize', width: 60, sortable: true, align: 'right', renderer: transize },
                { display: '创建时间', name: 'createtime', width: 120, sortable: true, align: 'center' }
				],
			    buttons: [
                { name: '下面是最近一个月上传的文件', bclass: 'tip' },
                { separator: true },
				{ name: '查询', bclass: 'view', onpress: app_query },
		        { name: '清空', bclass: 'clear', onpress: app_reset }
				],
			    searchitems: [
			    { display: '文件名', name: 'filename', type: 1 },
			    { display: '上传人', name: 'subject', type: 1 }
			    ],
			    sortname: "createtime",
			    sortorder: "desc",
			    usepager: true,
			    singleSelect: false,
			    autoload: true,
			    useRp: true,
			    rp: 15,
			    multisel: true,
			    showTableToggleBtn: false,
			    resizable: false,
			    height: 'auto',
			    onError: showError,
			    onSuccess: initMenu,
			    preProcess: processData
			}
		);

        var g = 1024 * 1024 * 1024;
        var m = 1024 * 1024;
        var k = 1024;
        function transize(fldval, row) {
            if (parseInt(fldval) > g) {
                return (parseInt(fldval) / g).toFixed(2) + " G";
            }
            else if (parseInt(fldval) > m) {
                return (parseInt(fldval) / m).toFixed(2) + " M";
            }
            else if (parseInt(fldval) > k) {
                return (parseInt(fldval) / k).toFixed(2) + " K";
            }
            else if (fldval != "0") {
                return fldval + " B";
            }
            else {
                return "";
            }
        }
        function transtype(fldval, row, td) {
            if (fldval == "") {
                $(td).attr("flag", "folder");
                return "<div class='flag folder'></div>";
            }
            else {
                $(td).attr("flag", "file");
                return "<div class='flag " + fldval.substring(1) + "'></div>";
            }
        }
        function processData(data) {
            gridData = data;
            return data;
        }
        function fnPath(v, row) {
            var fileid = $("folderid", row).text(); 
            return "<a class='path' href=\"javascript:openFolder('" + fileid + "');\"  class='foldername' target='_self'>" + v + "</a>";
        }

        function transname(fldval, row, td) {
            var fileid = $("fileid", row).text();
            var filetype = $("filetype", row).text();
            $(td).attr("fileId", fileid);
            $(td).attr("ext", filetype);
            var flimit = $("limit", row).text();
            if (filetype == "") {
                if(flimit == "9"){
                    $(td).addClass("tdfolder");
                }
                if(flimit>"1"){
                    return "<a href=\"javascript:openFolder('" + fileid + "');\"  class='foldername' target='_self'>" + fldval + "</a>";
                }
                else{
                    return fldval;
                }
            }
            else {
                $(td).addClass("tdfile"+flimit);

                if(flimit>"1"){
                    return "<a href=\"javascript:readFile('" + fileid + "','"+filetype+"');\" class='filename'>" + fldval + "</a>";
                }else{
                    return fldval;
                }
            }

        }

        function app_send(){
            var arr = getSelectFiles();
            var arr2 =[];
            if(arr.length==0){
                alert("请先选择文件");
                return;
            }
            var ret = "";
            ret = _curClass.SaveSelect("1",arr, arr2);
            if (ret.error) {
                alert("保存选中的记录时出错:" + ret.error.Message);
            }
            else{
                openCenter("DocFolderSend.aspx", "_blank", 500, 340);            
            }
            
        }
        function app_select(cmd,grid){
            var arr = getSelectFiles();
            var arr2 = getSelectFolders();
            if(arr.length==0 && arr2.length==0){
                alert("请先选择对象");
                return;
            }
            var ret = "";
            if(cmd=="复制")
            {
                ret = _curClass.SaveSelect("1",arr, arr2);
            }
            else if(cmd=="剪切"){
                ret = _curClass.SaveSelect("2",arr, arr2);
            }

            if (ret.error) {
                alert("保存选中的记录时出错:" + ret.error.Message);
            }
            else {
                alert("选择的文件已经【"+cmd+"】\r\n请到目标目录中选择【粘贴】操作");
            }
        }

        function loadData(folderId) {

            $("#flex1").flexOptions({
                url: '../getdata.ashx?t=' + Math.random(),
                params: [{ name: "queryid", value: "doc_list" }, { name: "condition", value: "folderId='" + folderId + "'"}]
            });
            $("#flex1").flexReload();
        }

        function openFolder(folderId) {
            window.open("DocList.aspx?folderId=" + folderId + "&treeId=0&time=" + Math.random(), "_self");
        }

        function tranchk(fldval, row, td) {
            var filetype = $("filetype", row).text();
            filetype = filetype.length > 0 ? "chkfile" : "chkfolder";
            return "<input type='checkbox' onclick='selectchk(this);' class='selectchk " + filetype + "' value='" + fldval + "'/>";
        }

        function selectchk(obj) {
            if (obj.checked) {
                $(obj).closest("tr").addClass("trSelected");
            }
            else {
                $(obj).closest("tr").removeClass("trSelected");
            }
        }

        function app_selall() {
            $(".selectchk").each(function () {
                this.checked = true;
                $(this).closest("tr").addClass("trSelected");
            })
        }

        var curNode;

        function handler2(tp) {
            if (tp == 'ok') {
                var pId = curNode.id;
                var folderName = jQuery("#folderName").val();
                var ret = _curClass.NewFolder(folderName, pId);
                if (ret.error) {
                    alert("新建文件夹出错");
                }
                else {
                    newFolder(ret.value, folderName);
                }
            }
        }

        function showError(data) {
            //alert("加载数据出错");
        }

        function app_reset(cmd, grid) {
            $("#flex1").clearQueryForm();
        }
        function getSelectFiles() {
            var arr = [];
            $('.chkfile:checked').each(function () {
                arr.push(this.value);
            });
            return arr;
        }
        function getSelectFolders() {
            var arr = [];
            $('.chkfolder:checked').each(function () {
                arr.push(this.value);
            });
            return arr;
        }
        var menuFolder = [[
            /*{
            text: "共享",
            func: function () {
                openCenter("DocFolderShare.aspx?folderId=" + trId, "_blank", 500, 340);
            }}, */
            { text: "属性",
                func: function () {
                    openCenter("DocFolderEdit.aspx?folderId=" + trId, "_blank", 600, 400);
                }
            }
        ]];
        var officeExts=[".txt",".doc",".docx",".xls",".xlsx",".ppt",".pptx",".pdf",".wps"];
        var picExts=[".bmp",".jpg",".jpeg",".gif",".png",".tif",".tiff"];
        var videoExts=[".flv",".mp4"];
        function readFile(fileId,_fileExt){
            if(jQuery.inArray(_fileExt,officeExts)>-1){
			    var para=_curClass.CryptPara("read=1&fileId=" + fileId).value;
                //openCenter("../SysFolder/common/WebOffice.aspx?para=" + para, "_blank", 800, 600);
                window.open("../SysFolder/common/fileViewer.aspx?para=" + para);
            }
            else if(jQuery.inArray(_fileExt,picExts)>-1){
			    var para=_curClass.CryptPara("read=1&fileId=" + fileId).value;
                window.open("../SysFolder/common/fileView_Pic.aspx?para=" + para);
            }
            else if(jQuery.inArray(_fileExt,videoExts)>-1){
			    var para=_curClass.CryptPara("read=1&fileId=" + fileId).value;
                window.open("../SysFolder/common/fileView_Video.aspx?para=" + para);
            }
            else{
			    var para=_curClass.CryptPara("fileId=" + fileId).value;
                openCenter("../SysFolder/common/filedown.aspx?para=" + para, "_blank", 800, 600);
            }
        }
        var menuFile = [{
            text: "查看",
            func: function () {
                readFile(trId,fileExt);
            }
        },{
            text: "下载",
            func: function () {
                window.open("../SysFolder/common/filedown.aspx?fileid=" + trId, "_blank");
            }
        }];

        var trId = "";
        var fileExt = "";
        var flag = "";
        function initMenu() {
            jQuery("#flex1 td.tdfolder").each(function(){
                var folder=$(this);
                folder.smartMenu(menuFolder
                , { name: "contextMenu1"
                    , beforeShow: function () {
                        trId = $(this).attr("fileId");
                    }
                });
            
            });

            jQuery("#flex1 td.tdfile2").smartMenu([[menuFile[0]]]
            , { name: "contextMenu2"
                , beforeShow: function () {
                    trId = $(this).attr("fileId");
                }
            });
           jQuery("#flex1 td.tdfile3").smartMenu([[menuFile[0],menuFile[1]]]
            , { name: "contextMenu3"
                , beforeShow: function () {
                    trId = $(this).attr("fileId");
                    fileExt = $(this).attr("ext");
                }
            });
            jQuery("#flex1 td.tdfile6").smartMenu([[menuFile[0],menuFile[1],menuFile[2]]]
            , { name: "contextMenu6"
                , beforeShow: function () {
                    trId = $(this).attr("fileId");
                    fileExt = $(this).attr("ext");
                }
            });
            jQuery("#flex1 td.tdfile9").smartMenu([menuFile]
            , { name: "contextMenu9"
                , beforeShow: function () {
                    trId = $(this).attr("fileId");
                    fileExt = $(this).attr("ext");
                }
            });
        }

        function app_query() {
            $("#flex1").flexReload();
        }

        function app_reset(cmd, grid) {
            $("#flex1").clearQueryForm();
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
//-->
</script>

