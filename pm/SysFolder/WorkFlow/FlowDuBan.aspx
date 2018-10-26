<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowDuBan.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowDuBan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>任务督办</title>
    <link rel="stylesheet" type="text/css" href="../../Css/wfStyle.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>

    <style type="text/css">
        body{
            background:white url(../../img/common/body_bg.gif) repeat-x;
        }
        input[type=submit],input[type=button],button{
            padding:3px;width:60px;
        }
       .info{font-size:1em;color:red;padding:10px 0px;line-height:1.5em;}
    </style>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".Read").attr("readonly", true);

                jQuery("#btnLeader").click(function () {
                    openpage('../Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=txtLeaderId,txtLeader');
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
            function afterSave() {
                $.noticeAdd({ text: '保存成功！', stay: false, onClose: function () {
                    //frameElement.lhgDG.curWin.app_query();
                    frameElement.lhgDG.cancel();
                }
                });
            }
            function winClose() {
                //window.close();
                frameElement.lhgDG.cancel();
            }
    </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="width:560px;">
            <br />
            <div style="font-size:12pt;padding:10px;text-align:center;"><%=curInstance.InstanceName %></div>
            <table class='normaltbl' style="width:100%;" border="1" cellpadding="3" align="center">
            <tr>
            <td width="100">&nbsp;催办对象：</td>
            <td style="padding:5px;">
                <asp:CheckBoxList ID="chkUserList" runat="server" RepeatDirection="Horizontal">
                </asp:CheckBoxList>
            </td>
            </tr>
            </table>
        <br />
		<div style="padding:5px;text-align:left;">
			<span style="font-weight:bold;">督办提示</span>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue">通知方式:</span>
			<asp:CheckBox ID="CheckBox1" runat="server" Checked="true"  Text="系统消息" />
			<asp:CheckBox ID="CheckBox3" runat="server" Checked="true" Text="手机短信" />
			<asp:CheckBox ID="CheckBox2" runat="server" Checked="false" Text="电子邮件" />
		</div>
        <div style="text-align:left;">
            <table style="background:white;width:100%;border-collapse:collapse;" border="0">
            <tr>
                <td colspan="2">
                    <asp:TextBox Rows="5" TextMode="MultiLine"  CssClass="TextBoxInArea" ID="txtReason" runat="server"></asp:TextBox>                
                </td>
            </tr>
            </table>

           <%=TipMsg%>
           <div style="padding:5px;">
            <asp:Button ID="Button1" CssClass="clear" runat="server" Text=" 提 交 " onclick="Button1_Click" />
            &nbsp;
            <button value=" 关 闭 " onclick="javascript:winClose();" > 关 闭 </button>
            </div>
        </div>

    </div>
    </form>
</body>
</html>
