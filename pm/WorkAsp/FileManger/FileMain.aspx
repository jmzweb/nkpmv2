<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileMain.aspx.cs" Inherits="NTJT.Web.WorkAsp.FileManger.FileMain" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script> 
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>

    <link href="../../css/filemanger.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../Static/mainpm/iconfont/iconfont.css" />
</head>
<body>
    <% 
        string btnname = "<i class=\"iconfont\">&#xe6b1;</i>管理";
        StringBuilder sb = new StringBuilder();
        if (!string.IsNullOrEmpty(GetParaValue("readonly")))
        {
            btnname = "<i class=\"iconfont\">&#xe62d;</i>查看";
        }
        string[] pointid = new string[] { "all" };
        string[] pointstr = new string[] { "all" };
        if (!string.IsNullOrEmpty(GetParaValue("reportall")))////统计模式 显示所有目录及统计数量
        {
            pointid = new string[] { "50", "51", "52", "11", "30", "13", "14", "15", "16", "17" };
            pointstr = new string[] { "股权类项目", "担保项目", "融资租赁项目", "储备项目", "基金", "基金管理机构", "律所", "会所", "资产评估机构", "券商" };
        }
        for (var pi = 0; pi < pointid.Length;pi++ )
        {
            var drh3s = dth3.Select("1=1");
            var pointidi = pointid[pi];
            if (pointidi != "all")
            {
                drh3s = dth3.Select("SystemType='" + pointidi + "'");
                sb.Append("<div class='dirgroup' systemtype='" + pointidi + "' systemtext='" + pointstr[pi] + "'>"); 
            } 
            foreach (DataRow drh3 in drh3s)
            {
                sb.Append("<div class='diritem' systemtype='" + drh3["SystemType"] + "'><h3><i class=\"iconfont\">&#xe6e8;</i>&nbsp;<span>" + drh3["FunctionalStage"] + "</span></h3>");
                foreach (DataRow drpoint in dtpoint.Select("SystemType='" + drh3["SystemType"] + "' and FunctionalStageCode='" + drh3["FunctionalStageCode"] + "'"))
                {
                    sb.Append("<h4><i class=\"iconfont\">&#xe6f0;</i>&nbsp;" + drpoint["FunctionalNode"] + "</h4>");
                    sb.Append("<table class=\"ctable\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><thead><tr class=\"trth\"><td class=\"coldesc w3\">目录名称</td><td class=\"coldesc\">目录说明</td><td class=\"coldesc wfs3\">档案数量</td><td class=\"coldesc tdaddbtn\">操作</td></tr></thead><tbody>");

                    foreach (DataRow drdir in dtdir.Select("PointID='" + drpoint["PointID"] + "'"))
                    {
                        sb.Append("<tr><td>" + drdir["CatalogName"] + "</td><td>" + drdir["SpecialVersion"] + "</td><td>" + drdir["fcount"] + "</td><td><a href='javascript:void(0)' class='openfilelist' catalogcode='" + drdir["CatalogCode"] + "' catalogname='" + drdir["CatalogName"] + "'>" + btnname + "</a></td></tr>");
                    }

                    sb.Append("</tbody></table>");
                }
                sb.Append("</div>");
            }
            if (pointidi != "all")
            {
                sb.Append("</div>");
            }
        }
    %>
    <div class="hidesmall" style="display: none;">
        <div class="searchbox"><input type="text" id="searchkey" placeholder="请输入关键字"/><a class="searchbtn" title="查找"><i class="iconfont">&#xe62d;</i>查找</a></div>
        <div class="sideline"></div>
        <div class="sidebarbox">
            <ul class="sidebar">
            </ul> 
            <ul class="sidebarss">
            </ul>
        </div>
    </div>
    <div class="dirlist">
        <%=sb.ToString() %>
    </div>
    <%=log %>
