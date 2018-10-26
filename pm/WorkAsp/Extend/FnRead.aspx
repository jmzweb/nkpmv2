<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FnEdit.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.FnEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="/iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>

    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

</head>
<body>
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
            <td style="width: 130px">
                <%=EditType %>
            </td>
            <td class="wfs4" style="width: 55px; text-align: right;">时间：</td>
            <td class="">
                <%=EditYear %>
                <%=EditQueater %>
                <%=EditMonth %>
            </td>
        </tr>
    </table>

    <div class="subtitlespt">
        <div class="tabbtns subbtns"><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div> 
    </div>
    <div class="tabbox">
        <div class="tabitem tabitem1">
        </div>
        <div class="tabitem tabitem2">
        </div>
        <div class="tabitem tabitem3">
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    //保存数据
    $(function () {
        $(".tabbtns a").click(function () {
            $(this).addClass("select").siblings().removeClass("select");
            $(".tabitem").eq($(this).index()).show().siblings().hide(); 
        });
        $(".tabbtns a").first().trigger("click");
        var EditDatas1 = '<%=EditDatas1%>';
        if (EditDatas1) {
            var datas1 = $.evalJSON(EditDatas1);
            $(".tabitem1").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>期末余额</td></tr></thead><tbody>" +
                zjs.render(datas1, "<tr><td class='coldesc'>{{SUBNAME}}</td><td class='comdify'>{{SUBDATA}}</td></tr>") +
                "</tbody></table>");
        }
        var EditDatas2 = '<%=EditDatas2%>';
        if (EditDatas2) {
            var datas1 = $.evalJSON(EditDatas2);
            $(".tabitem2").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                zjs.render(datas1, "<tr><td class='coldesc'>{{SUBNAME}}</td><td class='comdify'>{{SUBDATA}}</td></tr>") +
                "</tbody></table>");
        }
        var EditDatas3 = '<%=EditDatas3%>';
        if (EditDatas3) {
            var datas1 = $.evalJSON(EditDatas3);
            $(".tabitem3").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                zjs.render(datas1, "<tr><td class='coldesc'>{{SUBNAME}}</td><td class='comdify'>{{SUBDATA}}</td></tr>") +
                "</tbody></table>");
        }

        $(".tabbox .comdify").each(function (i, v) {
            $(v).html(comdify($(v).text()));
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
    };
    function comdify(n) {//处理千分位
        var re = /\d{1,3}(?=(\d{3})+$)/g;
        var n1 = n.replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });
        if (n1 == "0") {
            return "&nbsp;";
        } else {
            if (n < 0) {
                return "<span class='error'>" + n1 + "</span>";
            } else {
                return n1;
            }
        }
    };
</script>


