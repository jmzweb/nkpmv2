<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FundReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.FundReport" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基金概况统计表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <style>
        .ctable tr td{
            font-size:20px;
            line-height:50px;
        }
    </style>
</head>
<body>
    <div class="box" style="width: 100%;">
        <h2>基金概况统计表</h2>
        <div class="">
            金额单位：人民币 （万元）
        </div>
        <div class="clear10"></div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1" style="width:100%">
            <thead>
                <tr>
                    <td>序号</td> 
                    <td>基金名称</td>
                    <td>基金规模（万元）</td>
                    <td>实际到位资金（万元）</td>
                    <td>实际到位比例</td>
                    <td>财政承诺额度（万元）</td>
                    <td>财政到位资金（万元）</td> 
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < FundInfo.Rows.Count; i++)
                    {
                        var drf = FundInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号  
                         
                        htmlstr += "<td><a FundCode='" + drf["FundCode"] + "' K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["FundAbbr"] + "</a></td>" +//基金名称
                            "<td class='comdify'>" + CvnDblByObj(drf["FundScale"]) + "</td><td class='comdify'>" + CvnDblByObj(drf["InInvestM"]) + "</td>" +//基金规模
                            "<td class='ratio'>" + Math.Round((CvnDblByObj(drf["InInvestM"]) / CvnDblByObj(drf["FundScale"]) * 100), 2) + "</td>" +//实际到位比例
                            "<td class='comdify'>" + CvnDblByObj(drf["CztPlanInvestM"]) + "</td><td class='comdify'>" + CvnDblByObj(drf["CztInInvestM"]) + "</td></tr>";  
                    }
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [2, 3, 5, 6];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify'>{{sumcol2}}</td><td class='comdify'>{{sumcol3}}</td>" +
            "<td ></td><td class='comdify'>{{sumcol5}}</td><td class='comdify'>{{sumcol6}}</td></tr>";
        var defcolspan = 1;//合并单元格列默认占几列

        function CloseLayer() {
            setTimeout(function () { layer.close(LayerTemp) }, 300);
        }
        var LayerTemp = 0;
        function OpenLayer(url) {
            var width = $(window).width() - 20;
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
        });
    </script>
    <script src="report.js"></script>
</body>
</html>
