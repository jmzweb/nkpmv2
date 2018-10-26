<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppCond.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppCond" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>高级查询</title>
    <link href="../../Bootstrap/3.2.0/Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../css/font-awesome.min.css" rel="stylesheet" />
    <link type="text/css" href="../../css/toastr.css" rel="stylesheet" />
    <link type="text/css" href="../../css/appCond.css" rel="stylesheet" />

    <script src="../../Js/jquery-2.0.3.min.js"></script>
    <script src="../../Bootstrap/3.2.0/Js/bootstrap.min.js"></script>
    <script src="../../Js/jquery.toastr.js"></script>

    <link href="../../css/select2.min.css" rel="stylesheet" />
    <script src="../../js/select2.full.min.js"></script>
    <script src="../../Js/jquery.nestable.min.js"></script>
    
    <style>
        .select2{width:150px;}
        .dropdown-submenu {  
            position: relative;  
        }  
        .dropdown-submenu > .dropdown-menu {  
            top: 0;  
            left: 100%;  
            margin-top: -6px;  
            margin-left: -1px;  
            -webkit-border-radius: 0 6px 6px 6px;  
            -moz-border-radius: 0 6px 6px;  
            border-radius: 0 6px 6px 6px;  
        }  
        .dropdown-submenu:hover > .dropdown-menu {  
            display: block;  
        }  
        .dropdown-submenu > a:after {  
            display: block;  
            content: " ";  
            float: right;  
            width: 0;  
            height: 0;  
            border-color: transparent;  
            border-style: solid;  
            border-width: 5px 0 5px 5px;  
            border-left-color: #ccc;  
            margin-top: 5px;  
            margin-right: -10px;  
        }  
        .dropdown-submenu:hover > a:after {  
            border-left-color: #fff;  
        }  
        .dropdown-submenu.pull-left {  
            float: none;  
        }  
        .dropdown-submenu.pull-left > .dropdown-menu {  
            left: -100%;  
            margin-left: 10px;  
            -webkit-border-radius: 6px 0 6px 6px;  
            -moz-border-radius: 6px 0 6px 6px;  
            border-radius: 6px 0 6px 6px;  
        }  
        .btnspan{padding-right:10px;}
        #txtname{width:480px;}
        .linkbtn { position:absolute;top:10px;right:10px;color:#333;padding: 0px 0px 0 20px;background: url(../../grid/images/crossred.png) no-repeat center left;}
    </style>
</head>
<body>
    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
        <div class="well" id="qheader">
            <table>
                <tr>
                     <td >
                        <div class="input-group">
                          <span class="input-group-addon">查询名称</span>
                          <input type="text" id="txtname" class="form-control" placeholder="请输入查询名称" maxlength="15" aria-describedby="sizing-addon2"/>
                        </div>
                    </td>
                    <td >&nbsp;&nbsp;
                        <button id="btnSave" class="btn btn-success" ><i class="fa fa-save"></i> 保存</button>
                        <button id="btnExec" class="btn btn-danger" ><i class="fa fa-search"></i> 执行</button> 

                        <!-- Single button -->
                        <div class="btn-group">
                          <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            更多 <span class="caret"></span>
                          </button>
                          <ul class="dropdown-menu">
                            <li><a href="#" id="btnAdd">新建查询</a></li>
                            <li><a href="#" id="btnDel">删除查询</a></li>
                            <li role="separator" class="divider"></li>
                            <%=sbCond %>
                          </ul>
                        </div>
                    </td>
                </tr>
            </table>

        </div>
        <div class="well">
            <div class="dd dd-draghandle bordered">
                <ol id="olroot" class="dd-list">
                </ol>
            </div>
        </div>

    <div style="display:none;">

        <div id="condtbl">
        <table style="width:90%;" align="right">
            <tr>
                <td>
                    <div class="cell">
                        <select class="select2 fld_sel">
                            <option value=""></option>
                        </select>
                    </div>
                </td>
                <td style="width: 80px; padding-right: 10px;">
                    <div class="cell">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle fld_rel" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="btnspan">关系</span><span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu menu_relation">
                            <li><a data-ref="01" href="#">包含</a></li>
                            <li><a data-ref="02" href="#">开头</a></li>
                            <li><a data-ref="03" href="#">结尾</a></li>
                            <li><a data-ref="04" href="#">等于</a></li>
                            <li><a data-ref="05" href="#">大于</a></li>
                            <li><a data-ref="06" href="#">小于</a></li>
                            <li><a data-ref="07" href="#">不等于</a></li>
                            <li><a data-ref="08" href="#">大于等于</a></li>
                            <li><a data-ref="09" href="#">小于等于</a></li>
                            <li><a data-ref="10" href="#">介于中间</a></li>
                        </ul>
                    </div>
                    </div>
                </td>
                <td style="width: 220px; padding-right: 10px;">
                    <div class="cell">
                    <div class="input-group">
                        <span class="input-group-addon">值</span>
                        <input type="text" class="form-control fld_val" placeholder="字段值" style="width: 180px;" />
                    </div>
                    </div>
                </td>
                <td style="width: 50px; padding-right: 10px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-cog"></i>
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="lnkAnd" href="#">关系（AND）</a></li>
                            <li><a class="lnkOr" href="#">关系（OR）</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a class="lnkAddGroup" href="#">添加分组</a></li>
                            <li><a class="lnkInsert" href="#">插入条件</a></li>
                            <li><a class="lnkDelete" href="#">删除</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
        </div>
         <form id="form1" runat="server">
            <asp:TextBox ID="txtCondText" runat="server"></asp:TextBox>
        </form>
    </div>
</body>
</html>
<script>
    var _curClass = EZ.WebBase.SysFolder.AppFrame.AppCond;
    jQuery(function () {

        if (!loadJson()) {
            var hItem = genItem();
            $("#olroot").append(hItem);
        } else {
            fnListChg();
        }

        $('.dd').nestable();
        $('.dd').on('change', function () {
            fnListChg();
        });

        $("#olroot").on("click", "a", function () {
            var obj = $(this);
            var rel = (obj.data("ref"));
            var btnGroup = obj.closest(".btn-group");
            btnGroup.find(".fld_rel").data("rel", rel);
            btnGroup.find(".btnspan").text(obj.text());
        });

        $("#olroot").on("click", ".lnkAddGroup", function () {
            var obj = $(this);
            var hItem = genItem();
            var dItem = obj.closest("li.dd-item");
            dItem.after(hItem);
        });

        $("#olroot").on("click", ".lnkDelete", function () {

            var obj = $(this);
            if (!confirm("确认删除吗"))
                return false;

            var li = obj.closest("li.dd-item");
            var pt = li.parent();
            var pid = pt.attr("id");
            li.remove();

            if (pid != "olroot") {
                if (pt.children().length == 0)
                {
                    var pli = pt.parent();
                    pli.removeClass("dd-collapsed");
                    pli.children('[data-action]').remove();
                    pli.children("ol").remove();
                }


                //li.prepend('<button data-action="expand" type="button" style="display:none;">Expand</button>');
                //li.prepend('<button data-action="collapse" type="button">Collapse</button>');
            }


            fnListChg();
        });

        $("#olroot").on("click", ".lnkInsert", function () {
            var obj = $(this);
            var innerol = obj.closest("li.dd-item").children("ol.dd-list");

            var hItem = genItem();

            if (innerol.length > 0) {
                innerol.append(hItem);
            }
            else {
                var li = obj.closest("li.dd-item");
                li.prepend('<button data-action="expand" type="button" style="display:none;">Expand</button>');
                li.prepend('<button data-action="collapse" type="button">Collapse</button>');
                var ol = $('<ol class="dd-list"></ol>')
                ol.append(hItem);

                li.append(ol);
            }

            fnListChg();
        });

        $("#olroot").on("click", ".lnkAnd", function () {
            var obj = $(this);
            var icon = obj.closest("li.dd-item").find("i.normal-icon");
            if (icon.hasClass("fa-link"))
                return false;
            icon.removeClass("fa-chain-broken").addClass("fa-link");
        });

        $("#olroot").on("click", ".lnkOr", function () {
            var obj = $(this);
            var icon = obj.closest("li.dd-item").find("i.normal-icon");
            if (icon.hasClass("fa-chain-broken"))
                return false;
            icon.removeClass("fa-link").addClass("fa-chain-broken");
        });

        //保存数据
        $("#btnSave").click(function () {
            //var arr = $('.dd').nestable('serialize');
            var tname = $("#txtname").val()
            if (tname=="")
            {
                toastr.warning("查询名称不能为空", { timeOut: 3000 });
                return false;
            }

            var root = getJson();
            if (_logs.length > 0)
            {
                toastr.error(_logs.join("<br/>"),"保存时出错", { timeOut: 0 });
                return false;
            }

            var str = JSON.stringify(root);
            $("#txtCondText").val(str);

            var ret = _curClass.Save("<%=condId%>", "<%=tblName%>", tname, str);
            if (ret.error) {
                toastr.error(ret.error.Message, "保存时出错", { timeOut: 5000 });
            }
            else {
                toastr.success("保存成功！");
            }
            return false;
        });

        $("#btnAdd").click(function () {
            window.open("AppCond.aspx?tblName=<%=tblName%>","_self");
        });

        $("#btnDel").click(function () {
            if (!confirm("确认删除吗"))
                return false;

            var ret = _curClass.Remove("<%=condId%>");
            if (ret.error) {
                toastr.error(ret.error.Message, "删除时出错", { timeOut: 5000 });
            }
            else {
                toastr.success("操作成功！");
                $("#txtname,#btnSave,#btnExec,.dd *").prop("disabled", true);

            }
        });

        $("#btnExec").click(function () {
            var root = getJson();
            if (_logs.length > 0) {
                toastr.error(_logs.join("<br/>"), "保存时出错", { timeOut: 0 });
                return false;
            }
            var str = JSON.stringify(root);
            $("#txtCondText").val(str);
            window.parent["app_search"](root);
            _appClose();
        });


    });

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
    var _logs = [];
    function fnListChg() {
        $("li.dd-item").each(function () {
            var li = $(this);
            if (li.find("ol.dd-list").length > 0)
                li.find("div.cell").hide();
            else
                li.find("div.cell").show();
        });
    }
    function getJson()
    {
        var root = {};
        root.v = $("#txtname").val();
        root.children = [];
        _logs = [];
        $("#olroot>li").each(function () {
            fnSerialize(root, this);
        });

        return root;
    }

    function loadJson(){
        var str = $("#txtCondText").val();
        if(str == "")
            return false;
        var root = JSON.parse(str);
        $("#txtname").val(root.v);
        var ps = root.children || [];
        var el = $("#olroot");
        $("#olroot").empty();
        for (var i = 0; i < ps.length; i++) {
            loadItem(el,ps[i]);
        }
        return true;
    }

    function loadItem(p,item) {
        var hItem = genItem(item);
        if (p.attr("id") != "olroot") {
            var dlist = p.children("ol.dd-list");
            if(dlist.length == 0){
                p.append('<ol class="dd-list"></ol>');
                dlist = p.children("ol.dd-list")
            }
            dlist.append(hItem);
        }
        else{
            p.append(hItem);
        }

        var childs = item.children || [];
        for (var i = 0; i < childs.length; i++) {
            loadItem(hItem, childs[i]);
        }
    }

    function fnSerialize(p,item) {
        var li = fnGetRow(item);
        
        p.children.push(li);
        $(item).find("ol.dd-list>li").each(function (i, o) {
            var sli = fnGetRow(this);
            li.children.push(sli);
        });
    }

    function fnGetRow(item) {
        var row = $(item);
        var obj = {};
        obj.children = [];
        obj.r = row.find("i.normal-icon").hasClass("fa-link") ? "and" : "or";

        if (row.children("ol.dd-list").length == 0)
        {
            obj.f = $(".fld_sel", row).val();
            obj.o = $(".fld_rel", row).data("rel");
            obj.v = $(".fld_val", row).val();
            obj.t = fldType(obj.f);

            if (obj.f == "" || obj.o == "" || obj.v == "")
            {
                if (obj.f != "")
                    _logs.push(fldCn(obj.f) + "：关系、查询值不能为空");
                else
                    _logs.push("查询字段、关系、查询值不能为空");
            }
        }
        else {
            obj.f = "";
            obj.o = "";
            obj.v = "";
            obj.t = "";
        }
        return obj;
    }

    function fldType(fld) {
        for (var i = 0; i < _arrFld.length; i++) {
            if (_arrFld[i].id == fld)
                return _arrFld[i].type;
        }
    }

    function fldCn(fld) {
        for (var i = 0; i < _arrFld.length; i++) {
            if (_arrFld[i].id == fld)
                return _arrFld[i].text;
        }
    }

    var _relMap;
    var _thtml = $("#condtbl").html();
    var _arrFld = [<%=sbFields%>];
    function getText(code)
    {
        if (!_relMap)
        {
            _relMap = {};
            $(".menu_relation a").each(function(){
                var obj = $(this);
                _relMap[obj.data("ref")] = obj.text();
            });
        }

        return _relMap[code];
    }

    function genItem(obj) {

        var arrHtml = ['<li class="dd-item dd2-item" >',
            '<div class="dd-handle dd2-handle">',
                '<i class="normal-icon fa fa-link"></i>',
                '<i class="drag-icon fa fa-arrows-alt "></i>',
            '</div>',
            '<div class="dd2-content">', _thtml, '</div>',
            '</li>'];

        var hItem = $(arrHtml.join(""));

        $('.select2', hItem).select2({ placeholder: "请选择查询字段", data: _arrFld, width: 180 })


        if (!!obj) {
            var link = $(".fld_rel", hItem);
            link.data("rel", obj.o);
            $(".btnspan", link).text(getText(obj.o));

            $(".fld_val", hItem).val(obj.v);

            if(obj.r == "or")
            {
                var icon = hItem.find("i.normal-icon");
                if (!icon.hasClass("fa-chain-broken"))
                    icon.removeClass("fa-link").addClass("fa-chain-broken");
            }

            $('.select2', hItem).val(obj.f).change();

        }
        return hItem;
    }

    toastr.options = {
        timeOut: 600,
        closeButton: true,
        positionClass: "toast-top-left",
        onclick: function () { }
    };
</script>