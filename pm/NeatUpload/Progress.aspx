<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="c#" AutoEventWireup="false" Inherits="Brettle.Web.NeatUpload.ProgressPage" %>
<%@ Register TagPrefix="Upload" Namespace="Brettle.Web.NeatUpload" Assembly="Brettle.Web.NeatUpload" %>
<html>
	<head runat="server">
		<title>文件上传进度</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" title="default" href="default.css" />		
		<style type="text/css">
		body, form, table, tr, td {
			margin: 0px;
			padding:0px;
			border: 0px none;
			padding: 0px;
			font-family:Tahoma,Helvetica,Arial,sans-serif;
		    font-size:12px;
		}

		html, body {
			width: 100%;
			height: 100%;
		}
		
		#progressDisplayCenterer {
			vertical-align: middle;
			margin: 0 auto;
			width: 100%;
			height: 100%;
		}
		
		#progressDisplay {
			vertical-align: middle;
			width: 100%;
		}
		
		#barTd {
			width: 70%;
		}
		
		#statusDiv {
			border: 1px solid #777;
			background-color:#FFFAF0;
			padding: 0px;
			position: relative;
			text-align: center;
			z-index: 1; 
		}
		
		#barDiv,#barDetailsDiv {
			border: 0px none ; 
			margin: 0px; 
			padding: 2spx; 
			position: absolute; 
			top: 0pt; 
			left: 0pt; 
			z-index: -1; 
			height: 100%;
			width: 75%;
		}
		</style>
	</head>
	<body>
		<form id="dummyForm" runat="server">
		<table id="progressDisplayCenterer" width="100%">
		<tr>
		<td>
		<table id="progressDisplay" class="ProgressDisplay">
		<tr>
		<td width="70">
			<span id="label" runat="server" class="Label">上传进度：</span>
		</td>
		<td id="barTd" >
			<div id="statusDiv" runat="server" class="StatusMessage">
				<Upload:DetailsSpan id="normalInProgress" runat="server" WhenStatus="NormalInProgress" style="font-weight: normal; white-space: nowrap;">
					<%# FormatCount(BytesRead) %>/<%# FormatCount(BytesTotal) %> <%# CountUnits %>
					(<%# String.Format("{0:0%}", FractionComplete) %>) 速度 <%# FormatRate(BytesPerSec) %>
					- 剩余<%# FormatTimeSpan(TimeRemaining) %>秒
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="chunkedInProgress" runat="server" WhenStatus="ChunkedInProgress" style="font-weight: normal; white-space: nowrap;">
					<%# FormatCount(BytesRead) %> <%# CountUnits %>
					速度 <%# FormatRate(BytesPerSec) %>
					- 剩余<%# FormatTimeSpan(TimeElapsed) %>秒 
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="processing" runat="server" WhenStatus="ProcessingInProgress ProcessingCompleted" style="font-weight: normal; white-space: nowrap;">
					<%# ProcessingHtml %>
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="completed" runat="server" WhenStatus="Completed">
					上传完成 <%# FormatCount(BytesRead) %> <%# CountUnits %>
					平均 <%# FormatRate(BytesPerSec) %>
					用时 <%# FormatTimeSpan(TimeElapsed) %>
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="cancelled" runat="server" WhenStatus="Cancelled">
					取消上传
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="rejected" runat="server" WhenStatus="Rejected">
					Rejected: <%# Rejection != null ? Rejection.Message : "" %>
				</Upload:DetailsSpan>
				<Upload:DetailsSpan id="error" runat="server" WhenStatus="Failed">
					错误: <%# Failure != null ? Failure.Message : "" %>
				</Upload:DetailsSpan>
				<Upload:DetailsDiv id="barDetailsDiv" runat="server" UseHtml4="true"
					 Width='<%# Unit.Percentage(Math.Floor(100*FractionComplete)) %>' CssClass="ProgressBar"></Upload:DetailsDiv>	
			</div>
		</td>
		<td width="100">
			<asp:HyperLink id="cancel" runat="server" Visible='<%# CancelVisible %>' NavigateUrl='<%# CancelUrl %>' ToolTip="取消上传" CssClass="ImageButton" >
				<img id="cancelImage" src="cancel.png" alt="取消上传" />
			</asp:HyperLink>
			<asp:HyperLink id="refresh" runat="server" Visible='<%# StartRefreshVisible %>' NavigateUrl='<%# StartRefreshUrl %>' ToolTip="刷新" CssClass="ImageButton" >
				<img id="refreshImage" src="refresh.png" alt="刷新" />
			</asp:HyperLink>
			<asp:HyperLink id="stopRefresh" runat="server" Visible='<%# StopRefreshVisible %>' NavigateUrl='<%# StopRefreshUrl %>' ToolTip="暂停刷新" CssClass="ImageButton">
				<img id="stopRefreshImage" src="stop_refresh.png" alt="暂停刷新" />
			</asp:HyperLink>
		</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>
		</form>
	</body>
</html>
