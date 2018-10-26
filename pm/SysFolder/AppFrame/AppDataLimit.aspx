<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppDataLimit.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppDataLimit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=title %></title>
    <style>
        body { text-align: center; }
        #divcss5 { margin: 0 auto; width: 100%; }
        .table4_1 th { background-color: #d5dae0; color: #000000; }

        .table4_1, .table4_1 th, .table4_1 td { font-size: 0.95em; text-align: left; padding: 4px; border-collapse: collapse; }

        .table4_1 th, .table4_1 td { border: 1px solid #d5dae0; /*border-width: 1px 0 1px 0;*/ }

        .table4_1 tr { border: 1px solid #d5dae0; background-color: #fff; }

        .table4_1 input[type=text] { width: 200px; height: 30px; background-image: none; border-radius: 3px; border: solid 1px #999; }
        .table4_1 textarea { width: 100%; height: 300px; border: none; }
        .sel_btn { width: 56px; margin-top: 10px; margin-right: 64px; height: 21px; line-height: 21px; padding: 0 11px; background: darkGrey; border: 1px darkGrey solid; border-radius: 3px; color: #fff; display: inline-block; text-decoration: none; font-size: 12px; outline: none; }
        .menubar { height: 55px; overflow: hidden; z-index: 100; }
        .topnav { width: 100%; left: 0px; display: block; z-index: 100; overflow: visible; position: fixed; top: 0px; background: #dce6f2; height: 50px; border-bottom: 1px solid #ccc; padding-left: 10px; }
        a.linkbtn { line-height: 50px; padding: 0px 0px 0 20px; text-decoration: none; display: inline-block; color: #000; font-size: 14px; }
        a.linkbtn:hover { color: #fff; text-decoration: none; }
        #btnSave { background: url(../../grid/images/disk.png) no-repeat center left; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" onclick="SaveData();" id="btnSave" name="btnSave">保存</a>
                </span>
            </div>
        </div>
        <div id="divcss5">
            <div style="width: 95%; margin: 0 auto;">
                <div style="width: 48%; float: left;">
                    <h3>共享权限</h3>
                    <table class="table4_1" style="width: 100%">
                        <tr>
                            <td align="right" width="85">单位部门：
                            </td>
                            <td>
                                <textarea id="Dept_text" name="Dept_text" placeholder="双击选择部门" readonly="readonly" ondblclick="selectDeptTree('Hide_Dept_text_id', 'Dept_text')"></textarea>

                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>角色：<input type="text" id="Role_text" name="Role_text" placeholder="双击选择角色" readonly="readonly" ondblclick="SelectRole('Hide_Role_text_id', 'Role_text')" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>岗位：<input type="text" id="Position_text" name="Position_text" placeholder="双击选择岗位" readonly="readonly" ondblclick="SelectPosition('Hide_Position_text_id', 'Position_text')" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>人员：<input type="text" id="User_text" name="User_text" placeholder="双击选择人员" readonly="readonly" ondblclick="SelectUser('Hide_User_text_Id', 'User_text')" />
                                <input type="checkbox" id="isAll" name="isAll" /><label for="isAll">所有人</label></td>
                        </tr>
                    </table>
                </div>
                <div style="width: 48%; float: left; margin-left: 4%;">
                    <h3>管理权限</h3>

                    <table class="table4_1" style="width: 100%">
                        <tr>
                            <td align="right" width="85">管理人员：</td>
                            <td>
                                <textarea id="AdminUser_text" name="User_text" placeholder="双击选择人员" readonly="readonly" ondblclick="SelectUser('Hide_AdminUser_text_Id', 'AdminUser_text')"></textarea></td>
                        </tr>
                    </table>
                </div>
            </div>
            <asp:HiddenField ID="Hide_Dept_text_id" runat="server" />
            <asp:HiddenField ID="Hide_Role_text_id" runat="server" />
            <asp:HiddenField ID="Hide_Position_text_id" runat="server" />
            <asp:HiddenField ID="Hide_User_text_Id" runat="server" />
            <asp:HiddenField ID="Hide_AdminUser_text_Id" runat="server" />
        </div>
        <script>
            var _curClass = EZ.WebBase.SysFolder.AppFrame.AppDataLimit;
            var deptname = '<%=deptnames%>';
            var deptid = '<%=deptids%>';
            document.getElementById("Dept_text").value = deptname;
            document.getElementById("Hide_Dept_text_id").value = deptid;
            var Roleid = '<%=Roleid%>';
            var RoleName = '<%=RoleName%>';
            document.getElementById("Role_text").value = RoleName;
            document.getElementById("Hide_Role_text_id").value = Roleid;

            var posid = '<%=posid%>';
            var posName = '<%=posName%>';
            document.getElementById("Position_text").value = posName;
            document.getElementById("Hide_Position_text_id").value = posid;
            var userid = '<%=userid%>';
            var userName = '<%=userName%>';
            document.getElementById("User_text").value = userName;
            document.getElementById("Hide_User_text_Id").value = userid;

            var Auserid = '<%=Aduserid%>';
            var AuserName = '<%=AduserName%>';
            document.getElementById("AdminUser_text").value = AuserName;
            document.getElementById("Hide_AdminUser_text_Id").value = Auserid;

            function SelectUser(ctlid, ctlname) {
                openpage('../Common/UserTree.aspx?method=1&self=0&queryfield=empname,empid&cid=' + ctlname + "," + ctlid);
            }
            function SelectPosition(ctlid, ctlname) {
                openpage('../Common/PositionTree.aspx?method=2&self=0&queryfield=positionname,positionid&cid=' + ctlname + "," + ctlid);
            }
            function selectDeptTree(ctlid, ctlname) {
                openpage('../Common/DeptTree.aspx?method=2&self=0&queryfield=deptname,deptwbs&cid=' + ctlname + "," + ctlid);
            }
            function SelectRole(ctlid, ctlname) {
                openpage('../Common/RoleTree.aspx?method=2&self=0&queryfield=rolename,roleid&cid=' + ctlname + "," + ctlid);
            } 

            function openpage(url) {
                openCenter(url, "_blank", 600, 500);
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


            function SaveData() {
                var isAll = document.getElementById("isAll");
                var dept = document.getElementById("Hide_Dept_text_id").value;
                var rol = document.getElementById("Hide_Role_text_id").value;
                var pos = document.getElementById("Hide_Position_text_id").value;
                var emp = document.getElementById("Hide_User_text_Id").value;
                var adminemp = document.getElementById("Hide_AdminUser_text_Id").value;
                var ret = _curClass.Save(dept, rol, pos, adminemp, emp, "<%=appname %>", "<%=appid %>", isAll.checked);
                if (ret.error) {
                    alert("保存出错：" + ret.error.Message);
                }
                else {
                    alert("保存成功！");
                }

            }           
           
            document.getElementById("isAll").checked=<%=IsAll?0:1%>==0?true:false;
           
        </script>
    </form>
</body>
</html>
