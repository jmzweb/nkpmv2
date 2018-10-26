<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Maintain_Win.aspx.cs" Inherits="EZ.WebBase.SysFolder.WorkFlow.Admin.Admin_Maintain_Win" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程节点信息维护</title>
    <link type="text/css" rel="stylesheet" href="../../../Css/wfstyle.css" />
    <script type="text/javascript" src="../../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../../js/tools.js"></script>

    <style type="text/css">
       #maindiv{width:94%;}
       a.linkbtn{display:inline-block;line-height:30px;height:30px;}
       table.list{table-layout:fixed;
                  width:100%;
                  margin-top:10px;
                  border:1px solid #dae2e5;
                  border-collapse:collapse;
                  background-color:White;
                  }
       table.list tr{cursor:pointer;}
       .trsel{background:#fbec88}
       table.list th{padding:5px 3px;border:1px solid #dae2e5;background:rgb(229, 241, 246);color:#444;}        
                  
       table.list td{padding:6px 3px;border:1px solid #dae2e5;}
       td.deltd{cursor:pointer;}
       td.yes{background:url(../../../img/common/accept.png) no-repeat center center;}
       td.no{background:url(../../../img/common/edit.png) no-repeat center center;}
       .middlebar{
           text-align:left;
           background-color:rgb(229, 241, 246);
           border:3px solid #eee;
           margin:5px 0px;
           padding:2px 3px;
           }
       .middlebar a.linkbtn{padding:0px 5px;}
       .middlebar a.linkbtn:hover{
           background:#3e88c7;
           color:White;
           border-radius:2px;
           padding:0px 5px;
           text-decoration:none;
           }
       .middlebar a.on{
           background:#3e88c7;
           color:White;
           border-radius:2px;
           padding:0px 5px;
           text-decoration:none;
           }
       .TextBoxInChar{float:none;padding:3px;border:1px solid #bbb;}
       .TextBoxInArea{float:none;padding:3px;}
       .middlebar a.disabled{color:Gray;}
       .middlebar a.disabled:hover{color:Gray;background-color:transparent;}
       .mainzone{text-align:left;padding:10px;background-color:#e5f1f6;border-radius:3px;}
       .mainzone .innerbar{
           margin:3px 0px;
           }
       .emptytip{color:Gray;}
       .tip{margin-bottom:5px;}
       input[type=checkbox]{vertical-align:middle;line-height:24px;}
       label{cursor:pointer;line-height:24px;padding-left:5px;}
       #del_curInfo ,#chg_curInfo{height:30px;line-height:30px;}
    </style>
    <script type="text/javascript">
        var tState = "<%=tState %>";
        jQuery(function () {

            $(window).resize(function () {
                $("#maindiv").height($(document.body).height() - 60);
            });
            $("#maindiv").height($(document.body).height() - 60);

            $(".list>tbody>tr").live("click", function () {
                $(".trsel").removeClass("trsel");
                $(this).toggleClass("trsel");
                checkBtnState($(this).attr("p"));
            });

            $(".signtask,.deltask,.chgtaskuser").prop("disabled", true).addClass("disabled");


            $("#TextBox1").attr("emptytip", "<请双击选择新任务处理人>").attr("readOnly", true).dblclick(function () {
                openpage('../../Common/UserTree.aspx?method=1&queryfield=empid,empname,posid&cid=Sel_EmpId,TextBox1,Sel_PosId');
            });
            $("#TextBox2").attr("emptytip", "<请双击选择加签任务处理人>").attr("readOnly", true).dblclick(function () {
                openpage('../../Common/UserTree.aspx?method=1&queryfield=empid,empname,posid&cid=Sel_EmpId,TextBox2,Sel_PosId');
            });
            $("#TextBox3").attr("emptytip", "<请输入任务撤销原因>");
            $("#TextBox4").attr("emptytip", "<请双击选择任务处理人>").attr("readOnly", true).dblclick(function () {
                openpage('../../Common/UserTree.aspx?method=2&queryfield=empid,empname,posid&cid=Sel_EmpId,TextBox4,Sel_PosId');
            });

            $("#TextBox5").attr("emptytip", "<请双击选择该步骤处理人>").attr("readOnly", true).dblclick(function () {
                openpage('../../Common/UserTree.aspx?method=1&queryfield=empid,empname,posid&cid=Sel_EmpId,TextBox5,Sel_PosId');
            });

            $(".newtask").click(function () {
                switchZone(this, ".newTaskZone");
            });
            $(".signtask").click(function () {
                switchZone(this, ".newSignZone");
            });
            $(".deltask").click(function () {
                switchZone(this, ".delTaskZone");
            });
            $(".chgtaskuser").click(function () {
                switchZone(this, ".chgTaskUserZone");
            });
            $(".chgnodeuser").click(function () {
                switchZone(this, ".chgNodeUserZone");
            });
            $(".chglimit").click(function () {
                switchZone(this, ".chgNodeLimitZone");
            });
            jQuery(".emptytip").emptyValue();

            $("#Button1").click(function () {
                if ($("#TextBox1").val() == "") {
                    $(".tip").show().text("提示：请选择新任务处理人！");
                    return false;
                }
                return true;
            });
            $("#Button2").click(function () {
                if ($("#TextBox2").val() == "") {
                    $(".tip").show().text("提示：请选择加签任务处理人！");
                    return false;
                }
                return true;
            });
            $("#Button3").click(function () {
                if ($("#TextBox3").val() == "") {
                    $(".tip").show().text("提示：请输入任务撤销原因！");
                    return false;
                }
                return true;
            });
            $("#Button4").click(function () {
                if ($("#TextBox4").val() == "") {
                    $(".tip").show().text("提示：请选择新的任务处理人！");
                    return false;
                }
                return true;
            });
            $("#Button5").click(function () {
                if ($("#TextBox5").val() == "") {
                    $(".tip").show().text("提示：请选择该步骤处理人！");
                    return false;
                }
                return true;
            });
        });
        function switchZone(btnObj, zoneClass) {
            if ($(btnObj).prop("disabled")) return true;

            $(btnObj).siblings(".on").removeClass("on");
            $(btnObj).addClass("on");
            $(".tip").hide();
            $(zoneClass).siblings().hide();
            $(zoneClass).show();
        }
        function checkBtnState(attr) {
            var arr = attr.split("|");
            $(".deltask,.chgtaskuser").prop("disabled", false).removeClass("disabled");
            $("#del_curInfo").html("当前处理人：" + arr[3]);
            $("#chg_curInfo").html("当前处理人：" + arr[3]);
            $("#Sel_uTaskId").val(arr[0]);
            $("#Sel_TaskId").val(arr[1]);

            if (arr[2] == "0" || arr[2] == "1") {
                $(".signtask").prop("disabled", false).removeClass("disabled");

            }
            else {
                $(".signtask").prop("disabled", true).addClass("disabled");
            }
        }
    </script>
</head>
<body class="bgbody">
    <form id="form1" runat="server">
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav">
            <span style="color:#666;padding-left:24px;">步骤名称：<%=nodeName %>（<%=nodeType %>）</span>
            <span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
                <a class="linkbtn" href="javascript:" onclick="window.location.href=window.location.href;" >【刷新】</a> &nbsp;&nbsp;&nbsp;&nbsp;
            </span>
        </div>
    </div>
    
    <div id="maindiv" style="height:100%;">
        <table class="list" align="center">
            <thead>
                <tr>
                    <th width="30">序号</th>
                    <th width="120">步骤名称</th>
                    <th width="60">处理人</th>
                    <th width="50">审批</th>
                    <th >处理意见</th>
                    <th width="100">查看时间</th>
                    <th width="100">处理时间</th>
                    <th width="30">状态</th>
                </tr>
            </thead>
            <tbody>
                <%=dealList %>
            </tbody>
        </table>
        <div class="tip <%=tipClass %>"><%=tipInfo %></div>
        <div class="middlebar">
            <a class="linkbtn newtask" href="javascript:" >分配新任务</a>
                <em class="split">|</em>
            <a class="linkbtn signtask" href="javascript:" >分配加签任务</a>
                <em class="split">|</em>
            <a class="linkbtn deltask disabled" disabled="true" href="javascript:" >撤销已分配任务</a> 
                <em class="split">|</em>
            <a class="linkbtn chgtaskuser disabled" disabled="true" href="javascript:" >变更任务处理人</a> 
                <em class="split">|</em>
            <a class="linkbtn chgnodeuser" href="javascript:" >调整处理人定义</a> 
                <em class="split" style="display:none;">|</em>
            <a class="linkbtn chglimit" style="display:none;" href="javascript:" >调整操作权限</a> 
        </div>
        <div class="mainzone">
            <div class="newTaskZone hidden">
                <asp:TextBox ID="TextBox1" CssClass="TextBoxInChar emptytip" Width="300" runat="server"></asp:TextBox>
                <div class="innerbar">
                    <asp:Button ID="Button1" runat="server" Text=" 确 定 " onclick="Button1_Click" />
                </div>
            </div>
            <div class="newSignZone hidden">
                <asp:TextBox ID="TextBox2" CssClass="TextBoxInChar emptytip" Width="300" runat="server"></asp:TextBox>
                <div class="innerbar">
                <asp:Button ID="Button2" runat="server" Text=" 确 定 " onclick="Button2_Click" />
                </div>
            </div>
            <div class="delTaskZone hidden">
                <div id="del_curInfo"></div>
                <asp:TextBox ID="TextBox3" TextMode="MultiLine" Rows="3" Width="400" CssClass="TextBoxInArea emptytip" runat="server"></asp:TextBox>
                <div class="innerbar">
                <asp:Button ID="Button3" runat="server" Text=" 确 定 " onclick="Button3_Click" />        
                </div>
            </div>
            <div class="chgTaskUserZone hidden">
                <div id="chg_curInfo"></div>
                <asp:TextBox ID="TextBox4" CssClass="TextBoxInChar emptytip" Width="300" runat="server"></asp:TextBox>
                <div class="innerbar">
                <asp:Button ID="Button4" runat="server" Text=" 确 定 " onclick="Button4_Click" />        
                </div>
            </div>
            <div class="chgNodeUserZone hidden">
                <asp:HiddenField ID="Sel_TaskId" runat="server" />
                <asp:HiddenField ID="Sel_uTaskId" runat="server" />
                <asp:HiddenField ID="Sel_EmpId" runat="server" />
                <asp:HiddenField ID="Sel_PosId" runat="server" />

                <asp:TextBox ID="TextBox5" CssClass="TextBoxInChar emptytip" Width="300" runat="server"></asp:TextBox>

                <div class="innerbar">
                <asp:Button ID="Button5" runat="server" Text=" 确 定 " onclick="Button5_Click" />        
                </div>
            </div>
            <div class="chgNodeLimitZone hidden">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="CheckBox1" Text="表单编辑权限" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="CheckBox2" Text="调整预定义处理人" runat="server" />                        
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="CheckBox3" Text="回退范围" runat="server" />                        
                        </td>
                    </tr>
                </table>
                <div class="innerbar">
                    <asp:Button ID="Button6" runat="server" Text=" 确 定 " onclick="Button6_Click" />        
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>