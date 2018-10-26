<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DaZDSel.aspx.cs" Inherits="EIS.Web.Doc.DaZDSel" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>分类目录选择</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link rel="stylesheet" type="text/css" href="../Css/DefStyle.css"/>
    <link href="../css/tree.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.7.min.js" type="text/javascript"></script>
    <script src="../js/jquery.tree.js" type="text/javascript"></script>
    <style type="text/css">
     	#tree
	    {
	        background:#f9fafe;
	        border:#c3daf9 1px solid;
	        padding:5px;
	        margin:5px;
	        overflow:auto;
	    }
	    input{padding:2px;line-height:18px;}
    </style> 
    <script type="text/javascript">
        jQuery(function () {
            var h = $(document).height();
            $("#tree").height(h - 80);
        });
    </script>
	</head>
	<body >
		<form id="Form1" method="post" runat="server">
        <div id="tree">
        </div>
        <div style="padding: 5px;text-align:right;">
				<input class="defaultbtn" id="btnconfirm" type="button" value=" 确定 "/> &nbsp;
				<input class="defaultbtn" id="btndel" onclick="window.close();" type="button" value=" 关闭 "/>
		</div>
		</form>
   
    <script type="text/javascript">
        var userAgent = window.navigator.userAgent.toLowerCase();
        $.browser.msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
        $.browser.msie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
        $.browser.msie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
        <%=treedata %>
        function load() {        
            var o = { showcheck: false,
            onnodeclick:function(item){
            
            }, 
            blankpath:"../Img/common/",
            cbiconpath:"../Img/common/"
            };
            o.data = treedata;                  
            $("#tree").treeview(o);            
            $("#btnconfirm").click(function(e){
                var nodes = $("#tree").getCurItem();
                var cid="<%=cid %>";
                var bizfields=cid.split(",");
                window.opener.document.getElementById(bizfields[0]).value=nodes.id;
                window.opener.document.getElementById(bizfields[1]).value=nodes.text;
                window.close();
            });

        }   
        if( $.browser.msie6)
        {
            load();
        }
        else{
            $(document).ready(load);
        }


    </script>

	</body>
</html>
