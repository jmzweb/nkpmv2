var _tmplRowId = "srkjdslABHSAS";
Date.prototype.format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份      
        "d+": this.getDate(), //日      
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时      
        "H+": this.getHours(), //小时      
        "m+": this.getMinutes(), //分      
        "s+": this.getSeconds(), //秒      
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度      
        "S": this.getMilliseconds() //毫秒      
    };
    var week = { "0": "/u65e5", "1": "/u4e00", "2": "/u4e8c", "3": "/u4e09", "4": "/u56db", "5": "/u4e94", "6": "/u516d" };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f" : "/u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;

}

var _class2type = {};
var _arrType = "Boolean Number String Function Array Date RegExp Object".split(" ");
jQuery.each(_arrType,
    function (i, name) {
        _class2type["[object " + name + "]"] = name.toLowerCase();
    });
var _core_toString = Object.prototype.toString;
jQuery.extend({
    type: function (obj) {
        return obj == null ?
            String(obj) :  // 如果传入的值为null或者是undefined直接调用String()方法 
            _class2type[_core_toString.call(obj)] || "object";
    }
});

var _upKeyCode = 38;
var _downKeyCode = 40;
var _inputBg = {};
//平台初始化 var _sysModel=[{主表1},{主表2}];
$(function () {
    if (_isNew) jQuery(".subtbl input.emptytip").emptyValue();

    jQuery("textarea.emptytip").emptyValue();
    jQuery(".normaltbl input.emptytip").emptyValue();

    jQuery(":text,.TextBoxInArea").live("focus", function () {
        var obj = $(this);
        _inputBg = { "backgroundColor": obj.css("background-color"), "backgroundImage": obj.css("background-image"), "color": obj.css("color") };
        obj.css({ "backgroundColor": "#fffacd", "backgroundImage": "none" });
        if (obj.val().length > 0 && (obj.data("type") == 'int' || obj.data("type") == 'float')) {
            obj.val(obj.val().replace(/,/g, ''));
        }
    });

    jQuery(":text,.TextBoxInArea").live("blur", function () {
        var obj = $(this);
        obj.css(_inputBg);
        if (obj.val().length > 0) {
            if (obj.data("type") == 'int')
                obj.val(_formatMoney(obj.val(), 0));
            else if (obj.data("type") == 'float')
                obj.val(_formatMoney(obj.val(), obj.attr("precision")));
        }
    });

    //主表字段映射关系
    _genModelsMap();

    //SQLID|input07,input02|EmployeeName,CompanyName|companyId='{CompanyId}'|EmployeeName,LoginName,CompanyName
    jQuery(".EnterSearch").attr("autocomplete", "off").live("keyup", function (e) {
        _enterSearch($(this)[0],e||window.event);
    });
    jQuery(".EnterSearch").live("dblclick", function (e) {
        _clickSearch($(this)[0], e || window.event);
    });
    jQuery(".FrameList").live("dblclick", function (e) {
        _clickFrame($(this)[0], e || window.event);
    });
    jQuery(".openpage").live("dblclick", function () {
        var url = $(this).attr("url");
        if (!!url) {
            var fld = _getFieldById(this.id);
            if (fld != null) {
                if (fld.limit == "0")
                    return;
            }
            _openCenter(url, "_blank", 640, 500);
        }
    });
    //dLink 字段联动，dLink的格式为：fieldId&fieldOdr|参考表1&字段1|参考表2&字段2
    var _dLinkEvent = {};
    jQuery(".dLink").each(function () {
        var dLink = $(this).attr("dLink");
        if (dLink.length > 0) {
            var arrLink = dLink.split("|");
            var fieldInfo = arrLink[0].split("&");
            var targetId = this.id;

            for (var i = 1; i < arrLink.length; i++) {
                var fieldTbl = arrLink[i];
                var arr = fieldTbl.split("&");
                var eventFlag = fieldInfo[0] + "_" + arr[1];
                if (_dLinkEvent[eventFlag] != undefined)
                    continue;
                _dLinkEvent[eventFlag] = "1";

                $("." + arr[0] + "_" + arr[1]).live("change", { "arrLink": arrLink, "targetId": targetId }, function (event) {
                    var pArr = [];
                    var rField = event.data.arrLink;
                    var fieldInfo = rField[0].split("&");
                    var fieldId = fieldInfo[0];
                    for (var n = 1; n < rField.length; n++) {
                        var ff = rField[n].split("&");
                        if (this.id.indexOf("input") > -1) {
                            pArr.push("@" + ff[1] + "=" + _sys.getValue(ff[0]+'.'+ff[1]));
                        }
                        else {
                            var subFld = _getField(ff[0],ff[1]);
                            var idSeg = this.id.split("_");
                            var refId = idSeg[0] + "_" + idSeg[1] + "_" + subFld.sodr;
                            pArr.push("@" + ff[1] + "=" + $("#" + refId).val());

                        }
                    }
                    var ret = _curClass.GetLinkData(fieldId, pArr.join("|"));
                    if (!ret.error) {
                        var dt = ret.value;
                        //开始装载下拉框
                        if (dt != null) {
                            var codeFld = dt.Columns[0].Name;
                            var dispFld = dt.Columns[1].Name;
                            //清空options
                            var targetCtl = document.getElementById(event.data.targetId);
                            targetCtl.options.length = 1;
                            for (var j = 0; j < dt.Rows.length; j++) {
                                targetCtl.options.add(new Option(dt.Rows[j][dispFld], dt.Rows[j][codeFld]));
                            }
                        }
                    }
                });
            }
        }
    });

    //AutoSn 自动编号，AutoSn的格式为：fieldId&fieldOdr|参考表1&字段1|参考表2&字段2
    var _AutoSnEvent = {};
    jQuery(".autosn").each(function () {
        var dLink = $(this).attr("autosn");
        if (dLink == undefined)
            return;
        if (dLink.length > 0) {
            var arrLink = dLink.split("|");
            var fieldInfo = arrLink[0].split("&");
            var targetId = this.id;

            for (var i = 1; i < arrLink.length; i++) {
                var fieldTbl = arrLink[i];
                var arr = fieldTbl.split("&");
                var eventFlag = fieldInfo[0] + "_" + arr[1];
                if (_AutoSnEvent[eventFlag] != undefined)
                    continue;
                _AutoSnEvent[eventFlag] = "1";

                $("." + arr[0] + "_" + arr[1]).live("change", { "arrLink": arrLink, "targetId": targetId }, function (event) {
                    var pArr = [];
                    var rField = event.data.arrLink;
                    var fieldInfo = rField[0].split("&");
                    var fieldId = fieldInfo[0];
                    for (var n = 1; n < rField.length; n++) {
                        var ff = rField[n].split("&");
                        if (this.id.indexOf("input") > -1) {
                            pArr.push("@" + ff[1] + "=" + _sys.getValue(ff[1]));
                        }
                        else {
                            var subOdr = _getSubOdr(ff[0]);
                            var fieldOdr = _getFieldOdr(subOdr, ff[1]);
                            var idSeg = this.id.split("_");
                            var refId = idSeg[0] + "_" + idSeg[1] + "_" + fieldOdr;
                            pArr.push("@" + ff[1] + "=" + $("#" + refId).val());

                        }
                    }
                    var ret = _curClass.GetAutoSn(fieldId, pArr.join("|"));
                    if (!ret.error) {
                        //开始装载下拉框
                        if (ret.value != null) {
                            var targetCtl = document.getElementById(event.data.targetId);

                            targetCtl.value = ret.value;

                        }
                    }
                });
            }
        }
    });
    try {
        KindEditor.create(".WebEditor", { uploadJson: '../../UploadImage.axd?AppName=' + _mainTblName + "&appId=" + _mainId, filterMode: false, urlType: 'relative'
            , tmplType: _mainTblName
            , appName: _mainTblName
            , appId : _mainId
            , cssData: "body{font-size:14px;}"
            , allowWeiXin: true
            , afterCreate: function () {
                var _self = this;
                _self.edit.doc.onpaste = function (event) { _copyImg(_self, event||window.event); };
            }
        });
    } catch (e) { }

    $(".subtbl input[type!=button]").live("keydown", function (e) {
        var obj = e || window.event;
        var ctlName = $(this).attr("name");
        var arrName = ctlName.split("_");
        if (arrName.length < 2) return;

        var subOdr = arrName[0].substr(7);

        if (_sysModel[0].subtbls[subOdr].limit == "0")
            return;

        var rowIndex = parseInt(arrName[1]);
        if (obj.keyCode == _upKeyCode) {
            arrName[1] = rowIndex - 1;
            var targetName = arrName.join("_");
            var ctl = $("#" + targetName);
            if (ctl.length == 0) {
                while (rowIndex > 0) {
                    rowIndex = rowIndex - 1;
                    arrName[1] = rowIndex;
                    targetName = arrName.join("_");
                    var ctl = $("#" + targetName);
                    if (ctl.length > 0) {
                        ctl.focus().select();
                        break;
                    }
                }
            }
            else {
                ctl.focus().select();
            }
        }
        else if (obj.keyCode == _downKeyCode) {
            arrName[1] = rowIndex + 1;
            var targetName = arrName.join("_");
            var ctl = $("#" + targetName);
            var maxRow = _sysModel[0].subtbls[subOdr].maxorder;
            //如果是最后一行，增加新行
            if (rowIndex == maxRow - 1) {
                if (!!_sys.subDownAdd)
                    _fnSubAdd(_sysModel[0].subtbls[subOdr].tblname);
            }
            if (ctl.length == 0) {
                while (rowIndex < maxRow) {
                    rowIndex = rowIndex + 1;
                    arrName[1] = rowIndex;
                    targetName = arrName.join("_");
                    var ctl = $("#" + targetName);
                    if (ctl.length > 0) {
                        ctl.focus().select();
                        break;
                    }
                }
            }
            else {
                ctl.focus().select();
            }
        }

    });

    //不让换行的textarea;
    $("textarea.noenter").blur(function () {
        var nr = $(this).val();
        if (nr.indexOf("\n") > -1)
            $(this).val(nr.replace(/\n/gi, ''));
    }).keydown(function (e) { var obj = e || window.event; if (obj.keyCode == 13) return false; });

    $(".linkAdd").live("click", function () {
        var bizName = $(this).closest(".subtbl").attr("id");
        _fnPopAdd(bizName);
    });
    $(".linkImport").live("click", function () {
        var bizName = $(this).closest(".subtbl").attr("id");
        if (_isNew) {
            if (confirm("导入数据前需要先保存表单，现在保存吗？")) {
                _saveAction = "2"
                if (_appSave({ 'close': false })) {
                    var url = "AppImport.aspx?tblName=" + bizName + "&mainId=" + _mainId
                    var dlg = new jQuery.dialog({ title: '导入数据', maxBtn: true, page: url
                    , btnBar: true, cancelBtnTxt: '确定', cover: true, width: 900, height: 600, bgcolor: 'black', onCancel: function () {
                        window.location = window.location + "&mainId=" + _mainId
                    }
                    });
                    dlg.ShowDialog();
                }
                _saveAction = "1";
            }
        }
        else {
            var url = "AppImport.aspx?tblName=" + bizName + "&mainId=" + _mainId
            var dlg = new jQuery.dialog({ title: '导入数据', maxBtn: true, page: url
                    , btnBar: true, cancelBtnTxt: '确定', cover: true, width: 900, height: 600, bgcolor: 'black', onCancel: function () {
                        window.location = window.location;
                    }
            });
            dlg.ShowDialog();
        }
    });

    $(".linkDelAll").live("click", function () {
        var bizName = $(this).closest(".subtbl").attr("id");
        _fnSubDelAll(bizName);
    });

    $(".linkins").live("click", function () {
        tr = $(this).closest(".dataRow");
        var sub = _getSubByCtlId(tr.attr("id"));

        var rowId = _fnSubAdd(sub.tblname, tr.attr("id"));
    });

    $(".linkup").live("click", function () {
        tr = $(this).closest(".dataRow");
        tr.prev().before(tr);
        var sub = _getSubByCtlId(tr.attr("id"));

        _setSubAutoSn(sub.tblname);
    });

    $(".linkdn").live("click", function () {
        var tr = $(this).closest(".dataRow");
        tr.next().after(tr);

        var sub = _getSubByCtlId(tr.attr("id"));
        _setSubAutoSn(sub.tblname);
    });

    $("table.subtbl").not(".readtbl").tableDnD({
        dragHandle: ".dragtd",
        onDragClass: "dragtr",
        onDrop: function (table, row) {
            var rowId = row.id;
            var sub = _getSubByCtlId(rowId);
            _setSubAutoSn(sub.tblname);
        }
    });

    $(".linkopen").live("click", function () {

        var linkId = $(this).attr("for");
        var linkUrl = $(this).attr("url");

        if (linkId.indexOf("SubTbl") == 0) {
            var segs = linkId.split("_");
            var subOdr = segs[0].substring(7);
            linkUrl = _replacePara(linkUrl, subOdr, segs[1]);
        }
        else {
            linkUrl = _replacePara(linkUrl);
        }
        if (_emptyValue) {
            alert("请先选择相关信息！");
        }
        else {
            window.open(linkUrl);
        }
    });
    if (!($.browser.msie && $.browser.version <= 7.0)) {
        $("input[title],select[title],textarea[title]").qtip({
            style: "qtip-shadow",
            show: { solo: true, event: 'mouseenter' },
            position: {
                adjust: { x: 0, y: 2 },
                my: 'top left',
                at: 'bottom left'
            }
        });
    }
    if (!_xmlData) {
        alert("请检查浏览器设置，关闭【ActiveX筛选】功能，重新打开本页面。");
        return false;
    }
});

