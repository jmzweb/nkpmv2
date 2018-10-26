<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FnEdit.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.FnEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="/iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>

    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

</head>
<body>
    <script src="../../js/p.WdatePicker.js"></script>
    <form id="cwqkzcAdd" class="cform formtable">
        <script type="text/javascript">
            function lxconchange($t, $input, $id) {
                $(".hide").hide();
                if ($id.val() == "年报" || $id.val() == "半年报") {
                    $('#yue').val('').trigger("change");
                    $('#jidu').val('').trigger("change");
                }
                if ($id.val() == "季报") {
                    $(".jdshow").show().trigger("change");
                    $('#yue').val('').trigger("change");
                }
                if ($id.val() == "月报") {
                    $(".ydshow").show().trigger("change");
                    $('#jidu').val('').trigger("change");
                }
            };
            $(function () {
                $(".tabbtns a").click(function () {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".tabitem").eq($(this).index()).show().siblings().hide();
                    //$(".abs").eq($(this).index()).show().siblings().hide();
                    $('.mb').show();
                });
                $(".tabbtns a").first().trigger("click");
                $('.mb').show();
                var NowDate = new Date();
                var eyear = '<%=EditYear %>';
                if (!eyear) {
                    $('#nian').val(NowDate.getFullYear());
                }
                $('#yue').val('<%=EditMonth %>').trigger("change");
                $('#jidu').val('<%=EditQueater %>').trigger("change");
            });
        </script>
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" id="submit">保存</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="../../DownLoad/20180501新财报导入模板.rar" target="_blank">下载导入模板</a>
                </span>
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="12" class="" style="width: auto; float: left; margin: 10px 0 15px 10px;">
            <tr>
                <td style="width: 80px; text-align: right;">财报类型：</td>
                <td style="width: 230px">
                    <input id="cblx" type="text" rule="length:25" class="cselectorRadio" mode=""
                        values="年报,半年报,季报,月报" conchange="lxconchange()" value='<%=EditType %>' />

                </td>

                <td class="wfs4" style="width: 55px; text-align: right;">年度：</td>
                <td class="" style="width: 200px">
                    <input id="nian" type="text" rule="length:25" value='<%=EditYear %>' onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                <td class="wsf4 jdshow hide" style="width: 55px; text-align: right;">季度：</td>
                <td class="w2 jdshow hide" style="width: 200px">
                    <input id="jidu" type="text" rule="length:25" class="cselector" mode=""
                        values="|-请选择-,第1季度,第2季度,第3季度,第4季度" value='<%=EditQueater %>' /></td>

                <td class="wsf4 ydshow hide" style="width: 55px; text-align: right;">月度：</td>
                <td class="w2 ydshow hide" style="width: 200px">
                    <input id="yue" type="text" rule="length:25" class="cselector" mode=""
                        values="|-请选择-,01月,02月,03月,04月,05月,06月,07月,08月,09月,10月,11月,12月" value='<%=EditMonth %>' />

                </td>
            </tr>
        </table>
    </form>

    <div class="subtitlespt">
        <div class="tabbtns subbtns"><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div>
        <div class="UpA abs">
            <a id="InA4">
                <input type="file" style="display: none;" name="uploadify4" id="uploadify4" /></a>
            <a id="InA1" style="z-index: 100;">
                <input type="file" style="display: none;" name="uploadify1" id="uploadify1" /></a>
            <a id="InA2">
                <input type="file" style="display: none;" name="uploadify2" id="uploadify2" /></a>
            <a id="InA3">
                <input type="file" style="display: none;" name="uploadify3" id="uploadify3" /></a>
            
        </div>
    </div>
    <div class="tabbox">
        <div class="tabitem tabitem1">
        </div>
        <div class="tabitem tabitem2">
        </div>
        <div class="tabitem tabitem3">
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    var AID = '<%=MainAID %>';
    var auid = "<% = Session.SessionID %>";
    var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
    //保存数据
    $(function () {
        $('#submit').click(function () {
            if ($('#cblx').val() == "") {
                alert("财报类型不能为空");
                return false;
            }
            if ($('#nian').val() == "") {
                alert("年度不能为空");
                return false;
            }
            if ($('#cblx').val() != "") {
                if ($('#cblx').val() == "季报" && $('#jidu').val() == "") {
                    alert("季度不能为空");
                    return false;
                }
                if ($('#cblx').val() == "月报" && $('#yue').val() == "") {
                    alert("月度不能为空");
                    return false;
                }
            }
            SaveData();
        });

        try { $('#uploadify1').uploadify('destroy'); } catch (e) { }

        $("#uploadify1").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=',
            'formData': { appName: "资产负债表", appId: AID + "资产负债表", folder: "", 'ASPSESSID': auid, 'AUTHID': auth },
            'buttonText': '导入资产负债表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts': "*.xls;*.xlsx",
            'fileSizeLimit': "0",
            'folder': '',
            'auto': true,
            'multi': true,
            'overrideEvents': ['onUploadSuccess'],
            onUploadSuccess: function (fileObj, response, data) {
                $.ajax({
                    type: 'post',
                    url: 'FnEdit.aspx',
                    data: { 't': 'dr', 'MainAID': AID, 'SubType': '资产负债表' },
                    success: function (data) {
                        var ret = eval('(' + data + ')');
                        if (ret.success) {
                            $(".tabitem1").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                                "<thead><tr><td width='360'>项目</td><td>期末余额</td></tr></thead><tbody>" +
                                zjs.render(ret.jlist, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                                "</tbody></table>");

                            var datatree = {};
                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.SUBDATA) {
                                    datatree[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }

                            if (ret.jerror.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror, "{{SUBNAME}}"));
                            }

                        } else {
                            if (ret.mag != "")
                                alert(ret.msg);
                            else
                                alert("保存失败");
                        }
                    }
                });
            }
        });


        try { $('#uploadify2').uploadify('destroy'); } catch (e) { }

        $("#uploadify2").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=',
            'formData': { appName: "利润表", appId: AID + "利润表", folder: "", 'ASPSESSID': auid, 'AUTHID': auth },
            'buttonText': '导入利润表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts': "*.xls;*.xlsx",
            'fileSizeLimit': "0",
            'folder': '',
            'auto': true,
            'multi': true,
            'overrideEvents': ['onUploadSuccess'],
            onUploadSuccess: function (fileObj, response, data) {
                $.ajax({
                    type: 'post',
                    url: 'FnEdit.aspx',
                    data: { 't': 'dr', 'MainAID': AID, 'SubType': '利润表' },
                    success: function (data) {
                        var ret = eval('(' + data + ')');
                        if (ret.success) {
                            $(".tabitem2").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                                zjs.render(ret.jlist, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                                "</tbody></table>");

                            var datatree = {};
                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.SUBDATA) {
                                    datatree[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }

                            if (ret.jerror.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror, "{{SUBNAME}}"));
                            }

                        } else {
                            if (ret.mag != "")
                                alert(ret.msg);
                            else
                                alert("保存失败");
                        }
                    }
                });
            }
        });


        try { $('#uploadify3').uploadify('destroy'); } catch (e) { }

        $("#uploadify3").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=',
            'formData': { appName: "现金流量表", appId: AID + "现金流量表", folder: "", 'ASPSESSID': auid, 'AUTHID': auth },
            'buttonText': '导入现金流量表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts': "*.xls;*.xlsx",
            'fileSizeLimit': "0",
            'folder': '',
            'auto': true,
            'multi': true,
            'overrideEvents': ['onUploadSuccess'],
            onUploadSuccess: function (fileObj, response, data) {
                $.ajax({
                    type: 'post',
                    url: 'FnEdit.aspx',
                    data: { 't': 'dr', 'MainAID': AID, 'SubType': '现金流量表' },
                    success: function (data) {
                        var ret = eval('(' + data + ')');
                        if (ret.success) {
                            $(".tabitem3").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                                zjs.render(ret.jlist, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                                "</tbody></table>");

                            var datatree = {};
                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.SUBDATA) {
                                    datatree[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            for (var jli in ret.jlist) {
                                var datajli = ret.jlist[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }

                            if (ret.jerror.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror, "{{SUBNAME}}"));
                            }

                        } else {
                            if (ret.mag != "")
                                alert(ret.msg);
                            else
                                alert("保存失败");
                        }
                    }
                });
            }
        });


          try { $('#uploadify4').uploadify('destroy'); } catch (e) { }

        $("#uploadify4").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=',
            'formData': { appName: "用友财报", appId: AID + "用友财报", folder: "", 'ASPSESSID': auid, 'AUTHID': auth },
            'buttonText': '导入用友财报',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts': "*.xls;*.xlsx",
            'fileSizeLimit': "0",
            'folder': '',
            'auto': true,
            'multi': true,
            'overrideEvents': ['onUploadSuccess'],
            onUploadSuccess: function (fileObj, response, data) {
                $.ajax({
                    type: 'post',
                    url: 'FnEdit.aspx',
                    data: { 't': 'drs', 'MainAID': AID, 'SubType': '用友财报' },
                    success: function (data) {
                        var ret = eval('(' + data + ')');
                        if (ret.success) {
                                                      

                            $(".tabitem1").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                         "<thead><tr><td width='360'>项目</td><td>期末余额</td></tr></thead><tbody>" +
                         zjs.render(ret.jlist.zcfz, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                         "</tbody></table>");
                            $(".tabitem2").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                                zjs.render(ret.jlist.lr, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                                "</tbody></table>");
                            $(".tabitem3").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                                zjs.render(ret.jlist.xjll, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                                "</tbody></table>");

                            var datatreezcfz = {};
                            for (var jli in ret.jlist.zcfz) {
                                var datajli = ret.jlist.zcfz[jli];
                                if (datajli.SUBDATA) {
                                    datatreezcfz[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            var datatreelr = {};
                            for (var jli in ret.jlist.lr) {
                                var datajli = ret.jlist.lr[jli];
                                if (datajli.SUBDATA) {
                                    datatreelr[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            var datatreexjll = {};
                            for (var jli in ret.jlist.xjll) {
                                var datajli = ret.jlist.xjll[jli];
                                if (datajli.SUBDATA) {
                                    datatreexjll[datajli.SUBCODE] = parseFloat(datajli.SUBDATA);
                                }
                            }

                            for (var jli in ret.jlist.lr) {
                                var datajli = ret.jlist.lr[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }
                            for (var jli in ret.jlist.zcfz) {
                                var datajli = ret.jlist.zcfz[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }
                            for (var jli in ret.jlist.xjll) {
                                var datajli = ret.jlist.xjll[jli];
                                if (datajli.ProofRule && datajli.SUBDATA) {//如果有校验规则的话
                                    var execstr = datajli.ProofRule;
                                    if (execstr.indexOf("sum") > -1) {//如果是泛聚合的需要先累计一下值
                                        var ppstr = execstr.substring(execstr.indexOf("sum(") + 4, execstr.indexOf(")"));
                                        var pptop = ppstr.replace(new RegExp("__", 'g'), "");
                                        var sumvalue = 0;
                                        for (var dti in datatree) {//替换关键字
                                            if (dti.substr(0, pptop.length) == pptop && dti.length == ppstr.length) {
                                                sumvalue += datatree[dti];
                                            }
                                        }
                                        execstr = execstr.replace("sum(" + ppstr + ")", sumvalue);
                                    }
                                    //否则就是正常表达式的
                                    for (var dti in datatree) {//替换关键字
                                        execstr = execstr.replace("[" + dti + "]", datatree[dti]);
                                    }
                                    if (parseInt(datajli.SUBDATA) != parseInt(eval(execstr))) {
                                        alert(datajli.SUBNAME + " 检验有误,应为:" + parseInt(eval(execstr)) + " 实为:" + parseInt(datajli.SUBDATA));
                                    }
                                }
                            }

                            if (ret.jerror.lr.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror.lr, "{{SUBNAME}}"));
                            }
                            if (ret.jerror.zcfz.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror.zcfz, "{{SUBNAME}}"));
                            }
                            if (ret.jerror.xjll.length > 0) {
                                alert("无效科目:" + zjs.render(ret.jerror.xjll, "{{SUBNAME}}"));
                            }

                        } else {
                            if (ret.mag != "")
                                alert(ret.msg);
                            else
                                alert("保存失败");
                        }
                    }
                });
            }
        });




        var EditDatas1 = '<%=EditDatas1%>';
        if (EditDatas1) {
            var datas1 = $.evalJSON(EditDatas1);
            $(".tabitem1").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>期末余额</td></tr></thead><tbody>" +
                zjs.render(datas1, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                "</tbody></table>");
        }
        var EditDatas2 = '<%=EditDatas2%>';
        if (EditDatas2) {
            var datas2 = $.evalJSON(EditDatas2);
            $(".tabitem2").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                zjs.render(datas2, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                "</tbody></table>");
        }
        var EditDatas3 = '<%=EditDatas3%>';
        if (EditDatas3) {
            var datas3 = $.evalJSON(EditDatas3);
            $(".tabitem3").html("<table border='0' cellpadding='0' cellspacing='0' class='ctable'>" +
                "<thead><tr><td width='360'>项目</td><td>本期发生额</td></tr></thead><tbody>" +
                zjs.render(datas3, "<tr><td class='coldesc'>{{SUBNAME}}</td><td><input SubCode='{{SUBCODE}}' OrderID='{{ORDERID}}' value='{{SUBDATA}}' /></td></tr>") +
                "</tbody></table>");
        }
        $(".tabbox input").each(function (i, v) {
            var $v = $(v);
            if ($v.val() == "0") {
                $v.val("");
            }
        });
    });

    function SaveData() {
        var datatree = {};//快捷数据树
        var jsondata = [];
        $(".tabbox input").each(function (i, v) {
            var $v = $(v);
            var jobj = {};
            jobj.SubCode = $v.attr("SubCode");
            jobj.OrderID = $v.attr("OrderID");
            jobj.SubData = $v.val() || "0";
            jsondata.push(jobj);

            datatree[jobj.SubCode] = parseFloat(jobj.SubData);
        });
        if (jsondata.length == 0) {
            alert("请先导入财报数据");
            return false;
        }

        var TotalPropertyJS = "[21]";//资产总额计算规则
        var TakingJS = "[61]";//营业收入计算规则
        var NetMarginJS = "[65]";//净利润计算规则
        var NetProfitJS = "[65]/[61]*100";//销售净利率计算规则
        var ROEJS = "[65]/[55]*100";//净资产收益率计算规则
        var LEVJS = "[41]/[21]*100";//资产负债率计算规则
        var QuickRatioJS = "([12]-[1118]-[1126]-[1128]-[1129])/[32]";//速动比例计算规则

        var codes = [21, 61, 65, 61, 55, 41, 12, 1118, 1126, 1128, 1129, 32]
        for (var di in codes) {//替换关键字 
            var dti = codes[di];
            var dtvv = datatree[dti] || 0;
            TotalPropertyJS = TotalPropertyJS.replace("[" + dti + "]", dtvv);//资产总额计算规则
            TakingJS = TakingJS.replace("[" + dti + "]", dtvv);//营业收入计算规则
            NetMarginJS = NetMarginJS.replace("[" + dti + "]", dtvv);//净利润计算规则
            NetProfitJS = NetProfitJS.replace("[" + dti + "]", dtvv);//销售净利率计算规则
            ROEJS = ROEJS.replace("[" + dti + "]", dtvv);//净资产收益率计算规则
            LEVJS = LEVJS.replace("[" + dti + "]", dtvv);//资产负债率计算规则
            QuickRatioJS = QuickRatioJS.replace("[" + dti + "]", dtvv);//速动比例计算规则 
        }
        var TotalProperty = parseFloat(eval(TotalPropertyJS) || "0").toFixed(2);//资产总额
        var Taking = parseFloat(eval(TakingJS) || "0").toFixed(2);//营业收入
        var NetMargin = parseFloat(eval(NetMarginJS) || "0").toFixed(2);//净利润
        var NetProfit = parseFloat(eval(NetProfitJS) || "0").toFixed(2);//销售净利率
        var ROE = parseFloat(eval(ROEJS) || "0").toFixed(2);//净资产收益率
        var LEV = parseFloat(eval(LEVJS) || "0").toFixed(2);//资产负债率
        var QuickRatio = parseFloat(eval(QuickRatioJS) || "0").toFixed(2);//速动比例
        if (NetProfit == "Infinity" || NetProfit == "-Infinity") {
            NetProfit = "0";
        }
        if (ROE == "Infinity" || ROE == "-Infinity") {
            ROE = "0";
        }
        if (LEV == "Infinity" || LEV == "-Infinity") {
            LEV = "0";
        }
        if (QuickRatio == "Infinity" || QuickRatio == "-Infinity") {
            QuickRatio = "0";
        }

        var gps = zjs.getQueryStr();
        $.ajax({
            type: 'post',
            url: 'FnEdit.aspx',
            data: {
                't': 'save', 'AID': AID, 'CorrelationCode': gps.code, 'Type': $("#cblx").val(), 'Year': $("#nian").val(), 'Quarter': $("#jidu").val(), 'Month': $("#yue").val(),
                'TotalProperty': TotalProperty, 'Taking': Taking, 'NetMargin': NetMargin, 'NetProfit': NetProfit,
                'ROE': ROE, 'LEV': LEV, 'LEV': LEV, 'QuickRatio': QuickRatio,
                'JsonData': $.toJSON(jsondata)
            },
            success: function (data) {
                var ret = eval('(' + data + ')');
                if (ret.success) {
                    alert('保存成功')
                    _appClose();
                } else {
                    if (ret.mag != "")
                        alert(ret.msg);
                }
            }
        });
    };
    //关闭窗口
    function _appClose() {
        if (!!frameElement) {
            if (!!frameElement.lhgDG)
                frameElement.lhgDG.cancel();
            else {
                if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                    window.parent.CloseLayer();
                } else if (window.parent.parent.CloseLayer) {
                    window.parent.parent.CloseLayer();
                }
            }
            window.close();
        }
        else {
            if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                window.parent.CloseLayer();
            } else if (window.parent.parent.CloseLayer) {
                window.parent.parent.CloseLayer();
            }
            // window.close();
        }
    }
</script>


