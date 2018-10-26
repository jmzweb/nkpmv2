<%@ Page language="c#" Codebehind="AppSelTree.aspx.cs" AutoEventWireup="false" Inherits="EZ.WebBase.SysFolder.AppFrame.AppSelTree" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择</title>
    <link href="../../css/appstyle.css" rel="stylesheet" type="text/css" />    
	<link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.ztree.all-3.4.min.js"></script>

     <style type="text/css">
         html{overflow:auto;}
         body{overflow:hidden;height:100%;}
     	#tree,#dTree
	    {
	        border:#c3daf9 1px solid;
	        padding:5px;
	        margin:5px;
	        overflow:auto;
	        background-color: rgb(249, 250, 254);
	    }
	    #dTree{display:none;}
	    .radioSpan{
	        text-align:right;
	        padding-right: 5px; 
	        padding-left: 10px; 
	        background: transparent url(../../img/common/site.png) no-repeat 10px center;
	        }
	    #topbar span{color:#3a6ea5;font-weight:bold;float:left;line-height:30px;padding-left:30px;} 
	    label{font-size:10pt;cursor:pointer;}
	    input[type=radio]{
	        vertical-align:middle;
	        }
	    .centerZone
		{
			border:#c3daf9 1px solid;
	        padding:2px;
	        margin-top:5px;
			overflow:hidden;
			background:white;
		}
     </style>    
	</head>
	<body >
		<form id="Form1" method="post" runat="server">
		</form>
         <div class="toolbar" id="topbar">
            &nbsp;&nbsp;
            <i style="line-height:30px;font-style:normal;">
				<button id="btnExpand" type="button" title="全部展开"><img alt="全部展开" src="../../img/common/ico6.gif" />全部展开</button>
	            <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>
                <input type="text" style="width:80px;" class="search" id="txtSearch" />
                <button id="btnSearch" type="button"><img alt="查找部门" src="../../img/common/search.png" />查找</button>&nbsp;
                <button id="btnConfirm" type="button"><img alt="确定" src="../../img/common/accept.png" />确定</button>&nbsp;
                <button id="btnClose" type="button" onclick="window.close();"><img alt="关闭" src="../../img/common/inbox_failure.png" />关闭</button>
            </i>

		</div>
        <div class="centerZone">
            <div id="tree" class="ztree"></div>
            </ul>
        </div>
   
    <script type="text/javascript">
         var chkCan = "<%=multi %>"!="1";
         var setting = { 
            check: {enable: chkCan},
            edit: {
                   drag:false,
				   enable: false
			    },
            callback:{
                onClick:zNodeClick
                },
            view:{showLine:false}
        };


        function zNodeClick(e,treeId,node,flag){
            zTree.checkNode(node,null,false);
            if(!chkCan) singleRet(node);
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

        var zTree ;
        jQuery(function () {
            $(window).resize(function () {
                $(".centerZone").height($(document.body).height() - 50);
                $("#tree").height($(document.body).height() - 80);
            });
            $(".centerZone").height($(document.body).height() - 50);
            $("#tree").height($(document.body).height() - 80);


            var zNodes =<%=treeData %>;
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

            $("#txtSearch").keydown(function(e){
                if(e.keyCode == 13){
                    searchNode();
                    $("#txtSearch").focus();
                    return false;
                }
            });

            //确定事件
            $("#btnConfirm").click(function(e){               
              var names=[];
              var fnames=[];
              var ids=[];
              var wbss=[]; 
              var codes=[]; 
              var nodes=null;
              nodes = zTree.getCheckedNodes(true);

                for(var i=0;i<nodes.length;i++)
                {
                    if(nodes[i].value == "")
                        continue;

                    if(index_id>-1)
                        ids.push(nodes[i].id);
                    if(index_name>-1)
                        names.push(nodes[i].name);
                    if(index_code>-1)
                        codes.push(nodes[i].value);
                }

               if(index_id>-1){
                    var pctl = getpc(bizfields[index_id]);
                    if(pctl){
                        pctl.value=ids;
                        try { window.opener.$(pctl).change();} catch (e) {}
                    }
               }
               if(index_name>-1){
                    var pctl = getpc(bizfields[index_name]);
                    if(pctl){
                        pctl.value= names;
                        try { window.opener.$(pctl).change();} catch (e) {}
                    }
               }
               if(index_code>-1){
                    var pctl = getpc(bizfields[index_code]);
                    if(pctl){
                        pctl.value= codes;
                        try { window.opener.$(pctl).change();} catch (e) {}
                    }
               }

      
               window.close();
            });
        });
        var cid="<%=cid %>";
        var bizfields=cid.split(",");
        var qryfields="<%=queryfield %>".split(",");
              
        var index_id = jQuery.inArray("nodeid",qryfields);
		var index_code = jQuery.inArray("nodecode",qryfields);
        var index_name = jQuery.inArray("nodename",qryfields);

    </script>
    <script type="text/javascript">

        function getpc( pcid ){
            return window.opener.document.getElementById(pcid);
        }
        function singleRet(node) { 
            var names=[];
            var fnames=[];
            var ids=[];
            var wbss=[]; 
            var codes=[]; 

            if(node.value=="")
                return ;
            if(node.children){ 
                zTree.expandNode(node,true,false,true);
                return ;
            }

            if(index_id>-1)
                ids.push(node.id);
            if(index_name>-1)
                names.push(node.name);
            if(index_code>-1)
                codes.push(node.value);


            if(index_id>-1){
                var pctl=getpc(bizfields[index_id]);
                if(pctl){
                    pctl.value=ids;
                    try { window.opener.$(pctl).change();} catch (e) {}
                }
            }
            if(index_name>-1){
                var pctl=getpc(bizfields[index_name]);
                if(pctl){
                    pctl.value= names;
                    try { window.opener.$(pctl).change();} catch (e) {}
                }
            }
            if(index_code>-1){
                var pctl=getpc(bizfields[index_code]);
                if(pctl){
                    pctl.value= codes;
                    try { window.opener.$(pctl).change();} catch (e) {}
                }
            }

      
            window.close();
        }
        
    </script>
	</body>
</html>