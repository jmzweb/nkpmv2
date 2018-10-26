<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppImport.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppImport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>数据导入</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <link type="text/css" href="../../Css/jquery-ui/lightness/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="../../js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../../js/jquery-ui-1.8.23.custom.min.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <script src="../../Js/jquery.cookie.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/tools.js"></script>
    <style type="text/css">
        body{background:white url(../../img/common/body_bg.gif) repeat-x;font-size:14px;}
        .normaltbl>tbody>tr>td{text-align:center;}
        .maintbl>tbody>tr>td{padding:10px 0px;}
        .kandyTabs .tabbody .tabcont{background:#fefefe;}
        ul.connSortable 
	    {
	        list-style-type: none; 
	        margin: 0; 
	        padding: 0; 
	        background: #eee; 
	        padding: 10px; 
	        width: 180px;
	        height:360px;
	        overflow-y:auto;
	        }
	        
	    .connSortable li 
	    {
	        margin: 0px 3px 2px 3px; 
	        padding: 2px; 
	        font-size: 1.0em; 
	        width: 150px;
	        cursor:pointer;
	        text-align:center;
		    word-break:keep-all;/* 不换行 */
		    white-space:nowrap;/* 不换行 */
		    overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
            text-overflow:ellipsis;
	    }
	    table.frametbl
        {
	        border-collapse: collapse;
            margin-left:auto;
	        margin-right:auto;
	        margin-bottom:10px;
	        font-size: 12px;
	        line-height:20px;
            width:700px;
	        border:#808080 1px solid;
	        color:#393939;
	        background:#FAF8F8;
	        table-layout:fixed;
        }
        table.frametbl td{padding:10px;}
        .resultArea{border:1px solid gray;line-height:1.5;padding:3px;width:100%;box-sizing:border-box;*width:98%;}
        u{font-family:宋体;line-height:18px;display:inline-block;border-bottom:1px solid #f08080;text-decoration:none;font-size:10pt;color:#ff4500;}
    </style>
    <script type="text/javascript">
        jQuery(function () {
            $("dl").KandyTabs({ trigger: "click" });

            $("#tablefld, #tablesel").sortable({
                connectWith: '.connSortable'
			    , placeholder: 'ui-state-highlight'
			    , dropOnEmpty: true
            }).disableSelection();

            $("#tablefld>li").dblclick(function () {
                $(this).appendTo("#tablesel");
            });
            $("#tablesel>li").dblclick(function () {
                $(this).appendTo("#tablefld");
            });

            var _curClass = EZ.WebBase.SysFolder.AppFrame.AppImport;
            $("#btnCreate").click(function () {
                var tablelist = $('#tablesel').sortable('toArray');
                var ret = _curClass.GenTemplate("<%=tblName %>", tablelist.join("|"));
                if (ret.error) {
                    $(".info").show().html("<div class='tip'>" + ret.error.Message + "</div>");
                }
                else {

                    $(".info").show().html("<div class='tip'>已经成功生成模板文件！"
                    + "<a href='../common/fileDown.aspx?fileId=" + ret.value + "' target='_blank'>【点击下载】</a>"
                    + "<a href='../common/webOffice.aspx?fileId=" + ret.value + "' target='_blank'>【点击编辑】</a>"
                    + "</div>");

                    window.frames["Iframe1"].location.reload();
                }

            });

            $("#Button1").click(function () {
                var arr = [$("#selConfig").val(), $("#selKey").val(), "<%=mainId %>"];
                var ret = _curClass.ImportDataEx("<%=tblName %>", arr.join("|"), "<%=GetParaValue("cpro") %>");
                if (ret.error) {
                    $("#TextBox1").val("导入出现异常：" + ret.error.Message);
                }
                else {

                    $("#TextBox1").val(ret.value);
                    try {
                        frameElement.lhgDG.curWin.app_query();
                    } catch (e) { }
                }
                return false;
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <br />
    <div id="maindiv" style="text-align:center;padding-top:0px;margin-left:auto;margin-right:auto;">
        <dl style="margin-left:auto;margin-right:auto;">
        <dt>数据导入</dt>
        <dd>

        <table class="maintbl center" align="center" style="text-align:left;">
            <caption style="font:bold 12pt/200% 'Microsoft YaHei';border-bottom:2px solid #3598db;padding-bottom:10px;">业务数据导入</caption>
            <tr>
                <td valign="top">
                    <span class="step">步骤1：</span>
                </td>
                <td> 
                    点击下面链接下载已有模板，也可以自己新建模板上传（<u>第一行为标题行，列名为字段中文名</u>）。
                    <div style="line-height:28px;color:Green;border:1px solid #ddd;margin-top:10px;">
                    <iframe id="Iframe1" frameborder="0" scrolling="auto"  
                    src="../Common/FileListFrame.aspx?set=*.xls||0&appName=<%=tblName %>&appId=<%=tblName %>_Template&read=0&fromDoc=0" width="100%" height="80px">
                    </iframe>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <span class="step">步骤2：</span>
                </td>
                <td >
                    点击下面的【选择文件】，上传整理好的Excel数据文件。
                    <div style="line-height:28px;color:Green;border:1px solid #ddd;margin-top:10px;">
                    <iframe id="Iframe2" frameborder="0" scrolling="auto"  
                    src="../Common/FileListFrame.aspx?set=*.xls;*.xlsx||0&appName=<%=tblName %>&appId=<%=mainId=="" ? tblName:mainId %>_Import&read=0&fromDoc=0" width="100%" height="80px">
                    </iframe>
                    </div>
                </td>
            </tr>
            <tr>
                <td >
                    
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" CssClass="btn01" Text="导入最新文件" />&nbsp;&nbsp;&nbsp;&nbsp;
                    选项：
                    <select id="selConfig">
                        <option value="1">1. 导入时跳过已有重复的数据行</option>
                        <option value="2">2. 导入时更新已有重复的数据行</option>
                        <option value="3">3. 导入时不检查重复数据行</option>
                        <option value="4">4. 导入前清空所有现有数据</option>
                    </select>
                    &nbsp&nbsp;
                    关键字：
                    <select id="selKey">
                        <%=keylist1 %>
                    </select>
                    <span style="display:none;">
                        <asp:CheckBox ID="CheckBox1" runat="server" Text=" 导入之前清空所有现有数据" />
                        <span style="color:red;">（如果需要重新导入可以勾选，否则不要勾选）</span>
                    </span>
                </td>
            </tr>
            <tr>
                <td><span class="step">处理<br/>结果</span>
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" CssClass="resultArea" Height="40" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
        </table>
        </dd>
        <dt>模板设计</dt>
        <dd>
            <div class="info center" style="width:700px;display:none;"></div>
            <table align="center" class="frametbl" border="1">
            <tr>
                <th align="center" height="30">表单字段</th>
                <th align="center">选中字段</th>
                <th align="center">操作</th>
            </tr>
            <tr>
                <td width="40%" valign="top" align="center">
                    <ul id="tablefld" class="connSortable">
                        <%=fieldlist1 %>
                    </ul>
                </td>
                <td width="40%"  valign="top" align="center">
                    <ul id="tablesel" class="connSortable">
                    </ul>
                </td>
                <td valign="top">
                    <input type="button" class="btn01" id="btnCreate" value="&nbsp;&nbsp;生成模板&nbsp;&nbsp;" />
                </td>
                </tr>
                
                </table>
        </dd>
        <dt>模板填报说明</dt>
        <dd>
            <div style="text-align:left;line-height:1.8;padding:10px;">
                <p>
                    1、日期类型字段要求格式为： <u>年-月-日</u>（如 2008-8-8）；
                </p>
                <%=noteHtml %>
            
            </div>
        </dd>

        </dl>
    </div>
    </form>
</body>
</html>
