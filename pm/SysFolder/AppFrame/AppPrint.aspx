<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppPrint.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>信息打印</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/appPrint.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../Js/DateExt.js"></script>
	<script type="text/javascript" src="../../Js/JsBarcode.all.min.js"></script>
	<script type="text/javascript" src="../../Js/jquery.qrcode.min.js"></script>
    <%=customScript%>
    <style type="text/css" media="print" id="printDiv"> 
	    .NoPrint{display:none;} 
	    .PageNext{page-break-after: always;}
	    .maindiv{height:100%;overflow:visible;} 
		.divcss5 table{width:70% !important;} 
    </style>
    <style type="text/css"> 
	    /*#maindiv{<%=formWidth%>}*/
    </style>  
    <script type="text/javascript">
        function appPrint(id) {
            //document.getElementById("WebBrowser").ExecWB(7, 1);
			LODOP=getLodop();  
			LODOP.PRINT_INIT("打印");
			var strBodyStyle="<style>div#qrcode{display: none;}</style>";
			strBodyStyle=strBodyStyle + "<style>table,td { border-collapse:collapse; }  table{width:90%;table-layout: fixed;}</style>";
			var strFormHtml=strBodyStyle+"<body>"+document.getElementById(id).innerHTML+"</body>";
			LODOP.ADD_PRINT_BARCODE(10,10,80,80,"QRCode",str);
			LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strFormHtml);
			
			LODOP.PREVIEW();
        }
		function appPrint2(id) {
            //document.getElementById("WebBrowser").ExecWB(7, 1);
			LODOP=getLodop();  
			LODOP.PRINT_INIT("打印全页");
			if (id=="all")
			{
				LODOP.ADD_PRINT_HTM(0,0,"100%","100%",document.documentElement.innerHTML);
			}else{
				LODOP.ADD_PRINT_HTM(0,0,"100%","100%",document.getElementById(id).innerHTML);
			}
			LODOP.PREVIEW();
        }
		//关闭窗口
		function _appClose() {
			if (!!frameElement) {
				if (!!frameElement.lhgDG)
					frameElement.lhgDG.cancel();
				else {
					if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
						window.parent.CloseLayer();
					} else if (window.parent.parent.CloseLayer) {
						window.parent.parent.CloseLayer();
					}
				}
				window.close();
			}
			else {
				if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
					window.parent.CloseLayer();
				} else if (window.parent.parent.CloseLayer) {
					window.parent.parent.CloseLayer();
				}
				// window.close();
			}
		}
		
        jQuery(function () {
            $(":radio,:checkbox").each(function () { $(this).prop("disabled", !$(this).prop("checked")); });
        });
    </script>
    <script type="text/javascript" src="LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
      <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="install_lodop.exe"></embed>
    </object>
</head>
<body>
    <form id="form1" runat="server">
    <object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" ></object> 
    <!-- 工具栏 -->
    <div class="menubar NoPrint">
        <div class="topnav">
            <ul>
                <li><a href="javascript:" onclick="appPrint('maindiv');" >打印</a></li>
                <li><a href="javascript:" onclick="_appClose();" >关闭</a> </li>
            </ul>
        </div>
    </div>
    
    <div id="maindiv" style="background:white;">
        <% =tblHTML%>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    <%=printScript%>
</script>

<script type="text/javascript">
    function DX(n) {
		if(n==10){
			return "十";
		}
		if(n==11){
			return "十一";
		}
		if(n==12){
			return "十二";
		}
		n = n +"";
		var reg0 = new RegExp( '0' , "g" );
		var reg1 = new RegExp( '1' , "g" );
		var reg2 = new RegExp( '2' , "g" );
		var reg3 = new RegExp( '3' , "g" );
		var reg4 = new RegExp( '4' , "g" );
		var reg5 = new RegExp( '5' , "g" );
		var reg6 = new RegExp( '6' , "g" );
		var reg7 = new RegExp( '7' , "g" );
		var reg8 = new RegExp( '8' , "g" );
		var reg9 = new RegExp( '9' , "g" );

        n= n.replace(reg0,'零');
		n=n.replace(reg1,'一');
		n=n.replace(reg2,'二');
		n=n.replace(reg3,'三');
		n=n.replace(reg4,'四');
		n=n.replace(reg5,'五');
		n=n.replace(reg6,'六');
		n=n.replace(reg7,'七');
		n=n.replace(reg8,'八');
		n=n.replace(reg9,'九');
		return n;
	}
</script>
<script type="text/javascript">
    //若存在日期字段，给日期字段赋值当前日期
		
		if(document.getElementById("ymdate")){
		  var d = new Date();
		  var years = d.getFullYear();
		  var month = add_zero(d.getMonth()+1);
		  function add_zero(temp)
		  {
		  if(temp<10) return "0"+temp;
		  else return temp;
		  }
		  document.getElementById("ymdate").innerHTML= DX(years)+"年"+DX(month)+"月";
		}
		if(document.getElementById("barcode")){
		  
		  //alert(document.getElementById("barcode").innerHTML);
		  var barcode = document.getElementById('barcode'),
			str = document.getElementById("barcodevalue").innerHTML,
			options = {
				format: "CODE128",
				displayValue: true,
				fontSize: 18,
				height: 100
			};
			JsBarcode(barcode, str, options);
		}
		if(document.getElementById("qrcode")){
		  
		  //alert(document.getElementById("barcode").innerHTML);
		  var str = document.getElementById("qrcodevalue").innerHTML;
		  $('#qrcode').qrcode({ 
				render: "table", //table方式 
				width: 50, //宽度 
				height:50, //高度 
				text: str //任意内容 
			});

		  var LODOP01=document.getElementById("qrcode"); 
		  LODOP01.PRINT_INIT("");
		  LODOP01.ADD_PRINT_BARCODE(10,10,90,90,"QRCode",str);
		  LODOP01.SET_PRINT_STYLEA(0,"QRCodeVersion",5); 
		  LODOP01.SET_PRINT_STYLEA(0,"QRCodeErrorLevel","H");
		  LODOP01.SHOW_CHART();

		}
</script>