//032弹出窗口，自动选择字段
function _autoSelect(fldName, cond, option) {

    var scope = "";
    var input = _sys.getInput(fldName);
    var ctlId = input.attr("id");
    var arr = input.attr("display").split("|");
    var arrCId = arr[1].split(",");
    var arrQuery = arr[2].split(",");

    var dt = _curClass.GetQuery2(arr[0], cond).value;
    if (dt.Rows.length == 1) {
        for (var i = 0; i < arrCId.length; i++) {
            var fvObject = dt.Rows[0][arrQuery[i]];
            var fv = fvObject.toString();
            if (jQuery.type(fvObject) == "date")
                fv = fvObject.format("yyyy-MM-dd");
            document.getElementById(arrCId[i]).value = fv;
            $("#" + arrCId[i]).change();
        }
    }
}

//032弹出窗口，键盘事件
function _enterSearch(ctl) {
    var fld = _getFieldById(ctl.id);
    if (fld.limit == "0")
        return;
    var arr = $(ctl).attr("display").split("|");
    var arrCId = arr[1].split(",");
    var arrQuery = arr[2].split(",");
    var scope = "";
    var v = $(ctl).val();
    if (arr[3].length > 0) {
        if (ctl.id.indexOf("SubTbl") == 0) {
            var segs = ctl.id.split("_");
            var subOdr = segs[0].substring(7);
            scope = _replacePara(arr[3], subOdr, segs[1]);
        }
        else {
            scope = _replacePara(arr[3]);
        }
    }
    if (v.length == 0 && event.keyCode == 13) {
        var cond = [];
        cond.push("queryid=" + arr[0]);
        cond.push("queryfield=" + arr[2]);
        cond.push("cid=" + arr[1]);
        cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));
        if (arr.length > 5) {
            cond.push("multi=" + arr[4]);
        }
        _openPage("../AppFrame/AppOutSelect.aspx?" + cond.join("&"));
    }
    else if (event.keyCode == 13) {
        scope = scope.replace(/\[QUOTES\]/ig, "'");
        var dt = _curClass.GetQuery(arr[0], v, scope).value;
        if (dt.Rows.length == 1) {
            for (var i = 0; i < arrCId.length; i++) {
                var fvObject = dt.Rows[0][arrQuery[i]];
                var fv = fvObject.toString();
                if (jQuery.type(fvObject) == "date")
                    fv = fvObject.format("yyyy-MM-dd");
                document.getElementById(arrCId[i]).value = fv;
                $("#" + arrCId[i]).change();
            }
        }
        else {
            $(ctl).val("");
            var cond = [];
            cond.push("queryid=" + arr[0]);
            cond.push("queryfield=" + arr[2]);
            cond.push("cid=" + arr[1]);
            var initArr = [];
            var arrCond = arr[4].split(",");
            if (arr.length > 5) {
                arrCond = arr[5].split(",");
            }
            for (var i = 0; i < arrCond.length; i++) {
                initArr.push(arrCond[i] + " like [QUOTES]%" + v + "%[QUOTES]");
            }
            if (initArr.length > 0) {
                cond.push("initCond=" + escape(initArr.join(" or ")));
            }
            var b = $.isFunction(window["_fnParaCallback"]);
            if (b) {
                var _para = window["_fnParaCallback"](fld.name, ctl.id);
                if (!!_para) {
                    if (!!_para["condition"])
                        scope = _para["condition"];
                    cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));

                    if (!!_para["defaultvalue"])
                        cond.push("defaultValue=" + escape(_para["defaultvalue"]).replace(/\+/g, '%2B'));
                }
                else {
                    cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));
                }
            }
            else {
                cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));
            }

            if (arr.length > 5) {
                cond.push("multi=" + arr[4]);
            }
            _openPage("../AppFrame/AppOutSelect.aspx?" + cond.join("&"));
        }
    }
    else {
        $(ctl).data("valid", 0);
    }
}

//032弹出窗口，点击事件
function _clickSearch(ctl) {
    var fld = _getFieldById(ctl.id);
    if (fld.limit == "0")
        return;
    //QueryID|本表字段控件ID|查询字段|过滤条件|multi|查询条件字段
    var arr = $(ctl).attr("display").split("|");
    var arrCId = arr[1].split(",");
    var arrQuery = arr[2].split(",");
    var scope = "";
    var v = $(ctl).val();
    if (arr[3].length > 0) {
        if (ctl.id.indexOf("SubTbl") == 0) {
            var segs = ctl.id.split("_");
            var subOdr = segs[0].substring(7);
            scope = _replacePara(arr[3], subOdr, segs[1]);
        }
        else {
            scope = _replacePara(arr[3]);
        }
    }

    var cond = [];
    cond.push("queryid=" + arr[0]);
    cond.push("queryfield=" + arr[2]);
    cond.push("cid=" + arr[1]);

    var b = $.isFunction(window["_fnParaCallback"]);
    if (b) {
        var _para = window["_fnParaCallback"](fld.name, ctl.id);
        if (!!_para) {
            if (!!_para["condition"])
                scope = _para["condition"];
            cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));

            if (!!_para["defaultvalue"])
                cond.push("defaultValue=" + escape(_para["defaultvalue"]).replace(/\+/g, '%2B'));
        }
        else {
            cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));        
        }
    }
    else{
        cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));
    }
    if (arr.length > 5) {
        cond.push("multi=" + arr[4]);
    }
    _openPage("../AppFrame/AppOutSelect.aspx?" + cond.join("&"));
}

