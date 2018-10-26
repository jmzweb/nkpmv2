<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppTreeLeft.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppTreeLeft" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>组织部门</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
	<link rel="stylesheet" href="../../css/appStyle.css?v=1" type="text/css"/>
	<link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.ztree.all-3.4.min.js"></script>

     <style type="text/css">
        body{overflow:hidden;height:100%;}
     	#tree
	    {
	        border:#c3daf9 1px solid;
	        background:#f9fafe;
	        overflow:auto;
	        padding:5px;
	        margin:5px;
	    }
     </style>    
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
         <div class="toolbar" style="">
            <button id="btnExpand" type="button"><img alt="全部展开" src="../../img/common/ico6.gif" />全部展开</button>
            <button id="btnSwitch" title="点击切换编辑模式" type="button"><img src="../../img/common/mode_list.png" /><span>列表模式</span></button>
            <input type="text" style="width:60px;" class="search" id="txtSearch" />
            <button id="btnSearch" type="button"><img alt="查找" src="../../img/common/search.png" />查找</button>
        </div>
        <div id="optionPanel" style="display:none;padding-left:10px;">
            <input class="defaultbtn" id="chkshow" checked="checked"  type="checkbox" />
        </div>
        <ul id="tree"  class="ztree"> 
        </ul>
   
		</form>
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
        function nodeClick(e,treeId,node)
        {
            var toUrl = "";
            var url = node.value;
            if("<%=editMode %>"=="0"){
                toUrl = url + '&funId=<%=Request["funId"] %>';                
            }
            else{
                if(node.getParentNode() == null){
                    if(editMode == 2)
                        toUrl = "AppTreeEdit.aspx?tblName=<%=treeTbl %>&treeFld=<%=wbsFld %>|<%=nameFld %>|<%=pwbsFld %>&cpro=<%=pwbsFld %>=<%=rootId %>^1|<%=cpro %>";
                    else 
                        toUrl = url + '&funId=<%=Request["funId"] %>';
                
                }
                else{
                    if(editMode == 2)
                        toUrl = "AppTreeEdit.aspx?tblName=<%=treeTbl %>&treeFld=<%=wbsFld %>|<%=nameFld %>|<%=pwbsFld %>&cpro=<%=pwbsFld %>=<%=rootId %>^1|<%=cpro %>&condition=<%=wbsFld %>=[QUOTES]" + node.id + "[QUOTES]";
                    else
                        toUrl = url + '&funId=<%=Request["funId"] %>';
                }
            }
            window.parent.frames["main"].location = encodeURI(toUrl);
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
            }
        }
        var zTree;
        var editMode = '<%=editMode %>';
        var imgs=["../../img/common/mode_list.png","../../img/common/mode_preview.png"];
        var zNodes =<%=treedata %>;
        $(function () {
            if("<%=treeTbl %>"=="" || editMode=="0")
            {
                //$("#btnSwitch").prop("disabled",true).css("color","gray");
                $("#btnSwitch").hide();
            }

            if(editMode == 2){
                $("span","#btnSwitch").text("表单模式");
                $("img","#btnSwitch").attr("src",imgs[1]);
            }
            else{
                $("span","#btnSwitch").text("列表样式");
                $("img","#btnSwitch").attr("src",imgs[0]);
            }

            $("#tree").height($(document).height()-60);

            $(window).resize(function(){
                $("#tree").height($(document).height()-60);
            });
            $.fn.zTree.init($("#tree"), setting, zNodes);
            zTree = $.fn.zTree.getZTreeObj("tree");
            var root =zTree.getNodeByTId("tree_1");
            $("#btnOption").click(function(){
                $("#optionPanel").toggle();
            });
            $("#txtSearch").keydown(function(){
                if(event.keyCode == 13)
                {
                    searchNode();
                    return false;
                }
            });
            $("#btnSearch").click(function(){
                searchNode();
            });
            $("#btnSwitch").click(function(){
                if($("span",this).text()=="表单模式"){
                    $("span",this).text("列表样式");
                    $("img",this).attr("src",imgs[0]);
                    editMode = 1;
                }
                else{
                    $("span",this).text("表单模式");
                    $("img",this).attr("src",imgs[1]);
                    editMode = 2;                
                }
                var nodes = zTree.getSelectedNodes();
                if(nodes.length>0){
                    nodeClick(null,"",nodes[0]);
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
        });

        //增加子节点
        function addNode(retArr)
        {
            var objId = retArr[0];
            var objName = retArr[1];
            var objPId = retArr[2];
            var searchNode = zTree.getNodeByParam("id", objPId);

            if (searchNode == null) {
                alert("请选择父节点");
            }
            else {
				var nodeValue = 'AppTreeList.aspx?TblName=<%=treeTbl%>&cpro=<%=pwbsFld%>='+retArr[0]
				+'^1&condition=<%=pwbsFld%>=[QUOTES]'+retArr[0]+'[QUOTES]&treeFld=<%=wbsFld%>|<%=nameFld%>|<%=pwbsFld%>&ext=800|500';
                var son = { id: retArr[0], name: retArr[1], value: nodeValue };
                zTree.addNodes(searchNode, son);
            }
        }

        //修改名称
        function changeNode(retArr)
        {
            var objId = retArr[0];
            var objName = retArr[1];
            var searchNode = zTree.getNodeByParam("id", objId);
            if (!!searchNode) {
                searchNode.name = objName;
                zTree.updateNode(searchNode);
            }
        }

        //删除节点
        function removeNode(nodeId,delRemote) {

            if (arguments.length == 2 && !!delRemote){
                var ret = EZ.WebBase.SysFolder.AppFrame.AppTreeLeft.RemoveNode("<%=treeTbl%>","<%=wbsFld%>='"+nodeId+"'");
                if(ret.error)
		        {
			        alert("删除时出错："+ret.error.Message); 
                    return false;
		        }
            }
            var searchNode = zTree.getNodeByParam("id", nodeId);
            if (!!searchNode) {
                zTree.removeNode(searchNode, true);
            }

            return true;
        }

    </script>
