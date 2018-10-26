<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pass_FetchInfo.aspx.cs" Inherits="EIS.Web.WorkAsp.Personal.Pass_FetchInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>找回密码</title>
    <style type="text/css">
        body{color:#000;background:#f1f1f1;font-size:12px;line-height:166.6%;text-align:center}
        body,input,button{font-family:Verdana,arial,sans-serif}
        *{font-size:100%;margin:0;padding:0}
        img{margin:0;line-height:normal}
        table{border-collapse:collapse;border-spacing:0}
        input,button, img{vertical-align:middle}
        .content{margin:auto}
        #btnConfirm{padding:3px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
<div id="Rpage" class="Rpage-main" style="width:900px;">
        <div id="Rheader">
            <span style="line-height: 100%; position: absolute; color: #76787a; margin-top: 40px;
                font-weight: bold; font-size: 24px; font-family: 黑体;">协同办公信息管理系统 </span>
        </div>
        <div id="Rbody">
            <div class="title">
                <b class="crl"></b><b class="crr"></b>
                <h1>找回密码</h1>
            </div>
            <div class="content">
                <br />
                <br />
                <table width="600" align="center">
                    <tbody>
                        <tr>
                            <td>
                                &nbsp;<img src="../Img/accept.gif" alt="成功"/>
                            </td>
                            <td height="40" valign="middle" style="line-height:200%;">
                                &nbsp;已经发送重置密码信息到[<%=Request["Email"] %>]，
                                请在24小时之内查收
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;<button type="button" onclick="javascript:window.close();"> 关闭窗口 </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
            </div>
            <div class="bottom">
                <b class="crl"></b><b class="crr"></b>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
