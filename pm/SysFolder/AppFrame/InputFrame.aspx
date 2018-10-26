<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppInput.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.InputFrame" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=TblNameCn%></title>
    <meta http-equiv="Pragma" content="no-cache" />
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
	<script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
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
        .posrel{position:relative;}
        .mspan{position:absolute;right:5px;top:17px;}
        .xspan{position:absolute;right:25px;top:17px;color:red;}
        #bottomToolbar a{ color:blue;}
        #maindiv{padding-bottom:50px;padding-top:20px;<%=formWidth%>}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 工具栏 -->
        <div class="menubar">
            <div class="topnav">
                <span style="float: left;">
                    <%--<a class='linkbtn' href="javascript:" onclick="_appSaveAdd();" id="btnSaveAdd" name="btnSaveAdd">保存后新增</a>
                    <em class="split">|</em>--%>
                    <a class='linkbtn' href="javascript:" onclick="_appSave();" id="btnSave" name="btnSave">保存</a>
                    <em class="split">|</em>
                    <%--                <a class='linkbtn' style="" href="javascript:" onclick="_appDirection();"  id="btnDirection" name="btnDirection">填报说明</a>
                <em class="split">|</em>
                <a class='linkbtn' style="" href="../Logs/DataLogList.aspx?tblName=Q_Log_Data&condition=appName=[QUOTES]<%=tblName %>[QUOTES] and appId=[QUOTES]<%=mainId %>[QUOTES]"  target="_blank">日志</a>
				<em class="split">|</em>--%>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                </span>
            </div>
        </div>

    </form>

    <div id="maindiv">
        <% =tblHTML%>
    </div>
</body>
</html>
<script type="text/javascript">
    $("dl").KandyTabs({ trigger: "click" });
    jQuery(function(){
        $("input[data-type='float'][precision='4']").after("<span class='mspan'>元</span>").parent().addClass("posrel");
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
        }

    });

    function SaveBefore(){
        return true;
    };

    //保存数据
    function _appSave(op)
    {   
        if(!SaveBefore()){
            return false;
        }
        op = op || {'close':true};
        //平台保存函数
        var safe = false;
        try {safe = _sysSave(op);} catch (err) {alert("提交过程中出现异常：" + err.message + "\r\n请尝试重新提交，或者联系管理员。");}

        if(safe)
        { 
            $.noticeAdd({ text: '保存成功！',stayTime:500, onClose:function(){
                    
                if(!op.close || !_sys.saveClose)
                    return; 
                    
                if(!!frameElement){
                    if(!!frameElement.lhgDG){
                        //    frameElement.lhgDG.curWin.app_query("<%=tblName %>");
                        frameElement.lhgDG.cancel();
                    }
                    else{
                        //try { window.opener.app_query("<%=tblName %>"); } catch (e) {}	   
                        if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                            window.parent.CloseLayer();
                        }else if(window.parent.parent.CloseLayer){
                            window.parent.parent.CloseLayer();
                        }
						
                    }
                }
                else{
                    //try { window.opener.app_query("<%=tblName %>"); } catch (e) {}  
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
    
        getQueryStr = function () {
            var qs = {};
            var url = decodeURIComponent(window.location.href); 
            //不管有没有伪静态 都看一下?问号后面的参数
            if (url.indexOf('?') > -1) {
                url = url.substring(url.indexOf('?') + 1);
                var prm = url.split('&');
                for (var p in prm) {
                    if (prm[p] && typeof prm[p]=="string") {
                        var sp = prm[p].split('=');
                        if (sp.length > 1) {
                            var spkey = sp[0];
                            var spvalue = sp[1];
                             
                            qs[spkey] = spvalue;
                        }
                    }
                }
            }
            return qs;
        };
    
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
        var _isNew = <%=isNew %>;
        var _appRoot = '<%=ResolveUrl("~") %>';
    var _mainTblName = "<%=tblName %>";
    var _mainId = "<%=mainId %>";
    var _sIndex = "<%=sIndex %>";
    var _saveAction = "1";
    var _curClass = EZ.WebBase.SysFolder.AppFrame.InputFrame;
    var _sysModel = <%=this.sbmodel %>;
    var _xmlData =jQuery(jQuery.parseXML('<xml><%= xmlData %></xml>'));
</script>
<script type="text/javascript" src="../../Js/SysFunction.js?v=<%=SysFuncEtag %>"></script>
<script type="text/javascript">
    <%=editScriptBlock %>    
</script>
