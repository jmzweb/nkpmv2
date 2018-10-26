<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_PosTree.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_PosTree" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>岗位信息</title>
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
        </div>
        <ul id="tree"  class="ztree"> 
        </ul>
       <script type="text/javascript">
        var setting = { 
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
            if(node.id.length == 36)
            {
                window.parent.frames["main"].location.href="QX_PosEdit.aspx?roleId="+node.id+ "&grade=<%=GetParaValue("grade") %>&rolename="+node.name+"&t="+Math.random();
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

        });
    </script>
		</form>
	</body>
</html>
