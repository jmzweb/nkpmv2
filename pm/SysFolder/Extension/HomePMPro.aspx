<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePMPro.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.HomePMPro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="iconfont/iconfont.css" rel="stylesheet" />
    <link href="css/homepmpro.css" rel="stylesheet" />
    <script src="../../js/jQuery-2.1.4.min.js"></script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script src="js/homepmpro.js"></script>
</head>
<body>
    <div class="protoobar">
        <a href='javascript:void(0)' class="addpro" openlayer='../AppFrame/InputFrame.aspx?TblName=F001'>
            <i class="iconfont">&#xe61e;</i>新增项目</a>
        <div class="searchinput">
            <input id="searchkey" name="searchkey" placeholder="请输入关键字" />
            <a class="searchbtn"><i class="iconfont">&#xe62d;</i></a>
        </div>
        <div class="searchbox">
            <div class="searchitem projd"> 
            </div>
            <div class="searchitem profx"> 
            </div>
            <div class="searchitem prolx"> 
            </div>
            <div class="searchitem prozm"> 
            </div>
        </div>
    </div>
    <div class="clearbar"></div>
    <div class="prolistbox">
    </div>
</body>
</html>
