<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeskTopSet.aspx.cs" Inherits="EIS.Web.DeskTopSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>快捷方式设置</title>
    <link rel="stylesheet" type="text/css" href="css/appstyle.css" />    
    <link rel="stylesheet" type="text/css" href="css/tree.css" />
	<link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.all-3.4.min.js"></script>
     <style type="text/css">
        body{overflow:hidden;padding:0px;margin:0px;}
     	#tree,#list,#note,#fieldDesk
	    {
	        border:#c3daf9 1px solid;
	        background:#f9fafe;
	        overflow:auto;
	        padding:5px;
	        margin:5px;
	        width:300px;
	        float:left;
	    }
	    #note,#fieldDesk{padding:5px;height:200px;}
	    #note legend,#fieldDesk legend{
            color:white;
            padding:3px 8px;
	        background:#3a6ea5;
	        }
        input[type=radio]{vertical-align:middle;cursor:pointer;}
        label{cursor:pointer;}
     </style>    
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
         <div class="toolbar" style="">
            <button id="btnReturn" type="button"><img alt="返回桌面" src="img/doc/arrow_left.png" />返回桌面</button>
            <button id="btnExpand" type="button"><img alt="全部展开" src="img/common/ico6.gif" />全部展开</button>
            <button id="btnDel" type="button"><img alt="删除" src="img/common/delete.png" />删除</button>
            <button id="btnFresh" type="button"><img alt="刷新" src="img/common/fresh.png" />刷新</button>
        </div>
        <ul id="list"  class="ztree"> 
        </ul>
        <ul id="tree"  class="ztree"> 
        </ul>
        <fieldset id="fieldDesk">
            <legend>默认桌面</legend>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
                onselectedindexchanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem Selected="True" Value="1"> 文字桌面</asp:ListItem>
                <asp:ListItem Value="2"> 图标桌面</asp:ListItem>
            </asp:RadioButtonList>
        </fieldset>
        <fieldset id="note">
            <legend>操作说明</legend>
            <ul style="list-style-type:decimal;padding-left:30px;line-height:22px;">
                <li>把一些最常用的功能放到桌面上以方便操作</li>
                <li>双击右边的功能节点就可以创建快捷方式。</li>
                <li>拖拽右边的功能节点到左边我的桌面。</li>
            </ul>
        </fieldset>
		</form>
	</body>
