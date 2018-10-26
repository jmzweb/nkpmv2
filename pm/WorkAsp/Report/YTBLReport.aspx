<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YTBLReport.aspx.cs" Inherits="NTJT.Web.WorkAsp.Report.YTBLReport" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基金投资比例表</title>
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <link href="report.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <style>
      
        .ctable tr td{
            font-size:20px;
            line-height:50px;
        }
        .ctable tr td.txtr { text-align:right;}
         .ctable tr td.txtrbl { text-align:right;}
        a {
             text-decoration:none;
        }
    </style>
</head>
<body>
    <div class="box" style="width: 100%;">
        <h2>基金投资比例表</h2>
        <div class="">  
            金额单位：人民币（万元）         
        </div>
        <div class="clear10"></div>
        <table class="ctable" id="ctable" cellspacing="0" cellpadding="0" border="1" style="width:100%">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>基金名称</td>
                    <td>基金规模</td> 
                    <td>实际到位资金</td>
                    <td>已投资金额</td>
                    <td>已投比例</td>                  
                </tr>
            </thead>
            <tbody>
                <% 
                    var htmlstr = "";
                    for (var i = 0; i < ProInfo.Rows.Count; i++)
                    {
                        var drf = ProInfo.Rows[i];
                        htmlstr += "<tr><td class='tdcen'>" + (i + 1) + "</td>";//序号 
                        htmlstr += "<td><a  href='javascript:void(0)' openlayer='SysFolder/Extension/BizFrame.aspx?funCode=JJKCK&CorrelationCode=" + drf["K_AUTOID"] + "&FundID=" + drf["FUNDCODE"] + "'>" + drf["FUNDABBR"] + "</a></td><td class='txtr'>" + drf["FUNDSCALE"] + "</td><td class='txtr'>" + drf["ININVESTM"] + "</td>";
                        htmlstr += "<td class='txtr'>" + drf["OUTINVESTM"] + "</td><td class='txtrbl'>" + drf["YTBL"] + "%</td></tr>\r\n";
                    }                                                                                                                       
                %>
                <%=htmlstr%>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //小计和合计模板
        var sumcol = [];//要合并哪些列的值
        var sumtemp = "<tr class='fontbold'><td></td><td colspan='{{hjcolspan}}'>{{text}}</td>" +
            "<td colspan='5'></td></tr>";
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
            $(document).on("click", "a[openlayer]", function () {
             var $t = $(this);
             var url = $t.attr("openlayer");
             OpenLayer('<%=base.ResolveUrl("~")%>'+url, $t);
            });

            $(".txtr").each(function () {
                $(this).text(comdify($(this).text()));                
            });
        });            
    </script>
    <script src="report.js"></script>
</body>
</html>
