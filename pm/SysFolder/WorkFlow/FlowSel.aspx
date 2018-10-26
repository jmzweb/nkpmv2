<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowList.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowSel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>流程新建</title>
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <link href="../../Bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="../../Bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="../../Bootstrap/3.2.0/js/html5shiv.min.js"></script>
        <script src="../../Bootstrap/3.2.0/js/respond.min.js"></script>
    <![endif]-->

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
			background:url(../../img/common/checkbox_0.gif) no-repeat left center;
			cursor:pointer;
		    }
		dd.infav em{
			background:url(../../img/common/checkbox_1.gif) no-repeat left center;
		    }
		    
		dd a{
			text-decoration:none;
			font-size:13px;
			color:gray;
			line-height:22px;
			padding-bottom:0px;
			border-bottom: solid gray 0px;
		}
		dd.infav a{color:Red;}
		dd.infav a:hover{
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
    </form>
    <br />
    <div class="container-fluid" style="padding-bottom:50px;">
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-primary">
          <div class="panel-heading">
            <h3 class="panel-title">请选择下面的流程</h3>
          </div>
          <div class="panel-body">
	        <table width="100%">
		        <tr>
			        <td valign="top"><%=sb %></td>
			        <td valign="top"><%=sb2 %></td>
			        <td valign="top"><%=sb3 %></td>
		        </tr>
	        </table>
          </div>
        </div>
      
      </div>
    </div>
    </div>
        <nav class="navbar navbar-default navbar-fixed-bottom">
          <div class="container" style="text-align:center;padding-top:5px;">
            <button type="button" id="btnOK" class="btn btn-primary"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 确认</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="btnClear" class="btn btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 清空</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="btnClose" class="btn btn-info"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> 关闭</button>

          </div>
        </nav>
</body>
</html>
	<script type="text/javascript">
	    var cid = '<%=Request["cid"] %>';
	    var cname = '<%=Request["cname"] %>';
	    jQuery(function () {
	        if (cid.length > 0) {
	            var oarr = window.opener.document.getElementById(cid).value;
	            if (oarr.length > 0) {
	                var arr = oarr.split(",");
	                for (var i = 0; i < arr.length; i++) {
	                    $("dd[wfcode=" + arr[i] + "]").addClass("infav");
	                }
	            }
	        }
	        jQuery("dl").each(function () {
	            var n = $("dd", this).length;
	            if (n > 0) {
	                $("dt", this).append("<span style='color:red;font-size:12px;'>&nbsp;&nbsp;(<b>" + n + "</b>)</span>");
	            }
	        });
	        jQuery("dt").click(function () {
	            var dl = $(this).parent();
	            var c = "0";
	            if (!!$(this).attr("check"))
	                c = "1";

	            if (c == "1") {
	                $("dd", dl).removeClass("infav");
	                $(this).attr("check", "");
	            }
	            else {
	                $("dd", dl).addClass("infav");
	                $(this).attr("check", "1");
	            }

	        });
	        $(".wflink").click(function () {
	            var em = $(this).parent();
	            em.toggleClass("infav");
	        });
	        $("#btnClose").click(function () {
	            window.close();
	        });
	        $("#btnClear").click(function () {
	            $("dd").removeClass("infav");
	        });
	        $("#btnOK").click(function () {

	            var arrName = [], arrId = [];
	            $("dd.infav").each(function () {
	                arrId.push($(this).attr("wfcode"));
	                arrName.push($(this).attr("wfname"));
	            });

	            window.opener.document.getElementById(cid).value = arrId.join(",");
	            window.opener.document.getElementById(cname).value = arrName.join(",");
	            window.close();

	        });
	    });
	    function openlist(tblname) {

	    }

	    function openchart(wfid) {
	        var d = new Date();
	        window.open('FlowChart.aspx?workflowid=' + wfid + "&rnd=" + d.getTime(), '_blank', 'top=0,left=0,width=1000,height=700,resizable=yes,scrollbars=yes');
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
