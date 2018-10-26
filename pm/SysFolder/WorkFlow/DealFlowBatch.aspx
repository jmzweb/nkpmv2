<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DealFlowBatch.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.DealFlowBatch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>批量审批</title>
    <link rel="stylesheet" type="text/css" href="../../Css/wfStyle.css" />
	<script language="javascript" type="text/javascript" src="../../js/jquery-1.7.min.js"></script>

    <style type="text/css">
		html{height:100%;overflow:hidden;}
		body{height:100%;overflow-y:scroll;}
        input.imgbutton{
            border:0px solid white;
            color:White;
            font-weight:bold;
            background:#666;
            border-radius:3px;
            margin:3px;
            height:30px;
            line-height:24px;
            cursor:pointer;
			padding-left:24px;
            }
        #btnSubmit{background:#aaa url(../../img/common/24_check.png) no-repeat 3px center;}
        #btnBack{background:#aaa url(../../img/common/24_cross.png) no-repeat 3px center;}
        #btnClose{background:#aaa url(../../img/common/24_go.png) no-repeat 3px center;}

        td{padding:2px;}
		#maindiv{width:900px;text-align:left;background-color:white;padding:10px;overflow:visible;height:auto;}
		.header{background:#3a6ea5;color:white;height:40px;font-size:16px;font-weight:bold;line-height:40px;}
		.headText{margin-left:auto;margin-right:auto;width:900px;text-align:left;}
        .groupZone{margin-bottom:10px;border:1px solid #6495ed;}
		.groupHeader{color:black;padding-left:2px;height:30px;line-height:30px;background:#aaa url(../../img/common/tool_bg.gif) repeat-x 3px center;margin-bottom:5px;}
		.task{height:28px;line-height:24px;border-top:1px solid white;border-bottom:1px solid white;}
		.task a{color:blue;text-decoration:none;}
		.lineuser,.linetime{color:#444;}
		.taskTbl{text-align:left;border-collapse: collapse;table-layout:fixed;}
		.taskTbl tbody tr{border-top:1px solid white;border-bottom:1px solid white;}
        .unread{width:20px;height:20px;background:transparent url(../../img/email/mail.png) no-repeat 3px center;}
        .readed{width:20px;height:20px;background:transparent url(../../img/email/readed.gif) no-repeat 3px center;color:#777; }
		.alt{background-color:#f3faff;}
		.headtbl{
			border:#bbb 1px solid;
		    table-layout:fixed;
			border-collapse: collapse;
			margin-left:auto;
			margin-right:auto;
			font-size: 12px;
		}
		.headtbl td{pading:2px;background:url(../../img/toolbar/bg.gif) repeat-x center top;height:26px;border:#bbb 1px solid;}
		.datatbl{
			border:#ddd 1px solid;
		    table-layout:fixed;
			border-collapse: collapse;
			margin-left:auto;
			margin-right:auto;
			font-size: 12px;
			margin-bottom:3px;
		}
		.datatbl thead td{padding:2px 3px;height:24px;border:#bbb 1px dotted;background:url(../../img/common/topbar.gif) repeat-x center top;}
		.datatbl tbody td{padding:2px 3px;height:24px;border:#bbb 1px dotted;}
		.taskTbl td.tdActName{
			width:60px;
			word-break:keep-all;
			white-space:nowrap;
			overflow:hidden;
			text-overflow:ellipsis;

		}
		.tdNextInfo{
			width:100px;
			word-break:keep-all;
			white-space:nowrap;
			overflow:hidden;
			text-overflow:ellipsis;

		}
    </style>
	<script type="text/javascript">
	    function afterSubmit() {
	        if (window.opener)
	            window.opener.app_query();
	        window.close();
	    }
		var _taskbg ={};
		$(function () {
		    $(".chklist").change(function () {
		        var wfcode = this.value;
		        $(".taskchk_" + wfcode).prop("checked",$(this).prop("checked"));
		    });
		    $(".task,.alt").hover(function () {
		        _taskbg = { "backgroundColor": $(this).css("background-color"), "backgroundImage": $(this).css("background-image")
					, "border-top": "1px solid white"
					, "border-bottom": "1px solid white"
		        };
		        $(this).css({ "backgroundColor": "#d5effc", "backgroundImage": "url(../../img/btn01.gif)"
					, "border-top": "1px solid #a8d8eb"
					, "border-bottom": "1px solid #a8d8eb"
		        });
		    }, function () {
		        $(this).css(_taskbg);
		    });

		    $(".datatbl>tbody>tr").hover(function () {
		        _taskbg = { "backgroundColor": $(this).css("background-color"), "backgroundImage": $(this).css("background-image")
					, "border-top": $(this).css("border-top") || ""
					, "border-bottom": $(this).css("border-bottom") || ""
		        };
		        $(this).css({ "backgroundColor": "#d5effc", "backgroundImage": "url(../../img/btn01.gif)"
					, "border-top": "1px solid #a8d8eb"
					, "border-bottom": "1px solid #a8d8eb"
		        });
		    }, function () {
		        $(this).css(_taskbg);
		    });

		    $("#btnBack").click(function () {
		        if ($("#txtAdvice").val() == "") {
		            alert("【退回】操作必须填写意见");
		            return false;
		        }
		        return true;
		    });
		});
    </script>
</head>
<body>
    <form id="form1" runat="server">
	<div class='header'>
	<div class='headText'>流程任务批量审批 V1.0</div>
	</div>
    <div id="maindiv">
		<table width="100%" class='headtbl'><tr>
			<td width="24"><input type="checkbox" class='checkall'/></td>
			<td width="22"></td>
			<td>&nbsp;任务名称</td>
			<td width="40">&nbsp;类型</td>
			<td width="60">&nbsp;步骤名称</td>
			<td width="100">&nbsp;下一步</td>
			<td width="70">&nbsp;发起人</td>
			<td width="100">&nbsp;发起时间</td>
			</tr>
		</table>
		<%=sbToDo%>
        <table width="100%">
            <tbody>
				<tr><td>请输入审批意见
				        <span style="color:red;">
                            &nbsp;提示：点击批准（通过）意见默认为同意，点击退回必须输入审批意见！
                        </span>
				</td></tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtAdvice" Rows="3" Width="900"  TextMode="MultiLine" runat="server"></asp:TextBox></td>
                </tr>
				<tr>
                    <td>
                        <div class='tip'>
							操作提示：提交之后，已经成功处理的任务不会在本页面显示，如果还在本页面显示，说明此任务不适合批量操作。
						</div>
							
						</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td>
                        <asp:Button ID="btnSubmit" CssClass='imgbutton' runat="server" Text=" 批 准 " onclick="btnSubmit_Click" />&nbsp;
                        <asp:Button ID="btnBack" CssClass='imgbutton' runat="server" Text=" 退 回 " onclick="btnBack_Click" />&nbsp;
                        <input id="btnClose" class="imgbutton" type="button" value=" 关 闭 " onclick="javascript:window.close();" />
                    </td>
                </tr>
            </tfoot>
        </table>
		<br/><br/>
    </div>
    </form>
</body>
</html>
