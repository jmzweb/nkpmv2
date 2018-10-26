<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowShareTo.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowShareTo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>任务传阅</title>
    <link rel="stylesheet" type="text/css" href="../../Css/wfStyle.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>

    <style type="text/css">
        #txtLeader{margin-top:3px;}
        .info{font-size:1.2em;font-weight:bolder;color:red;padding:10px 0px;line-height:1.5em;}
        body{
            background:white url(../../img/common/body_bg.gif) repeat-x;
        }
    </style>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".Read").attr("readonly", true);

                jQuery("#btnLeader").click(function () {
                    openpage('../Common/UserTree.aspx?method=1&self=0&queryfield=empid,empname&cid=txtLeaderId,txtLeader');
                });
            });
            function openCenter(url, name, width, height) {
                var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
                if (window.screen) {
                    var ah = screen.availHeight - 30;
                    var aw = screen.availWidth - 10;
                    var xc = (aw - width) / 2;
                    var yc = (ah - height) / 2;
                    str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
                    str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
                }
                return window.open(url, name, str);
            }

            function openpage(url) {
                openCenter(url, "_blank", 640, 500);
            }
    </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="width:500px;">
            <br />
            <h3 style="font-size:12pt;margin:5px;"><%=curInstance.InstanceName %></h3>
			&nbsp;
            <table class='normaltbl' style="width:500px;" border="1" cellpadding="3" align="center">
            <tr>
            <td  width="100">请选择接收人：</td>
            <td style="padding:5px;">
                <asp:TextBox ID="txtLeader" Width="280"  CssClass="TextBoxInChar Read" runat="server"></asp:TextBox>
				&nbsp;
                <input type="button" id="btnLeader" value="选择" />
                <asp:HiddenField ID="txtLeaderId" runat="server" />
            </td>
            </tr>
            </table>
        <br />
        <div style="padding:5px;text-align:left;">
			<span style="font-weight:bold;color:#444;">写给接收人的附言</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue">通知方式:</span>
			<asp:CheckBox ID="CheckBox1" runat="server" Checked="true"  Text=" 系统消息" />
			<asp:CheckBox ID="CheckBox2" runat="server" Checked="false" Text=" 电子邮件" />
            <asp:CheckBox ID="CheckBox3" runat="server" Checked="false" Text=" 手机短信" />
		</div>
        <div style="text-align:left;">
           <asp:TextBox Rows="3" TextMode="MultiLine"  CssClass="TextBoxInArea"  Width="98%" ID="txtReason" runat="server"></asp:TextBox>

           <%=TipMsg%>
           <div style="clear:both;height:40px;line-height:40px;">
            <asp:Button ID="Button1" CssClass="clear" runat="server" Text="提 交" onclick="Button1_Click" />
			&nbsp;&nbsp;
            <button type="button" onclick="javascript:window.history.back();" >返回任务</button>&nbsp;
            <button type="button"  onclick="javascript:window.close();" >关闭窗口</button>
            </div>
        </div>

    </div>
    </form>
</body>
</html>

