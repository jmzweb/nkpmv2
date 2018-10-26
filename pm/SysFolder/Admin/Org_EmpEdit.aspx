<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_EmpEdit.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_EmpEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>员工信息</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script type="text/javascript" src="../../js/tools.js"></script>
    <script src="../../Js/jquery.cookie.js" type="text/javascript"></script>
    <style type="text/css">
        table.normaltbl {
            border-color: gray;
            width: 700px;
        }
        td {
            padding: 5px;
            border-color: gray;
            height: 25px;
        }
        #maindiv {
            width: 700px;
        }
        body {
            background: white;
        }
        input[type=text] {
            width: 220px;
        }
        #selPosition {
            float: left;
            margin-right: 10px;
        }
        #txtNewPos {
            background-image: url();
            background-color: #fff280;
        }
        #initPass {
            border-width: 0px;
            color: Blue;
        }
        .topnav a {
            color: blue;
            text-decoration: none;
            font-size: 10pt;
        }
        .topnav a:hover {
            color: red;
            text-decoration: none;
            font-size: 10pt;
        }
        
        .tabs {
            padding-bottom: 0px;
            list-style-type: none !important;
            margin: 0px 0px 10px;
            padding-left: 0px;
            padding-right: 0px;
            zoom: 1;
            padding-top: 0px;
        }
        .tabs:before {
            display: inline;
            content: "";
        }
        .tabs:after {
            display: inline;
            content: "";
        }
        .tabs:after {
            clear: both;
        }
        .tabs li {
            padding-left: 5px;
            float: left;
        }
        .tabs li a {
            display: block;
        }
        .tabs {
            border-bottom: #d0e1f0 1px solid;
            width: 100%;
            float: left;
        }
        .tabs li {
            position: relative;
            top: 1px;
        }
        .tabs li a {
            border-bottom: #d0e1f0 1px solid;
            border-left: #d0e1f0 1px solid;
            padding-bottom: 0px;
            line-height: 28px;
            padding-left: 15px;
            padding-right: 15px;
            background: #e3edf7;
            color: #666 !important;
            border-top: #d0e1f0 1px solid;
            margin-right: 2px;
            border-right: #d0e1f0 1px solid;
            padding-top: 0px;
            border-radius: 4px 4px 0 0;
            -webkit-border-radius: 4px 4px 0 0;
            -moz-border-radius: 4px 4px 0 0;
        }
        .tabs li a:hover {
            background-color: #fff;
            text-decoration: none;
        }
        .tabs li.selected a {
            border-bottom: transparent 1px solid;
            border-left: #81b0da 1px solid;
            background-color: #fff;
            color: #000;
            border-top: #81b0da 1px solid;
            font-weight: bold;
            border-right: #81b0da 1px solid;
            _border-bottom-color: #fff;
        }
        #tabControl {
        }
        #listTbl th {
            background-color: lightblue;
            border: 1px solid gray;
            color: #444;
        }
        #listTbl td {
            text-align: center;
        }
        #editTbl {
            display: none;
            font-size: 10pt;
            background-color: #f8f8ff;
        }
        #editTbl input[type=text] {
            border: 1px solid gray;
            padding-left: 3px;
        }
        #leader_Biz label {
            margin-right: 5px;
        }
        #txtDeptName {
            background: transparent;
        }
    </style>
    <script type="text/javascript">
        function afterSave() {
            $.noticeAdd({ text: '保存成功！', stay: false, onClose: function () {
                frameElement.lhgDG.curWin.app_query();
                frameElement.lhgDG.cancel();
            }
            });
        }
		//关闭窗口
        function _appClose() {
            if (!!frameElement) {
                if (!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else
                    window.close();
            }
            else {
                window.close();
            }
        }
    </script>
</head>
<body>
    <form runat="server" id="form1">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav">
            <span style="float:right;margin-right:30px;">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="hidden" onclick="LinkButton2_Click">【保存后新增】</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">【保存】</asp:LinkButton>&nbsp;
            <a href="javascript:" onclick="_appClose()" >【关闭】</a>
            </span>
        </div>
    </div>
    <div id="maindiv">
        <%=TipMessage %>
        <div id="tabControl">
            <div>
                <table class='normaltbl' border="1" align="center">
                    <caption>
                        员工基本信息</caption>
                    <tbody>
                        <tr>
                            <td width="100">
                                &nbsp;员工姓名<span class='RequiredStar'>&nbsp;*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpName" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                            <td width="100">
                                &nbsp;员工编号
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpCode" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;性 别
                            </td>
                            <td class="style1">
                                <asp:RadioButtonList ID="selSex" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                    Width="193px">
                                    <asp:ListItem>男</asp:ListItem>
                                    <asp:ListItem>女</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                                &nbsp;出生日期 &nbsp;
                            </td>
                            <td>
                                <asp:TextBox ID="txtBirthDay" CssClass="Wdate TextBoxInDate" runat="server" MaxLength="10"
                                    ToolTip="只能输入如yyyy-mm-dd格式的日期字符串"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;所属部门<span class='RequiredStar'>&nbsp;</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDeptName" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;人员类别<span class='RequiredStar'>&nbsp;</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="selType" Width="150" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;岗位名称<span class='RequiredStar'>&nbsp;*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="selPosition" runat="server">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtNewPos" Width="100" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;职 务
                            </td>
                            <td>
                                <asp:DropDownList ID="selPosGrade" Width="150" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;登录帐号<span class='RequiredStar'>&nbsp;*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtLoginName" CssClass="TextBoxInChar" runat="server" Width="220px"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;登录密码
                            </td>
                            <td style="background-color: White;">
                                <input type="button" value="重置密码" style="display: none;" id="initPass" />
                                <span style='color: Red;'>&nbsp;默认密码为
                                    <%=EIS.AppBase.AppSettings.Instance.EmployeeDefaultPass%></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;是否锁定<span class='RequiredStar'>&nbsp;</span>
                            </td>
                            <td class="style1">
                                <asp:RadioButtonList ID="selLock" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                    Width="193px">
                                    <asp:ListItem>是</asp:ListItem>
                                    <asp:ListItem>否</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                                &nbsp;锁定原因
                            </td>
                            <td>
                                <asp:TextBox ID="txtLockReason" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                &nbsp;电子邮件
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;移动电话
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobile" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;办公电话
                            </td>
                            <td>
                                <asp:TextBox ID="txtOfficePhone" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;通讯录
                            </td>
                            <td>
                                <asp:RadioButtonList ID="selOutList" runat="server" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow" Width="193px">
                                    <asp:ListItem Value="否">可见</asp:ListItem>
                                    <asp:ListItem Value="是">不可见</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;虚拟用户<span class='RequiredStar'>&nbsp;</span>
                            </td>
                            <td class="style1">
                                <asp:RadioButtonList ID="selVirtEmp" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                    Width="193px">
                                    <asp:ListItem Value="1">是</asp:ListItem>
                                    <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td></td>
                            <td></td>
                            </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var editId = "", index = 0, max = 0;
    var _curClass = EIS.WebBase.SysFolder.Org.Org_EmpEdit;
    $(document).ready(function () {
        $("#selPosition").change(function () {
            var posId = $(this).val();
            if (posId == "" && "<%=EditEmployeeId %>" == "") {
                $("#txtNewPos").show();
            }
            else {
                $("#txtNewPos").hide();
            }
        }).change();

        $(".Read").attr("readonly", true);
        $(".Wdate").focus(function () {
            WdatePicker({ isShowClear: false, dateFmt: 'yyyy-MM-dd' });
        });
        var validator = $("#form1").validate({
            rules: {
                txtEmpName: "required",
                txtLoginName: "required"
            }
        });
        $("#LinkButton1,#LinkButton2").click(function () {
            return $("#form1").valid();
        });
        $("#initPass").click(function () {
            var empId = "<%=EditEmployeeId %>";
            if (empId) {
                if (!confirm("您确认重置密码吗？"))
                    return;
                var ret = _curClass.InitialPassWord(empId);
                if (ret.error) {
                    alert("密码重置时出现错误:" + ret.error.Message);
                }
                else {
                    alert("已经把密码成功初始化");
                }
            }
        });

        $("#btnAdd").click(function () {
            editId = "";
            index = max++;

            $("#leader_Id").val("");
            $("#leader_Cn").val("");
            $(":radio", "#leader_Type").prop("checked", false);
            $(":checkbox", "#leader_Biz").prop("checked", false);

            $("#editTbl").show();
        });
        $("#leader_Save").click(function () {
            var arr = [];
            arr.push("<%=deptId %>");
            arr.push($(":checked", "#leader_Type").val());
            var bizType = [];
            $(":checkbox:checked", "#leader_Biz").each(function () {
                bizType.push(this.value);
            });
            arr.push(bizType.join(","));
            arr.push($("#leader_Id").val());
            arr.push($("#leader_Cn").val());

            //编辑
            if (editId) {
                var ret = _curClass.Leader_Save(arr, editId);
                if (ret.error)
                    alert("保存时出错:" + ret.error.Message);
                else {
                    $.noticeAdd({ text: '保存成功！', stay: false });
                    $("#editTbl").hide();

                    //保存到变量
                    $("#LeaderType_" + index).val(arr[1]);
                    $("#BizType_" + index).val(arr[2]);
                    $("#LeaderId_" + index).val(arr[3]);
                    $("#LeaderCn_" + index).val(arr[4]);

                    $("#sp_name_" + index).html(arr[4]);
                    $("#sp_biz_" + index).html(arr[2]);
                    $("#sp_type_" + index).html(arr[1] == "1" ? "部门负责人" : "分管领导");

                }
            }
            else {
                var ret = _curClass.Leader_Save(arr, "");
                if (ret.error)
                    alert("保存时出错:" + ret.error.Message);
                else {
                    $.noticeAdd({ text: '保存成功！', stay: false });
                    $("#editTbl").hide();
                    var newId = ret.value;

                    var newRow = [];
                    newRow.push("<tr>");
                    newRow.push("<td>"
                        , "<span id='sp_name_" + index + "'>", arr[4], "</span>"
                        , "<input type='hidden' id='LeaderId_" + index + "' value='", arr[3], "' />"
                        , "<input type='hidden' id='LeaderCn_" + index + "' value='", arr[4], "' /></td>");

                    newRow.push("<td>"
                        , "<span id='sp_type_" + index + "'>", arr[1] == "1" ? "部门负责人" : "分管领导"
                        , "</span><input type='hidden' id='LeaderType_" + index + "' value='", arr[1], "' /></td>");

                    newRow.push("<td>"
                        , "<span id='sp_biz_" + index + "'>", arr[2], "</span><input type='hidden' id='BizType_" + index + "' value='", arr[2], "' /></td>");

                    newRow.push("<td>"
                        , "<a index='" + index + "' recid='", newId, "' class='linkEdit' href='javascript:'>编辑</a>&nbsp;&nbsp;"
                        , "<a recid='", newId, "' class='linkDel' href='javascript:'>删除</a></td>"
                    );
                    newRow.push("</tr>");

                    $("#listTbl>tbody").append(newRow.join(""));

                }
            }

        });

        $(".linkEdit").live("click", function () {
            $("#editTbl").show();
            index = $(this).attr("index");
            editId = $(this).attr("recid");
            $("#leader_Id").val($("#LeaderId_" + index).val());
            $("#leader_Cn").val($("#LeaderCn_" + index).val());
            var t = $("#LeaderType_" + index).val();
            $(":radio[value='" + t + "']", "#leader_Type").prop("checked", true);
            var b = $("#BizType_" + index).val();
            $(":checkbox", "#leader_Biz").prop("checked", false);
            $.each(b.split(','), function (i, b) {
                $(":checkbox[value='" + b + "']", "#leader_Biz").prop("checked", true);
            });

        });
        $(".linkDel").live("click", function () {
            editId = $(this).attr("recid");

            var ret = _curClass.Leader_Del(editId);
            if (ret.error)
                alert("删除时出错:" + ret.error.Message);
            else {
                $.noticeAdd({ text: '删除成功！', stay: false });
                $(this).closest("tr").remove();
            }
        });

        $("#leader_Close").click(function () {
            $("#editTbl").hide();
        });

        jQuery("#A1").click(function () {
            openpage('../Common/UserTree.aspx?method=2&queryfield=empid,empname&cid=leader_Id,leader_Cn');
        });

        $(".tabs>li").click(function () {
            var i = $(this).index();
            $("li.selected").removeClass("selected");
            jQuery.cookie("selTabEmp", i);
            $(this).addClass("selected");
            $("#tabControl").children().hide();
            $("#tabControl").children(":eq(" + i + ")").show();

        });

        var selTab = jQuery.cookie("selTabEmp");
        if (selTab) {
            $(".tabs>li").eq(selTab).click();
        }
    });
    function notFind() {
        alert("找不到对应的公司");
        window.location = "../../welcome.htm";
    }
    function returnList() {
        var lastUrl = "<%=Request.UrlReferrer %>";
        if (lastUrl.indexOf("restore") > 0)
            window.open(lastUrl, "_self");
        else
            window.open(lastUrl + "&restore=1", "_self");
    }
</script>
