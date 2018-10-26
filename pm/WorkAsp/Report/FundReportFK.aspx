<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FundReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.FundReport" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>投资基金情况一览表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
</head>
<body>
    <div class="box" style="width: 3200px;">
        <h2>投资基金情况一览表</h2>
        <div class="fl">
            截止时间：<%=DateTime.Now.ToString("yyyy年MM月dd日") %>
        </div>
        <div class="fr">
            金额单位：人民币 （亿元）
        </div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1">
            <thead>
                <tr>
                    <td rowspan="2">序号</td>
                    <td rowspan="2" colspan="3">基金类别</td>
                    <td rowspan="2">基金名称</td>
                    <td rowspan="2">主管部门</td>
                    <td rowspan="2">设立时间</td>
                    <td colspan="2">基金规模</td>
                    <td rowspan="2">受托管理机构</td>
                    <td colspan="2">基金管理公司/实际管理人</td>
                    <td rowspan="2">基金运作模式</td>
                    <td colspan="2">资金到位</td>
                    <td colspan="2">决策情况</td>
                    <td colspan="2">已完成投资情况</td>
                    <td colspan="2">退出情况</td>
                    <td colspan="2">子基金设立情况</td>
                    <td rowspan="2">备注</td>
                </tr>
                <tr>
                    <td>总规模</td>
                    <td>其中：财政出资</td>
                    <td>名称</td>
                    <td>注册地</td>
                    <td>总体到位</td>
                    <td>其中：财政到位</td>
                    <td>个数</td>
                    <td>金额</td>
                    <td>个数</td>
                    <td>金额</td>
                    <td>个数</td>
                    <td>金额</td>
                    <td>个数</td>
                    <td>金额</td>
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < FundInfo.Rows.Count; i++)
                    {
                        var drf = FundInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号 
                        htmlstr += "<td class='fg'>" + drf["fg1"] + "</td><td class='fg'>" + drf["fg2"] + "</td><td class='fg'>" + drf["fg3"] + "</td>";


                        htmlstr += "<td>" + drf["FundName"] + "</td><td>" + drf["MangerDept"] + "</td><td>" + CvnStrByObj(drf["CreationTime"]) + "</td>" +//基金名称设立日期
                            "<td class='comdify2'>" + CvnDblByObj(drf["FundScale"]) + "</td><td class='comdify2'>" + CvnDblByObj(drf["CztPlanInvestM"]) + "</td>" +//基金规模
                            "<td>" + drf["FromOrgName"] + "</td><td>" + drf["FundManageCorp"] + "</td><td>" + drf["FundManageCorpCity"] + "</td><td>" + drf["FundRunMode"] + "</td>" +//受托管理机构	基金管理公司/实际管理人 基金运作模式
                            "<td class='comdify2'>" + (drf["InInvestM"]) + "</td><td class='comdify2'>" + (drf["CztInInvestM"]) + "</td>" +//基金实际到位资金
                            "<td>" + (string.IsNullOrEmpty(drf["jcpronum"].ToString()) ? "0" : drf["jcpronum"].ToString()) + "</td><td class='comdify2'>" + CvnDblByObj(drf["jcpromoney"]) + "</td>" +//决策情况
                            "<td>" + (string.IsNullOrEmpty(drf["ytpronum"].ToString()) ? "0" : drf["ytpronum"].ToString()) + "</td><td class='comdify2'>" + CvnDblByObj(drf["ytpromoney"]) + "</td>" +//投资情况 
                            "<td>" + (string.IsNullOrEmpty(drf["tcpronum"].ToString()) ? "0" : drf["tcpronum"].ToString()) + "</td><td class='comdify2'>" + CvnDblByObj(drf["tcpromoney"]) + "</td>" + //退出情况
                            "<td>" + (string.IsNullOrEmpty(drf["zjjpronum"].ToString()) ? "0" : drf["zjjpronum"].ToString()) + "</td><td class='comdify2'>" + CvnDblByObj(drf["zjjpromoney"]) + "</td>" + //子基金情况
                            "<td></td></tr>";

                    }
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [7,8,13,14, 15,16,17,18,19,20,21,22];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify2'>{{sumcol7}}</td><td class='comdify2'>{{sumcol8}}</td>" +
            "<td colspan='4'></td><td class='comdify2'>{{sumcol13}}</td><td class='comdify2'>{{sumcol14}}</td>" +
            "<td class=''>{{sumcol15}}</td><td class='comdify2'>{{sumcol16}}</td><td class=''>{{sumcol17}}</td><td class='comdify2'>{{sumcol18}}</td>" +
            "<td class=''>{{sumcol19}}</td><td class='comdify2'>{{sumcol20}}</td><td class=''>{{sumcol21}}</td><td class='comdify2'>{{sumcol22}}</td>" +
            "<td colspan='1'></td></tr>";
        var defcolspan = 6;//合并单元格列默认占几列
    </script>
    <script src="report.js"></script>
</body>
</html>
