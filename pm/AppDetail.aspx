<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppInput.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppInput" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>[<%=TblNameCn%>] 查看记录</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge" />-->
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput2.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/kindeditor-4.1.11/themes/default/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <link rel="stylesheet" href="../../Theme/AdminLTE/bootstrap/css/bootstrap.min.css">
    <%=customScript%>
    <style type="text/css">
        .hide { display: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:LinkButton ID="btnStartWF" runat="server" OnClick="btnStartWF_Click" CssClass="hide">发起流程</asp:LinkButton>
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
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
    var _curClass = EZ.WebBase.SysFolder.AppFrame.AppInput;
    $(function () {
        $("input,select,textarea").addClass("Read").attr("readonly", "readonly").attr("disabled", "disabled");
        $(".EnterSearch").each(function (i, v) {
            var $v = $(v);
            var htmlbox = [];
            var arr = $v.attr("display").split("|");
            var arrCId = arr[1].split(",");//INPUT的ID
            var arrQuery = arr[2].split(",");//字段名

            var vals = $("#" + arrCId[1]).val().split(",");//取code的值 如果是多个值 就要取出来多个值对应的编码
            for (var vi = 0; vi < vals.length;vi++) {
                var vali = vals[vi];
                if (vali != "") {
                    switch (arrQuery[1]) {
                        case "CorpCode":
                            var dt = _curClass.GetDataTable("S_PM_C_CompanyInfo_Select", "@CorpCode=" + vali).value;
                            if (dt.Rows.length > 0) {
                                var K_AUTOID = dt.Rows[0].K_AUTOID;
                                var CORPNAME = dt.Rows[0].CORPNAME;
                                var TAG = dt.Rows[0].TAG;
                                var GPTAG = dt.Rows[0].GPTAG;
                                if (GPTAG == "1") { //基金管理机构
                                    htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=JJGLJGCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                        CORPNAME + "</a>");
                                } else {
                                    switch (TAG) {
                                        case "10": //内部机构
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=NBJGCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                        case "11": //储备项目
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=CBXMCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                        case "12": //外部机构
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=WBJGCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break; 
                                        case "14": //律师事务所
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=LSSWSCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                        case "15": //会计事务所
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=KJSWSCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                        case "16": //资产评估机构
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=CZPGJGCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                        case "17": //券商
                                            htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=QSCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                                CORPNAME + "</a>");
                                            break;
                                    }
                                }
                            }
                            break;
                        case "FundCode":
                        case "FOFCode":
                            var dt = _curClass.GetDataTable("S_PM_F_FundInfo_Select", "@FundCode=" + vali).value;
                            if (dt.Rows.length > 0) {
                                var K_AUTOID = dt.Rows[0].K_AUTOID;
                                var FUNDNAME = dt.Rows[0].FUNDNAME;
                                htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=JJKCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                    FUNDNAME + "</a>");
                            }
                            break;
                        case "ProjectCode":
                            var dt = _curClass.GetDataTable("S_PM_P_ProjectInfo_Select", "@ProjectCode=" + vali).value;
                            if (dt.Rows.length > 0) {
                                var K_AUTOID = dt.Rows[0].K_AUTOID;
                                var PROJECTNAME = dt.Rows[0].PROJECTNAME;
                                htmlbox.push("<a openlayer='<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=XMKCK&CorrelationCode=" + K_AUTOID + "' href='javascript:void(0)'>" +
                                    PROJECTNAME + "</a>");
                            }
                            break;
                    }
                }
            }
            if (htmlbox.length > 0) {
                $v.hide().after("<div class='linkshows'>" + htmlbox.join('') + "</div>");
            }
        });

        $("a[openlayer]").click(function () {
            OpenLayer($(this).attr("openlayer"));
        });
    });
    //关闭窗口
    function _appClose() {
        if (!!frameElement) {
            if (!!frameElement.lhgDG)
                frameElement.lhgDG.cancel();
            else {
                if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                    window.parent.CloseLayer();
                } else if (window.parent.parent.CloseLayer) {
                    window.parent.parent.CloseLayer();
                }
            }
            window.close();
        }
        else {
            if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                window.parent.CloseLayer();
            } else if (window.parent.parent.CloseLayer) {
                window.parent.parent.CloseLayer();
            }
            // window.close();
        }
    }

    function CloseLayer() {
        setTimeout(function () { layer.close(LayerTemp) }, 300);
    }
    var LayerTemp = 0; 
    function OpenLayer(url) {
        var width = $(window).width()-20;
        var height = $(window).height() - 20; 
        LayerTemp = layer.open({
            title: false,
            closeBtn: false,
            resize: true,
            isOutAnim: true,
            offset: ['10px', '10px'],
            type: 2,
            area: [width + 'px', height + 'px'],
            fixed: false, //不固定
            maxmin: false,
            content: url 
        });
    }
    <%=editScriptBlock %>    
</script>
