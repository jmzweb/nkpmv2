<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryLimit.aspx.cs" Inherits="EIS.Studio.SysFolder.Permission.QueryLimit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>授权分析</title>
    <meta content="no-cache" http-equiv="Pragma"/>
    <link href="../../Css/AppStyle.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery-1.7.min.js" type="text/javascript"></script>
    <style type="text/css">
    body
    {
	    font-size: 12px;
	    font-family: "Verdana", "Arial", "宋体", "sans-serif";
	    background:#ffffff;
	    color: #606060;
	    width:100%;
	    height:100%;
	
    }
    .level1{color:#007fff;font-weight:bold;}
    /* 容器,主要控件放这里面*/
    .ViewGridContain
    {
	    border:0;
	    position:relative;
	    background-color:#ffffff;
        margin:5px;/*180px;*/
	    width:640px;
	    padding:10px;
	
    }
    .table_title
    {
    	height:26px;
    	background:#efefef;
    }
    input[type=checkbox]{
    	margin-left:3px;
    	vertical-align:middle;
    }
    table.bodystyle{
        table-layout:fixed;
        border-collapse:collapse;
        border:1px solid #a0a0a0;
        }
     table.bodystyle td{
         padding:0px;height:26px;
         text-align:center;
         border:1px solid #a0a0a0;
         }
    table.bodystyle td.nodetd{
        text-align:left;
        border-top-width:0px;
        border-bottom-width:0px;
        }
        i{color:Blue;font-style:normal;}
      table.bodystyle tfoot{
          background-color:#ddd;
          }  
    </style>
</head>
<body>
    <form id="form1" runat="server">   
            <div class="menubar">
            <div class="topnav">
                <span style="float:left;margin-left:10px">姓名：<i><%=EmpName %></i>&nbsp;&nbsp;&nbsp;&nbsp;功能：<i><%=FunName %></i>
                </span>      
            </div>
            </div>
            <div class="ViewGridContain">
                <div id="TContent">
                    <table id="" class="bodystyle"  width="100%" border="1"  onclick="tableclick()">
                        <thead>
                        <tr class="table_title">
                        <th style="border:1px solid #a0a0a0;" width="160">对象名称
                        </th>
                        <th width="60">类型</th>
                        <th >显示</th>
                        <th >新建</th>
                        <th >修改</th>
                        <th >删除</th>
                        <th >条件</th>
                        <th >布局</th>
                        <th >导出</th>
                        <th >导入</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%=limitHtml%>
                    </tbody>
                    <tfoot>
                        <%=limitTotal %>
                    </tfoot>
                    </table>
                
                </div>
            </div>
    


    </form>
</body>
</html>
