<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QRCode.aspx.cs" Inherits="EZ.WebBase.QRCode" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>二维码扫描</title>
	<style>
		
		html,body{padding:0px;margin:0px;font-size:12px;text-align:center;}
	</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<img src='<%=AppPath %>/QRCode.axd?v=7&s=4&c=&_rnd=' style='margin:5px;border:4px solid white;border-radius:3px;' alt='微信拍照上传' />
		<div>请使用微信扫上面的二维码</div>
	</div>
    
    </form>
</body>
</html>
