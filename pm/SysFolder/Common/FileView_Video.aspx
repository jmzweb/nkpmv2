<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileView_Video.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.FileView_Video" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=fileName%></title>
	<script src="../../Js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../PlugIn/ckplayer/ckplayer.js" charset="utf-8"></script>
	<style>
		body{text-align:center;background-color:#f5f5f5;}
		#videoZone{margin-left:auto;margin-right:auto;}
		a{text-decoration:none;}
		h3{color:#1e90ff;}
	</style>
</head>
<body>
<h3><%=fileName%></h3>
<div id="videoZone"></div>
<div><br/><a href='fileDown.aspx?fileId=<%=base.GetParaValue("fileId") %>' target='_blank'>【点击此处下载视频】</a></div>
</body>
</html>
<script type="text/javascript">

	var panelId = "videoZone";
	var src = "fileDown.aspx?fileId=<%=base.GetParaValue("fileId") %>&log=view";

	var flashvars = { f: src, c: 0, b: 1, h:'4',q:'start'};
	CKobject.embed('../../PlugIn/ckplayer/ckplayer.swf', panelId, 'ckplayer_' + panelId, 640, 480, false, flashvars);

    function closelights() { }
    function openlights() { }
</script>
