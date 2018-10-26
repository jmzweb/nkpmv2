<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppNavi" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>导航页面</title>
    <link href="../../Css/common.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery-1.7.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="navPanel">
	    <div id="navMenu">
            <%=Links %>
	    </div>
    </div>
    <iframe width="100%" height="400px" frameborder="0" id="frmMain" name="frmMain" src="<%=firstLink %>"></iframe>
    </form>
</body>
</html>

<script type="text/javascript">
    $("#frmMain").height($(document).height() - 40);
    jQuery(function () {
        $("#navMenu a").click(function () {
            $("#navMenu a.active").removeClass("active");
            $(this).addClass("active");
        });
    });
</script>
