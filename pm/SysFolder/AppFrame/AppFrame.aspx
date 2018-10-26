<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>综合页面[<%=MainTitle%>]</title>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="../../css/layout-default-latest.css" />
	
	<style type="text/css">
		*{margin:0px;padding:0px;}
		.ui-layout-north,
		.ui-layout-center ,	/* has content-div */
		.ui-layout-west ,	/* has Accordion */
		.ui-layout-east ,	/* has content-div ... */
		.ui-layout-east .ui-layout-content { /* content-div has Accordion */
			padding: 0px;
			margin:0px;
			overflow: hidden;
			background-color:#f5f5f5;
		}
		.ui-layout-mask {
			opacity: 0.2 !important;
			filter:	 alpha(opacity=20) !important;
			background-color: #666 !important;
		}
		#HeadTable{height:60px;font:bold 16px/60px "微软雅黑",tahoma;background:#eee url(../../img/common/header.jpg) repeat-x;color:#fefefe;padding-left:14px;}
		ul{}
		li{padding-left:10px;height:30px;line-height:30px;background:#eee url(../../img/common/topbar.gif) repeat-x;border-bottom:1px solid #99BBE8;}
		li a{text-decoration:none;color:blue;background:transparent url(../../img/bullet.gif) no-repeat left center;padding-left:14px;display:block;}
		li a:hover{text-decoration:none;color:red;}
	</style>
	<!-- REQUIRED scripts for layout widget -->
	<script type="text/javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/Fader.js"></script>
    <script type="text/javascript" src="../../js/jquery.cookie.js"></script>
	<script type="text/javascript">
 
	var myLayout; // init global vars
	var tabpanel;

	function closeAllPanel()
	{
	    $.each('north,south,west,east'.split(','), function () { myLayout.close(this); });
    }
 	function openAllPanel()
	{
	    $.each('north,south,west,east'.split(','), function () { myLayout.open(this); });
    }
    function toggleAllPanel()
	{
	    $.each('north,south,west,east'.split(','), function () { myLayout.toggle(this); });
    } 
    function toggleLeftPanel()
	{
        myLayout.toggle("west");
    }
    $(function () {

        myLayout = $('body').layout({
              spacing_open: 5
			, west__size: 180
            , maskIframesOnResize: true
		    , west__onresize: function () { $("#accordion1").accordion("resize"); }
		    , center__onresize: function () { tabpanel.resize(); }
		    , north__resizable: false
		    , north__toggler: false
		    , west__toggler: false
        });
    });
	function menuClick(item) {
        var d=new Date();
        if(item.value)
		tabpanel.addTab({id:item.id , title:item.text, html:'<iframe src="'+item.value+'" width="100%" height="100%" frameborder="0"></iframe>'});
    }
    function addTab(tabId, tabTitle, tabUrl) {
        tabpanel.addTab({ id: tabId, title: tabTitle, html: '<iframe src="' + tabUrl + '" width="100%" height="100%" frameborder="0"></iframe>' });
    }
    document.execCommand("BackgroundImageCache", false, true) ;

	</script>
</head>
<body>
 
<div class="ui-layout-north">
    <div id="HeadTable">
		<%=MainTitle%>
    </div>
                
</div>

<div class="ui-layout-west" style="display: none;">
	<div id="accordion1" class="basic">
        <%=Links %>
	</div>
</div>
<iframe id="main" name="main" class="ui-layout-center" width="100%" height="100%" frameborder="0" scrolling="auto" src="<%=firstLink%>"></iframe>
  
</body>
</html> 