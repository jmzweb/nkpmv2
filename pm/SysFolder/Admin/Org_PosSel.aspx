<%@ Page language="c#" Codebehind="PositionTree.aspx.cs" AutoEventWireup="true" Inherits="EIS.WebBase.SysFolder.Org.Org_PosSel" enableViewState="True"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择岗位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
	<link rel="stylesheet" href="../../css/appStyle.css?v=1" type="text/css"/>
	<link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.ztree.all-3.4.min.js"></script>

     <style type="text/css">
         body{overflow:hidden;}
     	#tree
	    {
	        border:#c3daf9 1px solid;
	        background:#f9fafe;
	        overflow:auto;
	        padding:5px;
	        margin:5px;
	    }
	    a{text-decoration:none;}
     </style>    
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
         <div class="toolbar" style="">
            <button id="btnExpand" type="button" title="全部展开"><img alt="全部展开" src="../../img/common/ico6.gif" />全部展开</button>
            <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>
            <input type="text" style="width:80px;" class="search" id="txtSearch" />
            <button id="btnSearch" type="button"><img alt="查找部门" src="../../img/common/search.png" />查找部门</button>&nbsp;
            <button id="btnOK" type="button"><img alt="确定" src="../../img/common/accept.png" />确定</button>
        </div>
        <ul id="tree"  class="ztree"> 
        </ul>
       <script type="text/javascript">
        var chkCan = "<%=selmethod %>"!="1";
        var setting = { 
            check: {enable: chkCan},
        	async: {
		        enable: true,
		        contentType: "application/json",
		        url: "../Common/TreeData.ashx?queryid=PosListbyDeptId",
		        autoParam: ["id", "value"]
	        },
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
        function nodeNameChange(name)
        {
            var nodes = zTree.getSelectedNodes();
            if(nodes.length>0)
            {
                nodes[0].name=name;
                zTree.updateNode(nodes[0]);
            }

        }

        function nodeClick(e,treeId,node)
        {
            if(!chkCan && (node.id.length == 36 || node.id.length == 20))
                singleRet();
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
        var searchKey="" ;
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
            $("#tree").height(h-80);
            $(window).resize(function(){
                var h=$(document).height();
                $("#tree").height(h-80);
            });
            $.fn.zTree.init($("#tree"), setting, zNodes);
            zTree = $.fn.zTree.getZTreeObj("tree");
            var root =zTree.getNodeByTId("tree_1");

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
            $("#btnSearch").click(function(){
                searchNode();
            });
            $("#btnFind").click(function(){
                $("#optionPanel").toggle();
                var h=$(document).height();
                if($("#optionPanel").is(":visible"))
                    $("#tree").height(h-110);
                else
                    $("#tree").height(h-80);
            });
            $("#txtSearch").keydown(function(e){
                if(e.keyCode == 13){
                    searchNode();
                    $("#txtSearch").focus();
                    return false;
                }
            });

           $("#btnOK").click(function(){
           
                var nodes = zTree.getCheckedNodes(true);
                for (var i = 0; i < nodes.length; i++) {
                    if (nodes[i].id.length == 36 || nodes[i].id.length == 20) {
                        var arr = nodes[i].tag.split("|");
                        if (idindex > -1)
                            postionIds.push(nodes[i].id);
                        if (nameindex > -1)
                            postionNames.push(nodes[i].name);
                        if (didindex > -1)
                            deptIds.push(nodes[i].value);
                        if (dcodeindex > -1)
                            deptCodes.push(arr[0]);
                        if (dnameindex > -1)
                            deptNames.push(nodes[i].getParentNode().name);

                        if (cidindex > -1)
                            compIds.push(arr[2]);
                        if (ccodeindex > -1)
                            compCodes.push(arr[3]);
                        if (cnameindex > -1)
                            compNames.push(arr[4]);

                    }
                }

                if (idindex > -1)
                    getpc(bizfields[idindex]).value = postionIds;
                if (nameindex > -1)
                    getpc(bizfields[nameindex]).value = postionNames;
                if (didindex > -1)
                    getpc(bizfields[didindex]).value = deptIds;
                if (dcodeindex > -1)
                    getpc(bizfields[dcodeindex]).value = deptCodes;
                if (dnameindex > -1)
                    getpc(bizfields[dnameindex]).value = deptNames;

                if (cidindex > -1)
                    getpc(bizfields[cidindex]).value = compIds;
                if (ccodeindex > -1)
                    getpc(bizfields[ccodeindex]).value = compCodes;
                if (cnameindex > -1)
                    getpc(bizfields[cnameindex]).value = compNames;

                window.close();
           });

        });
    </script>
		</form>
	</body>
</html>

<script type="text/javascript">
    Array.prototype.contains = function (element) {
        for (var i = 0; i < this.length; i++) {
            if (this[i] == element) {
                return i;
            }
        }
        return -1;
    }
    var cid = "<%=cid %>";
    var bizfields = cid.split(",");
    var qryfields = "<%=queryfield %>".toLowerCase().split(",");
    var idindex = qryfields.contains("positionid");
    var nameindex = qryfields.contains("positionname");

    var didindex = qryfields.contains("deptid");
    var dcodeindex = qryfields.contains("deptcode");
    var dnameindex = qryfields.contains("deptname");

    var cidindex = qryfields.contains("companyid");
    var ccodeindex = qryfields.contains("companycode");
    var cnameindex = qryfields.contains("companyname");
    var postionIds = [];
    var postionNames = [];

    var deptIds = [];
    var deptCodes = [];
    var deptNames = [];

    var compIds = [];
    var compCodes = [];
    var compNames = [];

    function getpc(pcid) {
        return window.opener.document.getElementById(pcid);
    }
    function singleRet() {

        var nodes = zTree.getSelectedNodes();
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].id.length == 36 || nodes[i].id.length == 20) {
                var arr = nodes[i].tag.split("|");
                if (idindex > -1)
                    postionIds.push(nodes[i].id);
                if (nameindex > -1)
                    postionNames.push(nodes[i].name);
                if (didindex > -1)
                    deptIds.push(nodes[i].value);
                if (dcodeindex > -1)
                    deptCodes.push(arr[0]);
                if (dnameindex > -1)
                    deptNames.push(nodes[i].getParentNode().name);

                if (cidindex > -1)
                    compIds.push(arr[2]);
                if (ccodeindex > -1)
                    compCodes.push(arr[3]);
                if (cnameindex > -1)
                    compNames.push(arr[4]);

            }
        }

        if (idindex > -1)
            getpc(bizfields[idindex]).value = postionIds;
        if (nameindex > -1)
            getpc(bizfields[nameindex]).value = postionNames;
        if (didindex > -1)
            getpc(bizfields[didindex]).value = deptIds;
        if (dcodeindex > -1)
            getpc(bizfields[dcodeindex]).value = deptCodes;
        if (dnameindex > -1)
            getpc(bizfields[dnameindex]).value = deptNames;

        if (cidindex > -1)
            getpc(bizfields[cidindex]).value = compIds;
        if (ccodeindex > -1)
            getpc(bizfields[ccodeindex]).value = compCodes;
        if (cnameindex > -1)
            getpc(bizfields[cnameindex]).value = compNames;

        window.close();

    }
</script>