//032弹出窗口，点击事件回调函数
function _afterOutSelect(arrId, arrVal) {
    for (var i = 0; i < arrId.length; i++) {
        var ctlName = arrId[i];
        var ctlArr = $("input[name='" + ctlName + "']");
        if (ctlArr.length > 1) {
            var vals = arrVal[i].split(",");
            ctlArr.each(function (i, ctl) {
                if ($.inArray(ctl.value, vals) > -1)
                    $(ctl).attr("checked", "checked");
            });
        }
        else {
            jQuery("#" + ctlName).val(arrVal[i]).change();
        }
    }
}

//037弹出窗口，点击事件
function _clickFrame(ctl) {
    var fld = _getFieldById(ctl.id);
    if (fld.limit == "0")
        return;
    //QueryID|本表字段控件ID|查询字段|过滤条件|multi|查询条件字段
    var arr = $(ctl).attr("display").split("|");
    var arrCId = arr[1].split(",");
    var arrQuery = arr[2].split(",");
    var scope = "";
    var v = $(ctl).val();
    if (arr[3].length > 0) {
        if (ctl.id.indexOf("SubTbl") == 0) {
            var segs = ctl.id.split("_");
            var subOdr = segs[0].substring(7);
            scope = _replacePara(arr[3], subOdr, segs[1]);
        }
        else {
            scope = _replacePara(arr[3]);
        }
    }
    var cond = [];
    cond.push("framecode=" + arr[0]);
    cond.push("queryfield=" + arr[2]);
    cond.push("cid=" + arr[1]);
    cond.push("condition=" + escape(scope).replace(/\+/g, '%2B'));
    if (arr.length > 5) {
        cond.push("multi=" + arr[4]);
    }
    _openCenter("../AppFrame/AppTreeSelFrame.aspx?" + cond.join("&"),'_blank',900,500);
}

//032弹出窗口，返回多行
function _afterMultiRowsSel(retctl, multiRow, subName) {
    if (arguments.length == 2) {
        var segs = retctl[0].split("_");
        var subOdr = segs[0].substring(7);
        var rowId = _getRowId(retctl[0]);
        var subT = _sysModel[0].subtbls[subOdr];
        if(multiRow.length >1)
            _sys.subAutoSn = false;

        for (var i = 0; i < retctl.length; i++) {
            $("#" + retctl[i]).val(multiRow[0].data[i]).change();
        }

        for (var i = 1; i < multiRow.length; i++) {
            if (i == multiRow.length - 1)
                _sys.subAutoSn = true;
            var newId = _fnSubAdd(subT.tblname);
            for (var n = 0; n < retctl.length; n++) {
                segs = retctl[n].split("_");
                segs[1] = newId;
                var _ctlid = segs.join("_");
                $("#" + _ctlid).val(multiRow[i].data[n]).change();
            }
        }
    }
    else if (arguments.length == 3) {
        var subOdr = _getSubOdr(subName);
        for (var i = 0; i < multiRow.length; i++) {
            var newId = _fnSubAdd(subName);
            var rowId = "SubTbl0" + subOdr + "_" + newId + "_";
            for (var n = 0; n < retctl.length; n++) {
                _sys.setValue(retctl[n], multiRow[i].data[n], true, rowId);
            }
        }
    
    }
}
var _emptyValue = false;
//参数替换
function _replacePara(source, subOdr, rowNum) {
    _emptyValue = false;
    var reg = /{!?([\w\._1-9]+)!?}/gi;
    var matches = source.match(reg);
    if (matches != null) {
        for (var i = 0; i < matches.length; i++) {
            var fldName = matches[i].substr(1, matches[i].length - 2);
	        fldName = fldName.replace(/!/g,"");
            if (arguments.length == 3) {
                if (fldName.substring(0, 1) == ".") {
                    var subfld = fldName.substring(1);
                    var ix = _getFieldOdr(subOdr, subfld);
                    if (ix > -1) {
                        var subval = $("#SubTbl0" + subOdr + "_" + rowNum + "_" + ix).val();
                        source = source.replace(matches[i], subval);
                    }
                }
                else {
                    var fldv = _sys.getValue(fldName);
                    if (fldv == _tmplRowId) fldv = "";
                    if (fldv == "" && !_emptyValue) { _emptyValue = true; }
                    source = source.replace(matches[i], fldv);
                }
            }
            else {
                var fldv = _sys.getValue(fldName);
                if (fldv == _tmplRowId) fldv = "";
                if (fldv == "" && !_emptyValue) { _emptyValue = true; }

                source = source.replace(matches[i], fldv);
            }
        }
    }
    return source;
}

//主表字段映射关系
function _genModelsMap() {
    if (!!_sys.models)
        return;

    _sys.models = {};

    for (var n = 0; n < _sysModel.length; n++) {
        var mtbl = _sysModel[n];
        mtbl.modr = n;
        mtbl.prefix = "input" + n;
        _sys.models[mtbl.tblname] = mtbl;

        var fmap = {};
        _sys.models[mtbl.tblname + "_flds"] = fmap;
        var fieldArr = mtbl.fields;
        for (var i = 0; i < fieldArr.length; i++) {
            fmap[fieldArr[i].name] = fieldArr[i];
        }

        for (var s = 0; s < mtbl.subtbls.length; s++) {
            var stbl = mtbl.subtbls[s];
            //主表序号
            stbl.modr = n;
            stbl.sodr = s;
            stbl.msodr = n + "" + s;
            stbl.prefix = "SubTbl" + stbl.msodr;

            _sys.models[stbl.tblname] = stbl;
            var smap = {};
            _sys.models[stbl.tblname + "_flds"] = smap;
            var fieldArr = stbl.fields;
            for (var j = 0; j < fieldArr.length; j++) {
                smap[fieldArr[j].name] = fieldArr[j];
            }
        }
    }

}

//查询主表字段序号
function _getFieldOdr(fldName) {
    var fld;
    if(arguments.length==2)
        fld = _getField(arguments[0], arguments[1]);
    else
        fld = _getField(fldName);

    return !!fld ? fld.order : -1;
}

//返回字段定义
function _getField(fldName) {
    if (arguments.length == 1) {
        var arr = fldName.split(".");
        if (arr.length == 1) {
            var tblName = _sysModel[0].tblname;
            return _sys.models[tblName + "_flds"][fldName];
        }
        else {
            return _sys.models[arr[0] + "_flds"][arr[1]];
        }

    }
    else if (arguments.length == 2) {
        var tblName = arguments[0];
        return _sys.models[tblName + "_flds"][arguments[1]];

    }
    else {
        alert("参数有误");
    }

    //请求的字段定义不存在
    return null;

}

//返回字段定义
function _getFieldById(ctlId) {
    if (ctlId.indexOf("SubTbl") == 0) {
        var segs = ctlId.split("_");
        var mOdr = segs[0].substring(6,7);
        var sOdr = segs[0].substring(7);
        var subT = _getSubByOrder(mOdr, sOdr);

        var fldOdr = segs[2];
        

        for (var i = 0; i < subT.fields.length; i++) {
            if (subT.fields[i].order == fldOdr)
                return subT.fields[i];
        }

    }
    else {
        var mOdr = ctlId.substring(5,6);
        var fldOdr = ctlId.substring(6);
        var fldList = _sysModel[mOdr].fields;
        for (var i = 0; i < fldList.length; i++) {
            if (fldList[i].order == fldOdr)
                return fldList[i];
        }
    }

    //请求的字段定义不存在
    return null;

}

//返回控件对应的字段名称
function _getFieldName(ctl) {
    if (ctl.name.substr(0, 5) == "input")//主表
    {
        var tblIndex = ctl.name.substr(5, 1);
        var fieldArr = _sysModel[tblIndex].fields;
        for (var i = 0; i < fieldArr.length; i++) {
            if (fieldArr[i].order == ctl.name.substr(6))
                return fieldArr[i].name;
        }
        return "";
    }
    else {

    }
}

//返回主表指定字段名的控件值
function _getCtlByFieldName(fldName) {

    var fldOrder = _getFieldOdr(fldName);
    if (fldOrder == -1)
        return null;
    else {
        var ctlName = "input0" + fldOrder;
        return $("input[name='" + ctlName + "']");
    }

}

