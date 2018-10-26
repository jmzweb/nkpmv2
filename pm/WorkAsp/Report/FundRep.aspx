<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FundRep.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.FundRep" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基金统计</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
</head>
<body>
    <% var sstype = Request["ss"] ?? "tg";//tg投管部 fk风控部
       var fwtype = Request["fw"] ?? "mjj";//mjj母基金 zjj子基金 需要分开
       switch (sstype)
       {
           case "tg":%>
    <table class="ctable" id="Table1" cellspacing="0" cellpadding="0" border="1" style="width: 3900px">
        <caption>
            <%if (fwtype == "zjj")
              { 
            %><h2>投资基金情况表－子基金</h2>
            <%
              }
              else
              { 
            %><h2>投资基金情况表</h2>
            <%
              } %>
            截止时间：<%=DateTime.Now.ToString("yyyy年MM月dd日") %>&nbsp;&nbsp;&nbsp;金额单位：人民币 （亿元）</caption>
        <thead>
            <tr>
                <td rowspan="3">序号</td>
                <%if (fwtype == "zjj")
                  { 
                %>
                <td colspan="11">一、基本信息</td>
                <td colspan="6">二、出资情况</td>
                <td colspan="10">三、投资情况</td>
            </tr>
            <tr>
                <td rowspan="2" style="width: 130px;">母基金名称</td>
                <%
                  }
                  else
                  { 
                %>
                <td colspan="12">一、基本信息</td>
                <td colspan="6">二、出资情况</td>
                <td colspan="10">三、投资情况</td>
            </tr>
            <tr>
                <td rowspan="2">基金类型</td>
                <td rowspan="2" style="width: 130px;">基金类别</td>
                <%
                  } %>
                <td rowspan="2">基金名称</td>
                <td rowspan="2">组织形式</td>
                <td rowspan="2">设立情况</td>
                <td rowspan="2">设立时间</td>
                <td rowspan="2" style="width: 399px;">投资领域</td>
                <td rowspan="2">基金运作模式</td>
                <td rowspan="2">业务主管部门</td>
                <td rowspan="2">受托管理机构或发起设立机构</td>
                <td colspan="2">基金管理公司/实际管理人</td>
                <td colspan="4">基金规模</td>
                <td colspan="2">到位规模</td>
                <td colspan="2">决策情况</td>
                <td colspan="5">已完成投资情况</td>
                <td colspan="3">子基金设立情况</td>
            </tr>
            <tr>
                <td style="width: 200px;">名称</td>
                <td style="width: 300px;">注册地</td>
                <td>总规模</td>
                <td>其中：财政出资</td>
                <td style="width: 600px;">出资结构</td>
                <td>已落实出资</td>
                <td>实际到位</td>
                <td>其中：财政到位</td>
                <td>个数</td>
                <td>金额</td>
                <td>个数</td>
                <td>金额</td>
                <td>投资完成率</td>
                <td>退出个数</td>
                <td>退出金额</td>
                <td>个数</td>
                <td>金额</td>
                <td>母基金出资</td>
            </tr>
        </thead>
        <tbody>
            <%
            string htmls11 = "";
            int i11 = 1;
            DataRow[] fdt11 = FundInfo1.Select("PFundCode='' or PFundCode is null");
            if (fwtype == "zjj") {
                FundInfo1.DefaultView.Sort = "PFundCode";
                fdt11 = FundInfo1.DefaultView.ToTable().Select("PFundCode<>'' and PFundCode is not null");
            }  
            foreach (var drf in fdt11)
            {
                htmls11 += "<tr><td class='tdcen'>" + (i11++) + "</td>";
                if (fwtype == "zjj")
                {
                    htmls11 += "<td class='fg'>" + FundInfo1.Select("FundCode='" + drf["PFundCode"] + "'")[0]["FundAbbr"] + "</td>";
                }
                else
                {
                    htmls11 += "<td class='fg'>" + drf["FundType_SB"] + "</td><td class='fg'>" + drf["fg3"] + "</td>";
                }
                htmls11 += "<td><a FundCode='" + drf["FundCode"] + "' K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["FundName"] + "</a></td>" +
                     "<td>" + drf["CorpForm"] + "</td><td>" + drf["FoundStatus"] + "</td><td dateformat='yyyy-MM-dd'>" + drf["CreationTime"] + "</td><td>" + drf["InvestField"] + "</td><td>" + drf["FundRunMode"] + "</td>" +
                     "<td>" + drf["MangerDept"] + "</td><td>" + drf["FromOrgName"] + "</td><td>" + drf["FundManageCorp"] + "</td><td>" + drf["FundManageCorpAddr"] + "</td>" +
                     "<td class='comdify2'>" + drf["FundScale"] + "</td><td class='comdify2'>" + drf["CztPlanInvestM"] + "</td><td>";
                //出资结构
                foreach (var drcz in FundInfoCZ.Select("CorrelationCode='" + drf["K_AUTOID"] + "'"))
                {
                    htmls11 += drcz["Investor"] + "出资<span class='comdify2'>" + drcz["PlanInvestM"] + "</span>亿元；";
                }
                htmls11 += "</td><td class='comdify2'>" + drf["ImplementM"] + "</td><td class='comdify2'>" + drf["InInvestM"] + "</td><td class='comdify2'>" + drf["CztInInvestM"] + "</td>" +
                     "<td>" + drf["jcpronum"] + "</td><td class='comdify2'>" + drf["jcpromoney"] + "</td><td>" + drf["ytpronum"] + "</td><td class='comdify2'>" + drf["ytpromoney"] + "</td>" +
                     "<td class='ytbl' ytje='" + drf["ytpromoney"] + "' jjgm='" + drf["FundScale"] + "'></td>" +
                     "<td>" + drf["tcpronum"] + "</td><td class='comdify2'>" + drf["tcpromoney"] + "</td>";
                var zjjs = FundInfo1.Select("PFundCode='" + drf["FundCode"] + "'");
                var zjjsl = 0;
                decimal zjjgm = 0;
                decimal zjjcz = 0;
                foreach (var zjj in zjjs)
                {
                    zjjsl++;
                    zjjgm += (string.IsNullOrEmpty(zjj["FundScale"].ToString()) ? 0 : decimal.Parse(zjj["FundScale"].ToString()));
                    zjjcz += (string.IsNullOrEmpty(zjj["InvestmenMoeny"].ToString()) ? 0 : decimal.Parse(zjj["InvestmenMoeny"].ToString()));
                }
                htmls11 += "</td><td>" + zjjsl + "</td><td class='comdify2'>" + zjjgm + "</td><td class='comdify2'>" + zjjcz + "</td>";
            }
            %>
            <%=htmls11 %>
        </tbody>
    </table>
    <%if (fwtype == "zjj")
      { 
    %>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [12,13];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify2'>{{sumcol12}}</td><td class='comdify2'>{{sumcol13}}</td><td></td>";
        for (var i = 15; i < 28; i++) {
            sumcol.push(i);
            if (i == 22) {
                sumtemp += "<td class=''></td>";
            } else if (i == 18 || i == 20 || i == 23 || i == 25) {
                sumtemp += "<td class=''>{{sumcol" + i + "}}</td>";
            } else {
                sumtemp += "<td class='comdify2'>{{sumcol" + i + "}}</td>";
            }
        }
        sumtemp += "</tr>";
        var defcolspan = 11;//合并单元格列默认占几列
    </script>
    <%
              }
      else
      { 
    %>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [13, 14];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify2'>{{sumcol13}}</td><td class='comdify2'>{{sumcol14}}</td><td></td>";
        for (var i = 16; i < 29; i++) {
            sumcol.push(i);
            if (i == 23) {
                sumtemp += "<td class=''></td>";
            } else if (i == 19 || i == 21 || i == 24 || i == 26) {
                sumtemp += "<td class=''>{{sumcol" + i + "}}</td>";
            } else {
                sumtemp += "<td class='comdify2'>{{sumcol" + i + "}}</td>";
            }
        }
        sumtemp += "</tr>";
        var defcolspan = 12;//合并单元格列默认占几列
    </script>
    <%
              } %>
    <%
      break;
           case "tgjj":%>
    <table class="ctable" id="ctabletg2" cellspacing="0" cellpadding="0" border="1">
        <caption>
            <%if (fwtype == "zjj")
              { 
            %><h2>投资基金简要情况表－子基金</h2>
            <%
              }
              else
              { 
            %><h2>投资基金简要情况表</h2>
            <%
              } %>
            截止时间：<%=DateTime.Now.ToString("yyyy年MM月dd日") %>&nbsp;&nbsp;&nbsp;金额单位：人民币 （亿元）</caption>
        <thead>
            <tr>
                <td rowspan="3">序号</td>
                <td colspan="2">一、基本信息</td>
                <td colspan="5">二、出资情况</td>
                <td colspan="9">三、投资情况</td>
            </tr>
            <tr>
                <%if (fwtype == "zjj")
                  { 
                %><td rowspan="2" style="width: 130px;">母基金名称</td>
                <%
                  }
                  else
                  { 
                %><td rowspan="2" style="width: 130px;">基金类别</td>
                <%
                  } %>

                <td rowspan="2" style="width: 200px">基金名称</td>
                <td colspan="3">基金规模</td>
                <td colspan="2">到位规模</td>
                <td colspan="2">决策情况</td>
                <td colspan="4">已完成投资情况</td>
                <td colspan="3">子基金设立情况</td>
            </tr>
            <tr>
                <td>总规模</td>
                <td>财政出资</td>
                <td>已落实</td>
                <td>实际到位</td>
                <td>财政到位</td>
                <td>个数</td>
                <td>金额</td>
                <td>个数</td>
                <td>金额</td>
                <td>退出个数</td>
                <td>退出金额</td>
                <td>个数</td>
                <td>金额</td>
                <td>母基金出资</td>
            </tr>
        </thead>
        <tbody>
            <%
            string htmls12 = "";
            int i12 = 1;
            DataRow[] fdt12 = FundInfo1.Select("PFundCode='' or PFundCode is null");
            if (fwtype == "zjj") {
                FundInfo1.DefaultView.Sort = "PFundCode";
                fdt12 = FundInfo1.DefaultView.ToTable().Select("PFundCode<>'' and PFundCode is not null");
            } 
            foreach (var drf in fdt12)
            {
                htmls12 += "<tr><td class='tdcen'>" + (i12++) + "</td>"; 
                if (fwtype == "zjj")
                {
                    htmls12 += "<td class='fg'>" + FundInfo1.Select("FundCode='" + drf["PFundCode"] + "'")[0]["FundAbbr"] + "</td>";
                }
                else
                {
                    htmls12 += "<td class='fg'>" + drf["fg3"] + "</td>";
                }
                htmls12 += "<td><a FundCode='" + drf["FundCode"] + "' K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["FundAbbr"] + "</a></td>" +  
                     "<td class='comdify2'>" + drf["FundScale"] + "</td><td class='comdify2'>" + drf["CztPlanInvestM"] + "</td>"+
                     "<td class='comdify2'>" + drf["ImplementM"] + "</td><td class='comdify2'>" + drf["InInvestM"] + "</td><td class='comdify2'>" + drf["CztInInvestM"] + "</td>" +
                     "<td>" + drf["jcpronum"] + "</td><td class='comdify2'>" + drf["jcpromoney"] + "</td><td>" + drf["ytpronum"] + "</td><td class='comdify2'>" + drf["ytpromoney"] + "</td>" + 
                     "<td>" + drf["tcpronum"] + "</td><td class='comdify2'>" + drf["tcpromoney"] + "</td>";
                var zjjs = FundInfo1.Select("PFundCode='" + drf["FundCode"] + "'");
                var zjjsl = 0;
                decimal zjjgm = 0;
                decimal zjjcz = 0;
                foreach (var zjj in zjjs)
                {
                    zjjsl++;
                    zjjgm += (string.IsNullOrEmpty(zjj["FundScale"].ToString()) ? 0 : decimal.Parse(zjj["FundScale"].ToString()));
                    zjjcz += (string.IsNullOrEmpty(zjj["InvestmenMoeny"].ToString()) ? 0 : decimal.Parse(zjj["InvestmenMoeny"].ToString()));
                }
                htmls12 += "</td><td>" + zjjsl + "</td><td class='comdify2'>" + zjjgm + "</td><td class='comdify2'>" + zjjcz + "</td>";
            }
            %>
            <%=htmls12 %>
        </tbody>
    </table>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td>";
        for (var i = 3; i < 17; i++) {
            sumcol.push(i);
            if (i == 8 || i == 10 || i == 12 || i == 14) {
                sumtemp += "<td class=''>{{sumcol" + i + "}}</td>";
            } else {
                sumtemp += "<td class='comdify2'>{{sumcol" + i + "}}</td>";
            } 
        }
        sumtemp += "</tr>";
        var defcolspan = 2;//合并单元格列默认占几列
    </script>
    <%
            break;
           case "fk":
            break;
       } %>
    <script type="text/javascript">
        //ytbl
        $(".ctable .ytbl").each(function (ci, cv) {
            var $t = $(cv);
            if ($t.attr("ytje") && $t.attr("jjgm")) {
                $t.text((parseFloat($t.attr("ytje")) / parseFloat($t.attr("jjgm"))).toFixed(2));
            }
        });
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
            $("a[FundCode]").click(function () {
                var $t = $(this);
                var opurl = "<%=base.ResolveUrl("~")%>SysFolder/Extension/BizFrame.aspx?funCode=JJKCK&CorrelationCode=" + $t.attr("K_AUTOID") + "&FundID=" + $t.attr("FundCode") + "";
                OpenLayer(opurl);
            });
        });//page-break-after:always
    </script>
    <script src="report.js"></script>
</body>
</html>
