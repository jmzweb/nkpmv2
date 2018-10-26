<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowList.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>流程新建</title>
	<link href="../../css/appStyle.css" type="text/css" rel="stylesheet" />
	<link href="../../css/common.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>

	<style type="text/css">
	    dl{
	        margin-bottom:20px;
	    }
		dt{
			margin-bottom:2px;
			cursor:pointer;
			font-size:11pt;
			padding-left:20px;
			background:url(../../img/Workflow/ico6.gif) no-repeat left 2px;
		}
		dd{
			margin-left:0px;
		}
		dd em{
		    display:inline-block;
		    width:20px;
		    height:18px;
			background:url(../../img/Workflow/ag.gif) no-repeat left center;
			cursor:pointer;
		    }
		dd em.nofav{
			background:url(../../img/doc/star-gray.png) no-repeat left center;
		    }
		dd em.infav{
			background:url(../../img/doc/star.png) no-repeat left center;
		    }
		dd em.onfav{
			background:url(../../img/doc/star.png) no-repeat left center;
		    }
		dd a{
			text-decoration:none;
			font-size:13px;
			color:gray;
			line-height:22px;
			padding-bottom:0px;
			border-bottom: solid gray 0px;
		}
		dd a:hover{
			text-decoration:none;
			color:blue;
			padding-bottom:1px;
			border-bottom: solid blue 1px;
		}
		dd span{
			margin-left:5px;
			color:red;
			font-weight:bold;
			font-size:14px;
			cursor:hand;
		}
		dd span.flowchart
		{
			color:Gray;
			font-weight:normal;
			font-size:12px;
			cursor:pointer;
			}
		.wrapper
		{
			margin:3px 15px;
			border:solid #bbb 1px;
			padding:10px;
		}
		.clock{background:url(../../img/common/clock.png) no-repeat left 2px;color:Blue;}
		.star {background:url(../../img/doc/folder_heart.png) no-repeat left 2px;color:Blue;}
		body
		{
			background:#fafafa;
			height:auto;
		}
		table{table-layout:fixed;}
		#navMenu{line-height:30px;}
		#navMenu a{line-height:14px;}
	</style>

</head>
<body scroll="auto">
    <form id="form1" runat="server">

    <div id="navPanel" style="background:#fafafa;border-bottom-width:0px;">
	    <div id="navMenu">
		    <a class="active" href="javascript:" ><span>常用流程</span></a>
		    <a href="javascript:" ><span>所有流程列表</span></a>
	    </div>
    </div>
    <div class="wrapper">
        <table width="100%">
		<tr>
			<td valign="top"><%=sbLast %></td>
			<td valign="top"><%=sbFavorite %></td>
		</tr>
	    </table>
    </div>
    <div class="wrapper hidden">
	<table width="100%">
		<tr>
			<td valign="top"><%=sb %></td>
			<td valign="top"><%=sb2 %></td>
			<td valign="top"><%=sb3 %></td>
		</tr>
	</table>
    </div>

    </form>
