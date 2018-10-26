<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalInfo.aspx.cs" Inherits="EIS.Web.WorkAsp.Personal.PersonalInfo" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AdminLTE 2 | User Profile</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../Theme/AdminLTE//bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../Theme/AdminLTE/dist/css/AdminLTE.min.css">
       <link rel="stylesheet" href="../../Theme/AdminLTE/plugins/datepicker/datepicker3.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../Theme/AdminLTE/dist/css/skins/_all-skins.min.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        #PositionList, #DivChkHideAll span, #selSex {
            border: 0;
        }

        #txtBirthDay {
            height: auto;
            border: #d2d6de 1px solid;
        }
    </style>
</head>
<body class="skin-blue sidebar-mini">
    <form runat="server" class="form-horizontal" id="form1">
        <div class="wrapper">
            <div class="content-wrapper" style="width: 100%; margin-left: 0px; min-height: 632px;">
                <!-- Content Header (Page header) -->
                <!-- Main content -->
                <section class="content">

                    <div class="row">
                        <div class="col-md-3">

                            <!-- Profile Image -->
                            <div class="box box-primary">
                                <div class="box-body box-profile">
                                    <img class="profile-user-img img-responsive img-circle" src="<%=photoPath %>" alt="头像">
                                    <h3 class="profile-username text-center" id="TitleName"></h3>
                                    <p class="text-muted text-center" id="TitleCode"></p>

                                    <ul class="list-group list-group-unbordered">
                                        <li class="list-group-item">
                                            <b><font><font>岗位</font></font></b><a class="pull-right"><font><font><%=Session["PositionName"] %></font></font></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b><font><font>部门</font></font></b><a class="pull-right"><font><font><%=Session["DeptName"] %></font></font></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b><font><font>公司</font></font></b><a class="pull-right"><font><font><%=Session["CompanyName"] %></font></font></a>
                                        </li>
                                    </ul>
                                    <asp:FileUpload ID="FileUpload2" class="btn btn-primary btn-block" runat="server" />

                                </div>
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                            <!-- About Me Box -->
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><font><font>签名</font></font></h3>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                     <img style="width:100px;height:50px;" class="profile-user-img img-responsive " alt="个人签名" src="../../SysFolder/Common/SignImage.aspx?uId=<%=EditEmployeeId %>&rnd=<%=DateTime.Now.Ticks %>" /><br />
                                     <asp:FileUpload ID="FileUpload1" class="btn btn-primary btn-block"  runat="server" />&nbsp;&nbsp;<br />
                                    <p style="font-size:12px;color:red;">要求PNG格式（背景透明），大小100*50在审批打印时使用，更新签名时请先选择签名文件，然后点击右上角的【保存】</p>
                          
                                </div>
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-9">
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#settings" data-toggle="tab" aria-expanded="true"><font><font>设置</font></font></a></li>
                                </ul>
                                <div class="tab-content">
                                    <!-- /.tab-pane -->
                                    <div class="tab-pane active" id="settings">
                                        <div class="form-group" style="display:none;">
                                            <label for="inputName" class="col-sm-2 control-label"><font><font>姓名</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtEmpName" ReadOnly="true" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group" style="display:none;">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>编号</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtEmpCode" ReadOnly="true" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputName" class="col-sm-2 control-label"><font><font>性别</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:RadioButtonList ID="selSex" Enabled="false" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="form-control" RepeatLayout="Flow" Width="193px">
                                                    <asp:ListItem>男</asp:ListItem>
                                                    <asp:ListItem>女</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputExperience" class="col-sm-2 control-label"><font><font>出生日期</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtBirthDay"  CssClass="Wdate form-control" runat="server"
                                                    MaxLength="10" ToolTip="只能输入如yyyy-mm-dd格式的日期字符串"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputSkills" class="col-sm-2 control-label"><font><font>电子邮件</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>移动电话</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server"></asp:TextBox>&nbsp;
                                                    <asp:CheckBox Text=" 在通讯录中隐藏电话" ToolTip="在通讯录中隐藏移动电话" ID="chkHideMobile" runat="server" />

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>家庭电话</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtHomePhone" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>办公电话</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtOfficePhone" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>邮寄地址</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtOfficeAddress" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>邮编</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtPostCode" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>身份证号</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtIdCard" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>隐藏个人信息</font></font></label>
                                            <div class="col-sm-10" id="DivChkHideAll">
                                                <asp:CheckBox CssClass="form-control" Text=" 在通信录中隐藏我的信息" ForeColor="blue" ToolTip="在通信录中隐藏我的信息" ID="chkHideAll" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label"><font><font>默认岗位</font></font></label>
                                            <div class="col-sm-10">
                                                <asp:RadioButtonList CssClass="form-control" ID="PositionList" runat="server">
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-10">

                                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-danger" OnClick="LinkButton1_Click">保存</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.tab-pane -->
                                </div>
                                <!-- /.tab-content -->
                            </div>
                            <!-- /.nav-tabs-custom -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                </section>
                <!-- /.content -->
            </div>
        </div>
        <!-- ./wrapper -->
        <!-- jQuery 2.1.4 -->


    </form>
</body>
</html>

<script src="../../Theme/AdminLTE/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../../Theme/AdminLTE/bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../../Theme/AdminLTE/plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="../../Theme/AdminLTE/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<%--<script src="../../Theme/AdminLTE/dist/js/demo.js"></script>--%>
<%--<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../../Theme/AdminLTE/plugins/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript">
    jQuery(function () {
        $('#TitleName').html($('#txtEmpName').val());
        $('#TitleCode').html($('#txtEmpCode').val());
        $('#txtBirthDay').datepicker({
            language: 'zh-CN',
            autoclose: true,
            todayHighlight: true
        });
    });

</script>
