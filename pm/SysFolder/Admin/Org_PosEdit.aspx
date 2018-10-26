<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_PosEdit.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_PosEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>岗位信息</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>

    <style type="text/css">
        #maindiv{width:500px;}
        table{border-color:gray;}
        td{padding:5px;border-color:gray;}
        body{background:white;}
        input[type=text]{width:220px;}
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".Read").attr("readonly", true);
            $(".Wdate").focus(function () { WdatePicker({}); });
            jQuery("#btnUpLeader").click(function () {
                openpage('../Common/PositionTree.aspx?method=1&queryfield=positionid,positionname&cid=UpLeaderId,UpLeader');
            });

        });
        function notFind() {
            alert("找不到对应的公司");
            window.location = "../../welcome.htm";
        }
        function success() {
            $.noticeAdd({ text: '保存成功！', stay: false });
            window.setTimeout(function () {
                frameElement.lhgDG.curWin.app_query();
                frameElement.lhgDG.cancel();
            }, 1000);

        }
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
            openCenter(url, "_blank", 400, 500);
        }

    </script>
</head>
<body>
    <form runat="server" id="form1">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav" style="text-align:right;">
        <ul>
            <li><asp:LinkButton ID="LinkButton1" runat="server"  onclick="LinkButton1_Click">保存</asp:LinkButton></li>
            <li><a href="javascript:" onclick="frameElement.lhgDG.cancel();" >关闭</a> </li>
            </ul>
        </div>
    </div>
    
    <div  id="maindiv">
        <%=TipMessage %>
    <table class='normaltbl'  border="1"   align="center">
    <caption>岗位信息表</caption>
    <tbody>
      <tr>
        <td  width="30%">&nbsp;岗位编码</td>
        <td  >
            <asp:TextBox ID="txtCode" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
        </td>
        </tr>
        <tr>
        <td >&nbsp;岗位名称</td>
        <td  >
            <asp:TextBox ID="txtName" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>&nbsp;直接上级岗位</td>
        <td >
            <asp:TextBox ID="UpLeader" CssClass="TextBoxInChar" Width="220" runat="server"></asp:TextBox>
            <asp:HiddenField ID="UpLeaderId" runat="server" />
            <input type="button" id="btnUpLeader" value="选择"/>

        </td>
        </tr>
    <tr style="display:none;">
        <td>&nbsp;岗位级别</td>
        <td>
            <asp:DropDownList ID="listDJ" Width="160" runat="server">
            </asp:DropDownList>
        </td>
   </tr>

   <tr style="display:none;">
        <td>&nbsp;关联角色</td>
        <td>
            <asp:DropDownList ID="listProp" Width="160" runat="server">
            </asp:DropDownList>
        </td>
   </tr>
           <tr>
        <td>&nbsp;生效日期</td>
        <td>
            <asp:TextBox ID="txtStart" CssClass="Wdate TextBoxInChar Read" runat="server"></asp:TextBox>
        </td>

       </tr>
             <tr>
        <td>&nbsp;失效日期</td>
        <td>
            <asp:TextBox ID="txtEnd" CssClass="Wdate TextBoxInChar Read" runat="server"></asp:TextBox>
        </td>

       </tr>
      <tr>


        <td>&nbsp;排序</td>
        <td>
            <asp:TextBox ID="txtOrder" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
        </td>

        </tr>

        <tr><td colspan="2">
            <div style='line-height:2;color:Red;'>&nbsp;注：请按照公司岗位职责的相关要求，设置合理的岗位名称。</div>
        </td></tr>
    </tbody>
    </table>
    </div>
    </form>
</body>
</html>

