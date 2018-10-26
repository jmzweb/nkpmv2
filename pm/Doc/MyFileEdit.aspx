<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyFileEdit.aspx.cs" Inherits="EIS.Web.Doc.MyFileEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>文件信息编辑</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../Css/DefStyle.css" />
    <script src="../Js/jquery-1.7.min.js" type="text/javascript"></script>
    <script src="../Js/Tools.js" type="text/javascript"></script>
    <style type="text/css">
        input[type=submit],input[type=button]{padding:0px 10px;height:28px;}
        .maindiv{text-align:left;}
        label{cursor:pointer;}
        .data-table{
            border-collapse:collapse;
            border:1px solid #dae2e5;
            background-color:White;
            width:100%;
            top:0px;
            left:0px;
            font-size:12px;    
            }
        .data-table >thead>tr>th{
            background-color:#e5f1f6;
            color:#414141;
            text-align:center;
            font-size:12px;
            font-weight:normal;
            height:30px;
            border-right:1px solid #dae2e5;
            cursor:pointer;
            }
        .data-table >tbody>tr>td{
            text-align:center;
            vertical-align:middle;
            padding:5px 0px;
            border:1px solid #dae2e5;
            }
        a{color:Blue;text-decoration:none;}
        a:hover{text-decoration:underline;}
        
    </style>
    <script type="text/javascript">
        function afterSave() {
            if (window.opener) {
                window.opener.app_query();
            }
            window.close();
        }
        jQuery(function () {


        });
     </script>
</head>
<body class="bgbody">
    <form id="form1" runat="server">
    <div class="maindiv">
    <table style="width:560px;table-layout:auto;">
    <tr>
        <td height="25" width="80">文件名称：</td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server" Width="440" CssClass="textbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>同级排序：</td>
        <td>
            <asp:TextBox ID="TextBox3" runat="server" Width="160" CssClass="textbox"></asp:TextBox>            
        </td>
    </tr>
    <tr>
        
        <td height="25">文件的地址：
        </td>
        <td colspan="3">
            <asp:TextBox ID="TextBox1" runat="server" Width="440" CssClass="TextArea green" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
    </tr>
        <tr>
        <td></td>
        <td align="left">
            <br />
            <asp:Button AccessKey="s" ID="Button2" runat="server" Text=" 保存 "  OnClick="Button2_Click" />
            &nbsp;
            <input accesskey="c" type="button" value=" 关闭 " onclick="window.close();"/>

            </td>
    </tr>
    </table>
        <input id="Hidden1" type="hidden" value="" />
        <input id="Hidden2" type="hidden" value="" />
        <input id="LimitData" type="hidden" runat="server" value="" />
    </div>
    </form>
</body>
</html>
