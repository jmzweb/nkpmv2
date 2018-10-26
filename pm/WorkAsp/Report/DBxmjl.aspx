<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DBxmjl.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.DBxmjl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>项目概况统计表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <style>
        .ctable tr td { font-size: 20px; line-height: 50px; }
    </style>
</head>
<body>
    <div class="box" style="width: 100%;">
        <h2>项目概况统计表</h2>
        <div class="">
            金额单位：人民币 （万元）
        </div>
        <div class="clear10"></div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1" style="width: 100%">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>部门名称</td>
                    <td>项目经理</td>
                    <td>业绩(万)</td> 
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < ProInfo.Rows.Count; i++)
                    {
                        var drf = ProInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td><td>" + drf["BELONGDEPTNAME"] + "</td><td>" + drf["ProManage"] + "</td>" +
                            "<td class='comdify'>" + drf["GUARANTEEMONEY"] + "</td></tr>\r\n";//企业名称所在城市所属行业
                    }                                                                                                                       
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div> 
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [];//要合并哪些列的值
        var sumtemp = "";
        var defcolspan = 1;//合并单元格列默认占几列
         
    </script>
    <script src="report.js"></script>
</body>
</html>
