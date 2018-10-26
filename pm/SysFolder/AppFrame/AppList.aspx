<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppDefault.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppDefault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>默认查询</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <!--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />-->
    <link rel="stylesheet" type="text/css" href="../../grid/css/flexigrid2.css" />
	<link rel="stylesheet" type="text/css" href="../../Css/appList.css"/>
    <script type="text/javascript" src="../../grid/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="../../grid/flexigrid2.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 
    <style type="text/css">
        html{color:#4d4d4d;}
        body{
             font:12px tahoma, arial, 宋体;
             padding:10px;
             margin:0px;
         }
         .record-tit-link
         {
            line-height:30px;
            width:300px;
            vertical-align:middle;
         }
         .record-tit-link a{
            text-decoration:none;        
            color:#08c;
          }
        
    </style>
</head>
<body scroll="no">
    <form id="form1" runat="server">
    <div id="griddiv" >
        <table id="flex1" style="display:none"></table>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
<!--
            var _curClass =EZ.WebBase.SysFolder.AppFrame.AppDefault;
            var para="";
            $(function(){
            });
			$("#flex1").flexigrid
			(
			{
			url: '../getxml.ashx',
			params:[{name:"queryid",value:"<%=tblname %>"}
			        ,{name:"cryptcond",value:""}
			        ,{name:"sindex",value:"<%=sindex %>"}
			        ,{name:"condition",value:"<%= condition %>"}
                    		,{name:"defaultvalue",value:"<%=base.GetParaValue("defaultvalue") %>"}
			        ],
			colModel : [
			{display: '序号', name : 'rowindex', width : 30, sortable : false, align: 'center',renderer:colIndex},
                <%=colmodel %>
				],
			buttons : [
				{name: '添加', bclass: 'add', onpress : app_add , hidden : <%=addLimit %>},
				{name: '编辑', bclass: 'edit', onpress : app_edit , hidden : <%=editLimit %>},
				{name: '删除', bclass: 'delete', onpress : app_delete , hidden : <%=delLimit %>},
				{separator: true},
				{name: '查询', bclass: 'view', onpress : app_query},
				{name: '查询定制', bclass: 'setting', onpress : app_setquery},
				{name: '清空', bclass: 'clear', onpress : app_reset},
				{name: '保存布局', bclass: 'layout', onpress : app_layout}
				],
			searchitems :[
			    <%=querymodel %>
			    ],
			sortname: "",
			sortorder: "",
			usepager: true,
			singleSelect:true,
			useRp: true,
			rp: 15,
			multisel:false,
			showTableToggleBtn: false,
			resizable:false,
			height: 360,
			onError:showError,
			preProcess:<%=preProcess %>,
			onColResize:fnColResize
			}
			);
			function showError(data)
			{
			    alert("加载数据出错");
			}
			function app_add(cmd,grid)
			{
			    para="para="+_curClass.CryptPara("<%=para %>&condition=").value;
			    openCenter("AppInput.aspx?"+para,"_self",800,600);
			}
			function fnColResize(fieldname,width)
			{
			   
			}
            function wfStateRender(val,row)
            {
                var recid=$("_AutoID",row).text();
                var arr=[];
                switch( val)
                {
                    case "":
                    case "未发起":
                        arr.push("未发起","&nbsp;<a class='tdbtn' href=\"javascript:app_startwf('",recid,"');\">【发起】</a>");
                        break;
                    default:
                        arr.push(val,"&nbsp;<a class='tdbtn' href=\"javascript:app_wfinfo('",recid,"')\">【查看】</a>");
                        break;
                }

                return arr.join("");
            }
            function app_startwf(appId)
            {
                openCenter("../workflow/SelectWorkFlow.aspx?tblName=<%=tblname %>&mainId="+appId,"_blank",1000,700);
            }
			function app_layout(cmd,grid)
			{
			    //暂时有点儿问题，应该把fieldname 换成fieldid
			    var fldlist=[];
			    $('th',grid).each(function(){
			        if(this.fieldid)
			        fldlist.push((this.fieldid||this.field)+"="+($(this).width()-10)+"="+$(this).css("display"));
			    });
			    var ret=_curClass.saveLayout(fldlist,"<%=tblname %>","<%=sindex %>");
			    if(ret.error)
			    {
			        alert("保存出错："+ret.error.Message);
			    }
			    else
			    {
			        alert("保存成功！");
			    }
			}
			function app_reset(cmd,grid)
			{
                $("#flex1").clearQueryForm();
			}
			function app_edit(cmd,grid)
			{
			    if($('.trSelected',grid).length>0)
			    {
			        var editid=$('.trSelected',grid)[0].id.substr(3);
			        para="para="+_curClass.CryptPara("<%=para %>&condition=_autoid='"+editid+"'").value;
			        openCenter("AppInput.aspx?"+para,"_self",800,600);
				}
				else
				{
				    alert("请选中一条记录");
				}
			}
			function app_delete(cmd,grid)
			{
			    if($('.trSelected',grid).length>0)
			    {
				    if(confirm('确定删除这' + $('.trSelected',grid).length + '条记录吗?'))
				    {
			            $('.trSelected',grid).each
			            (
			                function()
			                {
			                    var ret=_curClass.DelRecord("<%=tblname %>",this.id.substr(3));
			                    if(ret.error)
			                    {
			                        alert("删除出错："+ret.error.Message);
			                    }
			                    else
			                    {
			                        alert("删除成功！");
			                        $("#flex1").flexReload();
			                    }
			                }
			            );
				         
				    }
				}
				else
				{
				    alert("请选中一条记录");
				}
			}
            function colIndex(fldval,row)
            {
                var autoid=$(row).attr("id");
                return "<a href=\"AppDetail.aspx?tblName=<%=tblname %>&condition=_autoid='"+autoid+"'\" target='_blank'>"+fldval+"</a>";
            }
            function app_view()
            {
                
            }
            function app_wfinfo(mainId)
            {
                var url = "AppWorkFlowInfo.aspx?tblName=<%=tblname %>&mainId=" + mainId;
			    openCenter(url,"_blank",1000,700);
            }
			function addCallBack()
			{
			    $("#flex1").flexReload();
			}

			function app_setquery()
			{
			    openCenter("AppConditionDef.aspx?tblname=<%=tblname %>&sindex=<%=sindex %>","_blank",400,500);
			}

			function app_query()
			{
			    $("#flex1").flexReload();
			}

		    function openCenter(url,name,width,height)
            {
	            var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
	            if (window.screen)
	            {
		            var ah = screen.availHeight - 30;
		            var aw = screen.availWidth - 10;
		            var xc = (aw - width) / 2;
		            var yc = (ah - height) / 2;
		            str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
		            str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
	            }
	            return window.open(url, name, str);
            }
            <%=listfn %>
//-->
</script>
