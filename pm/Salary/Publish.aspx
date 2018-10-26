<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Publish.aspx.cs" Inherits="EIS.HR.Web.Salary.Publish" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head runat="server">
    <title>工资编制工具</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <style type="text/css">
        BODY{margin-top:20px; margin-left:20px; margin-right:20px; color:#000000; font-family:Tahoma; background-color:white}
        A:link {font-weight:normal; color:#000066; text-decoration:none}
        A:visited {font-weight:normal; color:#000066; text-decoration:none}
        A:active {font-weight:normal; text-decoration:none}
        A:hover {font-weight:normal; color:#FF6600; text-decoration:none}
        P {margin-top:0px; margin-bottom:12px; color:#000000; font-family:Tahoma}
        PRE {border-right:#f0f0e0 1px solid; padding-right:5px; border-top:#f0f0e0 1px solid; margin-top:-5px; padding-left:5px; font-size:x-small; padding-bottom:5px; border-left:#f0f0e0 1px solid; padding-top:5px; border-bottom:#f0f0e0 1px solid; font-family:Courier New; background-color:#e5e5cc}
        TD {font-size:12px; color:#000000; font-family:Tahoma}
        H2 {border-top: #003366 1px solid; margin-top:25px; font-weight:bold; font-size:1.5em; margin-bottom:10px; margin-left:-15px; color:#003366}
        H3 {margin-top:10px; font-size: 1.1em; margin-bottom: 10px; margin-left: -15px; color: #000000}
        UL {margin-top:10px; margin-left:20px}
        OL {margin-top:10px; margin-left:20px}
        LI {margin-top:10px; color: #000000}
        FONT.value {font-weight:bold; color:darkblue}
        FONT.key {font-weight: bold; color: darkgreen}
        .divTag {border:1px; border-style:solid; background-color:#FFFFFF; text-decoration:none; height:auto; width:auto; background-color:#cecece}
        .BannerColumn {background-color:#000000}
        .Banner {border:0; padding:0; height:8px; margin-top:0px; color:#ffffff; }
        .BannerTextCompany {font:bold; font-size:18pt; color:#cecece; font-family:Tahoma; height:0px; margin-top:0; margin-left:8px; margin-bottom:0; padding:0px; white-space:nowrap; }
        .BannerTextApplication {color:white;font:bold; font-size:18pt; font-family:Tahoma; height:0px; margin-top:0; margin-left:8px; margin-bottom:0; padding:0px; white-space:nowrap; }
        .BannerText {font:bold; font-size:18pt; font-family:Tahoma; height:0px; margin-top:0; margin-left:8px; margin-bottom:0; padding:0px; }
        .BannerSubhead {border:0; padding:0; height:16px; margin-top:0px; margin-left:10px; color:#ffffff; }
        .BannerSubheadText {font:bold; height:11px; font-size:11px; font-family:Tahoma; margin-top:1; margin-left:10; }
        .FooterRule {border:0; padding:0; height:1px; margin:0px; color:#ffffff; }
        .FooterText {font-size:11px; font-weight:normal; text-decoration:none; font-family:Tahoma; margin-top:10; margin-left:0px; margin-bottom:2; padding:0px; color:#999999; white-space:nowrap}
        .FooterText A:link {font-weight:normal; color:#999999; text-decoration:underline}
        .FooterText A:visited {font-weight:normal; color:#999999; text-decoration:underline}
        .FooterText A:active {font-weight:normal; color:#999999; text-decoration:underline}
        .FooterText A:hover {font-weight:normal; color:#FF6600; text-decoration:underline}
        .ClickOnceInfoText {font-size:11px; font-weight:normal; text-decoration:none; font-family:Tahoma; margin-top:0; margin-right:2px; margin-bottom:0; padding:0px; color:#000000}
        .InstallTextStyle {font:bold; font-size:14pt; font-family:Tahoma; a:#FF0000; text-decoration:None}
        .DetailsStyle {margin-left:30px}
        .ItemStyle {margin-left:-15px; font-weight:bold}
        .StartColorStr {background-color:#4B3E1A}
        .JustThisApp A:link {font-weight:normal; color:#000066; text-decoration:underline}
        .JustThisApp A:visited {font-weight:normal; color:#000066; text-decoration:underline}
        .JustThisApp A:active {font-weight:normal; text-decoration:underline}
        .JustThisApp A:hover {font-weight:normal; color:#FF6600; text-decoration:underline}
        #InstallButton{height:20px;padding-top:3px;}
    </style>
    <script type="text/javaScript">
<!--
        runtimeVersion = "4.0.0";
        checkClient = false;
        directLink = "EIS.Salary.application?mainid=<%=GetParaValue("mainid") %>";
        function isIE() { //ie
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                return true;
            else
                return false;
        }
        function Initialize() {
            if (isIE()) {
                if (HasRuntimeVersion(runtimeVersion, false) || (checkClient && HasRuntimeVersion(runtimeVersion, checkClient))) {
                    InstallButton.href = directLink;
                    BootstrapperSection.style.display = "none";
                }
            }
            else {
                InstallButton.href = directLink;
                BootstrapperSection.style.display = "none";
                $("#tip").show();

                if (window.top != window.self) {
                    $("#InstallButton").hide();
                    $("#btntbl").show();
                    $("#InstallButton").show().html("在新窗口打开").attr("href","Publish.aspx").attr("target","_blank");
                }
                else {
                    $("#btntbl").hide();
                }
            }
        }
        function HasRuntimeVersion(v, c) {
            var va = GetVersion(v);
            var i;
            var a = navigator.userAgent.match(/\.NET CLR [0-9.]+/g);
            if (va[0] == 4)
                a = navigator.userAgent.match(/\.NET[0-9.]+E/g);
            if (c) {
                a = navigator.userAgent.match(/\.NET Client [0-9.]+/g);
                if (va[0] == 4)
                    a = navigator.userAgent.match(/\.NET[0-9.]+C/g);
            }
            if (a != null)
                for (i = 0; i < a.length; ++i)
                    if (CompareVersions(va, GetVersion(a[i])) <= 0)
                        return true;
            return false;
        }
        function GetVersion(v) {
            var a = v.match(/([0-9]+)\.([0-9]+)\.([0-9]+)/i);
            if (a == null)
                a = v.match(/([0-9]+)\.([0-9]+)/i);
            return a.slice(1);
        }
        function CompareVersions(v1, v2) {
            if (v1.length > v2.length) {
                v2[v2.length] = 0;
            }
            else if (v1.length < v2.length) {
                v1[v1.length] = 0;
            }

            for (i = 0; i < v1.length; ++i) {
                var n1 = new Number(v1[i]);
                var n2 = new Number(v2[i]);
                if (n1 < n2)
                    return -1;
                if (n1 > n2)
                    return 1;
            }
            return 0;
        }

-->
    </script>
</head>
<body onload="Initialize()">
    <form id="form1" runat="server">
    </form>
    <table width="100%" cellpadding="0" cellspacing="2" border="0">
        <!-- Begin Banner -->
        <tr>
            <td style="background-color:#1c5280;height:50px;border:2px solid #ddd;">
                 <span class="BannerTextApplication">工资编制工具<span id="tip" style="display:none;">（请使用IE内核模式）</span></span>
            </td>
        </tr>
        <!-- End Banner -->
        <!-- Begin Dialog -->
        <tr>
            <td align="left">
                <table cellpadding="2" cellspacing="0" border="0" width="540">
                    <tr>
                        <td width="496">
                            <!-- Begin AppInfo -->
                            <table>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>名称:</b>
                                    </td>
                                    <td width="5">
                                        <spacer type="block" width="10" />
                                    </td>
                                    <td>
                                        工资编制工具
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>版本:</b>
                                    </td>
                                    <td width="5">
                                        <spacer type="block" width="10" />
                                    </td>
                                    <td>
                                        1.0.0.21
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <!-- End AppInfo -->
                            <!-- Begin Prerequisites -->
                            <table id="BootstrapperSection" border="0">
                                <tr>
                                    <td colspan="2">
                                        以下系统必备组件是必需的:
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <ul>
                                            <li>Windows Installer 3.1</li>
                                            <li>Microsoft .NET Framework 4 (x86 和 x64)</li>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        如果已经安装了这些组件，您可以立即<span class="JustThisApp"><a href="EIS.Salary.application">启动</a></span>该应用程序。否则，请单击下面的按钮，安装系统必备组件并运行该应用程序。
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <!-- End Prerequisites -->
                        </td>
                    </tr>
                </table>
                <!-- Begin Buttons -->
                <table cellpadding="2" cellspacing="0" border="0" width="540" style="cursor: hand"
                    onclick="window.navigate(InstallButton.href)" id="btntbl">
                    <tr>
                        <td align="left">
                            <table cellpadding="1" bgcolor="#333333" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <table cellpadding="1" bgcolor="#cecece" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <table cellpadding="1" bgcolor="#efefef" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="20">
                                                                <spacer type="block" width="20" height="1" />
                                                            </td>
                                                            <td>
                                                                <a id="InstallButton" href="setup.exe">运行</a>
                                                            </td>
                                                            <td width="20">
                                                                <spacer type="block" width="20" height="1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="15%" align="right" />
                    </tr>
                </table>
                <!-- End Buttons -->
            </td>
        </tr>
        <!-- End Dialog -->
        <!-- Spacer Row -->
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <!-- Begin Footer -->
                <table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#ffffff">
                    <tr>
                        <td height="5">
                            <spacer type="block" height="5" />
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterText" align="center">
                            <a href="http://go.microsoft.com/fwlink/?LinkId=154571">ClickOnce 和 .NET Framework 资源</a>
                        </td>
                    </tr>
                    <tr>
                        <td height="5">
                            <spacer type="block" height="5" />
                        </td>
                    </tr>
                    <tr>
                        <td height="1" bgcolor="#cecece">
                            <spacer type="block" height="1" />
                        </td>
                    </tr>
                </table>
                <!-- End Footer -->
            </td>
        </tr>
    </table>
</body>
</html>