//返回主表指定字段名的控件值
function _getFieldValue(fldName, replace, rowId) {
    if (arguments.length < 3) {
        var fldOrder = _getFieldOdr(fldName);
        if (fldOrder == -1)
            return _tmplRowId;
        else {

            if (arguments.length == 2) {
                if (replace)
                    return _getValueXml(fldName);
            }
            else {
                var tName = _sysModel[0].tblname;
                var arrfld = fldName.split('.');
                if (arrfld.length == 2) {
                    tName = arrfld[0];
                    fldName = arrfld[1];
                }

                var ctlName = _sys.models[tName].prefix + fldOrder;
                var ctlArr = $("input[name='" + ctlName + "']");
                if (ctlArr.length > 1) {
                    return _getGroupValueByName(ctlName).join(",");
                }
                else {
                    if (document.getElementById(ctlName))
                        return jQuery("#" + ctlName).val();
                }
            }
        }
    }
    else {
        var subOdr = rowId.substr(7, 1);
        var sub = _getSubByCtlId(rowId);
        var fldOrder = _getFieldOdr(sub.tblname, fldName);
        if (fldOrder == -1)
            return "";
        else {
            var ctlName = rowId + fldOrder;
            var ctlArr = $("input[name='" + ctlName + "']");
            if (ctlArr.length > 1) {
                return _getGroupValueByName(ctlName).join(",");
            }
            else {
                if (document.getElementById(ctlName))
                    return jQuery("#" + ctlName).val();
            }
            if (replace)
                return _getValueXml(fldName,rowId);
        }
    }

    return _tmplRowId;
}

function _getValueXml(fldName, rowId) {
    if (arguments.length == 1) {

        var tName = _sysModel[0].tblname;
        var arrfld = fldName.split('.');
        if (arrfld.length == 2) {
            tName = arrfld[0];
            fldName = arrfld[1];
        }

        var rowNode = jQuery(tName + ">row:first", _xmlData);
        var xmlEl = rowNode.find(fldName);
        return xmlEl.text();
    }
    else {
        var rowNode = _xmlData.find("#" + rowId);
        var xmlEl = rowNode.find(fldName);
        return xmlEl.text();
    }
}

//返回多附件字段上传的文件名
function _getFileNames(fldName) {
    var fldOdr = _getFieldOdr(fldName);
    try {
        return getFrame("frm_" + fldOdr).getFileNames();
    } catch (e) { }

    return null;
}

//设置主表的字段值
function _setFieldValue(fldName, val, replace, rowId) {
    if (arguments.length < 4) {
        var tName = _sysModel[0].tblname;
        var arrfld = fldName.split('.');
        if (arrfld.length == 2)
        {
            tName = arrfld[0];
            fldName = arrfld[1];
        }
        var mtbl = _sys.models[tName];

        var fldOrder = _getFieldOdr(tName+"."+fldName);
        if (fldOrder == -1)
            return;
        else {
            var ctlName = mtbl.prefix + fldOrder;
            var ctlNameP = ctlName + "_p";
            var ctlArr = $("input[name='" + ctlName + "']");
            if (ctlArr.length > 1) {
                var vals = val.split(",");
                ctlArr.each(function (i, ctl) {
                    $(ctl).prop("checked",$.inArray(ctl.value, vals) > -1);
                });
            }
            else {
                if( jQuery("#" + ctlName).length == 1)
                    jQuery("#" + ctlName).val(val);

                jQuery("#" + ctlNameP).html(val);
            }

            if (arguments.length == 3 && replace)
                _setValueXml(fldName,val);
        }
    }
    else {
        var mOdr = rowId.substring(6, 7);
        var sOdr = rowId.substring(7, 8);
        var sub = _getSubByOrder(mOdr,sOdr);

        var fldOrder = _getFieldOdr(sub.tblname, fldName);

        var ctlName = rowId + fldOrder;
        var ctlNameP = ctlName + "_p";

        var ctlArr = $("input[name='" + ctlName + "']");
        if (ctlArr.length > 1) {
            var vals = val.split(",");
            ctlArr.each(function (i, ctl) {
                $(ctl).prop("checked", $.inArray(ctl.value, vals) > -1);
            });
        }
        else {
            if (jQuery("#" + ctlName).length == 1) {
                jQuery("#" + ctlName).val(val).change();
                jQuery("#" + ctlNameP).html(val);
            }
            else {
                jQuery("#" + ctlNameP).html(val);
            }
        }
        if (replace) 
            _setValueXml(fldName, val, rowId);
    }
}

function _setValueXml(fldName, val, rowId) {
    if (arguments.length == 2) {
        var tName = _sysModel[0].tblname;
        var arrfld = fldName.split('.');
        if (arrfld.length == 2) {
            tName = arrfld[0];
            fldName = arrfld[1];
        }

        var rowNode = jQuery(tName+">row:first", _xmlData);
        var xmlEl = rowNode.find(fldName);
        xmlEl.text(val);
        if (rowNode.attr("state") == "Unchanged")
            rowNode.attr("state", "Modified");
    }
    else {
        var rowNode = null;
        if (typeof (rowId) == "string")
            rowNode = _xmlData.find("#" + rowId);
        else
            rowNode = rowId;
        var xmlEl = rowNode.find(fldName);
        xmlEl.text(val);
        if (rowNode.attr("state") == "Unchanged")
            rowNode.attr("state", "Modified");
    }
}

//设置控件的值
function _setCtlValue(ctlName, val) {
    var ctlArr = $("input[name='" + ctlName + "']");
    if (ctlArr.length > 1) {
        var vals = val.split(",");
        ctlArr.each(function (i, ctl) {
            if ($.inArray(ctl.value, vals)>-1)
                $(ctl).attr("checked", "checked");
        });
    }
    else {
        jQuery("#" + ctlName).val(val);
    }
}

//平台对象
var _sys = {
    "getField": _getField,
    "getInput": _getCtlByFieldName,
    "setValue": _setFieldValue ,
    "getValue": _getFieldValue ,
    "setCtlValue": _setCtlValue ,
    "subAutoSn": true, "rowChange": true, "saveClose":true, "subDownAdd":false
 };

//返回Radio或者CheckBox的值（数组）
function _getGroupValue(ctlArr) {
    var ctlval = [];
    for (var i = 0; i < ctlArr.length; i++) {
        if (ctlArr[i].checked)
            ctlval.push(ctlArr[i].value);
    }
    return ctlval;
}

//返回Radio或者CheckBox的值（数组）
function _getGroupValueByName(ctlName) {
    var ctlArr = document.getElementsByName(ctlName);
    var ctlval = [];
    for (var i = 0; i < ctlArr.length; i++) {
        if (ctlArr[i].checked)
            ctlval.push(ctlArr[i].value);
    }
    return ctlval;
}

function _getRowsCount(subTbl) {

    return jQuery("tr.dataRow","#" + subTbl).length;
    //return jQuery("Table[TableName=" + subTbl + "]>row", _xmlData).length;
}

//保存数据
function _sysSave(op) {
    op = op || { 'close': true };
    //保存HTML编辑器
    try{
    KindEditor.sync('.WebEditor');
    } catch (e) { }

    var checkFlag = true;
    if (typeof (_sysBeforeSave) == "function") {
        //自定义验证，通过返回true
        checkFlag = _sysBeforeSave();
    }
    if (!checkFlag)
        return false;

    //验证同步数据
    if (!_formSynchData())
        return false;

    if (checkFlag) {
        var ret = _curClass.saveData(_mainTblName, _serializeToString(_xmlData));
        if (ret.error) {
            alert(ret.error.Message);
            return false;
        }
        else {
            //保存成功标志
            var saveFlag = true;
            if (typeof (_sysAfterAdd) == "function" && _isNew) {
                //新增保存通过后                        
                saveFlag = _sysAfterAdd();
            }
            else if (typeof (_sysAfterEdit) == "function" && !_isNew) {
                //修改保存通过后
                saveFlag = _sysAfterEdit();
            }
            //保存之后修改客户端缓存
            if (!op.close || !_sys.saveClose) {
                _isNew = false;
                _refreshXml();
            }
            return saveFlag;

        }
    }
    else {
        return false;
    }
}

//保存之后刷新客户端XML
function _refreshXml() {

    for (var mainOrd = 0; mainOrd < _sysModel.length; mainOrd++) {
        var curtbl = _sysModel[mainOrd];
        var mainNode = jQuery("row:first", _xmlData);
        mainNode.attr("state", "Unchanged");
        var subTblCount = curtbl.subtbls.length;
        for (var j = 0; j < subTblCount; j++) {
            //行数
            var subTbl = curtbl.subtbls[j];
            var fldCount = subTbl.fields.length;
            var subName = subTbl.tblname;
            var dataRows = _xmlData.find("Table[TableName='" + subName + "']>row");
            var rowCount = dataRows.length;

            for (var n = 0; n < rowCount; n++) {
                var rowNode = dataRows.eq(n);
                var st = rowNode.attr("state");
                if (st == "Deleted") {
                    var pNode = rowNode[0].parentNode;
                    pNode.removeChild(rowNode[0]);
                }
                else {
                    rowNode.attr("state", "Unchanged");
                }

            }
        }
    }
}

//仅验证表单，外部使用
function _formValidate() {

    for (var mainOrd = 0; mainOrd < _sysModel.length; mainOrd++) {
        var curtbl = _sysModel[mainOrd];
        //第一步验证数据
        var fieldsCount = curtbl.fields.length;
        for (var i = 0; i < fieldsCount; i++) {
            var el = curtbl.fields[i];
            if (_validateCtl(el) == false)
                return false;
        }
        for (var j = 0; j < curtbl.subtbls.length; j++) {
            //行数
            var subTbl = curtbl.subtbls[j];
            var rowCount = subTbl.maxorder;
            var fldCount = subTbl.fields.length;
            for (var n = 0; n < rowCount; n++) {
                var rowId = "SubTbl" + mainOrd + j + "_" + n + "_";
                if (document.getElementById(rowId) == null) continue;
                for (var i = 0; i < fldCount; i++) {
                    var el = subTbl.fields[i];
                    if (_validateCtl(el, rowId) == false)
                        return false;

                }
            }
        }
    }
    return true;
}

