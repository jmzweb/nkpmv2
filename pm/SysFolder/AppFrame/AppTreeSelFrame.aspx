<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppTreeSelFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppTreeSelFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=frameName%></title>
</head>
<frameset cols="<%=pageWidth%>" frameborder="no">
	<frame name="left" src="<%=leftPage%>">
	<frame name="main" src="<%=initPage%>">
</frameset>
</html>
