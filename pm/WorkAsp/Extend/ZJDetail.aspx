<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZJDetail.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.ZJDetail" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jQuery-2.1.4.min.js"></script> 
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>
    <script type="text/javascript" src="../../js/echarts.min.js"></script>
    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <link rel="stylesheet" href="../../Static/mainpm/iconfont/iconfont.css" />

</head>
<body>
    <script src="../../js/p.WdatePicker.js"></script>
    <form id="cwqkzcAdd" class="cform formtable">
        <script type="text/javascript">
            function lxconchange($t, $input, $id) {
                $(".hide").hide();
                if ($id.val() == "年报" || $id.val() == "半年报") {
                    $('.nb1').show();
                    $('.nb2').show();
                } else {
                    $('.nb1').hide()
                }
            };
            $(function () {
                //$('.nb1').hide();

                $(".sub2 a").click(function () {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".tabitem2").eq($(this).index()).show().siblings().hide();
                });
                $(".sub2 a").first().trigger("click");
            });
            //关闭窗口
            function _appClose() {
                if (!!frameElement) {
                    if (!!frameElement.lhgDG)
                        frameElement.lhgDG.cancel();
                    else {
                        if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                            window.parent.CloseLayer();
                        } else if (window.parent.parent.CloseLayer) {
                            window.parent.parent.CloseLayer();
                        }
                    }
                    window.close();
                }
                else {
                    if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                        window.parent.CloseLayer();
                    } else if (window.parent.parent.CloseLayer) {
                        window.parent.parent.CloseLayer();
                    }
                    // window.close();
                }
            }
        </script>
        <div class="menubar" style="height: 170px;">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" id="search">统计</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                    <em class="split">|</em>
                    <a class='linkbtn changetu' type="bar" href="javascript:">柱状图</a>
                    <a class='linkbtn changetu' type="line" href="javascript:">拆线图</a>
                </span>
            </div>
        </div>
        <div class="fixtop">
            <table border="0" cellpadding="0" cellspacing="12" class="" style="width: auto; float: left; margin: 10px 0 15px 10px;">
                <tr>
                    <td style="width: 80px; text-align: right;">财报类型：</td>
                    <td style="width: 230px">
                        <input id="cblx" type="text" rule="length:25" class="cselectorRadio" mode=""
                            values="年报,半年报,季报,月报" conchange="lxconchange()" />

                    </td>
                    <td class="wfs4" style="width: 55px; text-align: right;">年度：</td>
                    <td class="" style="width: 200px">
                        <input id="nian" type="text" rule="length:25" onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                    <td class="jdhide nb1">~</td>
                    <td class="jdhide nb1" style="width: 200px">
                        <input id="nian2" type="text" rule="length:25" onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                </tr>
            </table>
            <div class="subtitlespt hide">
                <div class="tabbtns subbtns sub2"><a>财务概况</a><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div>
            </div>
        </div>
    </form>
    <div class="reportbox hide">
        <div class="tabbox">
            <div class="tabitem tabitem2">
                <h3>成长性指标</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 30%;">
                                <div class="wBody" style="height: 300px;" id="Data1">
                                </div>
                            </td>
                            <td style="width: 30%;">
                                <div class="wBody" style="height: 300px;" id="Data2">
                                </div>
                            </td>
                            <td style="width: 30%;">

                                <div class="wBody" style="height: 300px;" id="Data3">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>盈利能力指标</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data4">
                                </div>
                            </td>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data5">
                                </div>
                            </td>

                        </tr>
                    </table>
                </div>
                <h3>偿债能力</h3>
                <div class="tabitem tabitem1">
                    <table>
                        <tr>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data6">
                                </div>
                            </td>
                            <td style="width: 50%;">
                                <div class="wBody" style="height: 300px;" id="Data7">
                                </div>
                            </td>

                        </tr>
                    </table>
                </div>
            </div>
            <div class="tabitem tabitem2">
                <table border="0" cellpadding="0" cellspacing="0" class="tablefloat tblbox1">
                    <tbody>
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0" class="w100">
                                    <tbody>
                                        <tr class="table" savepath="cwqkzc">
                                            <td class="ctable180">
                                                <table border="0" cellpadding="0" cellspacing="0" class="ctable">
                                                    <tbody>
                                                        <tr>
                                                            <td class="coldesc">资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">流动资产：</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">货币资金</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">交易性金融资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应收票据</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应收账款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">预付款项</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应收利息</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应收股利</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他应收款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">存货</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">一年内到期的非流动资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他流动资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">流动资产合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">非流动资产：</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">可供出售金融资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">持有至到期投资</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">长期应收款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">长期股权投资</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">投资性房地产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">固定资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">在建工程</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">工程物资</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">固定资产清理</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">生产性生物资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">油气资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">无形资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">开发支出</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">商誉</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">长期待摊费用</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">递延所得税资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他非流动资产</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">非流动资产合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">资产总计</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td class="tbl1"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0" class="w100">
                                    <tbody>
                                        <tr class="table" savepath="cwqkfz">
                                            <td class="ctable180" style="width: 210px;">
                                                <table border="0" cellpadding="0" cellspacing="0" class="ctable">
                                                    <tbody>
                                                        <tr>
                                                            <td class="coldesc">负债和所有者权益（或股东权益）</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">流动负债：</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">短期借款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">交易性金融负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付票据</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付账款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">预收款项</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付职工薪酬</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应交税费</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付利息</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付股利</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他应付款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">一年内到期的非流动负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他流动负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">流动负债合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">非流动负债：</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">长期借款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">应付债券</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">长期应付款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">专项应付款</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">预计负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">递延所得税负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">其他非流动负债</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">非流动负债合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">负债合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc f10">所有者权益（或股东权益)：</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">实收资本（或股本）</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">资本公积</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">减：库存股</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">盈余公积</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc">未分配利润</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc f10">所有者权益（或股东权益)合计</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="coldesc f10">负债和所有者权益(或股东权益)总计</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td class="tbl2"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="tabitem tabitem2">
                <table border="0" cellpadding="0" cellspacing="0" class="w100 tblbox2">
                    <tbody>
                        <tr class="table" savepath="cwqkzc">
                            <td class="ctable180" style="width: 330px;">
                                <table border="0" cellpadding="0" cellspacing="0" class="ctable">
                                    <tbody>
                                        <tr>
                                            <td class="coldesc">项目</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>一、营业收入</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">减：营业成本</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">营业税金及附加</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">销售费用</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">管理费用</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">财务费用</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">资产减值损失</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">加：公允价值变动收益（损失以“-”号填列）</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">投资收益（损失以“-”号填列）</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">其中:对联营企业和合营企业的投资收益</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>二、营业利润（亏损以“-”号填列）</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">加：营业外收入</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">减：营业外支出</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">其中：非流动资产处置损失</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>三、利润总额（亏损总额以“-”号填列）</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">减：所得税费用</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>四、净利润（净亏损以“-”号填列）</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>五、每股收益：</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">（一）基本每股收益</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">（二）稀释每股收益</td>
                                        </tr>
                                        <!--   <tr>
                                        <td class="coldesc">填表人</td>
                                    </tr>
                                    <tr>
                                        <td class="coldesc">填表时间</td>
                                    </tr>-->
                                    </tbody>
                                </table>
                            </td>
                            <td class="tbl3"></td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <div class="tabitem tabitem2">
                <table border="0" cellpadding="0" cellspacing="0" class="w100 tblbox3">
                    <tbody>
                        <tr class="table" savepath="cwqkzc">
                            <td class="ctable180" style="width: 330px;">
                                <table border="0" cellpadding="0" cellspacing="0" class="ctable">
                                    <tbody>
                                        <tr>
                                            <td class="coldesc">项目</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>一、经营活动产生的现金流量：</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">销售商品、提供劳务收到的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">收到的税费返还</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">收到其他与经营活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">经营活动现金流入小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">购买商品、接受劳务支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">支付给职工以及为职工支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">支付的各项税费</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">支付其他与经营活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">经营活动现金流出小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">经营活动产生的现金流量净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>二、投资活动产生的现金流量</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">收回投资收到的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">取得投资收益收到的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">处置固定资产、无形资产和其他长期资产收回的现金净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">处置子公司及其他营业单位收到的现金净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">收到其他与投资活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">投资活动现金流入小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">购建固定资产、无形资产和其他长期资产支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">投资支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">取得子公司及其他营业单位支付的现金净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">支付其他与投资活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">投资活动现金流出小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">投资活动产生的现金流量净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>三、筹资活动产生的现金流量</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">吸收投资收到的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">取得借款收到的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">收到其他与筹资活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">筹资活动现金流入小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">偿还债务支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">分配股利、利润或偿付利息支付的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">支付其他与筹资活动有关的现金</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">筹资活动现金流出小计</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">筹资活动产生的现金流量净额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>四、汇率变动对现金及现金等价物的影响</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>五、现金及现金等价物净增加额</strong></td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc">加：期初现金及现金等价物余额</td>
                                        </tr>
                                        <tr>
                                            <td class="coldesc"><strong>六、期末现金及现金等价物余额</strong></td>
                                        </tr>
                                        <!--  <tr>
                                        <td class="coldesc">填表人</td>
                                    </tr>
                                    <tr>
                                        <td class="coldesc">填表时间</td>
                                    </tr>-->
                                    </tbody>
                                </table>
                            </td>
                            <td class="tbl4"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    var chattype = "line";
    var TempJson;
    //保存数据
    jQuery(function () {
        $('#search').click(function () {
            SearchData();
        });
        $('.changetu').click(function () {
            chattype = $(this).attr("type");
            SearchData();
        });
    });
    function comdify(n) {//处理千分位
        var re = /\d{1,3}(?=(\d{3})+$)/g;
        var n1 = n.replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });
        if (n1 == "0") {
            return "&nbsp;";
        } else {
            if (n < 0) {
                return "<span class='error'>"+n1+"</span>";
            } else {
                return n1;
            }
        }
    };
    function SearchData() {
        if ($('#cblx').val() == "") {
            alert("财报类型不能为空");
            return false;
        }
        else if ($('#cblx').val() != "") {
            if (($('#cblx').val() == "年报" || $('#cblx').val() == "半年报") && ($('#nian').val() == "" || $('#nian2').val() == "")) {
                alert("年度不能为空");
                return false;
            }
            if ($('#nian').val() == "") {
                alert("年度不能为空");
                return false;
            }
        }
        $.ajax({
            type: 'post',
            url: 'ZJDetail.aspx',
            data: { 't': 'load', "Code": "<%=Code %>", "SType": $('#cblx').val(), "Year": $('#nian').val(), "Year2": $('#nian2').val() },
            success: function (data) {
                var ret = eval('(' + data + ')');
                if (ret.success) {
                    var Obj = ret.msg;
                    for (var i = 0; i < Obj.length; i++) {
                        var obj = $('.tabitem').eq(i);
                        if (i == 0) {
                            var mod = Obj[0];
                            var mod1 = Obj[1];
                            var tblHtml1 = '', tblHtml2 = '';
                            if (mod1.length > 0) {
                                if (mod.data.length > 4) {
                                    $(".tblbox1").width((mod.data.length / 4 * 100) + "%");
                                } else {
                                    $(".tblbox1").width("100%");
                                }
                                for (var j = 0; j < mod.data.length; j++) {
                                    var mod0 = mod.data[j];
                                    tblHtml1 = tblHtml1 + '<table style="width:' + (100 / mod.data.length) + '%;float:left;"><tbody><tr><td class="thead"><table border="0" cellpadding="0" cellspacing="0" class="ctable"><tbody><tr><td style="font-weight: bold;">' + mod0.name + '</td></tr></tbody><tbody class="importtable">';
                                    tblHtml2 = tblHtml2 + '<table style="width:' + (100 / mod.data.length) + '%;float:left;"><tbody><tr><td class="thead"><table border="0" cellpadding="0" cellspacing="0" class="ctable"><tbody><tr><td style="font-weight: bold;">' + mod0.name + '</td></tr></tbody><tbody class="importtable">';
                                    var obj1 = mod1[j];
                                    tblHtml1 = tblHtml1 + '<tr><td>' + obj1.CurrentAssets + '</td></tr><tr><td>' + obj1.Cash + '</td></tr><tr><td>' + obj1.JYMonetaryAssets + '</td></tr><tr><td>' + obj1.NoteReceivable + '</td></tr><tr><td>' + obj1.Receivables + '</td></tr><tr><td>' + obj1.AdvancePayment + '</td></tr><tr><td>' + obj1.InterestReceivable + '</td></tr><tr><td>' + obj1.DividendReceivable + '</td></tr><tr><td>' + obj1.OtherReceivables + '</td></tr><tr><td>' + obj1.Inventory + '</td></tr><tr><td>' + obj1.NonCurrentAssets + '</td></tr><tr><td>' + obj1.OtherCurrentAssets + '</td></tr><tr><td>' + obj1.TotalCurrentAssets + '</td></tr><tr><td>' + obj1.NCurrentAssets + '</td></tr><tr><td>' + obj1.CSMonetaryAssets + '</td></tr><tr><td>' + obj1.ExpireInvest + '</td></tr><tr><td>' + obj1.LongReceivables + '</td></tr><tr><td>' + obj1.LongEquityInvest + '</td></tr><tr><td>' + obj1.InvestRealEstate + '</td></tr><tr><td>' + obj1.FixedAssets + '</td></tr><tr><td>' + obj1.Construction + '</td></tr><tr><td>' + obj1.ConstMaterials + '</td></tr><tr><td>' + obj1.ClearAssets + '</td></tr><tr><td>' + obj1.BiologicalAssets + '</td></tr><tr><td>' + obj1.OilGasAssets + '</td></tr><tr><td>' + obj1.IntangibleAssets + '</td></tr><tr><td>' + obj1.ExploitExpend + '</td></tr><tr><td>' + obj1.Goodwill + '</td></tr><tr><td>' + obj1.LongoBligation + '</td></tr><tr><td>' + obj1.DeferredTaxAssets + '</td></tr><tr><td>' + obj1.OtherIlliquidAssets + '</td></tr><tr><td>' + obj1.TotalIlliquidAssets + '</td></tr><tr><td>' + obj1.TotalProperty + '</td></tr></tbody></table></td></tr></tbody></table>';
                                    tblHtml2 = tblHtml2 + '<tr><td>' + obj1.CurrentLia + '</td></tr><tr><td>' + obj1.ShortBorrM + '</td></tr><tr><td>' + obj1.FinancialLiability + '</td></tr><tr><td>' + obj1.NotePayable + '</td></tr><tr><td>' + obj1.AccountsPayable + '</td></tr><tr><td>' + obj1.AdvanceReceipt + '</td></tr><tr><td>' + obj1.PayrollPayable + '</td></tr><tr><td>' + obj1.TaxPayable + '</td></tr><tr><td>' + obj1.InterestPayabl + '</td></tr><tr><td>' + obj1.DividendsPayable + '</td></tr><tr><td>' + obj1.OtherPayables + '</td></tr><tr><td>' + obj1.NoncurrentLia + '</td></tr><tr><td>' + obj1.OtherCurrentLia + '</td></tr><tr><td>' + obj1.TotalCurrentLia + '</td></tr><tr><td>' + obj1.NCurrentLia + '</td></tr><tr><td>' + obj1.LongTermLoan + '</td></tr><tr><td>' + obj1.BondPayable + '</td></tr><tr><td>' + obj1.LongTermPayable + '</td></tr><tr><td>' + obj1.SpecialPayable + '</td></tr><tr><td>' + obj1.AnticipationLia + '</td></tr><tr><td>' + obj1.DeferredTaxLia + '</td></tr><tr><td>' + obj1.OtherNCurrentLia + '</td></tr><tr><td>' + obj1.TotalNCurrentLia + '</td></tr><tr><td>' + obj1.TotalLiability + '</td></tr><tr><td>' + obj1.Equity + '</td></tr><tr><td>' + obj1.Capital + '</td></tr><tr><td>' + obj1.CapitalReserve + '</td></tr><tr><td>' + obj1.TreasuryStock + '</td></tr><tr><td>' + obj1.SurplusReserves + '</td></tr><tr><td>' + obj1.UndistributedProfits + '</td></tr><tr><td>' + obj1.TotalEquity + '</td></tr><tr><td>&nbsp;</td></tr><tr><td>' + obj1.Total + '</td></tr></tbody></table></td></td></tr></tbody></table>';


                                }
                                $('.tbl1').html(tblHtml1);
                                $('.tbl2').html(tblHtml2);
                            }
                        } else if (i == 1) {
                            var mod = Obj[0];
                            var mod1 = Obj[2];
                            var tblHtml1 = '';
                            if (mod1.length > 0) {
                                if (mod.data.length > 6) {
                                    $(".tblbox2").width((mod.data.length / 6 * 100) + "%");
                                } else {
                                    $(".tblbox2").width("100%");
                                }
                                for (var j = 0; j < mod.data.length; j++) {
                                    var mod0 = mod.data[j];
                                    tblHtml1 = tblHtml1 + '<table style="width:' + (100 / mod.data.length) + '%;float:left;"><tbody><tr><td class="thead"><table border="0" cellpadding="0" cellspacing="0" class="ctable"><tbody><tr><td style="font-weight: bold;">' + mod0.name + '</td></tr></tbody><tbody class="importtable">';
                                    var obj1 = mod1[j];
                                    tblHtml1 = tblHtml1 + '<tr><td>' + obj1.Taking + '</td></tr><tr><td>' + obj1.OperatingCosts + '</td></tr><tr><td>' + obj1.SalesTax + '</td></tr><tr><td>' + obj1.SellMoney + '</td></tr><tr><td>' + obj1.ManagerMoney + '</td></tr><tr><td>' + obj1.FinancialMoney + '</td></tr><tr><td>' + obj1.PropertyLoss + '</td></tr><tr><td>' + obj1.AlterationIncome + '</td></tr><tr><td>' + obj1.InvestIncome + '</td></tr><tr><td>' + obj1.OtherInvestIncome + '</td></tr><tr><td>' + obj1.TradingProfit + '</td></tr><tr><td>' + obj1.NonbusinessIncome + '</td></tr><tr><td>' + obj1.NonbusinessOutlay + '</td></tr><tr><td>' + obj1.DisposalLoss + '</td></tr><tr><td>' + obj1.TotalProfit + '</td></tr><tr><td>' + obj1.IncomeTaxFee + '</td></tr><tr><td>' + obj1.NetMargin + '</td></tr><tr><td>' + obj1.EPS + '</td></tr><tr><td>' + obj1.BasicEPS + '</td></tr><tr><td>' + obj1.DilutedEPS + '</td></tr></tbody></table></td></tr></tbody></table>';
                                }
                                $('.tbl3').html(tblHtml1);
                            }
                        } else if (i == 2) {
                            var mod = Obj[0];
                            var mod1 = Obj[3];
                            var tblHtml1 = '';
                            if (mod1.length > 0) {
                                if (mod.data.length > 6) {
                                    $(".tblbox3").width((mod.data.length / 6 * 100) + "%");
                                } else {
                                    $(".tblbox3").width("100%");
                                }
                                for (var j = 0; j < mod.data.length; j++) {
                                    var mod0 = mod.data[j];
                                    tblHtml1 = tblHtml1 + '<table style="width:' + (100 / mod.data.length) + '%;float:left;"><tbody><tr><td class="thead"><table border="0" cellpadding="0" cellspacing="0" class="ctable"><tbody><tr><td style="font-weight: bold;">' + mod0.name + '</td></tr></tbody><tbody class="importtable">';
                                    var obj1 = mod1[j];
                                    tblHtml1 = tblHtml1 + '<tr><td>' + obj1.RunFlows + '</td></tr><tr><td>' + obj1.CollectSellLabourC + '</td></tr><tr><td>' + obj1.RefundsTaxe + '</td></tr><tr><td>' + obj1.OtherCollectC + '</td></tr><tr><td>' + obj1.TotalCash + '</td></tr><tr><td>' + obj1.PaySellLabourC + '</td></tr><tr><td>' + obj1.PayStaffC + '</td></tr><tr><td>' + obj1.PayTaxes + '</td></tr><tr><td>' + obj1.PayOhterC + '</td></tr><tr><td>' + obj1.OtherPayC + '</td></tr><tr><td>' + obj1.CashFlowNetAmo + '</td></tr><tr><td>' + obj1.InvestFlows + '</td></tr><tr><td>' + obj1.CollecInvestC + '</td></tr><tr><td>' + obj1.ColInvestIncomeC + '</td></tr><tr><td>' + obj1.CollPropertyNC + '</td></tr><tr><td>' + obj1.CollSubsidiaryNC + '</td></tr><tr><td>' + obj1.CollOtherC + '</td></tr><tr><td>' + obj1.CollTotalInvesC + '</td></tr><tr><td>' + obj1.PropertyPC + '</td></tr><tr><td>' + obj1.InvestPC + '</td></tr><tr><td>' + obj1.PaySubsidiaryNC + '</td></tr><tr><td>' + obj1.PayOtherC + '</td></tr><tr><td>' + obj1.PayTotalInvesC + '</td></tr><tr><td>' + obj1.InvestNC + '</td></tr><tr><td>' + obj1.FinancingFlows + '</td></tr><tr><td>' + obj1.CollInvestC + '</td></tr><tr><td>' + obj1.CollBorrowC + '</td></tr><tr><td>' + obj1.CollFinancingC + '</td></tr><tr><td>' + obj1.ToCollFinancingC + '</td></tr><tr><td>' + obj1.payDebtC + '</td></tr><tr><td>' + obj1.InterestOutlayC + '</td></tr><tr><td>' + obj1.PayFinancingC + '</td></tr><tr><td>' + obj1.ToPayFinancingC + '</td></tr><tr><td>' + obj1.FinancingNC + '</td></tr><tr><td>' + obj1.ChangeImpact + '</td></tr><tr><td>' + obj1.NetIncrease + '</td></tr><tr><td>' + obj1.SRemainingSum + '</td></tr><tr><td>' + obj1.ERemainingSum + '</td></tr></tbody></table></td></tr></tbody></table>';
                                }
                                $('.tbl4').html(tblHtml1);
                            }
                        }
                    }
                    $(".sub2 a").first().trigger("click");
                    $(".reportbox,.subtitlespt").show();
                    var Json = LoadChartJson();
                    TempJson = Json;
                    Showline("Data1", "1", Json);
                    Showline("Data2", "2", Json);
                    Showline("Data3", "3", Json);
                    Showline("Data4", "4", Json);
                    Showline("Data5", "5", Json);
                    Showline("Data6", "6", Json);
                    Showline("Data7", "7", Json);

                    $(".importtable td").each(function (i, v) {
                        $(v).html(comdify($(v).text()));
                    });
                } else {
                    if (ret.msg != "") {
                        alert(ret.msg);
                    }
                }
            }
        });
    };
    LoadChartJson = function () {
        var JsonData = '';
        $.ajax({
            type: "POST",
            dataType: "text",
            async: false,
            url: 'ZJDetail.aspx', //提交到一般处理程序请求数据
            data: { 't': 'GetChart', "Code": "<%=Code %>", "SType": $('#cblx').val(), "Year": $('#nian').val(), "Year2": $('#nian2').val() },
            success: function (data) {
                JsonData = data;
            }
        });
        return JsonData;
    }
    Showline = function (line, dname, JsonData) {
        if (JsonData != '') {
            var retValue = eval('(' + JsonData + ')');
            if (retValue.success == true) {
                var legenddata = [];

                var TempLen = retValue.YearStr;
                var seriesdata_sub1 = [];

                for (var i = 0; i < TempLen.length; i++) {
                    legenddata.push(TempLen[i].data);
                }
                var retData = null;
                var title = '';
                if (dname == '1') {
                    title = ['资产总额'];
                    retData = retValue.Data1;
                } else if (dname == '2') {
                    title = ['营业收入'];
                    retData = retValue.Data2;
                } else if (dname == '3') {
                    title = ['净利润'];
                    retData = retValue.Data3;
                } else if (dname == '4') {
                    title = ['销售净利率'];
                    retData = retValue.Data4;
                } else if (dname == '5') {
                    title = ['净资产收益率'];
                    retData = retValue.Data5;
                } else if (dname == '6') {
                    title = ['资产负债率'];
                    retData = retValue.Data6;
                } else if (dname == '7') {
                    title = ['速动比例'];
                    retData = retValue.Data7;
                }

                for (var j = 0; j < TempLen.length; j++) {
                    seriesdata_sub1.push(retData[j].data);
                }

                var seriesdata = [{ name: title.join(''), type: chattype, data: [seriesdata_sub1.join(',')] }];
                seriesdata = [{
                    name: title.join(''),
                    type: chattype,
                    data: seriesdata_sub1
                }];
                var yAxisdate = [
                           {
                               type: 'value',
                               name: $('#cblx').val(),
                               axisLabel: {
                                   formatter: function (v) {
                                       if (v > 10000 || v < -10000) {
                                           if (v > 100000000 || v < -100000000)
                                               return (v / 100000000) + '亿';
                                           else
                                               return (v / 10000) + '万';
                                       } else {
                                           return v;
                                       }
                                   }
                               }
                           },
                            {
                                type: 'value',
                                name: $('#cblx').val(),
                                axisLabel: {
                                    formatter: function (v) {
                                        if (v > 10000 || v < -10000) {
                                            if (v > 100000000 || v < -100000000)
                                                return (v / 100000000) + '亿';
                                            else
                                                return (v / 10000) + '万';
                                        } else {
                                            return v;
                                        }
                                    }
                                }
                            }

                ];

                showlines(line, title, yAxisdate, seriesdata, legenddata);
            }
        }
    }

    showlines = function (objectid, legenddata, yAxisdate, seriesdata, xAxisdata) {
        var dom = document.getElementById(objectid);
        var myChart = echarts.init(dom, 'macarons');
        option = {
            calculable: true,
            legend: {
                data: legenddata
            },
            tooltip: {
                showDelay: 100,//显示延时，添加显示延时可以避免频繁切换
                hideDelay: 500,//隐藏延时
                enterable: true,
                trigger: 'axis'
            },
            grid: {
                left: '5%',
                right: '5%', 
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxisdata
                    //data:['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
                }
            ],
            yAxis: yAxisdate,
            series: seriesdata
        };
        // 为echarts对象加载数据 
        myChart.setOption(option);
    }
</script>