//验证表单，同步表单数据
function _formSynchData() {

    for (var mainOrd = 0; mainOrd < _sysModel.length; mainOrd++) {
        var curtbl = _sysModel[mainOrd];
        var rowNode = jQuery(curtbl.tblname + ">row", _xmlData);
        for (var i = 0; i < curtbl.fields.length; i++) {
            var el = curtbl.fields[i];
            var ctlName = "input" + mainOrd + el.order;
            //var ctl = $("#" + ctlName);
            var ctl = document.getElementById(ctlName);
            if (!!ctl && ctl.id == ctlName)//如果控件存在
            {
                if (_validateCtl(el, ctl) == false)
                    return false;
                var cv = ctl.value == '<请双击选择>' ? '':ctl.value;
                _synchData(rowNode, el, cv);
            }
            else {
                //针对Radio和CheckBox的情况做处理，只有控件存在的情况下才更新
                var ctlArr = document.getElementsByName(ctlName);

                if (ctlArr.length > 0) {
                    var ctlval = _getGroupValue(ctlArr);
                    if (_validateCtl(el, ctlArr, ctlval) == false)
                        return false;

                    if (el.dispstyle.substr(0, 2) == "04") {
                        _synchData(rowNode, el, ctlval.join(","));
                    }
                    else if (el.dispstyle.substr(0, 2) == "05") {
                        _synchData(rowNode, el, ctlval.join(","));

                    }
                }
            }

        }

        var subTblCount = curtbl.subtbls.length;
        for (var j = 0; j < subTblCount; j++) {
            //行数
            var subTbl = curtbl.subtbls[j];
            var fldCount = subTbl.fields.length;

            var dataRows = _xmlData.find(subTbl.tblname + ">row");
            var rowCount = dataRows.length;
            if (_saveAction == "1" && subTbl.notnull == "是" && rowCount == 0) {
                alert("明细表【" + subTbl.tblnamecn + "】必填，请录入数据");
                return false;
            }

            for (var n = 0; n < rowCount; n++) {
                var rowNode = dataRows.eq(n);
                var rowId = rowNode.attr("id");
                var rIndex = $("#" + rowId).index();
                rowNode.attr("newodr", rIndex);

                if (document.getElementById(rowId) == null) continue;

                for (var i = 0; i < fldCount; i++) {
                    var el = subTbl.fields[i];
                    var ctlName = rowId + el.order;
                    var ctl = document.getElementById(ctlName);
                    if (!!ctl && ctl.id == ctlName)//如果控件存在
                    {
                        
                        if (subTbl.mode != "1" && _validateCtl(el, ctl) == false)
                            return false;
                        var cv = ctl.value == '<请双击选择>' ? '' : ctl.value;
                        _synchData(rowNode, el, cv);
                    }
                    else {
                        var ctlArr = document.getElementsByName(ctlName);

                        //针对Radio和CheckBox的情况做处理，只有控件存在的情况下才更新
                        if (ctlArr.length > 0) {
                            var ctlval = _getGroupValue(ctlArr);
                            if (subTbl.mode != "1" && _validateCtl(el, ctlArr, ctlval) == false)
                                return false;

                            if (el.dispstyle.substr(0, 2) == "04") {
                                _synchData(rowNode, el, ctlval.join(","));
                            }
                            else if (el.dispstyle.substr(0, 2) == "05") {
                                _synchData(rowNode, el, ctlval.join(","));

                            }
                        }
                    }

                }
            }
        }
    }

    return true;
}

//序列化
function _serializeToString(objXML) {
    if (window.XMLSerializer) {
        return (new XMLSerializer()).serializeToString(objXML.find("root")[0])
    }
    else {
        return objXML.find("root")[0].xml;
    }
}

//同步数据到xml
function _synchData(rowNode, el, val) {
    //修改值
    if (el.save == "0")
        return;
    var xmlEl = rowNode.find(el.name);
    if(el.type == "2")
        val = val.replace(/,/g, "").replace(/ /g, "");
    if (xmlEl.text() != val) {
        xmlEl.text(val);
        if (rowNode.attr("state") == "Unchanged")
            rowNode.attr("state", "Modified");
    }
}

//验证控件
function _validateCtl(el,ctlArr, valArr) {
    if (ctlArr.length == 0)
        return true;


    //针对Radio和CheckBox的情况做处理，只判断 必填
    if (arguments.length == 3 && ctlArr.length > 0) {
        if (valArr.length == 0 && el.empty == "1" && _saveAction == "1") {
            alert("[" + el.namecn + "]不能为空");
            return false;
        }
        else {
            return true;
        }
    }
    else {
        if (el.empty == "1" && _saveAction == "1") {
            //针对附件校验
            if (el.dispstyle == "023") {
                try {
                    var has = getFrame("frm_" + el.order).hasFiles();
                    if (!has) {
                        alert("请上传附件〔" + el.namecn + "〕");
                        return false;
                    }

                } catch (e) {}
            }
        }
    }

    var ctl = $(ctlArr);
    var val = ctl.val(); if (val == null) val = "";
    var maxlen = el.length.split(",")[0];
    if (el.empty == "1" && val.length == 0 && _saveAction == "1")//不能为空
    {
        alert("[" + el.namecn + "]不能为空");
        try {
            if (el.type != '4') ctl.focus();
            ctl.select();
        } catch (e) { }
        return false;
    }
    if (el.empty == "0" && val.length == 0)//可以为空，且内容为空
    {
        return true;
    }
    if (val.length > maxlen && el.type == 1) {
        alert("[" + el.namecn + "]的长度不能大于" + maxlen);
        try { ctl.focus(); ctl.select(); } catch (e) { }
        return false;
    }

    var regfld = [/^[-]?([\d,])*$/, /^[-]?\d+([\d,])*\.?\d*$/, /^\d{4}-\d{1,2}-\d{1,2}$/];
    switch (el.type) {
        case '2':
            if (!regfld[0].test(val))//不能为空
            {
                alert("[" + el.namecn + "]必须输入整数");
                ctl.focus();
                ctl.select();
                return false;
            }
            break;
        case '3':
            if (!regfld[1].test(val))//不能为空
            {
                alert("[" + el.namecn + "]输入不符合要求");
                ctl.focus();
                ctl.select();
                return false;
            }
            var dotlen = el.length.split(",")[1];
            var m = parseFloat("9999999999999999999999".substring(0, maxlen - dotlen) + "." + "999999".substring(0, dotlen));
            var v = parseFloat(val.replace(/[,]/g, ""));
            if (v > m) {
                alert("[" + el.namecn + "]的值不能大于" + m);
                ctl.focus();
                ctl.select();
                return false;
            }

            break;
        case '4':
            /*
            if(!regfld[2].test(val))//不能为空
            {
            alert(el.namecn+"必须输入合法的日期格式");
            ctl.focus();
            ctl.select();
            return false;
            }*/
            break;
        default:
            return true;
    }
    return true;
}

//生成数据行
function _createXml(subName, rowId) {

    var retxml = _xmlData[0].createElement("row");
    var attID = _xmlData[0].createAttribute("id");
    attID.nodeValue = rowId;

    var attst = _xmlData[0].createAttribute("state");
    attst.nodeValue = "Detached";

    var atNode = _xmlData[0].createElement("K_AUTOID");
    atNode.appendChild(_xmlData[0].createCDATASection(_newGuid()));
    retxml.appendChild(atNode);

    var flds = _sys.models[subName].fields;
    for (var i = 0; i < flds.length; i++) {
        var fldnode = _xmlData[0].createElement(flds[i].name);
        fldnode.appendChild(_xmlData[0].createCDATASection(""));
        retxml.appendChild(fldnode);

    }
    retxml.attributes.setNamedItem(attID);
    retxml.attributes.setNamedItem(attst);
    return retxml;

}

//返回子表记录ID
function _getSubId(rowId) {
    var rowNode = _xmlData.find("#" + rowId);
    var xmlEl = rowNode.find("K_AUTOID");
    var subId = xmlEl.text();
    return subId;
}

//根据子表控件的ID返回行号
function _getRowId(ctlId) {
    return ctlId.substring(0, ctlId.lastIndexOf('_') + 1);
}

//返回子表的序号
function _getSubOdr(subName, msg) {
    var sub = _sys.models[subName];
    if (!!sub)
        return sub.sodr;

    if(arguments.length == 1 || msg)
    alert("子表[" + subName + "]不存在，请检查确认");
    return -1;
}

function _getSubByOrder(modr,sodr)
{
    return _sysModel[parseInt(modr)].subtbls[parseInt(sodr)];
}

function _getSubByCtlId(ctlId) {

    var arr = ctlId.split("_");
    var mOdr = arr[0].substring(6, 7);
    var sOdr = arr[0].substring(7);

    return _sysModel[parseInt(modr)].subtbls[parseInt(sodr)];
}

