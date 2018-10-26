<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PErrorReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.PErrorReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>项目数据核对统计表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
</head>
<body>
    <div class="box" style="width: 2200px;">
        <h2>项目数据核对统计表</h2>
        <div class="">
            <form action="">
                <input type="text" id="bn" name="bn" /><input type="submit" value="查询"/>
            </form>
        </div>
        <div class="clear10"></div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>子公司</td>
                    <td>项目名称</td>
                    <td>填写人</td>
                    <td>投资时间</td>
                    <td>投资金额（万元）</td>
                    <td>股权金额（万元）</td>
                    <td>债权金额（万元）</td>
                    <td>实际划款金额（万元）</td>
                    <td>股权比例</td>
                    <td>投资方式</td>
                    <td>资金来源</td>
                    <td>所在城市</td>
                    <td>所属行业（二级）</td>
                </tr>
            </thead>
            <tbody>
                <% 
                    var findex = 0;
                    var htmlstr = "";
                    for (var i = 0; i < ProInfo.Rows.Count; i++)
                    {
                        var drf = ProInfo.Rows[i];
                        if (string.IsNullOrEmpty(drf["INVESTMENTIME"].ToString()) || string.IsNullOrEmpty(drf["INVESTMENMOENY"].ToString()) ||
                            (string.IsNullOrEmpty(drf["STOCKMONEY"].ToString()) && string.IsNullOrEmpty(drf["CREDITORMONEY"].ToString())) ||
                            string.IsNullOrEmpty(drf["VIRTUALMOENY"].ToString()) || string.IsNullOrEmpty(drf["SHARERATIO"].ToString()) ||
                            string.IsNullOrEmpty(drf["INVESTMENTSTYLE"].ToString()) || string.IsNullOrEmpty(drf["CAPITALSOURCE"].ToString()) ||
                            drf["CITYD"].ToString() == "空" || drf["TRADEG_2_D"].ToString() == "空")
                        {
                            htmlstr += "<tr><td class='tdcen'>" + (findex + 1) + "</td>";//序号 
                            htmlstr += "<td class='fg'>" + drf["BELONGCORPNAME"] + "</td>";//所在城市

                            htmlstr += "<td><a K_AUTOID='" + drf["K_AUTOID"] + "'>" + drf["PROJECTNAME"] + "</a></td><td>" + drf["EmpName"] + "</td><td>" + CvnStrByObj(drf["INVESTMENTIME"]) + "</td>" +//所属行业 投资时间
                                "<td class='comdify'>" + drf["INVESTMENMOENY"] + "</td><td class='comdify'>" + drf["STOCKMONEY"] + "</td><td class='comdify'>" + drf["CREDITORMONEY"] + "</td>" +//投资金额股权金额债权金额
                                "<td class='comdify'>" + drf["VIRTUALMOENY"] + "</td><td class='ratio'>" + drf["SHARERATIO"] + "</td>" +//实际划款金额 股权比例
                                "<td>" + drf["INVESTMENTSTYLE"] + "</td>" +//投资股数投资价格投资方式
                                "<td>" + drf["CAPITALSOURCE"] + "</td>" +//资金来源
                                "<td>" + drf["CITYD"] + "</td>" +//项目名称 企业名称
                                "<td class=''>"+ drf["TRADEG_2_D"] + "</td></tr>\r\n";//退出比例金额收益

                            findex++;
                        }
                    }                                                                                                               
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td><td colspan='11'></td></tr>";
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
