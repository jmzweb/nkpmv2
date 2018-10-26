<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org_DeptEdit.aspx.cs" Inherits="EIS.WebBase.SysFolder.Org.Org_DeptEdit" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>部门信息</title>
    <meta http-equiv="Pragma" content="no-cache" />
    <link type="text/css" rel="stylesheet" href="../../Css/appInput.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script src="../../Js/jquery.cookie.js" type="text/javascript"></script>

    <style type="text/css">
        table{border-color:gray;}
        td{padding:5px;border-color:gray;height:25px;}
        body{background:white;}
        input[type=text]{width:220px;}
        .topnav button{
	        padding:1px;
	        margin:1px;
	        width: auto;
	        height:23px;
	        background-color:transparent;
	        border-width:0px;
            overflow:visible;
        }
        .topnav button img{
	        margin-right:2px;
            vertical-align:middle;
        }

        .imgbutton{
	        padding:0px 4px;
	        line-height:26px;
	        margin:1px;
	        width: auto;
            overflow:visible;
            cursor:pointer;
        }
        .imgbutton img{
            vertical-align:baseline;
            line-height:26px;
            margin-right:4px;
        }
        
        a
        {
            text-decoration: none;
            outline-style: none;
        }
        .tabs
        {
            padding-bottom: 0px;
            list-style-type: none !important;
            margin: 0px 0px 10px;
            padding-left: 0px;
            padding-right: 0px;
            zoom: 1;
            padding-top: 0px;
        }
        .tabs:before
        {
            display: inline;
            content: "";
        }
        .tabs:after
        {
            display: inline;
            content: "";
        }
        .tabs:after
        {
            clear: both;
        }
        .tabs li
        {
            padding-left: 5px;
            float: left;
        }
        .tabs li a
        {
            display: block;
        }
        .tabs
        {
            border-bottom: #d0e1f0 1px solid;
            width: 100%;
            float: left;
        }
        .tabs li
        {
            position: relative;
            top: 1px;
        }
        .tabs li a
        {
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
        .tabs li a:hover
        {
            background-color: #fff;
            text-decoration: none;
        }
        .tabs li.selected a
        {
            border-bottom: transparent 1px solid;
            border-left: #81b0da 1px solid;
            background-color: #fff;
            color: #000;
            border-top: #81b0da 1px solid;
            font-weight: bold;
            border-right: #81b0da 1px solid;
            _border-bottom-color: #fff;
        }
        #tabControl{}
        .blue{color:Blue;}
        #listTbl th{background-color:lightblue;border:1px solid gray;color:#444;}
        #listTbl td{text-align:center;}
        #editTbl {display:none;font-size:10pt;background-color:#f8f8ff;}
        #editTbl input[type=text]{border:1px solid gray;padding-left:3px;}
        #leader_Biz label{margin-right:5px;}
        select{width:140px;}
    </style>
</head>
<body>
    <form runat="server" id="form1">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav" style="line-height:26px;text-align:right;padding-right:60px;">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="hidden" onclick="LinkButton2_Click">保存后新增</asp:LinkButton>&nbsp;&nbsp;
            <button id="btnMove" class="imgbutton" type="button" title="把当前部门下的岗位和人员转移到另外一部门"><img alt="转移" src="../../img/common/side_contract.png" />转移</button>&nbsp;&nbsp;
            <button id="btnMerge" class="imgbutton" type="button" title="把当前部门下的岗位和人员合并到另外一部门"><img alt="合并" src="../../img/common/site.png" />合并</button>&nbsp;&nbsp;
            <button id="btnSave" class="imgbutton" type="button" title="保存"><img alt="保存" src="../../img/common/ico5.gif" />保存</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="hidden" onclick="LinkButton1_Click">保存</asp:LinkButton>
        </div>
    </div>
    
    <div  id="maindiv" style="width:700px;padding-top:5px;">
        <%=TipMessage %>
        <ul class="tabs">
            <li class="selected"><a href="#tabpage1">基本信息表</a></li>
            <li><a href="#tabpage2">业务负责人</a></li>
        </ul>
        <div id="tabControl">
            <div >
            <table class='normaltbl' style="width:100%;" border="1"   align="center">
            <caption>组织机构信息</caption>
            <tbody>
              <tr>
                <td  width="100">&nbsp;组织编码</td>
                <td  >
                    <asp:TextBox ID="txtCode" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                </td>

                <td width="100">&nbsp;组织简称</td>
                <td >
                    <asp:TextBox ID="txtAbbr" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
            <td  >&nbsp;组织名称</td>
                <td  >
                    <asp:TextBox ID="txtName" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                </td>
                <td>&nbsp;组织全称</td>
                <td >
                    <asp:TextBox ID="txtFullName" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
            
                </td>

           </tr>

            <tr>
                <td>&nbsp;组织类型</td>
                <td>
                    <asp:DropDownList ID="listType" runat="server">
                    </asp:DropDownList>
                </td>
                <td>&nbsp;组织状态</td>
                <td >
                    <asp:RadioButtonList ID="RadioState" runat="server" 
                        RepeatDirection="Horizontal" RepeatLayout="Flow" Width="193px">
                        <asp:ListItem>正常</asp:ListItem>
                        <asp:ListItem>停用</asp:ListItem>
                    </asp:RadioButtonList>
                </td>

            </tr> 
                <tr>
                <td>&nbsp;组织级别</td>
                <td>
                    <asp:DropDownList ID="listProp" runat="server">
                    </asp:DropDownList>
                </td>
                <td>&nbsp;组织WBS</td>
                <td >
                    <asp:TextBox ID="txtWbs" CssClass="TextBoxInChar Read" runat="server"></asp:TextBox>
                </td>
            </tr> 
            <tr>
                <td>&nbsp;所属区域</td>
                <td>
                    <asp:DropDownList ID="listArea" runat="server">
                    </asp:DropDownList>
                </td>
                <td>&nbsp;成本中心编码</td>
                <td >
                    <asp:TextBox ID="txtCostCode" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                </td>
                </tr>
              <tr>
                <td>
                    &nbsp;负责人岗位</td>
                <td>
        
                  <asp:DropDownList Width="140" ID="selPosition" runat="server">
                  </asp:DropDownList>
                  <span class="blue" id="spanfzr">&nbsp;<%=deptLeaders %></span>
                 </td>
                <td>
                    &nbsp;副负责人</td>
                    <td>
                    <asp:TextBox ID="txtPicName2" CssClass="TextBoxInChar Read" Width="180" runat="server"></asp:TextBox>
                    <a href="javascript:" id="btnPic2">【选择】</a>
                    <asp:HiddenField ID="hidPicId2" runat="server" />

                  </td>
                </tr>
                <tr>
                    <td>
                    &nbsp;分管领导</td>
                    <td>
                    <asp:TextBox ID="UpLeader2" CssClass="TextBoxInChar Read" Width="180" runat="server"></asp:TextBox>
                    <a href="javascript:" id="btnUpLeader2">【选择】</a>
                    <asp:HiddenField ID="UpLeaderId2" runat="server" />

                  </td>
                <td>&nbsp;分管领导岗位</td>
                <td >
                    <asp:TextBox ID="UpLeader" CssClass="TextBoxInChar Read" Width="180" runat="server"></asp:TextBox>
                    <a href="javascript:" id="btnUpLeader">【选择】</a>
                    <asp:HiddenField ID="UpLeaderId" runat="server" />

                </td>

                </tr>

                <tr style="display:none1;">
                <td>&nbsp;管理员</td>
                <td >
                    <asp:TextBox ID="AdminCn" CssClass="TextBoxInChar Read" Width="180" runat="server"></asp:TextBox>
                    <a href="javascript:" id="btnAdminCn">【选择】</a>
                    <asp:HiddenField ID="AdminId" runat="server" />

                </td>
                <td>
                    &nbsp;公文收发员</td>
                <td>
                    <asp:TextBox ID="DeptSfwCn" CssClass="TextBoxInChar Read" Width="180" runat="server"></asp:TextBox>
                    <a href="javascript:" id="btnDeptSfwCn">【选择】</a>
                    <asp:HiddenField ID="DeptSfwId" runat="server" />
                  </td>
                </tr>
                <tr>
                    <td>&nbsp;排序</td>
                    <td>
                        <asp:TextBox ID="txtOrder" CssClass="TextBoxInChar" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;工作日历</td>
                    <td>
                        <asp:DropDownList ID="selCalendar" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;生效日期</td>
                    <td>&nbsp;<asp:Label Text="" ID="labelst" runat="server" /></td>
                    <td>&nbsp;失效日期</td>
                    <td>&nbsp;<asp:Label Text="" ID="labelet" runat="server" /></td>
                </tr>
            </tbody>
            </table>
            </div>
            <div style="display:none;">
                <table id="listTbl" width="100%" class="normaltbl">
                    <thead>
                        <tr>
                            <th width="100">负责人</th>
                            <th width="100">类&nbsp;&nbsp;型</th>
                            <th >分管业务</th>
                            <th width="100">操&nbsp;&nbsp;作</th>
                        </tr>
                    </thead>
                    <tbody style="text-align:center">
                        <%=LeaderList %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>
                                <button type="button" id="btnAdd">添 加</button>
                            </td>
                            <td colspan="3" align="left">
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <br />
                <table id="editTbl" border="0" width="500" align="left">
                <tbody>
                    <tr>
                        <td width="80" align="left">&nbsp;&nbsp;负&nbsp;责&nbsp;人：</td>
                        <td align="left">
                            <input type="text" readonly="readonly" class="TextBoxInChar" id="leader_Cn"/>
                            <input type="hidden" id="leader_Id" />
                            <a href="javascript:" id="A1">【选择】</a>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;&nbsp;类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
                        <td align="left">
                            <asp:RadioButtonList ID="leader_Type" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                <asp:ListItem Text="部门负责人  " value="1" Selected="True"/>
                                <asp:ListItem Text="分管领导"  value="2"/>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;&nbsp;分管业务：</td>
                        <td align="left">
                            <asp:CheckBoxList ID="leader_Biz" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td></td>
                            <td align="left">
                                <button type="button" id="leader_Save"> 保 存 </button>&nbsp;&nbsp;
                                <button type="button" id="leader_Close"> 取 消 </button>
                                
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
    </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var editId = "", index = 0, max = 0;
    var _curClass = EIS.WebBase.SysFolder.Org.Org_DeptEdit;
    $(document).ready(function () {
        $("#selPosition").change(function () {
            var fzr = _curClass.GetEmployees($(this).val()).value;
            $("#spanfzr").html("&nbsp;" + fzr);
        });
        max = $("#listTbl>tbody>tr").length;

        $(".Read").attr("readonly", true);
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



        $(".tabs>li").click(function () {
            var i = $(this).index();
            $("li.selected").removeClass("selected");
            jQuery.cookie("selTabDept", i);
            $(this).addClass("selected");
            $("#tabControl").children().hide();
            $("#tabControl").children(":eq(" + i + ")").show();

        });

        var selTab = jQuery.cookie("selTabDept");
        if (selTab) {
            $(".tabs>li").eq(selTab).click();
        }

        $("#btnSave").click(function () {
            var deptName = $("#txtName").val();
            window.parent.frames["left"].nodeNameChange(deptName);
            __doPostBack('LinkButton1', '');
        });
        $("#txtName").change(function () {
            //window.parent.frames["left"].nodeNameChange(this.value);
        });
        jQuery("#btnUpLeader").click(function () {
            openpage('../Common/PositionTree.aspx?method=1&queryfield=positionid,positionname&cid=UpLeaderId,UpLeader');
        });
        jQuery("#btnAdminCn").click(function () {
            openpage('../Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=AdminId,AdminCn');
        });

        jQuery("#A1").click(function () {
            openpage('../Common/UserTree.aspx?method=2&queryfield=empid,empname&cid=leader_Id,leader_Cn');
        });

        jQuery("#btnPic2").click(function () {
            openpage('../Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=hidPicId2,txtPicName2');
        });

        jQuery("#btnUpLeader2").click(function () {
            openpage('../Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=UpLeaderId2,UpLeader2');
        });

        jQuery("#btnDeptSfwCn").click(function () {
            openpage('../Common/UserTree.aspx?method=1&queryfield=empid,empname&cid=DeptSfwId,DeptSfwCn');
        });

        jQuery("#btnMove").click(function () {
            window.location = "Org_DeptMove.aspx?deptId=<%=deptId %>";
        });
        jQuery("#btnMerge").click(function () {
            window.location = "Org_DeptMerge.aspx?deptId=<%=deptId %>";
        });

    });
    function notFind() {
        alert("找不到对应的公司");
        window.location = "../../welcome.htm";
    }
    function returnList() {

    }
    function openCenter(url, name, width, height) {
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

    function openpage(url) {
        openCenter(url, "_blank", 600, 500);
    }
</script>