//设置子表自动序号列
function _setSubAutoSn(subName) {

    if (!_sys.subAutoSn) return;
    var sub = _sys.models[subName];

    var snFieldOdr = sub.snfield;
    if (typeof (snFieldOdr) == "undefined") {
        sub.snfield = "";
        snFieldOdr = "";

        for (var i = 0; i < sub.fields.length; i++) {
            var field = sub.fields[i];
            if (field.dispstyle == "003") {
                sub.snfield = field.name;
                snFieldOdr = field.name;
                break;
            }
        }
    }

    var sn = 1;
    if (snFieldOdr) {
        var maxOdr = sub.maxorder;
        var snArr = $("." + subName + "_" + snFieldOdr);
        for (var i = 0; i < snArr.length; i++) {
            var rowId = "#" + snArr.eq(i).attr("id");
            $(rowId).val(i);
            $(rowId + "_p").html(i);
        }
    }

    sn = 1;
    var snArr = $(".rowno", "#" + subName);
    for (var i = 0; i < snArr.length; i++) {
        snArr.eq(i).html(i);
    }

}

//增加子表数据行
function _fnSubAdd(subName, retRowId, dataRow) {
    var retId = false, refRowId = "";
    if (typeof (retRowId) == "string") {
        refRowId = retRowId;
        retId = true;
    }
    else {
        retId = !!retRowId;
    }
    //处理界面
    var sub = _sys.models[subName];
    var subOdr = sub.sodr;

    if (subOdr == -1)
        return;
    
    if (sub.mode == "1") {
        _fnPopAdd(subName);
        return;
    }
    var newOdr = sub.maxorder++;
    if (typeof (window["_" + subName + "_BeforeAdd"]) == "function") {
        var canAdd = window["_" + subName + "_BeforeAdd"](newOdr);
        if (!canAdd)
            return -1;
    }

    var newhtml = $("#" + sub.prefix + "_srkjdslABHSAS_").parent().html().replace(/_srkjdslABHSAS_/g, "_" + newOdr + "_");
    var arrField = sub.fields;
    var rowData = {};
    for (var i = 0; i < arrField.length; i++) {
        if (arrField[i].dispstyle == "023") {
            var fldodr = arrField[i].order;
            var newId = _newGuid();
            rowData[arrField[i].name] = newId;
            newhtml = newhtml.replace("{" + arrField[i].name + "}", newId);
        }
    }
    newhtml = newhtml.replace(/tmplRow/g, "dataRow");
    if(refRowId == "")
        $("#" + sub.prefix).append(newhtml);
    else
        $("#" + refRowId).before(newhtml);

    //处理XML数据
    var prefix = sub.prefix + "_" + newOdr + "_";
    var newNode = _createXml(subName, prefix);
    $(subName, _xmlData).append(newNode);
    if (typeof (window["_" + subName + "_AfterAdd"]) == "function") {
        window["_" + subName + "_AfterAdd"](newOdr, prefix);
    }

    if (!!_sys.rowChange) {
        if (window[subName + "_RowChange"])
            window[subName + "_RowChange"].trigger("rowchange");

        _setSubAutoSn(subName);
    }
    //子表附件设置
    for (var i = 0; i < arrField.length; i++) {
        if (arrField[i].dispstyle == "023") {
            var fldodr = arrField[i].order;
            var obj = $("#" + prefix + fldodr);
            if (obj.length == 1) {
                var newId = rowData[arrField[i].name];
                obj.val(newId);       
            }
        }
    }
    jQuery("input.emptytip", "#" + prefix).emptyValue();
    if (arguments.length > 2) {
        $.each(dataRow, function (fldn, fldv) {
            _sys.setValue(fldn, fldv, false, prefix);
        });
    }

    $(".dragtd", "#" + prefix).bind("mousedown", function (e) {
        var table = $("#" + subName)[0];
        var config = table.tableDnDConfig;
        $.tableDnD.initialiseDrag($("#" + prefix)[0], table, this, e, config);
        return false;
    });

    return retId ? prefix : newOdr;
}

//删除子表数据行，无提示
function _fnSubDel(subName, rowId) {
    var subOdr = _getSubOdr(subName);
    if (subOdr == -1)
        return;
    if ($("#" + rowId).length == 0)
        return;

    if (typeof (window["_" + subName + "_BeforeDel"]) == "function") {
        var flag = window["_" + subName + "_BeforeDel"](rowId);
        if (!flag) {
            return false;
        }
    }

    $("#" + rowId).remove();
    if ($("#" + rowId, _xmlData).attr("state") == "Detached")//如果是新记录，
    {
        $(subName, _xmlData)[0].removeChild($("#" + rowId, _xmlData)[0]);
    }
    else {
        $("#" + rowId, _xmlData).attr("state", "Deleted");
    }
    if (typeof (window["_" + subName + "_AfterDel"]) == "function") {
        window["_" + subName + "_AfterDel"](rowId);
    }

    if (!!_sys.rowChange) {
        if (window[subName + "_RowChange"])
            window[subName + "_RowChange"].trigger("rowchange");
        _setSubAutoSn(subName);
    }
    return true;
}

//删除子表数据行，带提示
function _fnSubDelConfirm(subName, rowId) {
    if (!confirm('确定删除这条记录吗?'))
        return;
    var subOdr = _getSubOdr(subName,false);
    if (subOdr == -1) {
        var ret = _curClass.DelRecord(subName, rowId);
        if (ret.error) {
            alert(ret.error.Message);
        }
        else {
            app_query(subName);
        }
    }
    else {
        var sub = _sys.models[subName];
        if (sub.mode == "1") {
            var subId = _getSubId(rowId);
            var ret = _curClass.DelSubRecord(subName, subId);
            _fnSubDel(subName, rowId);
        }
        else {
            _fnSubDel(subName, rowId);
        }
    }
}

//清空子表数据行
function _fnSubDelAll(subName) {

    var subOdr = _getSubOdr(subName,false);
    if (subOdr == -1) {
        var ret = _curClass.DelAllRecord(subName, _mainId);
        app_query(subName);
    }
    else {
        var sub = _sys.models[subName];
        if (sub.mode == "1") {
          var ret = _curClass.DelAllRecord(subName, _mainId);
        }

        var tblNode = $(subName, _xmlData)[0];
        var dataRows = _xmlData.find(subName + ">row");
        var rowCount = dataRows.length;

        for (var n = 0; n < rowCount; n++) {
            var rowNode = dataRows.eq(n);
            var rowId = rowNode.attr("id");
            if (rowNode.attr("state") == "Detached")//如果是新记录，
            {
                tblNode.removeChild(rowNode[0]);
            }
            else {
                rowNode.attr("state", "Deleted");
            }
            $("#" + rowId).remove();

        }

        if (window[subName + "_RowChange"])
            window[subName + "_RowChange"].trigger("rowchange");

        /*
        var snArr = $(".dataRow", "#" + subName);
        for (var i = 0; i < snArr.length; i++) {
            _sys.rowChange = (i == snArr.length - 1);
            var rowId = snArr[i].id;
            _fnSubDel(subName, rowId);
        }*/
        
    }

}

function _fnSubEdit(subName, rowId) {

    var subOdr = _getSubOdr(subName, false);

    if (subOdr == -1) {
        var url = "../AppFrame/AppInput.aspx?tblName=" + subName + "&mainId=" + rowId + "&sindex=" + _sIndex;
        var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
                    , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
        });
        dlg.ShowDialog();
    }
    else {
        var rowNode = _xmlData.find("#" + rowId);
        var xmlEl = rowNode.find("K_AUTOID");
        var subId = xmlEl.text();

        var sub = _sys.models[subName];
        var url="";
        if (sub.limit == "0") {
            url = "../AppFrame/AppSubView.aspx?tblName=" + subName + "&subId=" + subId + "&sindex=" + _sIndex;
        }
        else {
            url = "../AppFrame/AppSub.aspx?tblName=" + subName + "&rowId=" + rowId + "&subId=" + subId + "&mainId=" + _mainId + "&sindex=" + _sIndex;
        }
        var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
                    , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
        });
        dlg.ShowDialog();
    }
}

function _fnSubCopy(subName, rowId) {

    var sub = _sys.models[subName];

    if (!sub) {
        var url = "../AppFrame/AppInput.aspx?tblName=" + subName + "&mainId=&sindex=" + _sIndex + "&copyId=" + rowId + "&parentId=" + _mainId;
        var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
                    , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
        });
        dlg.ShowDialog();
    }
    else {
        if (sub.mode == "1") {
            var rowNode = _xmlData.find("#" + rowId);
            var xmlEl = rowNode.find("K_AUTOID");
            var subId = xmlEl.text();
            var newId = _fnNewRowId(subName);

            var url = "../AppFrame/AppSub.aspx?tblName=" + subName + "&rowId=" + newId + "&subId=&mainId=" + _mainId + "&sindex=" + _sIndex + "&copyId=" + subId;
            var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
                    , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
            });
            dlg.ShowDialog();
        }
        else {
            var num = _fnSubAdd(subName);
            var nRowId = rowId.substr(0, 9) + num + "_";
            var arrField = sub.fields;
            for (var i = 0; i < arrField.length; i++) {
                var v = _sys.getValue(arrField[i].name, true, rowId);
                if (arrField[i].dispstyle != "003" && arrField[i].dispstyle != "023") {
                    _sys.setValue(arrField[i].name, v, true, nRowId);
                }
            }
        }
    
    }

  }

function _fnNewRowId(subName) {
    var sub = _sys.models[subName];
    if (!sub)
        return;

    var newOdr = sub.maxorder++;
    var rowId = sub.prefix + "_" + newOdr + "_";
    return rowId;
}

