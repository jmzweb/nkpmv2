<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DaSaveFrame.aspx.cs" Inherits="EIS.Web.Doc.DaSaveFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>流程归档</title>
</head>
<frameset cols="*,400" frameborder="no">
	<frame name="left" id="left" src="../Sysfolder/AppFrame/AppWorkFlowInfo2.aspx?InstanceId=<%=instanceId %>">
	<frame name="main" id="main" src="DaSave.aspx?instanceId=<%=instanceId %>">
	<noframes>
	</noframes>
</frameset>

</html>
