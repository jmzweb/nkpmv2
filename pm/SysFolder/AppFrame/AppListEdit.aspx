<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.DefaultFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title><%=GetParaValue("Title")%></title>
</head>
<frameset cols="*,400" frameborder="yes">
	<frame name="main" id="main" src="../../welcome.htm"/>
	<frame name="right" id="right" src="AppDefault.aspx?<%=Request.QueryString%>&target=main&btnLimit=---0000"/>
</frameset>
</html>