</body>
</html>
<script type="text/javascript">
    $(function () {
        var oneline = 125;
        var twoline = 165;
        if ($(".dirgroup").length > 1) {//统计模式 
            $(".hidesmall").show();
            $(".sidebar").empty();
            $(".dirgroup").each(function (i, v) {
                $(".sidebar").append("<li systemtype='" + $(v).attr("systemtype") + "'>" + $(v).attr("systemtext") + "</li>");
            });
            $(".sidebar li").click(function () {
                var $t = $(this);
                $(this).addClass("select").siblings().removeClass("select");
                $(".dirgroup").eq($t.index()).show().siblings().hide();
                $(".sidebarss").empty().show();
                $(".diritem[systemtype='" + $t.attr("systemtype") + "']").each(function (i, v) {
                    $(".sidebarss").append("<li>" + $(v).find("h3 span").text() + "</li>");
                });
                $(".sidebarss li").click(function () {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".dirgroup").eq($t.index()).children(".diritem").eq($(this).index()).show().siblings().hide();
                });
                $(".sidebarss li").first().trigger("click");
                $(".dirlist").height($(window).height() - twoline);
                $(".sideline").height(twoline);

                //还原搜索前状态
                $(".ssfocus").removeClass("ssfocus");
                $(".ssfocusa").remove();
                searchkey = "";
                searchlength = 0;
                searchindex = 0;
            });
            $(".sidebar li").first().trigger("click");
        } else {
            $(".sidebarss,.searchbox").hide();
            if ($(".diritem").length > 1) {
                oneline = 55;
                //如果有5个以上目录  就增加选项卡切换
                $(".hidesmall").show();
                $(".sidebar").empty();
                $(".diritem").each(function (i, v) {
                    $(".sidebar").append("<li>" + $(v).find("h3 span").text() + "</li>");
                });
                $(".sidebar li").click(function () {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".diritem").eq($(this).index()).show().siblings().hide();
                });
                $(".sidebar li").first().trigger("click");
                $(".dirlist").height($(window).height() - oneline);
                $(".sideline").height(oneline);
                $(".sidebarbox").css({"top":"0px"});
            }
        }
        var searchkey = "";
        var searchlength = 0;
        var searchindex = 0;
        $('.searchbtn').click(function () {//查找关键字
            if (searchkey != $("#searchkey").val()) {
                searchkey = $("#searchkey").val();
                searchlength = $("h3:contains('" + searchkey + "'),h4:contains('" + searchkey + "'),td:contains('" + searchkey + "')").length;
                searchindex = 0;
            }
            if (searchkey) {
                $(".sidebarss").hide();
                $(".sidebar li.select").removeClass("select");
                $(".dirgroup").show();
                $(".diritem").show();
                $(".dirlist").height($(window).height() - oneline);
                $(".sideline").height(oneline);

                if (searchindex < searchlength) {
                    var $tg = $("h3:contains('" + searchkey + "'),h4:contains('" + searchkey + "'),td:contains('" + searchkey + "')").eq(searchindex);
                    $(".ssfocus").removeClass("ssfocus");
                    $(".ssfocusa").remove();
                    $tg.addClass("ssfocus").append("<a class='ssfocusa' name='ssfocusa'></a>"); 
                    $(".sidebar li").eq($tg.parents(".dirgroup").index()).addClass("select");
                    window.location.hash = "#ssfocusa";
                    //var stop = $tg.position().top;
                    //$(".dirlist").scrollTop(stop-100);
                    searchindex++;
                }
            }
        });
        $("#searchkey").keydown(function (e) {//回车切换焦点
            if (e.keyCode == 13) {
                $('.searchbtn').trigger("click");
            }
        });
        $('.openfilelist').click(function () {
            var $t = $(this);
            var width = window.innerWidth - 20;
            var height = window.innerHeight - 20;
            var url = "filelist.aspx?SystemType=<%=cproSystemType%>&CorrelationCode=<%=cproCorrelationCode%>&CorrelationName=<%=cproCorrelationName%>&CatalogCode=" + $t.attr("catalogcode") + "&CatalogName=" + $t.attr("catalogname") + "";
            var isreadonly = '<%=GetParaValue("readonly")%>';
            if (isreadonly) {
                var condition = '';
                if ('<%=cproSystemType%>' != '') {
                    condition += " and SystemType=[QUOTES]<%=cproSystemType%>[QUOTES]";
                }
                if ('<%=cproCorrelationCode%>' != '') {
                    condition += " and CorrelationCode=[QUOTES]<%=cproCorrelationCode%>[QUOTES]";
                }
                url = "../../SysFolder/AppFrame/AppQuery.aspx?TblName=T_PM_T_FileInfo&condition=CatalogCode=[QUOTES]" + $t.attr("catalogcode") + "[QUOTES]" + condition + "&checkoutshow=1&hidedetail=1";
                //等权限做好以后 需要在这里设置一下 查看文档的权限要遵循查看企业\基金\项目的权限控制
            }
            layer.open({
                title: '附件',
                closeBtn: 1,
                resize: true,
                isOutAnim: true,
                offset: ['10px', '10px'],
                type: 2,
                area: [width + 'px', height + 'px'],
                fixed: false, //不固定
                maxmin: false,
                content: url,
                end: function () {
                    if ($t.text().indexOf("管理") > -1) {//只有管理时 回调刷新 否则不用刷新
                        window.location.href = window.location.href + "&tm=" + new Date().getTime();
                    }
                }
            });
        });
    });
</script>
