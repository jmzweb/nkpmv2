<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePM.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.HomePM" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="iconfont/iconfont.css" rel="stylesheet" />
    <link href="css/homepm.css" rel="stylesheet" />
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script src="js/homepm.js"></script>
</head>
<body>
    <a href='javascript:void(0)' class="addpro" openlayer='../AppFrame/InputFrame.aspx?TblName=F001' title="新增项目"><i class="iconfont">&#xe61e;</i></a>
    <%
        if (dth3.Rows.Count == 0)
        {//如果没有节点信息 直接跳到项目桌面
            Response.Redirect("HomePMPro.aspx", true);
        }
        StringBuilder sb = new StringBuilder();
        foreach (DataRow drh3 in dth3.Rows)
        {
            sb.Append("<div class='h3box h3box" + drh3["FunctionalStageCode"] + "'><h3><span>" + drh3["FunctionalStage"] + "</span></h3><div class='btns'><ul>");
            foreach (DataRow drp in dtpoint.Select("FunctionalStage='" + drh3["FunctionalStage"] + "'"))
            {
                var TblName = "F002";
                switch (drp["FunctionalStageCode"].ToString())
                {
                    case "2":
                        TblName = "F003";
                        break;
                    case "3":
                        TblName = "F004";
                        break;
                }
                sb.Append("<li><p></p><a openlayer='../AppFrame/InputFrame.aspx?TblName=" + TblName + "&Node=" + drp["FunctionalNode"] + "&Type=" + drp["FuncType"] + "&PointID=" + drp["PointID"] + "'>" + drp["FunctionalNode"] + "</a></li>\r\n");
            }
            sb.Append("</ul></div></div>");
        } 
    %>
    <div class="procitembox">
        <%=sb.ToString() %>
        <div class="h3box h3boxpro">
            <h3><span>最近项目</span></h3>
            <div class="btns">
                <ul class="prolist">  
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
