<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.Logs.LogFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>日志查看</title>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="../../css/appStyle.css?v=1" type="text/css"/>
    <link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="../../css/layout-default-latest.css" />
	
	<style type="text/css">
		*{margin:0px;padding:0px;}
		body{font-size:10pt;font-family:Tahoma,Helvetica,Arial,sans-serif;}
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
		.ui-layout-center{
			overflow: auto;
			background-color:white;
			padding:10px;
		    }
        .ui-layout-south{
			background-color:#f9fafe;
			padding-left:300px;
		    }
		.ui-layout-mask {
			opacity: 0.2 !important;
			filter:	 alpha(opacity=20) !important;
			background-color: #666 !important;
		}
		li a{text-decoration:none;color:blue;;padding-left:14px;display:block;}
		li a:hover{text-decoration:none;color:red;}
        li.sellink a{color:red;}
        #tree
	    {
	        border:#c3daf9 1px solid;
	        background:#f9fafe;
	        overflow:auto;
	        padding:5px;
	        margin:5px;
	    }
	    .time{font-weight:bold;color:Blue;margin-right:5px;}
	    .bottombar a{text-decoration:none;color:Blue;display:inline-block;padding:3px 5px;}
	    .bottombar a.on{border-radius:2px;color:white;background:#3a6ea5;}
	</style>
    <style type="text/css">
        .error{color:red;}
        .csharp{color:#b22222;}
        .sqlkey{color:blue;}
        .sqlother{color:#ff00ff;}
        .sqlpara{color:#008080;padding:2px;}
    </style>
	<!-- REQUIRED scripts for layout widget -->
	<script type="text/javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/Fader.js"></script>
    <script type="text/javascript" src="../../js/jquery.cookie.js"></script>
	<script type="text/javascript" src="../../js/jquery.ztree.all-3.4.min.js"></script>
	<script type="text/javascript">

	    var myLayout; // init global vars
	    var tabpanel;

	    function closeAllPanel() {
	        $.each('north,south,west,east'.split(','), function () { myLayout.close(this); });
	    }
	    function openAllPanel() {
	        $.each('north,south,west,east'.split(','), function () { myLayout.open(this); });
	    }
	    function toggleAllPanel() {
	        $.each('north,south,west,east'.split(','), function () { myLayout.toggle(this); });
	    }
	    function toggleLeftPanel() {
	        myLayout.toggle("west");
	    }

	    $(function () {
	        myLayout = $('body').layout({
	            spacing_open: 6
            , spacing_closed: 15
            , togglerTip_open: "关闭"
            , togglerTip_closed: "打开"
			, east__size: 320
            , maskIframesOnResize: true
		    , east__onresize: function () { $("#accordion1").accordion("resize"); }
		    , center__onresize: function () { tabpanel.resize(); }
		    , north__resizable: false
		    , north__toggler: false
		    , east__toggler: false
	        });
	        $("a.scope").click(function () {
	            $(this).siblings(".scope").removeClass("on");
	            $(this).addClass("on");

	            $(".reload").click();
	        });
	    });
	    function menuClick(item) {
	        var d = new Date();
	        if (item.value)
	            tabpanel.addTab({ id: item.id, title: item.text, html: '<iframe src="' + item.value + '" width="100%" height="100%" frameborder="0"></iframe>' });
	    }
	    function addTab(tabId, tabTitle, tabUrl) {
	        tabpanel.addTab({ id: tabId, title: tabTitle, html: '<iframe src="' + tabUrl + '" width="100%" height="100%" frameborder="0"></iframe>' });
	    }
	    document.execCommand("BackgroundImageCache", false, true);

	</script>
</head>
<body>
    <form id="form1" runat="server">
    </form>    
  <div id="txtZone" class="ui-layout-center">
    <div style="margin-left:auto;margin-right:auto;">请选择右侧的日志文件</div>
  </div>
  <div class="ui-layout-east" style="display: none;overflow:auto;">
    <div class="toolbar" style="">
        <button id="btnExpand" type="button"><img alt="全部展开" src="../../img/common/ico6.gif" />全部展开</button>
        <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>
        <input type="text" style="width:70px;" class="search" id="txtSearch" />
        <button id="btnSearch" type="button"><img alt="查找" src="../../img/common/search.png" />查找</button>
    </div>
    <ul id="tree" class="ztree"> 
    </ul>
</div>
  <div class="ui-layout-south">
    <div class="bottombar">
        <span id="fileSpan" style="display:inline-block;position:absolute;left:10px;color:#ff6347;font-weight:bold;">请选择日志文件</span>&nbsp;
        <a class="reload" style="color:White;background-color:#cd5c5c;border-radius:2px;" href="javascript:">重新加载</a>&nbsp;&nbsp;
        [<a class="autofresh" href="javascript:">自动刷新</a>]&nbsp;&nbsp;&nbsp;&nbsp;
        [<a class="scope" rel="" href="javascript:">显示全部内容</a>&nbsp;
        <a class="scope on" rel="50" href="javascript:">只显示最近50条</a>&nbsp;
        <a class="scope" rel="100" href="javascript:">只显示最近100条</a>]
    </div>
  </div>
</body>
</html> 

<script type="text/javascript">
    var setting = { 
        edit: {
                drag:{
                    autoExpandTrigger: true,
                    isCopy:true,
                    isMove:true
                    },
				enable: false,
                showRenameBtn:false,
                showRemoveBtn:false,
				editNameSelectAll: false
			},
        callback:{
                onClick:nodeClick
            }
    };
    var _logFile = "";
    var _curClass = EZ.WebBase.SysFolder.Logs.LogFrame;
    function nodeClick(e,treeId,node)
    {
        _logFile = node.value;
        $("#fileSpan").html("日志文件："+node.name);
        var scope = $(".on").attr("rel");
        var log = _curClass.ReadLog(_logFile,scope).value;
        log = render(log);

        $("#txtZone").html(log+"</br>");
        $('#txtZone').scrollTop( $('#txtZone')[0].scrollHeight );
    }
    function expandToRoot(node)
    {
        if(node.getParentNode())
        {
            var pNode =node.getParentNode();
            zTree.expandNode(pNode,true,false,true);
            expandToRoot(pNode);
        }
    }
    var searchKey="";
    var searchOrder = 0;
    var searchNodes =[];
    function searchNode()
    {
        if(!$("#txtSearch").val())
        {
            alert("请输入查询内容");
            return;
        }
        if(searchKey != $("#txtSearch").val())
        {
            //新的查询
            searchKey = $("#txtSearch").val();
            searchNodes = zTree.getNodesByParamFuzzy("name", searchKey);
            searchOrder = 0;
        }
        if(searchOrder<searchNodes.length)
        {
            if(searchNodes.length>0)
            {
                zTree.selectNode(searchNodes[searchOrder]);
                expandToRoot(searchNodes[searchOrder]);
                searchOrder++;
            }
        }
        else
        {
            alert("已经查找到头");
            searchOrder=0;
        }
    }
    var zTree;
    var zNodes =<%=treedata %>;
    $(function () {
        var h=$(document).height();
        $("#tree").height(h-130);
        $(window).resize(function(){
            var h=$(document).height();
            $("#tree").height(h-130);
        });
        $.fn.zTree.init($("#tree"), setting, zNodes);
        zTree = $.fn.zTree.getZTreeObj("tree");
        var root =zTree.getNodeByTId("tree_1");
        $("#btnOption").click(function(){
            $("#optionPanel").toggle();
        });
        $("#txtSearch").keydown(function(e){
            if(e.keyCode == 13)
            {
                searchNode();
                $("#txtSearch").focus();
                return false;
            }
        });
        $("#btnSearch").click(function(){
            searchNode();
        });

        $("#btnExpand").toggle(function(){
            $.each(root.children,
            function(i,n){
                zTree.expandNode(n,true,true,false);
            });
        },function(){
            $.each(root.children,
            function(i,n){
                zTree.expandNode(n,false,true,false);
            });
        });

        $("#btnFresh").click(function(){
            window.location.reload();
        });

        $(".reload").click(function(){
            var scope = $(".on").attr("rel");
            var log = _curClass.ReadLog(_logFile,scope).value;
            log = render(log);
            $("#txtZone").html(log+"</br>");
            $('#txtZone').scrollTop( $('#txtZone')[0].scrollHeight );
        });
    });

    function render(msg){
        msg = msg.replace(/\|error\|/gi,"<span class='error'>$0</span>&nbsp;");
        msg = msg.replace(/([\w\.`]+)\((\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?(\s*(\w+)\s+(\w+)\s*,?)?\)/gi,
        function($0,$1){
            var str =  $0;
            var cls = $1;
            str = str.replace(/(\w+)\s+(\w+)/ig,"<span class='sqlkey'>$1</span>&nbsp;<span class='sqlother'>$2</span>");
            str = str.replace(cls,"<span class='csharp'>"+cls+"</span>");

            return str
        });

        msg = msg.replace(/(\b)(select|insert|update|delete|into|is|set|from|where|values|group\s+by|order\s+by)(?=[^\w])/gi,"$1<span class='sqlkey'>$2</span>");
        msg = msg.replace(/(\b)(top|distinct|not|and|or|null|case|when|then|begin|end|if|else|in(?=\()|dateadd|getdate|count(?=\()|sum(?=\()|avg(?=\())(?=[^\w])/gi,"$1<span class='sqlother'>$2</span>");
        //msg = msg.replace(/'.*?'/gi,"<span class='sqlother'>$0</span>");
        msg = msg.replace(/@(\w*)/gi,"<span class='sqlpara'>$0</span>");

        return msg;
    }
</script>