//增加子表行（弹出）
function _fnPopAdd(subName) {

    var subOdr = _getSubOdr(subName,false);
    if (subOdr == -1) {
        var url = "../AppFrame/AppInput.aspx?tblName=" + subName + "&parentId=" + _mainId + "&sindex=" + _sIndex;
        var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
                , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
        });
        dlg.ShowDialog();
    }
    else {
        var sub = _sys.models[subName];
        if (sub.mode == "1") {
            //处理界面
            if (!_isNew) {
                _saveAction = "2";
                _isNew = _sysSave();
                _saveAction = "1";
                if (!_isNew) return;
            }
            var newOdr = _sysModel[0].subtbls[subOdr].maxorder++;
            if (typeof (window["_" + subName + "_BeforeAdd"]) == "function") {
                var canAdd = window["_" + subName + "_BeforeAdd"](newOdr);
                if (!canAdd)
                    return -1;
            }
            var rowId = sub.prefix + "_" + newOdr + "_";
            var url = "../AppFrame/AppSub.aspx?tblName=" + subName + "&rowId=" + rowId + "&subId=&mainId=" + _mainId + "&sindex=" + _sIndex;
            var dlg = new jQuery.dialog({ title: '编辑', maxBtn: true, page: url
            , btnBar: false, cover: true, lockScroll: false, width: 900, height: 600, bgcolor: 'black'
            });
            dlg.ShowDialog();
        }
        else {
            _fnSubAdd(subName);
        }
    }
}

//弹出回调函数
function _fnPopAddAfter(subName,rowId) {
    var subOdr = rowId.substr(7, 1);
    var newOdr = rowId.split("_")[1];
    var sub = _sys.models[subName];

    var newhtml = $("#" + sub.prefix + "_srkjdslABHSAS_").parent().html().replace(/_srkjdslABHSAS_/g, "_" + newOdr + "_");
    var arrField = _sysModel[0].subtbls[subOdr].fields;
    var rowData = {};
    for (var i = 0; i < arrField.length; i++) {
        if (arrField[i].dispstyle == "023") {
            var fldodr = arrField[i].order;
            var newId = _newGuid();
            rowData[arrField[i].name] = newId;
            newhtml = newhtml.replace("{" + arrField[i].name + "}", newId);
        }
    }
    newhtml = newhtml.replace(/tmplRow/g, "dataRow");
    $("#" + sub.prefix).append(newhtml);
    //处理XML数据
    var prefix = sub.prefix + "_" + newOdr + "_";
    var newNode = _createXml(subName, prefix);
    $(subName, _xmlData).append(newNode);
    if (typeof (window["_" + subName + "_AfterAdd"]) == "function") {
        window["_" + subName + "_AfterAdd"](newOdr, prefix);
    }

    if (!!_sys.rowChange) {
        if (window[subName + "_RowChange"])
            window[subName + "_RowChange"].trigger("rowchange");
        _setSubAutoSn(subName);
    }
    //子表附件设置
    for (var i = 0; i < arrField.length; i++) {
        if (arrField[i].dispstyle == "023") {
            var fldodr = arrField[i].order;
            var obj = $("#" + prefix + fldodr);
            if (obj.length == 1) {
                var newId = rowData[arrField[i].name];
                obj.val(newId);
            }
        }
    }
    jQuery("input.emptytip", "#" + prefix).emptyValue();
    return newOdr;
  
}

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

