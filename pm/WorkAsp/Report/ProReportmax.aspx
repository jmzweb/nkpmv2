<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.ProReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>项目概况统计表</title>
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
        <h2>项目概况统计表</h2>
        <div class="">
            金额单位：人民币 （万元）
        </div>
        <div class="clear10"></div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1" style="width:100%">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>项目名称</td>
                    <td>投资时间</td>
                    <td>投资金额（万元）</td>
                  <!--  <td>股权金额（万元）</td>
                    <td>债权金额（万元）</td>
                    <td>实际划款（万元）</td>
                    <td>股权比例</td>
                    <td>投资股数</td>
                    <td>退出金额（万元）</td>
                    <td>退出比例</td>>
                    <td>收益金额（万元）</td>
                    <td>投资方式</td>
                    <td>资金来源</td>
                    <td>企业名称</td>-->
                    <td>所在城市</td>
                    <td>所属行业</td>
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < ProInfo.Rows.Count; i++)
                    {
                        var drf = ProInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号 
                        htmlstr += "<td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td><td>" + CvnStrByObj(drf["INVESTMENTIME"]) + "</td>" +//项目名称投资时间
                            "<td class='comdify'>" + drf["INVESTMENMOENY"] + "</td>";//<td class='comdify'>" + drf["STOCKMONEY"] + "</td><td class='comdify'>" + drf["CREDITORMONEY"] + "</td>" +//投资金额股权金额债权金额
                           // "<td class='comdify'>" + drf["VIRTUALMOENY"] + "</td><td class='ratio'>" + drf["SHARERATIO"] + "</td>" +//实际划款 股权比例
                       //     "<td>" + drf["SHARESNUM"] + "</td>" +//投资股数投资价格
                      //      "<td class='comdify'>" + drf["EXITMONEY"] + "</td><td class='ratio'>" + drf["EXITRATIO"] + "</td><td class='comdify'>" + drf["INCOMEAMOUNT"] + "</td>";//退出比例金额收益
                      //  htmlstr += "<td>" + drf["INVESTMENTSTYLE"] + "</td>";//投资方式
                        //    htmlstr += "<td>" + drf["CAPITALSOURCE"] + "</td><td>" + drf["CORPNAME"] + "</td>"; //资金来源 
                        htmlstr += "<td >" + drf["CITYD"] + "</td><td class=''>" + drf["TRADEG_1_D"] + "</td></tr>\r\n";//企业名称所在城市所属行业
                    }                                                                                                                       
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [3];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td class='comdify'>{{sumcol3}}</td>" +
            "<td colspan='3'></td></tr>";
        var defcolspan = 2;//合并单元格列默认占几列

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
            $("a[K_AUTOID]").click(function () {
                var $t = $(this);
                var opurl = "<%=base.ResolveUrl("~")%>SysFolder/Extension/ProBizFrame.aspx?funCode=XMKCK&CorrelationCode=" + $t.attr("K_AUTOID") + "&readonly=1";
                OpenLayer(opurl);
            });
        });
    </script>
    <script src="report.js"></script>
</body>
</html>
