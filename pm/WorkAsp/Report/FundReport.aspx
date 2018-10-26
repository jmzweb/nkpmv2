<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FundReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.FundReport" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基金运营统计表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
</head>
<body>
    <div class="box" style="width: 3200px;">
        <h2>基金运营统计表</h2>
        <div class="fl">
            截止时间：<%=DateTime.Now.ToString("yyyy年MM月dd日") %>&nbsp;&nbsp;&nbsp;&nbsp;<%--<a href="javascript:void(0)" onclick="output(ctable)">导出</a>--%>
        </div>
        <div class="fr">
            金额单位：人民币 （万元）
        </div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1">
            <thead>
                <tr>
                    <td rowspan="2">序号</td>
                    <td rowspan="2">基金类别</td>
                    <td rowspan="2">基金名称</td>
                    <td rowspan="2">基金设立时间</td>
                    <td rowspan="2">基金规模（万元）</td>
                    <td rowspan="2">财政出资额度（万元）</td>
                    <td colspan="3">基金实际到位资金（万元）</td>
                    <td colspan="2">决策情况</td>
                    <td colspan="2">投资情况</td>
                    <td rowspan="2">决策金额占基金规模的比例</td>
                    <td rowspan="2">投资金额占基金规模的比例</td>
                    <td colspan="2">退出情况</td>
                </tr>
                <tr>
                    <td>基金总到位资金（万元）</td>
                    <td>财政到位资金（万元）</td>
                    <td>社会资本到位资金（万元）</td>
                    <td>决策项目个数（个）</td>
                    <td>决策项目金额（万元）</td>
                    <td>已投项目个数（个）</td>
                    <td>已投资项目金额（万元）</td>
                    <td>退出项目个数（个）</td>
                    <td>退出项目金额（万元）</td>
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < FundInfo.Rows.Count; i++)
                    {
                        var drf = FundInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号 
                        htmlstr += "<td class='fg'>" + drf["fg3"] + "</td>";


                        htmlstr += "<td>" + drf["FundAbbr"] + "</td><td>" + CvnStrByObj(drf["CreationTime"]) + //基金名称设立日期
                            "</td><td class='comdify'>" + CvnDblByObj(drf["FundScale"]) + "</td><td class='comdify'>" + CvnDblByObj(drf["CztPlanInvestM"]) + "</td>" +//基金规模
                            "<td class='comdify'>" + CvnDblByObj(drf["InInvestM"]) + "</td><td class='comdify'>" + CvnDblByObj(drf["CztInInvestM"]) + "</td>" +
                            "<td class='comdify'>" + (CvnDblByObj(drf["InInvestM"]) - CvnDblByObj(drf["CztInInvestM"])) + "</td>" +//基金实际到位资金
                            "<td>" + (string.IsNullOrEmpty(drf["jcpronum"].ToString()) ? "0" : drf["jcpronum"].ToString()) + "</td><td class='comdify'>" + CvnDblByObj(drf["jcpromoney"]) + "</td>" +//决策情况
                            "<td>" + (string.IsNullOrEmpty(drf["ytpronum"].ToString()) ? "0" : drf["ytpronum"].ToString()) + "</td><td class='comdify'>" + CvnDblByObj(drf["ytpromoney"]) + "</td>" +//投资情况
                            "<td>" + CvnDblByObj(drf["jcbl"]) + "%</td><td>" + CvnDblByObj(drf["ytbl"]) + "%</td>" +//占基金规模的比例
                            "<td>" + (string.IsNullOrEmpty(drf["tcpronum"].ToString()) ? "0" : drf["tcpronum"].ToString()) + "</td><td class='comdify'>" + CvnDblByObj(drf["tcpromoney"]) + "</td></tr>";

                    }
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [4,5,6, 7, 8, 9, 10, 11, 12, 15, 16];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify'>{{sumcol4}}</td><td class='comdify'>{{sumcol5}}</td><td class='comdify'>{{sumcol6}}</td><td class='comdify'>{{sumcol7}}</td><td class='comdify'>{{sumcol8}}</td>" +
            "<td class=''>{{sumcol9}}</td><td class='comdify'>{{sumcol10}}</td><td class=''>{{sumcol11}}</td><td class='comdify'>{{sumcol12}}</td><td colspan='2'>&nbsp;</td><td>{{sumcol15}}</td><td class='comdify'>{{sumcol16}}</td></tr>";
        var defcolspan = 3;//合并单元格列默认占几列
    </script>
    <script src="report.js"></script>
</body>
</html>