//系统弹出
function _openPage(url) {
    _openCenter(url, "_blank", 800, 500);
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

//传入控件ID得到数值
function _getNumById(ctlId) {
    if (document.getElementById(ctlId) && document.getElementById(ctlId).value) {
        var v = document.getElementById(ctlId).value.replace(/,/g, "");
        return parseFloat(isNaN(v) ? 0 : v);
    }
    else if (document.getElementById(ctlId+"_p")) {
        var v = $("#"+ctlId + "_p").html().replace(/,/g, "");
        return parseFloat((isNaN(v) || v == "") ? 0 : v);
    }
    else
        return 0;
}

//合计控件值
function _sumById() {
    var len = arguments.length;
    var s = 0;
    for (var i = 0; i < len; i++) {
        s += _getNumById(arguments[i])
    }
    return s;
}

//多个数相乘
function _multiById() {
    var len = arguments.length;
    var s = _getNumById(arguments[0]);
    for (var i = 1; i < len; i++) {
        s = s * _getNumById(arguments[i]);
    }
    return s;

}

//合计子表的字段
function _sumSubField(subName, fieldName, fnFilter) {

    var s = 0;
    var xsLen = 2;
    var sub = _sys.models[subName];
    var maxOdr = sub.maxorder;
    if (arguments.length == 3) {
        var fieldOdr = _getFieldOdr(sub, fieldName);
        if (jQuery.type(fnFilter) == "function") {
            for (var i = 0; i <= maxOdr; i++) {
                if (fnFilter(sub.prefix + "_" + i + "_")) {
                    s += _getNumById(sub.prefix + "_" + i + "_" + fieldOdr);
                }
            }
        }
        else {
            for (var i = 0; i <= maxOdr; i++) {
                s += _getNumById(sub.prefix + "_" + i + "_" + fieldOdr);
            }
        }
    }
    else if (arguments.length == 2) {
        var reg = /{([\w_1-9]+)}/gi;
        var matches = fieldName.match(reg);

        for (var i = 0; i <= maxOdr; i++) {
            var exp = fieldName;
            if (matches != null) {
                for (var j = 0; j < matches.length; j++) {
                    var fldName = matches[j].substr(1, matches[j].length - 2);
                    var fieldOdr = _getFieldOdr(subName, fldName);

                    var v = _getNumById(sub.prefix + "_" + i + "_" + fieldOdr);
                    var darr = v.toString().split(".");
                    if (darr.length == 2) {
                        if (darr[1].length > xsLen)
                            xsLen = darr[1].length;
                    }
                    var r = new RegExp(matches[j]);
                    exp = exp.replace(matches[j], v);
                }
                s += eval(exp);
            }
        }
    }
    return _fixNum(s, xsLen);
}

//如果结果为正数就返回整数，否则返回包含2位小数的float
function _fixNum(fval,xsLen) {
    var str = fval.toString();
    if (parseInt(str) == fval)
        return fval;
    else {
        if (arguments.length > 1) {
            return fval.toFixed(xsLen);
        }
        else {
            return fval.toFixed(2);
        }
    }
}

//相乘并合计子表字段
function _multiSubField(subName, fieldName1, fieldName2) {

    var xsLen = 2;
    var sub = _sys.models[subName];
    var maxOdr = sub.maxorder;
    var fieldOdr1 = _getFieldOdr(subName, fieldName1);
    var fieldOdr2 = _getFieldOdr(subName, fieldName2);
    var s = 0;
    for (var i = 0; i <= maxOdr; i++) {
        var prefix = sub.prefix + "_" + i + "_";
        s += _multiById(prefix + fieldOdr1, prefix + fieldOdr2);
    }
    return _fixNum(s);
}

//计算主表某行的表达式
function _computeExp(exp,xlen) {
    var xsLen = 2;
    if (arguments.length == 2)
        xsLen = parseInt(xlen);

    var reg = /{([\w_1-9]+)}/gi;
    var matches = exp.match(reg);
    if (matches != null) {
        for (var j = 0; j < matches.length; j++) {
            var fldName = matches[j].substr(1, matches[j].length - 2);
            var fldOrder = _getFieldOdr(fldName);
            var ctlName = "input0" + fldOrder;
            var v = _getNumById(ctlName);
            var darr = v.toString().split(".");
            if (darr.length == 2) {
                if (darr[1].length > xsLen)
                    xsLen = darr[1].length;
            }

            var r = new RegExp(matches[j]);
            exp = exp.replace(matches[j], v);
        }
        return _fixNum(eval(exp), xsLen);
    }
    return 0;
}

//计算子表某行的表达式
function _computeSubExp(subName, subField, rowOdr, exp) {
    var sub = _sys.models[subName];
    var tOdr = _getFieldOdr(subName, subField);
    var xsLen = 2;

    var reg = /{([\w_1-9]+)}/gi;
    var matches = exp.match(reg);
    if (matches != null) {
        for (var j = 0; j < matches.length; j++) {
            var fldName = matches[j].substr(1, matches[j].length - 2);
            var fieldOdr = _getFieldOdr(subName, fldName);

            var v = _getNumById(sub.prefix + "_" + rowOdr + "_" + fieldOdr);
            var darr = v.toString().split(".");
            if (darr.length == 2) {
                if (darr[1].length > xsLen)
                    xsLen = darr[1].length;
            }
            var r = new RegExp(matches[j]);
            exp = exp.replace(matches[j], v);
        }
        jQuery("#" + sub.prefix + "_" + rowOdr + "_" + tOdr).val(_fixNum(eval(exp), xsLen)).change();
    }
}

//金额小写转大写
function _a2c(Num) {
    Num = Num + ""
    Num = Num.replace(/,/g, "").replace(/ /g, "").replace("￥", "")
    if (isNaN(Num)) {
        alert("请检查小写金额是否正确");
        return;
    }
    var fu = "";
    part = String(Num).split(".");
    if (part[0].substr(0, 1) == '-') {
        fu = "负";
        part[0] = part[0].substr(1, part[0].length - 1);
    }
    newchar = "";
    for (i = part[0].length - 1; i >= 0; i--) {
        if (part[0].length > 10) { alert("位数过大，无法计算"); return ""; }
        tmpnewchar = ""
        perchar = part[0].charAt(i);
        switch (perchar) {
            case "0": tmpnewchar = "零" + tmpnewchar; break;
            case "1": tmpnewchar = "壹" + tmpnewchar; break;
            case "2": tmpnewchar = "贰" + tmpnewchar; break;
            case "3": tmpnewchar = "叁" + tmpnewchar; break;
            case "4": tmpnewchar = "肆" + tmpnewchar; break;
            case "5": tmpnewchar = "伍" + tmpnewchar; break;
            case "6": tmpnewchar = "陆" + tmpnewchar; break;
            case "7": tmpnewchar = "柒" + tmpnewchar; break;
            case "8": tmpnewchar = "捌" + tmpnewchar; break;
            case "9": tmpnewchar = "玖" + tmpnewchar; break;
        }
        switch (part[0].length - i - 1) {
            case 0: tmpnewchar = tmpnewchar + "元"; break;
            case 1: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
            case 2: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
            case 3: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
            case 4: tmpnewchar = tmpnewchar + "万"; break;
            case 5: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
            case 6: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
            case 7: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
            case 8: tmpnewchar = tmpnewchar + "亿"; break;
            case 9: tmpnewchar = tmpnewchar + "拾"; break;
        }
        newchar = tmpnewchar + newchar;
    }
    if (Num.indexOf(".") != -1) {
        if (part[1].length > 2) {
            part[1] = part[1].substr(0, 2)
        }
        for (i = 0; i < part[1].length; i++) {
            tmpnewchar = ""
            perchar = part[1].charAt(i)
            switch (perchar) {
                case "0": tmpnewchar = "零" + tmpnewchar; break;
                case "1": tmpnewchar = "壹" + tmpnewchar; break;
                case "2": tmpnewchar = "贰" + tmpnewchar; break;
                case "3": tmpnewchar = "叁" + tmpnewchar; break;
                case "4": tmpnewchar = "肆" + tmpnewchar; break;
                case "5": tmpnewchar = "伍" + tmpnewchar; break;
                case "6": tmpnewchar = "陆" + tmpnewchar; break;
                case "7": tmpnewchar = "柒" + tmpnewchar; break;
                case "8": tmpnewchar = "捌" + tmpnewchar; break;
                case "9": tmpnewchar = "玖" + tmpnewchar; break;
            }
            if (i == 0) tmpnewchar = tmpnewchar + "角";
            if (i == 1) tmpnewchar = tmpnewchar + "分";
            newchar = newchar + tmpnewchar;
        }
    }
    while (newchar.search("零零") != -1)
        newchar = newchar.replace("零零", "零");
    newchar = newchar.replace("零亿", "亿");
    newchar = newchar.replace("亿万", "亿");
    newchar = newchar.replace("零万", "万");
    newchar = newchar.replace("亿万", "亿");
    newchar = newchar.replace("零元", "元");
    newchar = newchar.replace("零角", "");
    newchar = newchar.replace("零分", "");
    if (newchar.charAt(newchar.length - 1) == "元")
        newchar = newchar + "整"
    if (newchar.charAt(0) == "元")
        newchar = newchar.substring(1);

    return fu + newchar;
}

String.prototype.repeat = function (n) {
    n = parseInt(n);
    return new Array(n + 1).join(this);
}

/*
* _formatMoney(s,type)
* 功能：金额按千位逗号分割
* 参数：s，需要格式化的金额数值.
* 参数：type,判断格式化后的金额是否需要小数位.
* 返回：返回格式化后的数值字符串.
*/

function _formatMoney(s, type) {
    s = s.toString().replace(/,/g, "").replace(/ /g, "").replace("￥", "");
    var fh = '';
    if (s.substr(0, 1) == '-') {
        fh = '-';
        s = s.substr(1);
    }
    if (/[^0-9\.]/.test(s)) return "0";
    if (s == null || s == "") return "0";

    var rt = "";
    if (s.indexOf('.') > 0) {
        rt = s.split('.')[1];
        s = s.split('.')[0];
        s = s + ',';
    }
    else {
        s = s.toString().replace(/^(\d*)$/, "$1.");
        var dots = "00";
        if(type !='0')
            dots = '0'.repeat(type);
        s = (s + dots).replace(/(\d*\.\d\d)\d*/, "$1");
        s = s.replace(".", ",");    
    }

    var re = /(\d)(\d{3},)/;
    while (re.test(s))
        s = s.replace(re, "$1,$2");

    if (rt != "") {
        if (type != "0") {
            rt = parseFloat('0.' + rt).toFixed(type);
            rt = rt.substring(2);
        }
        s = s.replace(/,$/, '.') + rt;
    }
    else {
        s = s.replace(/,(\d*)$/, ".$1");
    }

    if (type == 0) { // 不带小数位(默认是有小数位)
        var a = s.split(".");
        if (a[1] == "00") {
            s = a[0];
        }
    }
    return fh+s;
}

// 针对my97日历控件，把 onpicked 转化为change事件
function _datePicked(obj) { $(obj.srcEl).change(); }

//使用dt数据行填充select对象
function _fillSelect(ctlId, dt, fldTxt, fldVal, ResFirstOp) {
    if (!!dt) {
        var ctlSel = $("#" + ctlId);
        if (ctlSel.length == 1) {
            if (ResFirstOp)
                $("option:gt(0)", ctlSel).remove();
            else
                ctlSel.empty();
            for (var i = 0; i < dt.Rows.length; i++) {
                ctlSel.append("<option value='" + dt.Rows[i][fldVal] + "'>" + dt.Rows[i][fldTxt] + "</option>");
            }
        }
    }
}

(function ($) {
    $.fn.limitTextarea = function (opts) {
        var defaults = {
            maxNumber: 140, //允许输入的最大字数
            afterHtml:'', //提示后缀
            position: 'top', //提示文字的位置，top：文本框上方，bottom：文本框下方
            onOk: function () { }, //输入后，字数未超出时调用的函数
            onOver: function () { } //输入后，字数超出时调用的函数   
        }
        var option = $.extend(defaults, opts);
        this.each(function () {
            var _this = $(this);
            var info = '<div id="info">还可以输入<b><i>&nbsp;' + (option.maxNumber - _this.val().length) + '</i></b>&nbsp;&nbsp;字' + option.afterHtml + '</div>';
            var fn = function () {
                var extraNumber = option.maxNumber - _this.val().length;
                var $info = $('#info');
                if (extraNumber >= 0) {
                    $info.html('还可以输入<b><i>&nbsp;' + extraNumber + '</i></b>&nbsp;&nbsp;字' + option.afterHtml);
                    option.onOk();
                }
                else {
                    $info.html('已经超出<b style="color:red;"><i>&nbsp;' + (-extraNumber) + '</i></b>&nbsp;&nbsp;字' + option.afterHtml);
                    option.onOver();
                }
            };
            switch (option.position) {
                case 'top':
                    _this.before(info);
                    break;
                case 'bottom':
                default:
                    _this.after(info);
            }
            //绑定输入事件监听器
            if (window.addEventListener) { //先执行W3C
                _this.get(0).addEventListener("input", fn, false);
            } else {
                _this.get(0).attachEvent("onpropertychange", fn);
            }
            _this.bind("keydown", function (e) {
                var obj = e || window.event;
                var key = obj.keyCode;
                (key == 8 || key == 46) && fn(); //处理回退与删除
            });
            try {
                _this.get(0).attachEvent("oncut", fn); //处理粘贴

            } catch (e) {}
        });
    }
})(jQuery)

//扩展String对象
String.prototype.format = function(args) {
    var result = this;
    if (arguments.length > 0) {    
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if(args[key]!=undefined){
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        }
        else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
　　　　　　　　　　var reg= new RegExp("({)" + i + "(})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result;
}

//返回frame对象
function getFrame(id) {
    return document.getElementById(id).contentWindow || document.frames[id];
}

$.fn.insertAtCaret = function (tagName) {
    return this.each(function () {
        if (document.selection) {
            //IE support
            this.focus();
            sel = document.selection.createRange();
            sel.text = tagName;
            this.focus();
        } else if (this.selectionStart || this.selectionStart == '0') {
            startPos = this.selectionStart;
            endPos = this.selectionEnd;
            scrollTop = this.scrollTop;
            this.value = this.value.substring(0, startPos) + tagName + this.value.substring(endPos, this.value.length);
            this.focus();
            this.selectionStart = startPos + tagName.length;
            this.selectionEnd = startPos + tagName.length;
            this.scrollTop = scrollTop;
        } else {
            this.value += tagName;
            this.focus();
        }
    });
};

function _copyImg(editor,event) {
    if (event.clipboardData || event.originalEvent) {
        //not for ie11   某些chrome版本使用的是event.originalEvent
        var clipData = (event.clipboardData || event.originalEvent.clipboardData);
        //判断是否是粘贴图片
        if (clipData && clipData.items[0].type.indexOf('image') > -1) {
            var that = this;
            var reader = new FileReader();
            var file = clipData.items[0].getAsFile();
            reader.onload = function (e) {
                // 得到图片的base64 (可以用作即时显示)
                editor.insertHtml('<img src="' + this.result + '" alt=""/>');
            }
            reader.readAsDataURL(file);
        }
    }

}