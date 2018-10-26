<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_DeptLeft.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_DeptLeft" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>组织部门</title>
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
            <button id="btnExpand" type="button" title="全部展开"><img alt="全部展开" src="../../img/common/ico6.gif" />展开</button>
            <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>
            <input type="text" style="width:80px;" class="search" id="txtSearch" />
            <button id="btnSearch" type="button"><img alt="查找" src="../../img/common/search.png" />查找</button>
        </div>
        <ul id="tree"  class="ztree"> 
        </ul>
       <script type="text/javascript">
        var _curClass = EIS.WebBase.SysFolder.Org.Org_DeptLeft;
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
                onClick:nodeClick,
                //beforeRemove : beforeNodeRemove,
                onRemove : afterNodeRemove
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
            if(node.value.length>0){
                var url="";
                if(node.value == "delete")
                    url = "Org_EmpList_Del.aspx?Condition="; 
                else
            	    url = "Org_EmpList.aspx?DeptId="+node.value+"&Condition=DeptWBS like '"+node.id+"%'"; 
                window.parent.frames["main"].location.href=url;

            }
        }
        function beforeNodeRemove(treeId,node)
        {
            if(!confirm("确认删除吗"))
                return false;
            if(node.children)
            {
                if(node.children.length>0)
                {
                alert("存在子节点，不能删除");
                return false;
                }
            }
        }
        function afterNodeRemove(e,treeId,node)
        {
            return;
            var afterNode = node.getPreNode();
            if(afterNode == null)
                afterNode = node.getParentNode();
            if(afterNode != null)
                zTree.selectNode(afterNode);
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

            var delNode={id:root.id, name:"已删除人员（<%=nDel %>）", value:"delete", icon:"../../img/common/crossred.png"};
            zTree.addNodes(root,delNode);

            $("#btnAdd").click(function(){
                var nodes = zTree.getSelectedNodes();
                if(nodes.length == 0)
                {
                    alert("请选择父节点");
                }
                else
                {
                    var nodeName="";
                    if(nodes[0].children)
                    {
                        nodeName="子节点"+nodes[0].children.length;
                    }
                    else
                    {
                        nodeName="子节点1";
                    }

                    var ret = _curClass.AddSonDept(nodeName,nodes[0].id);
                    if(ret.error)
                    {
                        alert("添加子节点时出错："+ret.error.Message);
                    }
                    else
                    {
                        var retArr=ret.value.split("|");
                        var son={id:retArr[1],name:nodeName,value:retArr[0]};
                        zTree.addNodes(nodes[0],son);

                        //编辑窗口自动切换到新节点
                    }
                }
            });
            $("#btnDel").click(function(){
                var nodes = zTree.getSelectedNodes();
                if(nodes.length == 0)
                {
                    alert("请选择要删除的节点");
                }
                else
                {
                    if(!confirm("确认删除吗？"))
                    return false;

                    $.each(nodes , function(i,n){
                        var ret = _curClass.RemoveDept(n.value);
                        if(ret.error)
                        {
                            alert("删除节点时出错："+ret.error.Message);
                        }
                        else
                        {
                            zTree.removeNode(n,true);
                        }
                    });
                     
                }
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
