<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_DeEdit.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_DeEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>[兼职管理] 编辑记录</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script type="text/javascript" src="../../js/jquery.masked.js"></script>
    <script type="text/javascript" src="../../js/jquery.smartMenu.js"></script>
    <script src="../../Js/DateExt.js" type="text/javascript"></script>
    <style type="text/css">
        #maindiv{padding-bottom:20px;padding-top:10px;width:400px}
    </style>
    <script type="text/javascript">
        function afterSave() {
            $.noticeAdd({ text: '保存成功！', stay: false });
            window.setTimeout(function () {
                frameElement.lhgDG.curWin.app_query();
                frameElement.lhgDG.cancel();
            }, 1000);

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav">
            <span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
                <asp:LinkButton CssClass="linkbtn" ID="LinkButton1" runat="server" 
                onclick="LinkButton1_Click">保存</asp:LinkButton>
				<em class="split">|</em>
                <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
            </span>
        </div>
    </div>
    
    
    <div id="maindiv">
    <%=TipMessage %>
     <table align="center" class="normaltbl" border="1"><caption align="middle" height="25">兼职岗位信息表</caption>
        <tbody>
        <tr>
            <td width="30%">&nbsp;员工姓名</td>
            <td><table border=0 width='100%' class='RequiredTbl'><tr><td>
                <input  type="text" id='input09' name='input09'  class='TextBoxInChar Read openpage emptytip'  readonly value="<%=EmpName %>"  title="请双击选择" emptytip='<请双击选择>' url="../Common/UserTree.aspx?method=&queryfield=empid,empname&cid=EmployeeId,input09" /></td><td class='RequiredStar'>*</td></tr></table></td>
        </tr>
        <tr>
            <td>&nbsp;兼职岗位</td>
            <td><table border=0 width='100%' class='RequiredTbl'><tr><td>
            <input  type="text" id='input08' name='input08'  class='TextBoxInChar Read openpage emptytip'  readonly   value="<%=PosName %>"  title="请双击选择" emptytip='<请双击选择>' url="../Common/PositionTree.aspx?method=1&queryfield=positionid,positionname,deptname&cid=PositionId,input08,input07" /></td><td class='RequiredStar'>*</td></tr></table></td>
        </tr>
        <tr>
            <td width="30%">&nbsp;兼职部门</td>
            <td><table border=0 width='100%' class='RequiredTbl'><tr><td>
            <input class='TextBoxInChar Read'  readonly  type='text' name='input07' id='input07' maxlength='100' title="最多输入100个字符"  value="<%=DeptName %>"  /></td><td class='RequiredStar'>*</td></tr></table></td>
        </tr>
        <tr>
            <td>&nbsp;生效日期</td>
            <td><table border=0 width='100%' class='RequiredTbl'><tr><td>
            <input maxlength='10' title="只能输入如yyyy-mm-dd格式的日期字符串" class='Wdate TextBoxInDate'  onFocus='WdatePicker({onpicked:_datePicked});' type='text' value='<%=StartDate %>' id='txtStart' name='txtStart'   /></td><td class='RequiredStar'>*</td></tr></table></td>
        </tr>
        <tr>
            <td>&nbsp;失效日期</td>
            <td><table border=0 width='100%' class='RequiredTbl'><tr><td>
            <input maxlength='10' title="只能输入如yyyy-mm-dd格式的日期字符串" class='Wdate TextBoxInDate'  onFocus='WdatePicker({onpicked:_datePicked});' type='text' value='<%=EndDate %>' id='txtEnd' name='txtEnd'   /></td><td class='RequiredStar'></td></tr></table></td>
        </tr>
        </tbody>
    </table>
    </div>
    <div class='hidden'>
        <input  type='text' name='input01' id='input01' maxlength='100' value=""  />
        <input  type='text' name='EmployeeId' id='EmployeeId' maxlength='50' value="<%=EmpId %>"  />
        <input  type='text' name='PositionId' id='PositionId' maxlength='50' value="<%=PosId %>"  />
    </div>
    </form>

</body>
</html>
    <script type="text/javascript">
        var _isNew = true;

        //返回列表
        function _appBack(){
            window.history.back();
        }
        //关闭窗口
        function _appClose(){
            if(!!frameElement){
                if(!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else
                    window.close();
            }
            else{
                window.close();
            }
        }
        // 针对my97日历控件，把 onpicked 转化为change事件
        function _datePicked(obj) { $(obj.srcEl).change(); }

        jQuery("input.emptytip").emptyValue();
        jQuery("textarea.emptytip").emptyValue();

        jQuery(":text,.TextBoxInArea").live("focus", function () {
            _inputBg = { "backgroundColor": $(this).css("background-color"), "backgroundImage": $(this).css("background-image") };
            $(this).css({ "backgroundColor": "#fffacd", "backgroundImage": "none" });
        });

        jQuery(":text,.TextBoxInArea").live("blur", function () {
            $(this).css(_inputBg);
        });

        jQuery(".openpage").live("dblclick", function () {
            var url = $(this).attr("url");
            if (!!url) {
                _openCenter(url, "_blank", 640, 500);
            }
        });
        //弹出窗口
        function _openCenter(url, name, width, height) {
            var str = "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width;
            if (window.screen) {
                var ah = screen.availHeight - 30;
                var aw = screen.availWidth - 10;
                var xc = (aw - width) / 2;
                var yc = (ah - height) / 2;
                str += ",left=" + xc + ",screenX=" + xc + ",top=" + yc + ",screenY=" + yc;
                str += ",resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no";
            }
            return window.open(url, name, str);
        }
    </script>
