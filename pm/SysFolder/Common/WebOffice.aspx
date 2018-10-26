<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebOffice.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.WebOffice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>文档编辑</title>
    <link type="text/css" rel="stylesheet" href="NtkoOffice/StyleSheet.css" />
    <script type="text/javascript" src="<%=base.ResolveUrlWidthETag("~/SysFolder/Common/NtkoOffice/ntko.js")%>"></script>
    <script type="text/javascript">
        var _auid = "<%= Session.SessionID %>";
        var _auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
        var _cookie = "&ASPSESSID=" + _auid + "&AUTHID=" + _auth;
        var _config = {
                classid: "C39F1330-3322-4a1d-9BF0-0BA2BB90E970",
                codebase: "NtkoOffice/OfficeControl.cab#version=5,0,2,7",
                codecrx: "NtkoOffice/ntkoplugins.crx#version=5,0,2,2",
                codexpi: "NtkoOffice/ntkoplugins.xpi#version=5,0,2,2",
                caption: "北京大学国际医院",
                key: "DAFB1711AE13F6D93F59BFFECCF73ED197FE8E58",
                title: "文档编辑",
                tool: "<%=Toolbars %>",
                menu: "<%=menu %>"
            };
    </script>
</head>
<body onload='onloaded("<%=filename %>","<%=newofficetype %>");' onunload ="onPageClose();" scroll="no">
    <form id="form1" action="WebOfficeSave.aspx" enctype="multipart/form-data">

    <div id="editmain" style="display:none;">
        <input type="hidden" id="fileid" name="fileid" value="<%=fileid %>"/>
        <input type="hidden" id="foldername" name="foldername" value="<%=foldername %>"/>
        <input type="hidden" id="hiddenTh" runat="server" />
        <input type="hidden" id="hiddenYz" runat="server" />
        <input type="hidden" id="hiddenYzfl" runat="server" />
        <input type="hidden" id="hiddenMb" runat="server" />
        <input type="hidden" id="hiddenReadonly" runat="server" />
        <input type="hidden" id="hiddenFullScrn" runat="server" />
        <input type="hidden" id="hiddenPrint" runat="server" />
        <input type="hidden" id="hiddenMark" runat="server" />
        <input type="hidden" id="hiddenCopy" runat="server" />
        <input type="hidden" id="hiddenFilenew" runat="server" />
        <input type="hidden" id="hiddenSaveas" runat="server" />
        <input type="hidden" id="hiddenControl" runat="server" />
        <input type="hidden" id="hiddenMbUrl" runat="server" />
        <input type="hidden" id="hiddenMbLoad" runat="server" />
        <input type="hidden" id="hiddenUserName" value="<%=base.EmployeeName %>" />
        <input type="hidden" id="filename" name="filename" value="<%=filename %>" />
        <input type="hidden" id="jstxt" name="jstxt" value="" runat="server"/>
    </div>

    <div id="officecontrol">
        <script type="text/javascript" src="<%=base.ResolveUrlWidthETag("~/SysFolder/Common/NtkoOffice/init.js")%>"></script> 
    </div>
    </form>

    <!--文档菜单事件-->
    <script type="text/javascript" for="TANGER_OCX" event="OnFileCommand(cmd,canceled);">
        fnFileCommand(cmd,canceled);
    </script>

    <!--文档打开后-->
    <script type="text/javascript" for="TANGER_OCX" event="OnDocumentOpened(file,doc);">
        fnDocumentOpened(file,doc);
    </script>

    <!--文档关闭后-->
    <script type="text/javascript" for="TANGER_OCX" event="OnDocumentClosed();">
        fnDocumentClosed();
    </script>

    <!--在新窗口打开-->
    <script type="text/javascript" for="TANGER_OCX" event="OnCustomFileMenuCmd(menuPos,menuCaption,menuID)">
        fnCustomFileMenuCmd(menuPos,menuCaption,menuID);
    </script>

    <!--自定义菜单事件-->
    <script type="text/javascript" for="TANGER_OCX" event="OnCustomMenuCmd2(menuPos,submenuPos,subsubmenuPos,menuCaption,menuID);">
        fnCustomMenuCmd2(menuPos,submenuPos,subsubmenuPos,menuCaption,menuID);
    </script>

    <!--自定义菜单按钮事件-->
    <script type="text/javascript" for="TANGER_OCX" event="OnCustomButtonOnMenuCmd(btnPos,btnCaption,btnId);">
        fnCustomButtonOnMenuCmd(btnPos,btnCaption,btnId);
    </script>

</body>
</html>

