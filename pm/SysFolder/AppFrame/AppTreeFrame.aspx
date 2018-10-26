<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppTreeFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppTreeFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=frameName%></title>
</head>
<frameset cols="<%=pageWidth%>" frameborder="no">
	<frame name="left" id="left" src="<%=leftPage%>&funId=<%=base.GetParaValue("funId") %>">
	<frame name="main" id="main" src="<%=initPage%>">
</frameset>
</html>
