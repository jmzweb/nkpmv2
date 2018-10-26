<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocFrame.aspx.cs" Inherits="EIS.Web.Doc.DocFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>文档管理</title>
</head>
<frameset cols="300,*" frameborder="no">
	<frame name="left" id="left" src="DocTree.aspx?treeId=<%=treeId %>&treeName=<%=treeName %>&_rnd=<%=DateTime.Now.Ticks %>">
	<frame name="main" id="main" src="DocRecent.aspx?treeNo=<%=treeId %>">
	<noframes>
	</noframes>
</frameset>
</html>
