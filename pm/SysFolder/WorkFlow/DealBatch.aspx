<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DealBatch.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.DealBatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>批量审批</title>
    <link rel="stylesheet" type="text/css" href="../../Css/wfStyle.css" />
	<script language="javascript" type="text/javascript" src="../../js/jquery-1.7.min.js"></script>

    <style type="text/css">
		html{height:100%;overflow:hidden;}
		body{height:100%;
            background:white url(../../img/common/body_bg.gif) repeat-x;
        }
        input.imgbutton{
            border:0px solid gray;
            color:White;
            font-weight:bold;
            background:#999;
            border-radius:3px;
            margin:3px;
            height:30px;
            line-height:24px;
            cursor:pointer;
			padding-left:24px;
            }
        #btnSubmit{background:#999 url(../../img/common/accept.png) no-repeat 5px center;}
        #btnBack{background:#999 url(../../img/common/undo.png) no-repeat 5px center;}
        #btnStop{background:#999 url(../../img/common/forbidden.png) no-repeat 5px center;}
        #btnClose{background:#999 url(../../img/common/R_Error.png) no-repeat 5px center;}
        #txtAdvice{padding:5px; line-height:1.8;color:#666;font-size:14px;border:1px solid gray;}
        td{padding:2px;}
		#maindiv{width:520px;text-align:left;padding:10px;overflow:visible;height:auto;}
        .unread{width:20px;height:20px;background:transparent url(../../img/email/mail.png) no-repeat 3px center;}
        .readed{width:20px;height:20px;background:transparent url(../../img/email/readed.gif) no-repeat 3px center;color:#777; }
		.alt{background-color:#f3faff;}
    </style>
	<script type="text/javascript">
	    function afterSubmit(t) {
	        if (window.opener)
	            window.opener.app_query();
	        window.close();
	    }
		var _taskbg ={};
		$(function () {
		    var btnLimit = '<%=Request["btnLimit"] %>';
		    if (btnLimit.length == 3) { 
                if(btnLimit.substr(1,1)=="0")
                    $("#btnBack").hide();

                if(btnLimit.substr(2,1)=="0")
                    $("#btnStop").hide();
            }
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
    <div id="maindiv">
        <table width="100%">
            <tbody>
				<tr><td><b style="color:#444;font-size:15px;">请输入审批意见：</b>
				        <span style="color:red;">
                            &nbsp;
                        </span>
				</td></tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtAdvice" Rows="3" Width="500"  TextMode="MultiLine" runat="server"></asp:TextBox></td>
                </tr>
				<tr>
                    <td>
                        <div class='tip'>
							操作提示：点击批准（通过）意见默认为同意，点击退回必须输入审批意见！
						</div>
							
						</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td>
                        <asp:Button ID="btnSubmit" CssClass='imgbutton' ToolTip="批 准" runat="server" Text=" 批 准 " onclick="btnSubmit_Click" />&nbsp;
                        <asp:Button ID="btnBack" CssClass='imgbutton' ToolTip="退 回" runat="server" Text=" 退 回 " onclick="btnBack_Click" />&nbsp;
                        <asp:Button ID="btnStop" CssClass='imgbutton' ToolTip="终 止" runat="server" Text=" 终 止 " onclick="btnStop_Click" />&nbsp;
                        <input id="btnClose" class="imgbutton" title="关 闭" type="button" value=" 关 闭 " onclick="javascript:window.close();" />
                    </td>
                </tr>
            </tfoot>
        </table>
		<br/><br/>
    </div>
    </form>
</body>
</html>
