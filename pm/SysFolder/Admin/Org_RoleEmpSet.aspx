<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_RoleEmpSet.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_RoleEmpSet" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>组织权限设置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
	<link rel="stylesheet" href="../../css/appStyle.css?v=1" type="text/css"/>
	<link rel="stylesheet" href="../../css/zTreeStyle/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
	<script type="text/javascript" src="../../js/jquery.ztree.all-3.4.min.js"></script>

     <style type="text/css">
        body{overflow:hidden;}
        .center{margin-left:auto;margin-right:auto;}
        fieldset{margin:5px;
	       border:#c3daf9 1px solid;    
        }
        #txtEmpCn{padding:2px 3px;}
     	#tree
	    {
	        background:#f9fafe;
	        overflow:auto;
	    }
     </style>    
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
         <div class="toolbar" style="">
            <table width="100%">
                <tr>
                    <td>&nbsp;角色名称：<span style="color:Blue;"><%=RoleName %></span></td>
                    <td align="right">
                        <button id="btnFresh" type="button"><img alt="刷新" src="../../img/common/fresh.png" />刷新</button>&nbsp;
                        <button id="btnSave" type="button"><img alt="保存" src="../../img/common/ico5.gif" />保存设置</button>
                        <button id="btnClose" type="button" onclick="winClose();"><img alt="关闭" src="../../img/common/inbox_failure.png" />关闭</button>
                    </td>
                </tr>
            </table>

        </div>
        <table class="center" width="96%">
            <tbody>
                <tr>
                    <td style="width:70px;padding-left:20px;padding-top:5px;">人员信息：</td>
                    <td align="left">
                        <asp:TextBox ID="txtEmpCn" runat="server" Width="200"></asp:TextBox>
                        <asp:HiddenField ID="txtEmpId" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                         <fieldset> 
                            <legend>&nbsp;组织权限：</legend>
                            <ul id="tree" class="ztree"></ul>
                        </fieldset>
                    </td>
                </tr>
            </tbody>
        </table>

        
        <script type="text/javascript">
        function winClose() {
            if(!!frameElement){
                if(!!frameElement.lhgDG){
                    frameElement.lhgDG.curWin.app_query();
                    frameElement.lhgDG.cancel();
                }
                else{
                	try { window.opener.app_query(); } catch (e) {}
	                window.close();
                }
            }
            else{
                try { window.opener.app_query(); } catch (e) {}
	            window.close();
            }
        }
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
            check:{
                enable: true,
                autoCheckTrigger: false,
                chkboxType: { "Y": "", "N": "" }
                    },
            callback:{
                onClick:nodeClick
                }
        };
        function nodeClick(e,treeId,node)
        {
            var d=new Date();
            node.checked = !!!node.checked;
	        zTree.updateNode(node,false);
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
        var searchKey = "";
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
            $("#tree").height(h-150);
            $(window).resize(function(){
                var h=$(document).height();
                $("#tree").height(h-150);
            });
            $.fn.zTree.init($("#tree"), setting, zNodes);
            zTree = $.fn.zTree.getZTreeObj("tree");
            var root =zTree.getNodeByTId("tree_1");
            $("#txtSearch").keydown(function(){
                if(event.keyCode == 13)
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
            
            $("#txtEmpCn").attr("readOnly", true);
            if("<%=MainId %>" == ""){
                $("#txtEmpCn").dblclick(function () {
                    openCenter('../../SysFolder/Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=txtEmpId,txtEmpCn','_blank',700,500);
                }).emptyValue("<请双击选择人员>");            
            }
            else {
                $("#txtEmpCn").prop("disabled",true)
            }


            $("#btnSave").click(function(){
                var empId = $("#txtEmpId").val();
                if(empId == "")
                {
                    alert("请选择人员信息");
                    return;
                }

                var nodes = zTree.getCheckedNodes(true);
                var arrCode=[];
                for (var i = 0; i < nodes.length; i++) {
                    var chkobj = nodes[i].getCheckStatus();
                    if(chkobj.checked){
                        arrCode.push(nodes[i].id);
                    }
                }
                
                var ret = EIS.WebBase.SysFolder.Org.Org_RoleEmpSet.SaveLimit("<%=RoleId %>",empId,arrCode);
                if(ret.error){
                    $.noticeAdd({ type:'error', text: '保存时出错！', stay: false });
                }
                else{
                    $.noticeAdd({ text: '保存成功！', stay: false });
                    winClose();
                }

            });
        });

        function openCenter(url,name,width,height)
        {
	        var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
	        if (window.screen)
	        {
		        var ah = screen.availHeight - 30;
		        var aw = screen.availWidth - 10;
		        var xc = (aw - width) / 2;
		        var yc = (ah - height) / 2;
                if (yc < 0)
		            yc = 0;
		        str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
		        str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
	        }
	        return window.open(url, name, str);
        }
        </script>
		</form>
	</body>
</html>

