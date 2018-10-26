<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileViewer.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.FileViewer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=fileName %></title>
    <style type="text/css" media="screen">
		html{ margin:0; }
		body{ height:100%; margin:0;background-color:white; }
		body { padding:0; overflow:auto; text-align:center;}
		#flashContent {display:none; }
		#txtContent {display:none; text-align:left;font-size:14px;line-height:1.8;overflow:auto;padding:20px 30px;}
		a.down{color:blue;}
		a.down:hover{text-decoration:none;}
        .tipul {
            margin-left:auto;margin-right:auto;
            width:460px;
            line-height:2;
            text-align:left;
        }
    </style>

    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="../../js/swfobject.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    	<div id="pdiv" style="margin-left:auto;margin-right:auto;">
            <div id="txtContent"><%=sbText %></div>
	        <div id="flashContent">
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    if ("<%=viewFlag %>" == "0") {
        $("#flashContent").show().html("<h3 style='color:Red;margin-top:40px;'>本文档不支持在线预览，请<a class='down' href='fileDown.aspx?fileId=<%=FileId%>'>[下载]</a>查看！</h3>");
    }
    else if ("<%=viewFlag %>" == "txt") {
        $("#txtContent").show();
    }
    else {
        $("#pdiv").height($(window).height());    
    }
</script>
<script type="text/javascript">
	var swfVersionStr = "10.0.0";
	var xiSwfUrlStr = "expressInstall.swf";
	var flashvars = {
	    SwfFile: escape('FileToSWF.aspx?fileId=<%=FileId%>&Create=<%=Request["Create"] %>&rnd=') + Math.random(),
	    Scale: 1.7,
	    ZoomTransition: "easeOut",
	    ZoomTime: 0.5,
	    ZoomInterval: 0.1,
	    FitPageOnLoad: false,
	    FitWidthOnLoad: false,
	    PrintEnabled: true,
	    FullScreenAsMaxWindow: false,
	    ProgressiveLoading: true,
	    PrintToolsVisible: true,
	    ViewModeToolsVisible: true,
	    ZoomToolsVisible: true,
	    FullScreenVisible: true,
	    NavToolsVisible: true,
	    CursorToolsVisible: true,
	    SearchToolsVisible: true,
	    localeChain: "zh_CN"
	};

	var params = {};
	params.quality = "high";
	params.bgcolor = "#ffffff";
	params.allowscriptaccess = "sameDomain";
	params.allowfullscreen = "true";
	var attributes = {};
	attributes.id = "FlexPaperViewer";
	attributes.name = "FlexPaperViewer";
	if ("<%=viewFlag %>" == "1") {
	    swfobject.embedSWF(
        "FlexPaperViewer.swf", "flashContent",
        "100%", "100%",
        swfVersionStr, xiSwfUrlStr,
        flashvars, params, attributes);
	    swfobject.createCSS("#flashContent", "display:block;");
	}
</script>
<script type="text/javascript">
    var docViewer;
    function getDocViewer() {
        if (docViewer)
            return docViewer;
        else if (window.FlexPaperViewer)
            return window.FlexPaperViewer;
        else if (document.FlexPaperViewer)
            return document.FlexPaperViewer;
        else
            return null;
    }
    function onExternalLinkClicked(link) {
        window.location.href = link;
    }

    function onProgress(loadedBytes, totalBytes) {}

    function onDocumentLoading() {}

    function onCurrentPageChanged(pageNum) {}

    function onDocumentLoaded(totalPages) {}

    //如果无法预览，直接通过浏览器打开
    var officeExts = ["doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf", "wps"];
    function onDocumentLoadedError(errMsg) {
        var _fileExt = "";
        var arr = "<%=fileName%>".toLowerCase().split(".");
        if (arr.length > 1) {
            _fileExt = arr[arr.length - 1];
        }
        if (_fileExt == "pdf") {
            window.location = "fileDown.aspx?fileId=<%=FileId%>&inline=1";
            return;
        }

        var html =[];
        html.push("<h3 style='color:Red;margin-top:40px;'>本文档不支持在线预览，请使用下面的方式尝试打开</h3><ul class='tipul'>");

        if (jQuery.inArray(_fileExt, officeExts) > -1) {
            html.push("<li>方法一：<a class='down' title='点击打开' href='WebOffice.aspx?fileId=<%=FileId%>&read=1'>通过WebOffice控件在线打开</a></li>");
        }
        
        html.push("<li>方法二：<a class='down' title='点击打开' href='fileDown.aspx?fileId=<%=FileId%>'>下载到本地打开</a></li>");
        html.push("</ul>");
        $("#pdiv").html(html.join(""));
    }
</script>
