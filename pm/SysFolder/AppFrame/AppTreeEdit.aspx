<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppInput.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppInput" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>[<%=TblNameCn%>] 编辑记录</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/kindeditor-4.1.10/themes/default/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/kindeditor-min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script type="text/javascript" src="../../js/jquery.tablednd.0.8.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script type="text/javascript" src="../../js/jquery.masked.js"></script>
    <script type="text/javascript" src="../../js/jquery.smartMenu.js"></script>
    <script src="../../Js/DateExt.js" type="text/javascript"></script>
    <%=customScript%>
    <style type="text/css">
        #bottomToolbar{
	        width:100%; height:40px; line-height:40px;
	        border-top:1px solid #ddd;
	        border-bottom:1px solid #ddd;
	        background-color:#f8f8ff;
	        margin-top:20px;
        }
        #bottomToolbar a{ color:blue;}
        #maindiv{padding-bottom:50px;padding-top:20px;<%=formWidth%>}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 工具栏 -->
    <div class="menubar hidden">
        <div class="topnav">
            <span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
                <asp:LinkButton ID="btnStartWF" runat="server" onclick="btnStartWF_Click">发起流程</asp:LinkButton>
            </span>
        </div>
    </div>
    
    </form>
    
    <div id="maindiv">
        <% =tblHTML%>
        <div id="bottomToolbar">
            <button type="button" id="btnSave"  class="btn01" >&nbsp;&nbsp;保 存&nbsp;&nbsp;</button>&nbsp;
            <button type="button" id="btnAddAfter"  class="btn01" >&nbsp;保存后继续&nbsp;</button>&nbsp;
            <button type="button" id="btnSub"  class="btn01" >&nbsp;添加子级&nbsp;</button>&nbsp;
            <button type="button" id="btnDel" class="btn01" >&nbsp;&nbsp;删 除&nbsp;&nbsp;</button>
        </div>
    </div>

</body>
</html>
    <script type="text/javascript">
        //wbsFld|nameFld|pwbsFld
        var fldArr = '<%=Request["treeFld"]%>'.split("|");
        $("dl").KandyTabs({ trigger: "click" });
        jQuery(function(){
            $(".btn01").hover(function(){
                this.className = "btn02";
            },function(){
                this.className = "btn01";
            });
            if(_isNew)
            {
                $("#btnSub,#btnDel").hide();
            }
            $("#btnSave").click(_appSave);
            $("#btnAddAfter").click(_appSaveAdd);
            $("#btnDel").click(function() {
                var nodeId = _sys.getValue(fldArr[0]);
                var nodeName = _sys.getValue(fldArr[1]);
                if(!confirm("您确认删除 ["+nodeName+"] 吗？"))
                    return true;
                var ret = window.parent.frames["left"].removeNode(nodeId,true);
                if(ret){
                    window.location = "../../welcome.htm";
                }
            });
            $("#btnSub").click(function(){
                var pwbs = _sys.getValue(fldArr[0]);
                window.location = 'AppTreeEdit.aspx?tblName=<%=tblName %>&treeFld=<%=Request["treeFld"]%>&cpro=<%=GetParaValue("cpro")%>|'
                 + fldArr[2] + "=" + pwbs + '^1';
            });
		});


        //保存数据
        function _appSave()
        {   
            //平台保存函数
            var safe = false;
            try {safe = _sysSave();} catch (err) {alert("提交过程中出现异常：" + err.message+"\r\n请尝试重新提交，或者联系管理员。");}

            if(safe)
            { 
                $.noticeAdd({ text: '保存成功！',stayTime:500,onClose:function(){
                    if(_isNew)
                    window.location = 'AppTreeEdit.aspx?tblName=<%=tblName %>&treeFld=<%=Request["treeFld"]%>&mainId='
                     + _mainId + '&cpro=<%=GetParaValue("cpro")%>';
                    
                }});
            }
        }

        //刷新关联主表列表
        function app_query(tName){
            var listHtml = _curClass.GetListHtml("<%=tblName %>",tName,_mainId,_sIndex).value;
            $("#"+tName).before(listHtml).remove();
        }

        //查询填报说明
        function _appDirection() {
            var dlg = new $.dialog({ title: '[<%=TblNameCn%>] 填报说明', page: 'AppDirection.aspx?tblName=<%=tblName %>'
                , btnBar: true, cover: true, lockScroll: true, width: 800, height: 600, bgcolor: 'gray', cancelBtnTxt: '关闭',
                onCancel: function () {
                }
            });
            dlg.ShowDialog();
        }

        //保存数据，新增
        function _appSaveAdd()
        {   
            //平台保存函数
            if(_sysSave())
            {
			    var pwbs = _sys.getValue(fldArr[2]);
                window.location = 'AppTreeEdit.aspx?tblName=<%=tblName %>&treeFld=<%=Request["treeFld"]%>&cpro=<%=GetParaValue("cpro")%>|' 
                + fldArr[2] + "=" + pwbs + '^1';
            }
        }
        //返回列表
        function _appBack(){
            window.history.back();
        }
        //关闭窗口
        function _appClose(){
            if(!!frameElement){
                if(!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else
                    window.close();
            }
            else{
                window.close();
            }
        }
		function _sysAfterAdd(){
			var nodeArr=[];
			nodeArr.push(_sys.getValue(fldArr[0]));
			nodeArr.push(_sys.getValue(fldArr[1]));
			nodeArr.push(_sys.getValue(fldArr[2]));
			window.parent.frames["left"].addNode(nodeArr);
			return true;
		}
		function _sysAfterEdit(){
			var nodeArr=[];
			nodeArr.push(_sys.getValue(fldArr[0]));
			nodeArr.push(_sys.getValue(fldArr[1]));
			window.parent.frames["left"].changeNode(nodeArr);
			return true;
		}
        var _curClass =EZ.WebBase.SysFolder.AppFrame.AppInput;
        var _isNew = <%=isNew %>;
        var _mainTblName = "<%=tblName %>";
        var _mainId = "<%=mainId %>";
        var _sIndex = "<%=sIndex %>";
        var _saveAction = "1";
        var _workflowCode ="";
        var _nodeCode ="";
        <%=this.sbmodel.ToString() %>;
        var _xmlData =jQuery(jQuery.parseXML('<xml><%= xmlData %></xml>'));
    </script>
    <script src="../../Js/SysFunction.js?v=<%=SysFuncEtag %>" type="text/javascript"></script>
    <script type="text/javascript">
        <%=editScriptBlock %>    
    </script>