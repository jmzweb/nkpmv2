<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppInput.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppInput" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>[<%=TblNameCn%>] 编辑记录</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge" />-->
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput2.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/kindeditor-4.1.11/themes/default/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.11/kindeditor-min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.11/lang/zh-CN.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script type="text/javascript" src="../../js/jquery.tablednd.0.8.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.masked.js"></script>
    <script type="text/javascript" src="../../js/jquery.smartMenu.js"></script>
    <script type="text/javascript" src="../../js/jquery.qtip.min.js"></script>
    <script type="text/javascript" src="../../Js/DateExt.js"></script>
    <link rel="stylesheet" href="../../Theme/AdminLTE/bootstrap/css/bootstrap.min.css">
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
        #maindiv{padding-bottom:50px;<%=formWidth%>}
        .hide{display:none;}
        .posrel{position:relative;}
        .mspan{position:absolute;right:9px;top:17px;}
        .RequiredTbl .mspan{top:9px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 工具栏 -->
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <asp:LinkButton ID="btnStartWF" runat="server" OnClick="btnStartWF_Click" CssClass="hide">发起流程</asp:LinkButton>
                    <a class='linkbtn' href="javascript:" onclick="_appSaveAdd();" id="btnSaveAdd" name="btnSaveAdd">保存后新增</a>
                    <em class="split">|</em>
                    <%--                    <em class="split" style="<%=startWF %>">|</em>
                    <em class="split">|</em>
                    <a class='linkbtn' style="" href="javascript:" onclick="_appDirection();" id="btnDirection" name="btnDirection">填报说明</a>--%>
                    <%--                    <em class="split">|</em>
                    <a class='linkbtn' style="" href="../../LoginAuth.aspx" id="btnAuth" target="_blank">请求协助</a>--%>
                    <a class='linkbtn' href="javascript:" onclick="_appSave();" id="btnSave" name="btnSave">保存</a>
                    
                    <em class="split appsaveto hide">|</em>
                    <a class='linkbtn appsaveto hide' href="javascript:" onclick="_appSaveTo();" id="btnSavea" name="btnClose">保存并转到已投库</a>

                    <%if (Request["hideclose"] == null)
                      {%>
                    <em class="split">|</em>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                    <%} %>
                </span>
            </div>
        </div>

    </form>
    <%if (Request["biz"]!=null)
      { %>
    <style type="text/css">
        .sidebarbox {overflow: hidden;position:fixed;top:0; width:100%;height:40px;padding-bottom:5px;z-index:100;}
        .sidebar { background-color: #4f5f6f;color:#fff; overflow: hidden;margin:0;}
        .sidebar li { float: left; line-height: 40px; padding: 0 20px; cursor: pointer;list-style:none;font-size:16px; }
        .sidebar li:hover,
        .sidebar .select { background-color: #32bce1; }

        .topnav { top:40px;}
        .closebtn { position: absolute; right: 15px;color:#333; top: 0px;z-index:101; line-height: 40px; color:#fff; }
        .closebtn:hover { color:#32bce1;}

    </style>
    <script type="text/javascript">
        $(function(){
            $(".sidebar li").click(function(){
                alert("请先保存基本信息");
            });
            $(".sidebar li").first().addClass("select");
        });
    </script>
    <a class='closebtn' href="javascript:" onclick="_appClose();">关闭</a>
    <div style="height:40px;"></div>
    <div class="sidebarbox">
    <ul class="sidebar">
        <%
            string funCode = GetParaValue("funCode");
            string funWbs = EZ.Permission.Service.FunNodeService.GetFunAttrById(funCode, "FunWbs");
           var  dt = EZ.Permission.Utility.GetSonLimitDataByEmployeeId(EmployeeID, funWbs, EZ.Data.Config.AppSettings.Instance.WebId);

           foreach (EZ.Entities.Permission.FunNode r in dt)
            {
        %>
        <li><%=r.FunName %></li>
        <%
        }   
        %>
    </ul>
        </div>
    <%} %>
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
	<script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
<script type="text/javascript">
    function CloseLayer() {
        setTimeout(function () { layer.close(LayerTemp) }, 300);
    };
    function OpenLayer(url) {
        var width = $(window).width() - 40;
        var height = $(window).height() - 40;
        LayerTemp = layer.open({
            title: false,
            closeBtn: true,
            resize: true,
            isOutAnim: true,
            offset: ['20px', '20px'],
            type: 2,
            area: [width + 'px', height + 'px'],
            fixed: false, //不固定
            maxmin: false,
            content: url
        });
    };
    var LayerTemp = 0;
    $(function () {
        $(document).on("click", "a[openlayer]", function () {
            var $t = $(this);
            var url = $t.attr("openlayer");
            OpenLayer(url);
        });
    });

    $("dl").KandyTabs({ trigger: "click" });
    jQuery(function(){
        $("input[data-type='float'][precision='4']").after("<span class='mspan'>元</span>").parent().addClass("posrel");
        $('.normaltbl').attr('border','0');
        $("div.kandyTabs span.tabbtn").click(function () {
            var pt = $(this).parent();
            $(".tabcur", pt).removeClass("tabcur");
            $(this).addClass("tabcur");
            var i = $(this).index();
            var blist = pt.next().children();
            blist.hide();
            blist.eq(i).show();
        });

        $(".btn01").hover(function(){
            this.className="btn02";
        },function(){
            this.className="btn01";
        });
        if(!_isNew)
        {
            jQuery("#btnSaveAdd").prev().andSelf().hide();
            jQuery("#btnSaveAdd").next().hide();
        }
        /*
        $(window).resize(function(){
           $("#maindiv").height($(document.body).height()-75);
        });
        
        $("#maindiv").height($(document.body).height()-75);
        */
        $("#btnStartWF").click(_appStartWF);

    }); 
    function _appSaveTo(op){
        $(".T_PM_P_ProjectInfo_ProjectStage").val("已投");
        _appSave(op);
    };
    //保存数据
    function _appSave(op)
    {   
        op = op || {'close':true};
        //平台保存函数
        var safe = false;
        try {safe = _sysSave(op);} catch (err) {alert("提交过程中出现异常：" + err.message + "\r\n请尝试重新提交，或者联系管理员。");}

        if(safe)
        { 
            $.noticeAdd({ text: '保存成功！',stayTime:500,onClose:function(){
                    
                if(!op.close || !_sys.saveClose)
                    return;
                if('<%=Request["biz"]??""%>'=='1')
                {//20170921 by zjs biz表示添加成功后 是否要跳到转多页签页面
                    var funCode='<%=Request["funCode"]??""%>';
                    var maincol='<%=Request["maincol"]??""%>';
                    window.location.href="../Extension/BizFrame.aspx?funCode="+funCode+"&"+maincol+"=" + _mainId;
                    return ;
                }
                if('<%=Request["addbiz"]??""%>'=='1')
                {//20170921 by zjs biz表示添加成功后 是否要跳到转多页签页面
                    var funCode='<%=Request["funCode"]??""%>';
                    var maincol='<%=Request["maincol"]??""%>';
                    parent.location.href="../Extension/BizFrame.aspx?funCode="+funCode+"&"+maincol+"=" + _mainId;
                    return ;
                }
                if('<%=Request["hideclose"]??""%>'=='1')
                {//20171013 多页签编辑时 保存后不需要关闭
                    return ;
                }
                if(!!frameElement){
                    if(!!frameElement.lhgDG){
                        frameElement.lhgDG.curWin.app_query("<%=tblName %>");
                        frameElement.lhgDG.cancel();
                    }
                    else{
                        try { window.opener.app_query("<%=tblName %>"); } catch (e) {}	   
                        if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                            window.parent.CloseLayer();
                        }else if(window.parent.parent.CloseLayer){
                            window.parent.parent.CloseLayer();
                        }
						
                    }
                }
                else{
                    try { window.opener.app_query("<%=tblName %>"); } catch (e) {}  
                    if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                        window.parent.CloseLayer();
                    }else if(window.parent.parent.CloseLayer){
                        window.parent.parent.CloseLayer();
                    } 
                }

            }});

        }

        return safe;
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
                else{ 
                    if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                        window.parent.CloseLayer();
                    }else if(window.parent.parent.CloseLayer){
                        window.parent.parent.CloseLayer();
                    }
                } 
                window.close();
            }
            else{
                if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                    window.parent.CloseLayer();
                }else if(window.parent.parent.CloseLayer){
                    window.parent.parent.CloseLayer();
                }
                // window.close();
            }
        }
        var _curClass =EZ.WebBase.SysFolder.AppFrame.AppInput;
        var _isNew = <%=isNew %>;
        var _mainTblName = "<%=tblName %>";
    var _mainId = "<%=mainId %>";
    var _sIndex = "<%=sIndex %>";
    var _saveAction = "1";
    var _workflowCode ="";
    var _nodeCode ="";
    var _nodeId ="";
    var _appRoot = '<%=ResolveUrl("~") %>';
    var _sysModel = <%=sbmodel.ToString() %>;
    var _xmlData =jQuery(jQuery.parseXML('<xml><%= xmlData %></xml>'));
</script>
<script src="../../Js/SysFunction.js?v=<%=SysFuncEtag %>" type="text/javascript"></script>
<script type="text/javascript">
    <%=editScriptBlock %>    
</script>
