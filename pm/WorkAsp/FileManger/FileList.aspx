<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileList.aspx.cs" Inherits="NTJT.Web.WorkAsp.FileManger.FileList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title></title>
    <script src="../../js/jQuery-2.1.4.min.js"></script> 
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" href="../../css/font-awesome.min.css">

    <link href="../../css/filemanger.css" rel="stylesheet" type="text/css" />
    <%--  <link href="../../css/appinput2.css" rel="stylesheet" type="text/css" />--%>
    <link rel="stylesheet" href="../../Static/mainpm/iconfont/iconfont.css" />
</head>
<body>
    <div class="tabitem" tabindex="8" style="display: block;">
        <div class="formtabletitle jssubtitle"><span>文档管理</span></div>
        <div class="dirlist">
            <table class="ctable customize" border="0" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="trth">
                        <td class="coldesc" style="width: 300px">存储路径</td>
                        <td class="coldesc" style="width: 300px">文档上传</td>
                        <td class="coldesc" style="width: 200px">档案名称</td>
                        <td class="coldesc">档案说明</td>
                        <td class="coldesc" style="width: 100px">版本号</td> 
                        <td class="coldesc" style="width: 100px">上传人</td>
                        <td class="coldesc" style="width: 100px">上传时间</td>

                    </tr>
                </thead>
                <tbody id="FileList">
                </tbody>
            </table>
            <div style="clear:both;margin:20px auto;width:98%;">
                <a id="SaveTD" class="btn fr"><i class="iconfont">&#xe63a;</i> 保存</a>
                <a id="AddTD" class="btn "><i class="iconfont">&#xe61e;</i> 新增</a>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    var UserName = '<%=EmployeeName %>'
    jQuery(function () {
        LoadList();
        $('#AddTD').click(function () {
            var TrLen = $('#FileList').find('.FileTr').length + 1;
            var Menu_Html = '';
            var guid = _newGuid();
            var Wordid = _newGuid();
            Menu_Html = Menu_Html + '<tr data-isNew="1" id="FileTR' + guid + '" class="FileTr" style="height:40px"><td  style="width:300px"><iframe id="frm_' + (TrLen + 1) + '" class="attachFrame" frameborder="0" scrolling="auto"  src="../../SysFolder/Common/FileListFrameNT.aspx?appName=T_PM_T_FileInfo&appId=' + guid + '&read=0&frmId=frm_' + (TrLen) + '" width="100%" height="40px"></iframe><input type="hidden" id="input' + (TrLen) + 'id" name="input018" value="' + guid + '"/></td>';
            Menu_Html = Menu_Html + '<td  style="width:300px"><iframe id="frm_' + (TrLen + 5) + '" class="attachFrame" frameborder="0" scrolling="auto"  src="../../SysFolder/Common/FileListFrameNT.aspx?appName=T_PM_T_FileInfo&appId=' + Wordid + '&read=0&frmId=frm_' + (TrLen+5) + '" width="100%" height="40px"></iframe><input type="hidden" id="input' + (TrLen+5) + 'id" name="input01" value="' + Wordid + '"/></td>';
            Menu_Html = Menu_Html+'<td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (TrLen) + '1" id="input' + (TrLen) + '1" maxlength="20" title="最多输入20个字符" value=""></td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + TrLen + '5" id="input' + (TrLen) + '5" maxlength="20" title="最多输入20个字符" value=""></td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode VerInput" type="text" name="input' + (TrLen) + '2" id="input' + (TrLen) + '2" maxlength="20" title="最多输入20个字符" value="0.0"></td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (TrLen) + '3" id="input' + TrLen + '3" maxlength="20" title="最多输入20个字符" readonly value="' + UserName + '"></td><td><input maxlength="10" title="要求输入格式：年 - 月 - 日" class="Wdate TextBoxInDate T_PM_C_GovernanceStructure_CreateDate" readonly type="text" value="' + GetTime() + '" id="input' + (TrLen) + '4" name="input' + TrLen + '4" style="color: rgb(85, 85, 85); background - image: none; background - color: rgb(255, 255, 255); "></td>';

            $('#FileList').append(Menu_Html);
        });
        $('#SaveTD').click(function () {
            var ObjTr = $('#FileList').find('.FileTr');
            var JsonData = '{"SystemType":"<%=SystemType %>","CorrelationCode":"<%=CorrelationCode %>","CatalogCode":"<%=CatalogCode %>","CorrelationName":"<%=CorrelationName %>","CatalogName":"<%=CatalogName %>","data":[';
            for (var i = 0; i < ObjTr.length; i++) {
                var Obj = $(ObjTr[i]);
                JsonData = JsonData + '{"filename":"' + Obj.find("#input" + (i + 1) + "1").val() + '","filever":"' + Obj.find("#input" + (i + 1) + "2").val() + '","fileUser":"' + Obj.find("#input" + (i + 1) + "3").val() + '","fileTime":"' + Obj.find("#input" + (i + 1) + "4").val() + '","fileNote":"' + Obj.find("#input" + (i + 1) + "5").val() + '","fileid":"' + Obj.find("#input" + (i + 1) + "id").val() + '","filetype":"' + Obj.attr('data-isNew') + '","wordid":"' + Obj.find("#input" + (i + 6) + "id").val() + '"},';
            }
            if (ObjTr.length > 0) JsonData = JsonData.substring(0, JsonData.length - 1);
            JsonData = JsonData + ']}';
            $.ajax({
                type: 'post',
                url: 'FileList.aspx',
                data: { 't': 'save', 'JsonData': escape(JsonData) },
                success: function (data) {
                    var ret = eval('(' + data + ')');
                    if (ret.success) {
                        alert("保存成功");
                        window.location.reload();
                    } else {
                        alert("保存失败");
                    }
                }
            });
        });





    });
    function LoadList() {
        $.ajax({
            type: 'post',
            url: 'FileList.aspx',
            data: { 't': 'load', 'SystemType': '<%=SystemType %>', 'CorrelationCode': '<%=CorrelationCode %>', "CatalogCode": "<%=CatalogCode %>" },
            success: function (data) {
                var ret = eval('(' + data + ')');
                var Menu_Html = "";
                if (ret.success) {
                    for (var i = 0; i < ret.rows.length; i++) {
                        var obj = ret.rows[i];
                        Menu_Html = Menu_Html + '<tr data-isNew="0"  class="FileTr"><td><iframe id="frm_' + (i + 1) + '" class="attachFrame" frameborder="0" scrolling="auto"  src="../../SysFolder/Common/FileListFrameNT.aspx?appName=T_PM_T_FileInfo&appId=' + obj.id + '&read=0&frmId=frm_' + (i + 1) + '" width="100%" height="40px"></iframe><input type="hidden" id="input' + (i + 1) + 'id" name="input018" value="' + obj.id + '"/></td>';
                        Menu_Html = Menu_Html + '><td><iframe id="frm_' + (i + 5) + '" class="attachFrame" frameborder="0" scrolling="auto"  src="../../SysFolder/Common/FileListFrameNT.aspx?appName=T_PM_T_FileInfo&appId=' + obj.wid + '&read=0&frmId=frm_' + (i + 5) + '" width="100%" height="40px"></iframe><input type="hidden" id="input' + (i + 5) + 'id" name="input018" value="' + obj.id + '"/></td>';
                        Menu_Html = Menu_Html + '<td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (i + 1) + '1" id="input' + (i + 1) + '1" maxlength="20" title="最多输入20个字符" value="' + obj.FileName + '"/></td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (i + 1) + '5" id="input' + (i + 1) + '5" maxlength="20" title="最多输入20个字符" value="' + obj.SpecialVersion + '"/></td><td class="relbox"><input class="TextBoxInChar T_PM_F_FundInfo_FundCode VerInput" type="text" name="input' + (i + 1) + '2"  id="input' + (i + 1) + '2" maxlength="20" title="最多输入20个字符" value="' + obj.Version + '"/><div class="lr_systembtn" id="CS_' + (i + 1) + '"><A class="UpA" id="Aup_' + (i + 1) + '"><i class="iconfont UpFile">&#xe674;</i></A>';
                        if (obj.Ver.length > 0)
                            Menu_Html = Menu_Html + '<div id="Sel_' + (i + 1) + '" class="lr_menu"><table><thead><tr><td>文件名</td><td style="width:50px;">版本</td><td style="width:60px;">上传人</td><td style="width:100px;">上传时间</td><td style="width:50px;">操作</td></tr></thead><tbody>';
                        //Menu_Html = Menu_Html + "<select id='Sel_" + (i + 1) + "' class='VerClass'>";
                        for (var j = 0; j < obj.Ver.length; j++) {
                            var child = obj.Ver[j];
                            //Menu_Html = Menu_Html + '<option value="' + child.id + '" data-name="' + child.filename + '">' + child.name + '</option>';
                            Menu_Html = Menu_Html + '<tr><td>' + child.filename + '</td><td>' + child.name + '</td><td>' + child.user + '</td><td>' + child.createtime + '</td><td><a href="../../SysFolder/Common/FileDown.aspx?fileid=' + child.id + '"><i class="iconfont">&#xe619;</i>下载</a></td>'
                        }
                        if (obj.Ver.length > 0)
                            Menu_Html = Menu_Html + "</tbody></table></div></div>";
                        //Menu_Html = Menu_Html + "</select>";
                        Menu_Html = Menu_Html + '</td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (i + 1) + '3" id="input' + (i + 1) + '3" maxlength="20" title="最多输入20个字符" readonly value="' + obj.UploadMan + '"/></td><td><input class="TextBoxInChar T_PM_F_FundInfo_FundCode" type="text" name="input' + (i + 1) + '4" id="input' + (i + 1) + '4" maxlength="20" title="最多输入20个字符" readonly value="' + obj.UploadTime + '"/></td></tr>';
                    }

                    $('#FileList').html(Menu_Html);
                    $('.VerClass').each(function (i, e) {
                        $(e).change(function () {
                            var id = $(this).val();
                            var name = $($(this).find("option:selected")).attr('data-name');
                            var In = $(this).attr('id').split('_')[1];
                            var arr = [];
                            arr.push("<div class='fileitem'><a class='filelink' href='FileDown.aspx?fileId=");
                            arr.push(id);
                            arr.push("' target='_blank'>");
                            arr.push(name);
                            arr.push("</a>");
                            arr.push("<div class='toolbar'>")
                            arr.push("<a class='lnkbtn downlink' href='javascript:' fileid='", id, "' >[下载]</a> ");
                            arr.push("</div>");
                            arr.push("</div>");
                            $('#frm_' + In).contents().find(".oldfilecontent").html(arr.join(""));
                        });
                    });
                    $(".UpA").click(function () {
                        var $t = $(this);
                        if ($t.attr("open")) {
                            $t.removeAttr("open");
                            $t.next("div").hide();
                            $t.find(".iconfont").html("&#xe674;");
                        } else {
                            $t.attr("open", "1");
                            $t.next("div").show();
                            $t.find(".iconfont").html("&#xe673;");
                        }
                    }); 
                }

            },
            error: function (request, textStatus, errorThrown) {
            }
        });
    }
    // 针对my97日历控件，把 onpicked 转化为change事件
    function _datePicked(obj) { $(obj.srcEl).change(); }
    function GetTime() {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1; //js从0开始取 
        var date1 = date.getDate();
        var hour = date.getHours();
        var minutes = date.getMinutes();
        var second = date.getSeconds();
        if (month < 10) {
            month = "0" + month;
        }
        if (date1 < 10) {
            date1 = "0" + date1;
        }
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (second < 10) {
            second = "0" + second;
        }

        var result = year + "-" + month + "-" + date1;
        return result;
    }
    //生成GUID
    function _newGuid() {
        var guid = "";
        for (var i = 1; i <= 32; i++) {
            var n = Math.floor(Math.random() * 16.0).toString(16);
            guid += n;
            if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                guid += "-";
        }
        return guid;
    }
    function UpVer(id) {
        var LastVer = $('#input' + id + '2').val();
        if (LastVer == "0.0") LastVer = "0.9";
        var Result = "";
        var VerArr = LastVer.split(".");
        if (VerArr.length == 2) {
            var VerTwo = parseInt(VerArr[1]);
            if (VerTwo < 9) Result = VerArr[0] + '.' + (VerTwo + 1);
            else Result = (parseInt(VerArr[0]) + 1) + '.0';
        } else {
            Result = '1.0';
        }
        $('#input' + id + '2').val(Result);
    }
    function DownVer(id,appid) {
        var LastVer = $('#input' + id + '2').val();
        if (LastVer == "1.0") {
            LastVer = "1.0";
            $('#input' + id + '2').val(LastVer);
            $('#FileTR' + appid).remove();
            return;
        }
        var Result = "";
        var VerArr = LastVer.split(".");
        if (VerArr.length == 2) {
            var VerTwo = parseInt(VerArr[1]);
            if (VerTwo == 0) Result = (parseInt(VerArr[0]) - 1) + '.9';
            else Result = (parseInt(VerArr[0])) + '.' + (parseInt(VerArr[1]) - 1);
        } else {
            $('#FileTR' + appid).remove();
            Result = '1.0';
            return;

        }
        $('#input' + id + '2').val(Result);


    }
</script>