</body>
</html>
	<script type="text/javascript">
	    var _curClass = EZ.WebBase.SysFolder.WorkFlow.FlowList;
	    jQuery(function () {

	        $("#navMenu a").click(function () {
	            $("#navMenu a.active").removeClass("active");
	            $(this).addClass("active");
	            $(".wrapper").hide();
	            $(".wrapper").eq($(this).index()).show();
	        });

	        var fnum = jQuery(".wrapper:eq(0) dd").length;
	        if (fnum == 0) {
	            $("#navMenu a:eq(1)").click();
	        }

	        jQuery("em.nofav").live("mouseover", function () {
	            $(this).removeClass("nofav").addClass("onfav");
	        });
	        jQuery("em.onfav").live("mouseout", function () {
	            var fav = $(this).attr("fav");
	            if (fav == "nofav")
	                $(this).removeClass("onfav").addClass("nofav");
	        });

	        jQuery("em.nofav__").click(function (e) {
	            var wfcode = $(this).attr("wfcode");
	            var ret = _curClass.UpdateFavorite("<%=EmployeeID %>", wfcode, "1");
	            if (ret.error) {
	                $.noticeAdd({ text: '保存时出现异常！', type: 'error' });
	            }
	            else {
	                if (ret.value == -1) {
	                    $.noticeAdd({ text: '已经收藏过了！' });
	                }
	                else {
	                    $.noticeAdd({ text: '已经成功收藏！' });
	                    $(this).removeClass("nofav").addClass("infav").attr("fav", "infav");
	                    var arr = [];
	                    arr.push("<dd wfcode='", wfcode, "'><em class='infav' wfcode='", wfcode, "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>");
	                    arr.push("<a href=\"javascript:newflow('", $(this).attr("wfid"), "','", $(this).attr("appname"), "')\" >", $(this).attr("wfname"), "</a>");
	                    arr.push("<span onclick=\"javascript:openchart('", $(this).attr("wfid"), "')\" class='flowchart'>(流程图)</span>");
	                    arr.push("</dd>");
	                    $(".dlstar").append(arr.join(""));
	                    freshNum();
	                }
	            }
	            e.stopPropagation();
	        });
	        jQuery("em").live("click", function () {

	            var wfcode = $(this).attr("wfcode");
	            if ($(this).hasClass("infav")) {
	                var ret = _curClass.UpdateFavorite("<%=EmployeeID %>", wfcode, "0");
	                if (ret.error) {
	                    $.noticeAdd({ text: '保存时出现异常！', type: 'error' });
	                }
	                else {
	                    //$(this).removeClass("infav").addClass("nofav").attr("fav", "nofav");
	                    $.noticeAdd({ text: '已经取消收藏！' });

	                    $(".dlstar>dd[wfcode='" + wfcode + "']").remove();
	                    $("em[wfcode='" + wfcode + "']").removeClass("infav").addClass("nofav").attr("fav", "nofav");
	                    freshNum();
	                }
	            }
	            else {
	                var ret = _curClass.UpdateFavorite("<%=EmployeeID %>", wfcode, "1");
	                if (ret.error) {
	                    $.noticeAdd({ text: '保存时出现异常！', type: 'error' });
	                }
	                else {
	                    if (ret.value == -1) {
	                        $.noticeAdd({ text: '已经收藏过了！' });
	                    }
	                    else {
	                        $.noticeAdd({ text: '已经成功收藏！' });
	                        $(this).removeClass("nofav").addClass("infav").attr("fav", "infav");
	                        var arr = [];
	                        arr.push("<dd wfcode='", wfcode, "'><em class='infav' wfcode='", wfcode, "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>");
	                        arr.push("<a href=\"javascript:newflow('", $(this).attr("wfid"), "','", $(this).attr("appname"), "')\" >", $(this).attr("wfname"), "</a>");
	                        arr.push("<span onclick=\"javascript:openchart('", $(this).attr("wfid"), "')\" class='flowchart'>(流程图)</span>");
	                        arr.push("</dd>");
	                        $(".dlstar").append(arr.join(""));
	                        freshNum();
	                    }
	                }
	                e.stopPropagation();
                }
	        });

	        jQuery("dt").attr("title", "点击标题查看流程");
	        jQuery("dl").each(function () {
	            var n = $("dd", this).length;
	            if (n > 0) {
	                $("dt", this).append("<span style='color:red;font-size:12px;'>&nbsp;&nbsp;(<b>" + n + "</b>)</span>");
	            }
	        });
	        jQuery("dt").click(function () {
	            var dl = $(this).parent();
	            $("dd", dl).toggle();
	        });
	    });

	    function openlist(tblname) {

	    }

	    function newflow(wfid, tblname) {
	        var d = new Date();
	        //window.top.createTab("Newflow_" + wfid, "发起新流程", 'SysFolder/Workflow/Newflow.aspx?workflowid=' + wfid + "&rnd=" + d.getTime(), "");
	        var url = 'Newflow.aspx?workflowid=' + wfid + "&rnd=" + d.getTime();
	        window.open(url, '_blank');
	        return;
	        url = 'SysFolder/workflow/Newflow.aspx?workflowid=' + wfid + "&rnd=" + d.getTime();
	        var layIndex = window.top.layer.open({
	            type: 2,
	            title: '发起审批任务',
	            maxmin: true,
	            area: ['1000px', '600px'],
	            content: url
	        });
	        window.top.layer.full(layIndex);

	    }
	    function openchart(wfid) {
	        var d = new Date();
	        var url = 'FlowChart.aspx?workflowid=' + wfid + "&rnd=" + d.getTime();
	        //window.open(url, '_blank', 'top=0,left=0,width=1000,height=700,resizable=yes,scrollbars=yes');
	        var layIndex = layer.open({
	            type: 2,
	            title: '查询流程图',
	            maxmin: true,
	            offset: '0px',
	            shade: false, 
	            area: ['1000px', '520px'],
	            content: url
	        });
	        layer.full(layIndex);
	    }

	    function freshNum() {
	        var n = $(".dlstar>dd").length;
	        if (n > 0) {
	            $(".dlstar>dt").html("我收藏的流程<span style='color:red;font-size:12px;'>&nbsp;&nbsp;(<b>" + n + "</b>)</span>");
	        }
	        else {
	            $(".dlstar>dt").html("我收藏的流程<span style='color:red;font-size:12px;'></span>");
            }
	    }

    </script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
