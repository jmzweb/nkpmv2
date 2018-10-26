<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainLC.aspx.cs" Inherits="NTJT.Web.MainLC" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>项目管理系统</title>
    <link href="SysFolder/Extension/css/mainlc.css" rel="stylesheet" />
    <link href="SysFolder/Extension/iconfont/iconfont.css" rel="stylesheet" />
    <script src="js/jQuery-2.1.4.min.js"></script>
    <script src="SysFolder/Extension/js/echarts.min.js"></script>
    <script src="SysFolder/Extension/js/echarts-henan.js"></script>
    <script src="SysFolder/Extension/js/echarts-china.js"></script>
    <script src="SysFolder/Extension/js/echarts-sk-westeros.js"></script>
    <script type="text/javascript" src="js/layer/3.0.2/layer.js"></script>
</head>
<body>
    <h1 class="pmlogo"></h1>
    <div class="fixright">
        <select id="PosList" name="PosList">
            <%=sbPosList %>
        </select>
        <a href="javascript:void(0)" openlayer="ChangePass.aspx" title="修改密码"><i class="iconfont">&#xe6ea;</i></a>
        <a href="default.aspx?logout=1" title="退出系统"><i class="iconfont">&#xe627;</i></a>
    </div>
    <h3 class="maintitle"><b>项目管理系统</b></h3>
    <div class="mainechartbox">
        <div class="mainlcbox">
            <i class="iconfont iconfontsj lefttopi">&#xe6f1;</i>
            <i class="iconfont iconfontsj righttopi">&#xe6f1;</i>
            <i class="iconfont iconfontsj leftbottomi">&#xe6f1;</i>
            <i class="iconfont iconfontsj rightbottomi">&#xe6f1;</i>
            <div id="main"></div>
        </div>
    </div>
    <div class="leftbox">
        <div class="hfbox">
            <dl class="lcbox mb30 brb">
                <dt class="titlelcbox"><a href='javascript:void(0)' openlayer='SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_F_FundInfo&funCode=JJKCK&checkoutshow=1&relationId=<%=relationId %>'><b>基金总览</b></a></dt>
                <dd>
                    <i class="iconfont iconfontsj lefttopi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj righttopi">&#xe6f1;</i>
                    <div class="mkshow">
                        <span>基金数量</span><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/echartService.aspx?t=11&relationId=<%=relationId %>"><b style=""><font class="jjsldata"></font> 支</b></a>
                        <span>基金规模</span><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/echartService.aspx?t=12&relationId=<%=relationId %>"><b style=""><font class="jjgmdata"></font> 亿</b></a>
                    </div>
                    <div class="clear"></div>
                    <ul class="jjshow">
                        <li><a href="javascript:void(0)" openlayer="WorkAsp/Report/FAllReportmax.aspx?&relationId=<%=relationId %>"><b style=""><font class="sjdwdata"></font>亿</b><p>实际到位</p>
                        </a>
                        </li>
                        <li><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/echartService.aspx?t=14&relationId=<%=relationId %>"><b style=""><font class="ytjedata"></font>亿</b><p>已投金额</p>
                        </a>
                        </li>
                        <li><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/echartService.aspx?t=15&relationId=<%=relationId %>"><b style=""><font class="jjfpdata"></font>亿</b><p>基金分配</p>
                        </a>
                        </li>
                    </ul>
                    <div class="clear"></div>
                </dd>
            </dl>
            <dl class="lcbox brt">
                <dd class="jjlist">
                    <i class="iconfont iconfontsj leftbottomi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj rightbottomi">&#xe6f1;</i>
                    <table class="ctable" border="0" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td>基金名称  <a href="javascript:void(0)" openlayer="WorkAsp/Report/YTBLReport.aspx?relationId=<%=relationId %>">更多&gt;&gt;</a></td>
                                <td style="width: 200px;">已投比例</td>
                            </tr>
                        </thead>
                        <tbody class="jjlistdata">
                        </tbody>
                    </table>
                </dd>
            </dl>
        </div>
    </div>
    <div class="rightbox">
        <div class="hfbox">
            <dl class="lcbox mb30 brb">
                <dt class="titlelcbox"><a href='javascript:void(0)' openlayer='SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_P_ProjectInfo&condition=&funCode=XMKCK&checkoutshow=1&relationId=<%=relationId %>'><b>项目总览</b></a></dt>
                <dd>
                    <i class="iconfont iconfontsj lefttopi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj righttopi">&#xe6f1;</i>
                    <div class="mkshow">
                        <span>储备</span><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/AppQuery.aspx?TblName=Q_PM_CompanyInfoGQ&condition=Tag=11&funCode=CBXMCK&checkoutshow=1&relationId=<%=relationId %>"><b style=""><font class="cbkdata"></font> 个</b></a>
                        <span>项目</span><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_P_ProjectInfo&condition=PROJECTTYPE=[QUOTES]股权类[QUOTES]&funCode=XMKCK&checkoutshow=1&relationId=<%=relationId %>"><b style=""><font class="xmkdata"></font> 个</b></a>
                    </div>
                    <div class="clear"></div>
                    <ul class="jjshow">
                        <li><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_P_ProjectInfo&condition=ProjectStage=[QUOTES]拟投[QUOTES] and PROJECTTYPE=[QUOTES]股权类[QUOTES]&funCode=XMKCK&checkoutshow=1&relationId=<%=relationId %>"><b style=""><font class="ntkdata"></font>个</b><p>拟投</p>
                        </a>
                        </li>
                        <li><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_P_ProjectInfo&condition=ProjectStage=[QUOTES]已投[QUOTES] and PROJECTTYPE=[QUOTES]股权类[QUOTES]&funCode=XMKCK&checkoutshow=1&relationId=<%=relationId %>"><b style=""><font class="ytkdata"></font>个</b><p>已投</p>
                        </a>
                        </li>
                        <li><a href="javascript:void(0)" openlayer="SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_P_ProjectInfo&condition=ProjectStage=[QUOTES]退出[QUOTES] and PROJECTTYPE=[QUOTES]股权类[QUOTES]&funCode=XMKCK&checkoutshow=1&relationId=<%=relationId %>"><b style=""><font class="tckdata"></font>个</b><p>退出</p>
                        </a>
                        </li>
                    </ul>
                    <div class="clear"></div>
                </dd>
            </dl>
            <dl class="lcbox brt">
                <dd class="xmlist">
                    <i class="iconfont iconfontsj leftbottomi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj rightbottomi">&#xe6f1;</i>
                    <table class="ctable" border="0" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td>最新项目动态&nbsp;&nbsp;<a href="javascript:void(0)" openlayer="WorkAsp/Report/FAllReportmaxNew.aspx?relationId=<%=relationId %>&tt=股权类">更多>></a></td>
                                <td style="width: 85px;">所属公司</td>
                                <td style="width: 50px;">日期</td>
                            </tr>
                        </thead>
                        <tbody class="xmlistdata">
                        </tbody>
                    </table>
                </dd>
            </dl>
        </div>
    </div>
    <div class="bottombox">
        <div class="showother">
            <a href="javascript:void(0)" openlayer="SysFolder/Extension/ShareStructJJ.aspx?relationId=<%=relationId %>"><i class="iconfont">&#xe6d9;</i>基金关系图</a>
            <a href="javascript:void(0)" openlayer="SysFolder/Extension/ShareStruct.aspx?relationId=<%=relationId %>"><i class="iconfont">&#xe652;</i>股权结构图</a>
            <a href="MainLCZBDB.aspx?relationId=<%=relationId %>"><i class="iconfont">&#xe62e;</i>担保系统</a>
            <a href="MainLCZBZL.aspx?relationId=<%=relationId %>"><i class="iconfont">&#xe62b;</i>租赁系统</a>
            <a href="javascript:void(0)" openlayer="WorkAsp/Report/RepMenu.aspx"><i class="iconfont">&#xe671;</i>统计报表</a>
        </div>
        <div class="fxinfo lcbox">
            <dl class="">
                <dt class="titlelcbox"><a href='javascript:void(0)' openlayer='SysFolder/AppFrame/AppQuery.aspx?TblName=Q_PM_P_RiskInfo&condition=ProjectStage!=[QUOTES]退出[QUOTES] and PROJECTTYPE=[QUOTES]股权类[QUOTES]&checkoutshow=1&relationId=<%=relationId %>'><b>风险事件</b></a></dt>
                <dd>
                    <i class="iconfont iconfontsj lefttopi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj righttopi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj leftbottomi">&#xe6f1;</i>
                    <i class="iconfont iconfontsj rightbottomi">&#xe6f1;</i>
                    <ul class="fxshow">
                    </ul>
                    <ul class="fxlist">
                    </ul>
                    <div class="clear"></div>
                </dd>
            </dl>
        </div>
    </div>
    <script type="text/javascript">
        var ajaxtt = "ss";
    </script>
    <script src="SysFolder/Extension/js/mainlc.js"></script>
</body>
</html>
