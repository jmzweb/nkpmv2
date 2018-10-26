<%@ Page Language="C#" Async="true"  AutoEventWireup="true" CodeBehind="FlowAssign.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.FlowAssign" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>任务加签</title>
    <link rel="stylesheet" type="text/css" href="../../Css/wfStyle.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>

        <style type="text/css">
        #txtReason{border-width:1px;padding:3px;line-height:150%;width:98%;}
        input[type=submit],input[type=button],button{
            padding:3px;
            }
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
            function winClose() {
                if (!!frameElement) {
                    if (!!frameElement.lhgDG) {
                        frameElement.lhgDG.cancel();
                    }
                    else {
                        window.close();
                    }
                }
                else {
                    window.close();
                }

            }
    </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="maindiv" style="width:500px;">
        <br />
        <div style="font-size:11pt;padding:10px;font-weight:bold;text-align:center;color:#666;"><%=curInstance.InstanceName %></div>
        <table class='normaltbl' style="width:100%;" border="1" cellpadding="3" align="center">
        <tr>
        <td  width="100">请选择加签人：</td>
        <td style="padding:5px;">
            <asp:TextBox ID="txtLeader" Width="320" Height="26" CssClass="TextBoxInChar Read" runat="server"></asp:TextBox>
            &nbsp;<input type="button" id="btnLeader" value="选 择" />
            <asp:HiddenField ID="txtLeaderId" runat="server" />
        </td>
        </tr>
        </table>
		<div style="padding:7px 5px;text-align:left;">
			<span style="font-weight:bold;color:#444;">写给加签人的附言</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue">通知方式:</span>
			<asp:CheckBox ID="CheckBox1" runat="server" Checked="true"  Text=" 系统消息" />
			<asp:CheckBox ID="CheckBox2" runat="server" Checked="false" Text=" 电子邮件" />
            <asp:CheckBox ID="CheckBox3" runat="server" Checked="false" Text=" 手机短信" />
		</div>
        <div style="text-align:left;">
            <table style="background:white;width:100%;border-collapse:collapse;" border="0">
            <tr>
                <td colspan="2">
                    <asp:TextBox Rows="3" TextMode="MultiLine"  CssClass="TextBoxInArea" ID="txtReason" runat="server"></asp:TextBox>                
                </td>
            </tr>
               <tr>
                    <td style="padding:7px 0px 7px 5px;text-align:left;border-left:1px solid #bbb;border-bottom:1px solid #bbb;width:94px;">
                       <span style="font-weight:bold;color:#444;">任务加签方式：</span>
                    </td>
                    <td style="padding:7px 5px;text-align:left;border-right:1px solid #bbb;border-bottom:1px solid #bbb;">
                       <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatLayout="Table" RepeatDirection="Horizontal">
                           <asp:ListItem Text="&nbsp;等待加签人办理&nbsp;&nbsp;" Value="1" Selected="True"/>
                           <asp:ListItem Text="&nbsp;加签没有完成也可以提交" Value="2" />
                       </asp:RadioButtonList>
                    </td>

               </tr>
            </table>

           <%=TipMsg%>
           <div style="padding:10px 0px;">
            <asp:Button ID="Button1" CssClass="clear" runat="server" Text=" 提 交 " onclick="Button1_Click" />
            &nbsp;
            <button value="关 闭" onclick="javascript:winClose();" >&nbsp;关 闭&nbsp;</button>
            </div>
        </div>

    </div>
    </form>
</body>
</html>

