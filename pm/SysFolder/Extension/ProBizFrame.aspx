<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BizFrame.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.BizFrame" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <link href="css/bizframe.css" rel="stylesheet" />
    <script src="js/bizframe.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.sidebar').find('li').click(function () {
                $(this).addClass('sidebar-current').siblings().removeClass('sidebar-current');
                $("#tabs_iframe").attr("src", $(this).find('a').attr("href"));
            });
            $("#tabs_iframe").attr("src", $('.sidebar a').attr("href"));//默认打开第一个 
        });
    </script>
    <title></title>
</head>
<body>
    <a class='closebtn' href="javascript:" onclick="_appClose();">关闭</a>
    <div class="main-area ui-v5">
        <div id="new-sidebar" class="bcc-sidebar-box new-sidebar-box">
            <%DataTable dtpoint = getProPoint();%>
            <script type="text/javascript">
                $(function () {
                    var ProjectType = '<%=ProjectType%>';
                    switch (ProjectType) {
                        case "股权类":
                            $(".main-area .sidebar li.dbl").hide();
                            $(".main-area .sidebar li.zll").hide();
                            break;
                        case "担保类":
                            $(".main-area .sidebar li.gql").hide();
                            $(".main-area .sidebar li.tq a").text("保前事件记录");
                            $(".main-area .sidebar li.th a").text("保后事件记录");
                            break;
                        case "融资租赁类":
                            $(".main-area .sidebar li.gql").hide();
                            $(".main-area .sidebar li.tq a").text("租前事件记录");
                            $(".main-area .sidebar li.th a").text("租中事件记录");
                            $(".main-area .sidebar li.tc a").text("租后事件记录");
                            break;
                    };
                });
            </script>
            <%
                if (dtpoint.Rows.Count > 0)
                {
            %>
            <style type="text/css">
                .linepoint li { width:<%=100.00 / dtpoint.Rows.Count%>%;}
            </style>

            <%
                    if (Request["readonly"] == null)
                    {%>
            <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
            <script type="text/javascript">
                function CloseLayer() {
                    setTimeout(function () { layer.close(LayerTemp) }, 300);
                }
                var LayerTemp = 0;
                $(function () {
                    <%if (ProjectStage == "拟投")
                      {%>
                    $(".linepoint li.select通过,.linepoint li.select暂缓,.linepoint li.select终止").last().prevAll(".linepoint li.select").addClass("select跳过");
                    <%}%>
                    $(".linepoint a[openlayer]").click(function () {
                        var $t = $(this);
                        var url = $t.attr("openlayer");

                        var width = $(window).width();
                        var height = $(window).height();
                        LayerTemp = layer.open({
                            title: false,
                            closeBtn: false,
                            resize: true,
                            isOutAnim: true,
                            offset: ['0px', '0px'],
                            type: 2,
                            area: [width + 'px', height + 'px'],
                            fixed: false, //不固定
                            maxmin: false,
                            content: url,
                            end: function () {
                                window.location.href = window.location.href + "&tm=" + new Date().getTime();
                            }
                        });
                    });
                });
            </script>
            <div class="linetitle" id="linetitle<%=ProjectStage%>">
                <%if (ProjectStage == "拟投")
                  {%>
                <style type="text/css">
                    .closebtn { top: 140px; }

                    @media only screen and (max-width:1600px) {
                        .closebtn { top: 120px; }
                    }
                </style>
                <ul class="lpdemo">
                    <li class="">未开始</li>
                    <li class="select通过">通过</li>
                    <li class="select跳过">跳过</li>
                    <li class="select暂缓">暂缓</li>
                    <li class="select终止">终止</li>
                </ul>
                <%}
                  else
                  {%>
                <style type="text/css">
                    .closebtn { top: 120px; }

                    @media only screen and (max-width:1600px) {
                        .closebtn { top: 100px; }
                    }
                </style>
                <ul class="lpdemo">
                    <li class="">事件快速记录</li>
                </ul>
                <%}%>
            </div>
            <div class="clear"></div>
            <div class="linepoint" id="linepoint<%=ProjectStage%>">
                <ul>
                    <%=dtrender(dtpoint, "<li class='select#REVIEWERSTATE#'><p></p><a href='javascript:void(0)' openlayer='../AppFrame/AppInput.aspx?#TBLPARA#&biz=1&maincol=CorrelationCode&cpro=CorrelationCode=" + GetParaValue("CorrelationCode") + "^1|Node=#FUNCTIONALNODE#^1' target='tabs_iframe' title='点击添加 #FUNCTIONALNODE# 事件记录' >#FUNCTIONALNODE#</a><span><i>#STARTTIME#</i></span></li>")%>
                </ul>
            </div>
            <div class="clear"></div>
            <%}
                    else//只读状态下 只显示拟投的节点 其他不显示
                    {
                        if (ProjectStage == "拟投")
                        {
            %>
            <style type="text/css">
                .closebtn { top: 140px; }

                @media only screen and (max-width:1600px) {
                    .closebtn { top: 120px; }
                }
            </style>
            <div class="linetitle">
                <ul class="lpdemo">
                    <li class="">未开始</li>
                    <li class="select通过">通过</li>
                    <li class="select跳过">跳过</li>
                    <li class="select暂缓">暂缓</li>
                    <li class="select终止">终止</li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="linepoint">
                <ul>
                    <%=dtrender(dtpoint, "<li class='select#REVIEWERSTATE#'><p></p><a href='javascript:void(0)'>#FUNCTIONALNODE#</a><span><i>#STARTTIME#</i></span></li>")%>
                </ul>
            </div>
            <div class="clear"></div>
            <%
                        }
                    }
                } %>
            <div class="sidebar-wrap sidebar-wrap-l1" id="sidebar<%=ProjectStage %>">
                <ul class="sidebar submenu">
                    <%=render(dt, "<li class='menu-item menu-item-common #DesktopImage#'><a href='" + ResolveUrl("~") + "#LinkFile#&hideclose=1' target='tabs_iframe'>#FunName#</a></li>") %>
                </ul>
            </div>
        </div>

        <div id="main" class="ui-v5">
            <div class="bcc-instance bcc-main-wrap main-wrap-new">
                <div class="content-wrap">
                    <iframe id="tabs_iframe" name="tabs_iframe" allowtransparency="true" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" style="width: 100%; height: 100%;"></iframe>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