</html>
    <script type="text/javascript">
        $("#btnReturn").click(function(){
            window.open("DeskTop.aspx","_self");
        });
        var _curClass = EIS.Web.DeskTopSet;
        var setting1 = { 
            edit: {
                    drag:{
                        autoExpandTrigger: true,
                        isCopy:true,
                        isMove:true,
                        inner:true
                        },
				    enable: true,
                    showRenameBtn: false,
                    showRemoveBtn: false,
				    editNameSelectAll: false
			    },
            callback:{
                beforeDrop: nodeBeforeDrop1 ,
                onDrop : nodeDrop1
                },
            view:{showLine:false}

        };
        var setting2 = { 
            edit: {
                    drag:{
                        autoExpandTrigger: true,
                        isCopy:true,
                        isMove:true,
                        prev:false,
                        next:false,
                        inner:false
                        },
				    enable: true,
                    showRenameBtn: false,
                    showRemoveBtn: false,
				    editNameSelectAll: false
			    },
            callback:{
                onDblClick : nodeDblClick ,
                beforeDrop: nodeBeforeDrop2 ,
                beforeDrag: nodeBeforeDrag2 ,
                onDrop : nodeDrop2
                },
            view:{showLine:false}

        };

        function nodeBeforeDrag(treeId, treeNodes) {
			for (var i=0,l=treeNodes.length; i<l; i++) {
				if (treeNodes[i].drag === false) {
					return false;
				}
			}
			return true;
		}
		function nodeBeforeDrop1(treeId, treeNodes, targetNode, moveType) {
            var node = treeNodes[0];
            if(moveType == "inner")
			    return node.id.length < 30;
            else
                return true;
		}
        function nodeBeforeDrop2(treeId, treeNodes, targetNode, moveType) {
            var searchNodes = zTree1.getNodesByParamFuzzy("id", treeNodes[0].id);
            if (searchNodes.length > 0) {
                return false;
            }
			return targetNode.id.length < 30;
		}
        function nodeBeforeDrag2(treeId, treeNodes) {
			return treeNodes[0].children == undefined;
		}
        function nodeDrop1(e,treeId,nodes,targetNode,moveType,isCopy){
            if(targetNode == null)
                return false;
			if(moveType!="inner"){
				var arrId=[];
				var brotherNodes=targetNode.getParentNode().children;
				for(var i=0;i<brotherNodes.length;i++){
					arrId.push(brotherNodes[i].id);
				}
				ret = _curClass.UpdateOrder(arrId);
				if(ret.error)
				{
					alert("调整顺序时出错："+ret.error.Message);
				}
			}
			
		}
        function nodeDrop2(e,treeId,nodes,targetNode,moveType,isCopy){
            if(targetNode == null)
                return false;
			var arr=["",nodes[0].name,nodes[0].id,"",""];
			if(moveType == "inner"){
				arr[3]=targetNode.id;
			}
			else{
                if(targetNode.id=="0")
                    arr[3]="0";
                else
				    arr[3]=targetNode.getParentNode().id;
			}

			var ret = _curClass.AddNode(arr[3],arr[2],"");
			if(ret.error)
			{
				zTree.removeNode(nodes[0]);
				alert("添加节点时出错："+ret.error.Message);
			}
			else{
				if(moveType!="inner"){
					var arrId=[];
					var brotherNodes=targetNode.getParentNode().children;
					for(var i=0;i<brotherNodes.length;i++){
						arrId.push(brotherNodes[i].id);
					}
					ret = _curClass.UpdateOrder(arrId);
					if(ret.error)
					{
						alert("调整顺序时出错："+ret.error.Message);
					}
				}
			}
		}
        function nodeDblClick(e,treeId,node)
        {
			if (node.children != undefined)
                return;
            var searchNodes = zTree1.getNodesByParamFuzzy("id", node.id);
            if (searchNodes.length > 0) {
                return false;
            }
			var ret = _curClass.AddNode("0", node.id, "");
            var root =zTree1.getNodeByTId("list_1");

            var son = { id: node.id, name: node.name, value: "" };
            zTree1.addNodes(root, son);
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
        var zTree1;
        var zTree2;
        var zNodes1 =<%=listdata %>;
        var zNodes2 =<%=treedata %>;
        $(function () {
            var h=$(document).height();
            $("#list").height(h-80);
            $("#tree").height(h-80);
            $(window).resize(function(){
                var h=$(document).height();
                $("#list").height(h-80);
                $("#tree").height(h-80);
            });
            $.fn.zTree.init($("#list"), setting1, zNodes1);
            $.fn.zTree.init($("#tree"), setting2, zNodes2);

            zTree1 = $.fn.zTree.getZTreeObj("list");
            zTree2 = $.fn.zTree.getZTreeObj("tree");

            var root =zTree1.getNodeByTId("list_1");

            $("#btnDel").click(function(){
                var nodes = zTree1.getSelectedNodes();
                if(nodes.length == 0)
                {
                    alert("请选择左边要删除的快捷方式");
                }
                else
                {
                    if(!confirm("确认删除这个快捷方式吗"))
				        return false;
                    $.each(nodes , function(i,n){
                        var ret = _curClass.RemoveNode(n.id);
                        if(ret.error)
                        {
                            alert("删除时出错："+ret.error.Message);
                        }
                        else
                        {
                            zTree1.removeNode(n,true);
                        }
                    });
                     
                }
            });

            $("#btnExpand").toggle(function(){
                $.each(root.children,
                function(i,n){
                    zTree1.expandNode(n,true,true,false);
                });
            },function(){
                $.each(root.children,
                function(i,n){
                    zTree1.expandNode(n,false,true,false);
                });
            });
            $("#btnFresh").click(function(){
                window.location.reload();
            });
        });
        function addNode(retArr)//增加子节点
        {
            var nodes = zTree.getSelectedNodes();
            if (nodes.length == 0) {
                alert("请选择父节点");
            }
            else {
                var son = { id: retArr[0], name: retArr[1], value: retArr[2] };
                zTree1.addNodes(nodes[0], son);
            }
        }

        function removeNode(nodeId) {
            var searchNodes = zTree.getNodesByParamFuzzy("id", objid);
            if (searchNodes.length > 0) {
                searchNodes[0].name = objname;
                zTree.removeNode(searchNodes[0], true);
            }
        }
        function upFolder() {
            if (treeObj.getCurItem().parent) {
                var p = treeObj.getCurItem().parent;
                treeObj.expandNode(p.id);
            }
        }
        function openFolder(folderId) {
            var searchNodes = zTree.getNodesByParamFuzzy("id", folderId);
            if (searchNodes.length > 0) {
                zTree.selectNode(searchNodes[0]);
                expandToRoot(searchNodes[0]);
            }
        }
    </script>
