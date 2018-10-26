<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShareStructM.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.ShareStruct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="iconfont/iconfont.css" rel="stylesheet" />
    <link href="css/zjs.layout.css" rel="stylesheet" />
    <link href="css/ShareStruct.css" rel="stylesheet" />
    <script src="js/jquery.zjs.js"></script>
    <script src="js/m.cselector.config.js"></script>
    <script src="js/m.cselector.2.0.0.js"></script>
    <script src="js/ShareStruct.js"></script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script type="text/javascript">
        $(function () {
            wfshowinit("1");
        });

        function CloseLayer() {
            setTimeout(function () { layer.close(LayerTemp) }, 300);
        }
        var LayerTemp = 0;
        function OpenLayer(url) {
            var width = $(window).width() - 80;
            var height = $(window).height() - 80;
            LayerTemp = layer.open({
                title: false,
                closeBtn: false,
                resize: true,
                isOutAnim: true,
                offset: ['40px', '40px'],
                type: 2,
                area: [width + 'px', height + 'px'],
                fixed: false, //不固定
                maxmin: false,
                content: url,
                end: function () {
                }
            });
        }
    </script>
</head>
<body>
    <div class="wfshowctrl">
        模块图例：
        <span class="jt">集团</span>
        <span class="gs2">二级公司</span>
        <span class="gs3">三级公司</span>
        <span class="cg">参股公司</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        关系图例：
        <b class="gq">--> 股权</b>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        显示范围：
        <select id="changeview">
            <option value="" selected="selected">全部</option>
            <option value="hidecg">控股</option>
        </select>
    </div>
    <div class="bodybox">
        <div class="canvasbox"></div>
        <div class="wfeditor"></div>
    </div>
</body>
</html>
