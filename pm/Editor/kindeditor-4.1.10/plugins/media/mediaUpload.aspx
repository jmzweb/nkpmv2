<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NeatUpload.aspx.cs" EnableSessionState="false" Inherits="EIS.WebBase.SysFolder.Common.NeatUpload" %>
<%@ Register TagPrefix="Upload" Namespace="Brettle.Web.NeatUpload" Assembly="Brettle.Web.NeatUpload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>附件上传</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
        #ProgressBar{width:100%;height:60px;}
        .tip{overflow:auto;overflow-x:hidden;margin-left:auto;margin-right:auto;margin-top:0px;margin-bottom:10px;
            border:dotted 1px orange;background:#F9FB91;text-align:left;padding:5px;}
        *{font-size:12px;}
        input[type=submit],input[type=button]{
            border:0px solid white;
            color:White;
            font-weight:bold;
            background-color:#49afcd;
            border-radius:3px;
            margin:0px;
            height:22px;
            line-height:20px;
            cursor:pointer;
            }
    </style>
    <script type="text/javascript">
        function success(url) {
			window.parent.GenUrl(url);
            //frameElement.lhgDG.cancel();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div style="padding:0px 5px;">
        选择文件：&nbsp;&nbsp;&nbsp;
        <Upload:InputFile id="FileInput" Width="330" runat="server" />    
        <asp:Button id="BtnUpload" runat="server" Text="开始上传" onclick="BtnUpload_Click" />
    </div>

    <div>
    <Upload:ProgressBar id="ProgressBar" Triggers="BtnUpload" runat="server" inline="true" />
    </div>
    <%=Msg %>
    </div>
    </form>
</body>
</html>
