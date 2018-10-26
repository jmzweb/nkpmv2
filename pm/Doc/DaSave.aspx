<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DaSave.aspx.cs" Inherits="EIS.Web.Doc.DaSave" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程归档</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet" type="text/css" href="../Css/DefStyle.css" />
    <script type="text/javascript" src="../Js/Tools.js" ></script>
    <script type="text/javascript" src="../../Js/jquery.notice.js"></script>

    <style type="text/css">
        input {
            padding: 3px;
        }
        .textbox{width:240px;}
    </style>
    <script type="text/javascript">
        function selCat() {
            openpage('DaCatalogSel.aspx?cid=hidCatalogId,txtCatalog');
        }
        function selPos() {
            openpage('DaPositionSel.aspx?cid=hidLocationId,txtLocation');
        }
        function winDa() {
            openCenter('DaEdit.aspx?instanceId=<%=instanceId %>', "_parent", 900, 640);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" style="width: 360px">
        <caption style="color:#4677bf;font-size:16px;"><b>档案信息编制</b></caption>
            <tr>
                <td height="25" width="80">文&nbsp;号：</td>
                <td>
                    <asp:TextBox ID="txtFwCode" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
           </tr>
           <tr>
                <td height="25">
                    标&nbsp;题：
                </td>
                <td>
                    <asp:TextBox ID="txtFwTitle" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
           </tr>
           <tr>
                <td></td>
                <td style="color:Blue;height:25px;">
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="同时更新审批任务名称" />
                </td>
                <td>
                    &nbsp;</td>
           </tr>
                <tr>
                <td>
                    发文公司：
                </td>
                <td>
                    <asp:TextBox ID="txtCompName" runat="server" CssClass="textbox" ReadOnly="True"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    发文部门：
                </td>
                <td>
                    <asp:TextBox ID="txtDeptName" runat="server" CssClass="textbox" ReadOnly="True"></asp:TextBox>
                    
                </td>
                <td>
                    &nbsp;</td>
            </tr>
                <tr>
                <td height="25">
                    归档目录：
                </td>
                <td>
                    <asp:TextBox ID="txtCatalog" runat="server" CssClass="textbox"></asp:TextBox>
                    
                </td>
                <td>
                    <input type="button" value="..." onclick="selCat();" />
                    </td>
                </tr>
           <tr>
                <td >归档人：</td>
                <td>
                    <asp:TextBox ID="txtGdName" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                </tr>
                <tr>
                <td >归档日期：</td>
                <td>
                    <asp:TextBox ID="txtGdDate" runat="server" CssClass="textbox" ReadOnly="True"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                </tr>
                <tr>
                <td >
                    存放位置：
                </td>
                <td>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
                <td>
                   <input type="button" value="..." onclick="selPos();" />
            </td>
            </tr>

            <tr>
                <td colspan="3" align="left">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="文号不能为空" ControlToValidate="txtFwCode" Display="None"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="标题不能为空" ControlToValidate="txtFwTitle" Display="None"></asp:RequiredFieldValidator>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />


                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Button1" runat="server" Text="归 档" Width="60px" OnClick="Button1_Click" />
                    &nbsp;&nbsp;
                    <input type="button" value="详 细" onclick="winDa();" />
                    &nbsp;&nbsp;
                    <input type="button" value="关 闭" onclick="window.parent.close();" />


                </td>
                <td align="center">
                    &nbsp;</td>
            </tr>
        </table>
        <br />
        <table align="center" style="width: 360px;display:none;">
        <tr>
            <td style="padding:4px;" width="100">
                <img style="border:2px solid gray;" alt="档案信息二维码" src="../QRCode.axd" />
            </td>
            <td style="padding:5px;line-height:20px;">
                <b class="green">档案信息二维码</b>
                <br />
                将左图二维码标签打印出来，粘贴在档案袋上，可以快速定位纸质档案对应的电子档案
            </td>
        </tr>
        </table>
    </div>

         <asp:HiddenField ID="hidLocationId" Value="" runat="server" />
         <asp:HiddenField ID="hidCatalogId" Value="" runat="server" />
    </form>
</body>
</html>
