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
	        background:white url(../../img/common/topbar.gif); 
	        border-top:2px solid #708090;
	        position:fixed; bottom:0; left:0;
	        _position:absolute; 
        }
        #bottomToolbar a{ color:blue;}
        #maindiv{padding-bottom:50px;padding-top:20px;<%=formWidth%>}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav">
            <span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
                <a class='linkbtn' href="javascript:" onclick="_appSaveAdd();" id="btnSaveAdd" name="btnSaveAdd">保存后新增</a>
				<em class="split">|</em>
                <a class='linkbtn' href="javascript:" onclick="_appSave();"  id="btnSave" name="btnSave">保存</a>
                <em class="split" style="<%=startWF %>">|</em>
                <asp:LinkButton ID="btnStartWF" runat="server" onclick="btnStartWF_Click">发起流程</asp:LinkButton>
				<em class="split">|</em>
                <a class='linkbtn' style="" href="javascript:" onclick="_appDirection();"  id="btnDirection" name="btnDirection">填报说明</a>
				<em class="split">|</em>
                <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
            </span>
        </div>
    </div>
    
    </form>
    
    <div id="maindiv">
    <% =tblHTML%>
    </div>
    <!-- 底部工具栏
    <div id="bottomToolbar">
        <button type="button" id="btnSubmit" class="btn01" onclick="_appSubmit();">&nbsp;提 交&nbsp;</button>&nbsp;
        <button type="button" id="btnSave"  class="btn01" onclick="_appSave();">&nbsp;保 存&nbsp;</button>&nbsp;
        <button type="button" id="btnClose" class="btn01" onclick="javascript:window.close();">&nbsp;关 闭&nbsp;</button>
    </div>
    -->
</body>
</html>
    <script type="text/javascript">
        $("dl").KandyTabs({ trigger: "click" });
        jQuery(function(){
            $(".btn01").hover(function(){
                this.className="btn02";
            },function(){
                this.className="btn01";
            });
            if(!_isNew)
            {
                jQuery("#btnSaveAdd").prev().andSelf().hide();
            }
            /*
            $(window).resize(function(){
                $("#maindiv").height($(document.body).height()-75);
            });
            $("#maindiv").height($(document.body).height()-75);
            */
            $("#btnStartWF").click(_appStartWF);
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

                    if(!!frameElement){
                        if(!!frameElement.lhgDG){
                            frameElement.lhgDG.curWin.app_query("<%=tblName %>");
                            frameElement.lhgDG.cancel();
                        }
                        else{
                	        try { window.opener.app_query("<%=tblName %>"); } catch (e) {}
	                        window.close();
                        }
                    }
                    else{
                	    try { window.opener.app_query("<%=tblName %>"); } catch (e) {}
	                    window.close();
                    }

                }});

            }
        }

        //刷新关联主表列表
        function app_query(tName){
            var listHtml = _curClass.GetListHtml("<%=tblName %>",tName,_mainId,_sIndex).value;
            $("#"+tName).before(listHtml).remove();
        }

        //保存数据,发起流程
        function _appSubmit()
        {
            if(!confirm("您确认提交审批吗?")){
                return false;
            }

            var safe = false;
            try { safe = _sysSave(); } catch (err) {alert("提交过程中出现异常：" + err.message+"\r\n请尝试重新提交，或者联系管理员。");}

            if(safe)
            { 
                var url = "";
                
                if('<%=base.GetParaValue("workflowStart") %>'=='2'){
                    __doPostBack('btnStartWF','');
                }
                else{
                    if("<%=workflowCode %>" == ""){
                        url = "../Workflow/SelectWorkFlow.aspx?tblName=<%=tblName %>&mainId=<%=mainId %>";
                        window.location.href=url;
                    }
                    else{
                        url = "../workflow/NewFlow.aspx?workflowCode=<%=workflowCode %>&mainId=<%=mainId %>";
                        window.location.href=url;
                    }
                }


            }
        }

        //保存数据,发起流程
        function _appStartWF()
        {
            if(!confirm("您确认提交审批吗?")){
                return false;
            }   
            //平台保存函数
            if(_sysSave())
            { 
                var url = "";
                if("<%=workflowCode %>" == ""){
                    if('<%=base.GetParaValue("workflowStart") %>'=='2'){
                        return true;
                    }
                    else{
                        url = "../Workflow/SelectWorkFlow.aspx?tblName=<%=tblName %>&mainId=<%=mainId %>";
                        window.location.href=url;
                        return false;
                    }
                }
                else{
                    url = "../workflow/NewFlow.aspx?workflowCode=<%=workflowCode %>&mainId=<%=mainId %>";
                    window.location.href=url;
                }

            }
            else{
                return false;
            }
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
                try { window.opener.app_query();} catch (e) {}
                window.location.href = window.location.href;
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
		var fldArr = '<%=Request["treeFld"]%>'.split("|");
		function _sysAfterAdd(){
			var nodeArr=[];
			nodeArr.push(_sys.getValue(fldArr[0]));
			nodeArr.push(_sys.getValue(fldArr[1]));
			nodeArr.push(_sys.getValue(fldArr[2]));
			window.opener.parent.frames["left"].addNode(nodeArr);
			return true;
		}
		function _sysAfterEdit(){
			var nodeArr=[];
			nodeArr.push(_sys.getValue(fldArr[0]));
			nodeArr.push(_sys.getValue(fldArr[1]));
			window.opener.parent.frames["left"].changeNode(nodeArr);
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