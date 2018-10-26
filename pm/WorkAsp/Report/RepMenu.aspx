<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../SysFolder/Extension/iconfont/iconfont.css" rel="stylesheet" />
    <script src="../../js/jquery-1.8.0.min.js"></script>
    <style type="text/css">
        .zbox { margin: 50px; }
        a { width: 200px; height: 100px; float: left; margin: 30px;padding:20px; text-align: center; color: #000; text-decoration: none;background: #90d7ec; box-shadow: 0 0 10px #dedede; border-radius: 10px;  }
        a .iconfont { display: block; font-size: 60px; }
    </style>
</head>
<body>
    <div class="zbox">
        <a target="_blank" href="ProRep.aspx"><i class="iconfont">&#xe617;</i>项目总览</a>
        <a target="_blank" href="FundRep.aspx?ss=tg"><i class="iconfont">&#xe62b;</i>投资基金情况表</a>
        <a target="_blank" href="FundRep.aspx?ss=tg&fw=zjj"><i class="iconfont">&#xe62b;</i>投资基金情况表－子基金</a>
        <a target="_blank" href="FundRep.aspx?ss=tgjj"><i class="iconfont">&#xe62b;</i>投资基金简要情况表</a>
        <a target="_blank" href="FundRep.aspx?ss=tgjj&fw=zjj"><i class="iconfont">&#xe62b;</i>投资基金简要情况表－子基金</a>
    </div>
</body>
</html>
