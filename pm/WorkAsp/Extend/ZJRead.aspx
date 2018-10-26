<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZJEdit.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.ZJEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="/iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jQuery-2.1.4.min.js"></script> 
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>

    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

</head>
<body>
    <form id="cwqkzcAdd" class="cform formtable">
        <script type="text/javascript">
            $(function () {
                var idtype = '<%=EditType %>';
                if (idtype == "季报") {
                    $(".jdshow").show();
                }
                if (idtype == "月报") {
                    $(".ydshow").show();
                }

                $(".tabbtns a").click(function () {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".tabitem").eq($(this).index()).show().siblings().hide();
                    //$(".abs").eq($(this).index()).show().siblings().hide();
                    $('.mb').show();
                });
                $(".tabbtns a").first().trigger("click");

                $("input,select,textarea").addClass("Read").attr("readonly", "readonly").attr("disabled", "disabled");
            });
        </script>
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                </span>
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="12" class="" style="width: auto; float: left; margin: 10px 0 15px 10px;">
            <tr>
                <td style="width: 80px; text-align: right;">财报类型：</td>
                <td style="width: 200px"><%=EditType %></td>

                <td class="wfs4" style="width: 55px; text-align: right;">年度：</td>
                <td class="" style="width: 200px"><%=EditYear %></td>
                <td class="wsf4 jdshow hide" style="width: 55px; text-align: right;">季度：</td>
                <td class="w2 jdshow hide" style="width: 200px"><%=EditQueater %></td>

                <td class="wsf4 ydshow hide" style="width: 55px; text-align: right;">月度：</td>
                <td class="w2 ydshow hide" style="width: 200px"><%=EditMonth %></td>
            </tr>
        </table>
    </form>

    <div class="subtitlespt">
        <div class="tabbtns subbtns"><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div>
    </div>
    <div class="tabbox">
        <div class="tabitem">

            <%=tblHTML1 %>
        </div>
        <div class="tabitem">

            <%=tblHTML2 %>
        </div>
        <div class="tabitem">

            <%=tblHTML3 %>
        </div>
    </div>
</body>
</html>
<script type="text/javascript"> 
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
</script>


