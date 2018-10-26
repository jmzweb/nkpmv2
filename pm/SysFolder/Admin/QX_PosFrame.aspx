<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_DeptFrame.aspx.cs" Inherits="EIS.HR.Web.SysFolder.HR.HR_DeptFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>组织部门定义</title>
</head>
<frameset cols="300,*" frameborder="no">
	<frame name="left" id="left" src="QX_PosLeft.aspx?limit=1&grade=<%=GetParaValue("grade") %>">
	<frame name="main" id="main" src="../../welcome.htm">
	<noframes>
	</noframes>
</frameset>
</html>
