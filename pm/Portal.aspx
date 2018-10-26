<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Portal.aspx.cs" Inherits="EIS.Web.Portal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>门户首页</title>
    <link href="Css/Portal.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.min.js" type="text/javascript"></script>
    <script src="Js/Portal.js" type="text/javascript"></script>
    <script src="Js/lhgdialog.min.js?s=default" type="text/javascript"></script>
    <script src="Js/DateExt.js" type="text/javascript"></script>
</head>
<body>
	<form id="Form1" method="post" runat="server">
    </form>    
    <div id="MainPanel">
        <div class="portalMenu">
            <%=portalMenu %>
        </div>
        <div class="portal">
            <%=portalList %>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    var layout=<%=layout %>;
    var _curClass = EIS.Web.Portal;
    //window.parent.document.getElementById("openClose").click();
    <%=sbScript %>
</script>
