<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FundPointReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.FundPointReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基金进程统计表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
</head>
<body>
    <div class="box" style="width: 2200px;">
        <h2>基金进程统计表</h2>
        <div class="fl">
            截止时间：<%=DateTime.Now.ToString("yyyy年MM月dd日") %>&nbsp;&nbsp;&nbsp;&nbsp;<%--<a href="javascript:void(0)" onclick="output(ctable)">导出</a>--%>
        </div>
        <div class="fr">
            单位：个数
        </div>
        <%
            var tdhtml = "";
            var temphtml = "";
            var sumcol = "";
            for (int i = 0; i < ProPointInfo.Rows.Count; i++)
            {
                var drp = ProPointInfo.Rows[i];
                tdhtml += "<td>" + drp["FunctionalNode"] + "</td>";
                sumcol += (i + 3) + ",";
                temphtml += "<td>{{sumcol" + (i +3 ) + "}}</td>";
            }
             %>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>基金类别</td>
                    <td>基金名称</td>
                    <%=tdhtml%>
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < FundPointInfo.Rows.Count; i++)
                    {
                        var drf = FundPointInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号 
                        htmlstr += "<td class='fg'>" + drf["fg3"] + "</td><td>" + drf["FundAbbr"] + "</td>";

                        for (int j = 0; j < ProPointInfo.Rows.Count; j++)
                        {
                            var drp = ProPointInfo.Rows[j];

                            var xmsl = PFManageInfo.Select("FundID='" + drf["FundCode"] + "' and Node='" + drp["FunctionalNode"] + "'").Length;

                            htmlstr += "<td>" + xmsl + "</td>";
                        }
                        
                        htmlstr += "</tr>\r\n";//             
                    }                                                                                                                       
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [<%=sumcol%>];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><%=temphtml%></tr>";
        var defcolspan = 2;//合并单元格列默认占几列
    </script>
    <script src="report.js"></script>
</body>
</html>
