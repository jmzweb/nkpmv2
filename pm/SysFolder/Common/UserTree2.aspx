<%@ Page language="c#" Codebehind="UserTree.aspx.cs" AutoEventWireup="false" Inherits="EZ.WebBase.SysFolder.Common.UserTree" enableViewState="True"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择用户</title>
     <link href="../../css/appstyle.css" rel="stylesheet" type="text/css" />    
     <link href="../../css/tree.css" rel="stylesheet" type="text/css" />
     <style type="text/css">
     	#tree
	    {
	        border:#c3daf9 1px solid;
	        padding:5px;
	        margin:5px;
	    }
     </style>    
	</head>
	<body >
		<form id="Form1" method="post" runat="server">
					<fieldset style="padding-right: 5px; padding-left: 10px; padding-bottom: 2px; padding-top: 2px; background-color: #f2f4fb">

					<input class="defaultbtn" id="btnconfirm" style=" left: 72px; top: 8px; height: 24px"
					type="button" value="确定返回"/> &nbsp;
					<input class="defaultbtn" id="btndel" style=" left: 152px; top: 8px; height: 24px"
					onclick="window.close();" type="button" value="关闭窗口"/>
			</fieldset>
		<br />
        <div id="tree">
            
        </div>
        
    <script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.tree.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        Array.prototype.contains = function (element) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == element) {
                    return i;
                }
            }
            return -1;
        }

        var userAgent = window.navigator.userAgent.toLowerCase();
        $.browser.msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
        $.browser.msie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
        $.browser.msie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
        <%=treedata %>
        function load() {        
            var o = { showcheck: true,
            onnodeclick:function(item){
            		
            
            }, 
            blankpath:"../../Img/common/",
            cbiconpath:"../../Img/common/",
            url:"../Common/TreeData.ashx?queryid=EmployeeByDeptID"
            };
            o.data = treedata;                  
            $("#tree").treeview(o); 
                       
            $("#btnconfirm").click(function(e){
                //var s=$("#tree").getTSVs();
              var cid="<%=cid %>";
              var bizfields=cid.split(",");
              var qryfields="<%=queryfield %>".split(",");
              var idindex=qryfields.contains("empid");
              var nameindex=qryfields.contains("empname")
              var emps=[];
              var ids=[]; 
              var nodes = $("#tree").getTSNs();
              for(var i=0;i<nodes.length;i++)
              {
                if(nodes[i].id.length=="36")
                {
                    if(idindex>-1)
                        ids.push(nodes[i].id);
                    if(nameindex>-1)
                        emps.push(nodes[i].text);
                }
              }
              
               if(idindex>-1)
               {
                      window.opener.document.getElementById(bizfields[idindex]).value=ids;
               }
               if(nameindex>-1)
               {
                      window.opener.document.getElementById(bizfields[nameindex]).value=emps;
               }
               if('<%=Request["callback"] %>'!="")
               {
                    window.opener["<%=Request["callback"] %>"](bizfields);
               }
                  
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
		</form>
	</body>
</HTML>