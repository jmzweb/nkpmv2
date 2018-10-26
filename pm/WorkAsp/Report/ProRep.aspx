<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProRep.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.ProRep" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>项目统计</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
</head>
<body>
    <%
        string[] pts = new string[] { "拟投", "已投", "退出" };
        string[] lbs = new string[] { "股权类", "担保类", "融资租赁类" };
        string[] gqgs = new string[] { "豫农产投", "基金投资", "农投金控", "高创公司", "现代服务业", "中原联创" };
        string[] dbgs = new string[] { "农开担保", "畜牧担保" };
        string[] zlgs = new string[] { "融资租赁" };
        if (Request["ss"] == null)
        {%>
    <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1">
        <caption>项目总览</caption>
        <thead>
            <tr>
                <td colspan="4">股权类</td>
                <td colspan="4">担保类</td>
                <td colspan="4">融资租赁类</td>
                <td rowspan="2">合计</td>
            </tr>
            <tr>
                <td>拟投</td>
                <td>已投</td>
                <td>退出</td>
                <td>小计</td>
                <td>保前</td>
                <td>保后</td>
                <td>退出</td>
                <td>小计</td>
                <td>租前</td>
                <td>租后</td>
                <td>退出</td>
                <td>小计</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <%
            string htmls1 = "";
            var hj1 = 0;
            foreach (var lb in lbs)
            {
                var xj1 = 0;
                foreach (var pt in pts)
                {
                    var sl = int.Parse((ProInfo1.Select("PROJECTTYPE='" + lb + "' and PROJECTSTAGE='" + pt + "'").Length > 0 ? ProInfo1.Select("PROJECTTYPE='" + lb + "' and PROJECTSTAGE='" + pt + "'")[0]["SL"].ToString() : "0"));
                    htmls1 += "<td>" + sl + "</td>";
                    xj1 += sl;
                    hj1 += sl;
                }
                htmls1 += "<td>" + xj1 + "</td>";
            }
                %>
                <%=htmls1 %>
                <td><%=hj1 %></td>
            </tr>
        </tbody>
    </table>
    <div class="clear10"></div>
    <table class="ctable" id="ctablegq" cellspacing="0" cellpadding="0" border="1">
        <caption>股权类项目总览</caption>
        <thead>
            <tr>
                <td width="390">公司名称</td>
                <td>拟投</td>
                <td>已投</td>
                <td>退出</td>
                <td>小计</td>
            </tr>
        </thead>
        <tbody>
            <%
            string htmls2 = "";
            foreach (var gs in gqgs)
            {
                htmls2 += "<tr><td><a openlayer='prorep.aspx?ss=" + gs + "'>" + gs + "</a></td>";
                var xj2 = 0;
                foreach (var pt in pts)
                {
                    var sl = int.Parse((ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'").Length > 0 ? ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'")[0]["SL"].ToString() : "0"));
                    htmls2 += "<td>" + sl + "</td>";
                    xj2 += sl;
                }
                htmls2 += "<td>" + xj2 + "</td></tr>";
            }
            %>
            <%=htmls2 %>
        </tbody>
    </table>
    <div class="clear10"></div>
    <table class="ctable" id="ctabledb" cellspacing="0" cellpadding="0" border="1">
        <caption>担保类项目总览</caption>
        <thead>
            <tr>
                <td width="390">公司名称</td>
                <td>保前</td>
                <td>保后</td>
                <td>退出</td>
                <td>小计</td>
            </tr>
        </thead>
        <tbody>
            <%
            string htmls3 = "";
            foreach (var gs in dbgs)
            {
                htmls3 += "<tr><td><a openlayer='prorep.aspx?ss=" + gs + "'>" + gs + "</a></td>";
                var xj3 = 0;
                foreach (var pt in pts)
                {
                    var sl = int.Parse((ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'").Length > 0 ? ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'")[0]["SL"].ToString() : "0"));
                    htmls3 += "<td>" + sl + "</td>";
                    xj3 += sl;
                }
                htmls3 += "<td>" + xj3 + "</td></tr>";
            }
            %>
            <%=htmls3 %>
        </tbody>
    </table>
    <div class="clear10"></div>
    <table class="ctable" id="ctablezl" cellspacing="0" cellpadding="0" border="1">
        <caption>融资租赁类项目总览</caption>
        <thead>
            <tr>
                <td width="390">公司名称</td>
                <td>租前</td>
                <td>租后</td>
                <td>退出</td>
                <td>小计</td>
            </tr>
        </thead>
        <tbody>
            <%
            string htmls5 = "";
            foreach (var gs in zlgs)
            {
                htmls5 += "<tr><td><a openlayer='prorep.aspx?ss=" + gs + "'>" + gs + "</a></td>";
                var xj5 = 0;
                foreach (var pt in pts)
                {
                    var sl = int.Parse((ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'").Length > 0 ? ProInfo2.Select("BELONGCORPNAME='" + gs + "' and PROJECTSTAGE='" + pt + "'")[0]["SL"].ToString() : "0"));
                    htmls5 += "<td>" + sl + "</td>";
                    xj5 += sl;
                }
                htmls5 += "<td>" + xj5 + "</td></tr>";
            }
            %>
            <%=htmls5 %>
        </tbody>
    </table>
    <% 
        }
        else
        {
            switch (Request["ss"].ToString())
            {
                case "豫农产投":
                case "基金投资":
                case "农投金控":
                case "高创公司":
                case "现代服务业":
                case "中原联创":
    %>
    <table class="ctable" id="ctablegsnt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 拟投项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>拟投金额（万元）</td>
                <td>项目进度</td>
                <td>更新日期</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls6 = "";
            int i6 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='拟投'"))
            {
                htmls6 += "<tr><td class='tdcen'>" + (i6++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td><td class='comdify'>" + drf["PreInvestmenMoeny"] + "</td>" +
                    "<td>" + drf["PROJECTNODE"] + "</td><td dateformat='yyyy-MM-dd'>" + drf["k_updatetime"] + "</td><td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls6 %>
        </tbody>
    </table>
    <table class="ctable" id="ctablegsyt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 已投项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>投资时间</td>
                <td>投资金额（万元）</td>
                <td>股权比例</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls7 = "";
            int i7 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='已投'"))
            {
                htmls7 += "<tr><td class='tdcen'>" + (i7++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["INVESTMENTIME"] + "</td><td class='comdify'>" + drf["INVESTMENMOENY"] + "</td><td class='ratio'>" + drf["SHARERATIO"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls7 %>
        </tbody>
    </table>
    <table class="ctable" id="ctablegstc" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 退出项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>投资时间</td>
                <td>投资金额（万元）</td>
                <td>股权比例</td>
                <td>退出时间</td>
                <td>退出金额（万元）</td>
                <td>退出比例</td>
                <td>收益金额（万元）</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls8 = "";
            int i8 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='退出'"))
            {
                htmls8 += "<tr><td class='tdcen'>" + (i8++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["INVESTMENTIME"] + "</td><td class='comdify'>" + drf["INVESTMENMOENY"] + "</td><td class='ratio'>" + drf["SHARERATIO"] + "</td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["EXITTIME"] + "</td><td class='comdify'>" + drf["EXITMONEY"] + "</td><td class='ratio'>" + drf["EXITRATIO"] + "</td><td class='comdify'>" + drf["INCOMEAMOUNT"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls8 %>
        </tbody>
    </table>
    <%
            break;
                case "农开担保":
                case "畜牧担保":
    %>
    <table class="ctable" id="ctabledbnt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 保前项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>担保金额（万元）</td>
                <td>项目进度</td>
                <td>更新日期</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls26 = "";
            int i26 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='拟投'"))
            {
                htmls26 += "<tr><td class='tdcen'>" + (i26++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td><td class='comdify'>" + drf["GuaranteeMoney"] + "</td>" +
                    "<td>" + drf["PROJECTNODE"] + "</td><td dateformat='yyyy-MM-dd'>" + drf["k_updatetime"] + "</td><td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls26 %>
        </tbody>
    </table>
    <table class="ctable" id="ctablegdbyt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 保后项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>担保时间</td>
                <td>担保金额（万元）</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls27 = "";
            int i27 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='已投'"))
            {
                htmls27 += "<tr><td class='tdcen'>" + (i27++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["GuaranteeSTime"] + "</td><td class='comdify'>" + drf["GuaranteeMoney"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls27 %>
        </tbody>
    </table>
    <table class="ctable" id="ctabledbtc" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 退出项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>担保开始时间</td>
                <td>担保结束时间</td>
                <td>担保金额（万元）</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls28 = "";
            int i28 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='退出'"))
            {
                htmls28 += "<tr><td class='tdcen'>" + (i28++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["GuaranteeSTime"] + "</td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["GuaranteeETime"] + "</td><td class='comdify'>" + drf["GuaranteeMoney"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls28 %>
        </tbody>
    </table>
    <%
            break;
                case "融资租赁": 
    %>
    <table class="ctable" id="ctablezlnt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 租前项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>租赁金额（万元）</td>
                <td>项目进度</td>
                <td>更新日期</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls36 = "";
            int i36 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='拟投'"))
            {
                htmls36 += "<tr><td class='tdcen'>" + (i36++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td><td class='comdify'>" + drf["LEASEMONEY"] + "</td>" +
                    "<td>" + drf["PROJECTNODE"] + "</td><td dateformat='yyyy-MM-dd'>" + drf["k_updatetime"] + "</td><td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls36 %>
        </tbody>
    </table>
    <table class="ctable" id="ctablegzlyt" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 租后项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>租赁时间</td>
                <td>租赁金额（万元）</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls37 = "";
            int i37 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='已投'"))
            {
                htmls37 += "<tr><td class='tdcen'>" + (i37++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["LeaseSTime"] + "</td><td class='comdify'>" + drf["LEASEMONEY"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls37 %>
        </tbody>
    </table>
    <table class="ctable" id="ctablezltc" cellspacing="0" cellpadding="0" border="1">
        <caption><%=Request["ss"] %> 退出项目统计</caption>
        <thead>
            <tr>
                <td>序号</td>
                <td>项目名称</td>
                <td>租赁开始时间</td>
                <td>租赁结束时间</td>
                <td>租赁金额（万元）</td>
                <td>所在城市</td>
                <td>所属行业</td>
            </tr>
        </thead>
        <tbody>
            <%  
            string htmls38 = "";
            int i38 = 1;
            foreach (var drf in ProInfo1.Select("BELONGCORPNAME='" + Request["ss"] + "' and PROJECTSTAGE='退出'"))
            {
                htmls38 += "<tr><td class='tdcen'>" + (i38++) + "</td><td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["LeaseSTime"] + "</td>" +
                    "<td dateformat='yyyy-MM-dd'>" + drf["LeaseETime"] + "</td><td class='comdify'>" + drf["LEASEMONEY"] + "</td>" +
                    "<td>" + drf["CITYD"] + "</td><td>" + drf["TRADEG_2_D"] + "</td>"; 
            }
            %>
            <%=htmls38 %>
        </tbody>
    </table>
    <%
            break;
            }
        } %>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [];//要合并哪些列的值
        var sumtemp = "";
        var defcolspan = 1;//合并单元格列默认占几列
        function CloseLayer() {
            setTimeout(function () { layer.close(LayerTemp) }, 300);
        }
        var LayerTemp = 0;
        function OpenLayer(url) {
            var width = $(window).width() - 60;
            var height = $(window).height() - 60;
            LayerTemp = layer.open({
                title: false,
                resize: true,
                isOutAnim: true,
                offset: ['30px', '30px'],
                type: 2,
                area: [width + 'px', height + 'px'],
                fixed: false, //不固定
                maxmin: false,
                content: url,
                end: function () {
                }
            });
        }
        $(function () {
            $("a[openlayer]").click(function () {
                var $t = $(this);
                window.location.href = ($t.attr("openlayer"));
            });
            $("a[K_AUTOID]").click(function () {
                var $t = $(this);
                var opurl = "<%=base.ResolveUrl("~")%>SysFolder/Extension/ProBizFrame.aspx?funCode=XMKCK&CorrelationCode=" + $t.attr("K_AUTOID") + "&readonly=1";
                OpenLayer(opurl);
            });
            $("a[KCK_AUTOID]").click(function () {
                var $t = $(this);
                var opurl = "<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=CBXMCK&CorrelationCode=" + $t.attr("KCK_AUTOID") + "&CorpID=" + $t.attr("CORPCODE") + "";
                OpenLayer(opurl);
            });
        });//page-break-after:always
    </script>
    <script src="report.js"></script>
</body>
</html>
