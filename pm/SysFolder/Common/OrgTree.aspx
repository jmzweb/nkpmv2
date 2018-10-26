<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgTree.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.OrgTree" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>组织部门</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
	<link rel="stylesheet" href="../../css/appStyle.css?v=1" type="text/css"/>
	<link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
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
	    a:hover{text-decoration:none;}
	    #txtSearch{padding:2px 3px;border:1px solid #bbb;}
     </style>    
	</head>
	<body>
		<form id="form1" method="post" runat="server">
         <div class="toolbar" style="background-image:url();border-bottom-color:#ddd;">
            <button id="btnExpand" type="button" title="全部展开"><img alt="全部展开" src="../../img/common/ico6.gif" />展开</button>
            <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>
        	<input id="txtSearch"  type="text" size="8"/>
            <button id="btnFind" type="button"><img alt="查找" src="../../img/common/search.png" />查找</button>
        </div>
        <ul id="tree"  class="ztree"> 
        </ul>
       <script type="text/javascript">
        var _curClass = EZ.WebBase.SysFolder.Common.OrgTree;
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
            if(node.tag == "1"){
                var tnode ={id:"tempNode", name:"加载中…", value:"", tag:""};
                zTree.addNodes(node,tnode);

                var ret = _curClass.GetEmployee(node.value).value;
                for (var i = 0; i < ret.Rows.length; i++) {
                    var emp = ret.Rows[i];
                    var icon = "../../img/common/" + (emp.Sex == "男" ? "man.png":"woman.png");
                    var son={id:emp.EmployeeID, name:emp.EmployeeName, value:"", tag:"2",icon:icon};
                    zTree.addNodes(node,son);
                }
                var delNode = zTree.getNodesByParamFuzzy("id", "tempNode");
                zTree.removeNode(delNode[0],true);
                node.tag = "3";
            }
            else if(node.tag == "2"){
                window.open("UserInfo.aspx?empId=" + node.id ,"_blank");
            }
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
                searchOrder=0;
            }
        }
        var zTree;
        var zNodes =<%=treedata %>;
        $(function () {
            var h=$(document).height();
            $("#tree").height(h-60);
            $(window).resize(function(){
                var h=$(document).height();
                $("#tree").height(h-60);
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
            $("#btnFind").click(function(){
                searchNode();
            });
            $("#txtSearch").keydown(function(e){
                if(e.keyCode == 13){
                    searchNode();
                    $("#txtSearch").focus();
                    return false;
                }
            });
        });
       </script>
		</form>
	</body>
</html>
