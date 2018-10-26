$(function () {
    var fgbox = [];//将数据塞进数组中
    $(".ctable tbody tr").each(function (tri, trv) {
        var fgrow = [];
        $(trv).find(".fg").each(function (tdi, tdv) {
            var fgobj = { "text": $(tdv).text(), "rowspan": 1, "colspan": 1, "rowcount": 1 };
            fgrow.push(fgobj);
        });
        fgbox.push(fgrow);
    });

    //1处理横向合并
    for (var tri = fgbox.length - 1; tri > -1; tri--) {//横向合并先进行文本前移
        var fgrow = fgbox[tri];
        for (var tindex = 0; tindex < fgrow.length; tindex++) {//一步一位 需要多排几次才能合并所有空行
            for (var tdi = 1; tdi < fgrow.length; tdi++) {
                var fgobj = fgrow[tdi];//当前对象
                var fgobjprev = fgrow[tdi - 1];//前一个对象 因为tdi=1 所以不会出现数组溢出
                if (fgobjprev.text == "") {//如果前面值为空 就转移当前对象到前边 并清空自己
                    fgobjprev.text = fgobj.text;
                    fgobj.text = "";
                }
            }
        }
    }
    for (var tri = fgbox.length - 1; tri > -1; tri--) {//处理横向合并单元格
        var fgrow = fgbox[tri];
        for (var tdi = fgrow.length - 1; tdi > 0; tdi--) {
            var fgobj = fgrow[tdi];//当前对象
            var fgobjprev = fgrow[tdi - 1];//前一个对象
            if (fgobj.text == "") {//如果前面值为空 就合并2个单元格的colspan值 并清空自己的colspan
                fgobjprev.colspan = fgobjprev.colspan + fgobj.colspan;

                fgobj.colspan = 1;
            }
        }
    }

    //2处理纵向合并 
    for (var tri = fgbox.length - 1; tri > 0; tri--) {//行倒着循环 如果和上一行的值一样 就删除自己 并将自己的rowspan给上一行
        var fgrow = fgbox[tri];
        var fgrowprev = fgbox[tri - 1];
        for (var tdi = fgrow.length - 1; tdi > -1; tdi--) {
            var fgobj = fgrow[tdi];//当前对象
            var fgobjprev = fgrowprev[tdi];//前一个对象
            if (fgobj.text != "" && fgobjprev.text != "" && fgobj.text == fgobjprev.text) {//如果两值都不为空 同时又相同 就合并
                fgobjprev.rowspan = fgobjprev.rowspan + fgobj.rowspan;
                fgobjprev.rowcount = fgobjprev.rowcount + fgobj.rowcount;

                fgobj.text = "";//清空并重置自己
                fgobj.rowspan = 1;
                fgobj.rowcount = 1;
            }
        }
    }

    //3处理小计和合计
    for (var tri = 0; tri < fgbox.length; tri++) {//小计
        var fgrow = fgbox[tri];
        for (var tdi = 0; tdi < fgrow.length; tdi++) {
            var fgobj = fgrow[tdi];//当前对象
            if (fgobj.rowspan > 1 && fgobj.text != "") {//如果有合并行 并且值不为空 就计算小计
                fgobj.values = {};
                for (var sumi = 0; sumi < sumcol.length; sumi++) {//循环要合并哪些列
                    fgobj.values["sumcol" + sumcol[sumi]] = 0;//设置默认为0
                    for (var trei = tri; trei < tri + fgobj.rowspan; trei++) {//循环当前元素要小计的行数
                        var $tr = $(".ctable tbody tr").eq(trei);//将这些行的对应列小计进去
                        fgobj.values["sumcol" + sumcol[sumi]] += parseFloat($tr.find("td").eq(sumcol[sumi]).text() || "0");
                    }
                }
                fgobj.rowspan++;//累计完数据 再加一个放小计的行 自己加自己的

                for (var dbtri = 0; dbtri <= tri; dbtri++) {
                    var dbfgrow = fgbox[dbtri];
                    for (var dbtdi = 0; dbtdi < tdi; dbtdi++) {
                        var dbfgobj = dbfgrow[dbtdi];//要对比的对象
                        if (dbfgobj.rowspan > 1 && dbfgobj.text != "") {
                            //如果跨的行 包含本行 就要加一个小计行
                            if (dbtri + dbfgobj.rowspan >= tri) {
                                dbfgobj.rowspan++;
                            }
                        }
                    }
                }
            }
        }
    }
    //3.1处理合计
    var sumvalues = {};
    for (var sumi = 0; sumi < sumcol.length; sumi++) {//循环要合并哪些列
        sumvalues["sumcol" + sumcol[sumi]] = 0;//总计设置默认为0
        $(".ctable tbody tr").each(function (stri, strv) {
            sumvalues["sumcol" + sumcol[sumi]] += parseFloat($(strv).find("td").eq(sumcol[sumi]).text() || "0");
        });
    }
    sumvalues.hjcolspan = defcolspan;
    sumvalues.text = "总计（" + $(".ctable tbody tr").length + "）";

    //4渲染
    $("td.fg").remove();//先清空所有基金组
    for (var tri = fgbox.length - 1; tri > -1; tri--) {//仅渲染合并单元格
        var fgrow = fgbox[tri];
        var fghtml = [];
        for (var tdi = 0; tdi < fgrow.length; tdi++) {
            var fgobj = fgrow[tdi];
            if (fgobj.text) {
                fghtml.push(renderRow(fgobj, "<td class='fg' colspan='{{colspan}}' rowspan='{{rowspan}}'>{{text}}</td>"));
            }
        }
        var $v = $(".ctable tbody tr").eq(tri);
        $v.find(".tdcen").after(fghtml.join(''));//渲染合并单元格 
    }

    var sumcount = 0;//累计已经追加的小计行数
    for (var tri = 0; tri < fgbox.length ; tri++) {//正序插入
        var fgrow = fgbox[tri];
        var fghtml = [];
        for (var tdi = fgrow.length - 1; tdi > -1; tdi--) {
            var fgobj = fgrow[tdi];
            if (fgobj.rowspan > 1 && fgobj.text && fgobj.values) {//如果有小计 就追加一行
                fgobj.values.hjcolspan = defcolspan;//默认小计的td是跨5列
                for (var coli = tdi; coli > -1; coli--) {//如果有父级 有一级就减1个跨列 最少的是放到基金名称下
                    fgobj.values.hjcolspan = fgobj.values.hjcolspan - fgrow[coli].colspan;
                    fgobj.values.text = "<span class='xjtxt'>" + fgobj.text + "</span>小计（" + fgobj.rowcount + "）";
                }

                var afindex = tri + sumcount + fgobj.rowspan;
                if (fgrow.length == 3) {//合并3列的情况
                    if (tdi == 0 && fgobj.colspan == 1) {
                        afindex = afindex - 4;//如果是一级 并且有子级 就不用减
                    } else if (tdi == 1 && fgobj.colspan > 1 && fgrow[0].text == "") {
                        afindex = afindex - 3;//如果是二级 就-3 
                    } else {
                        afindex = afindex - 2;//如果是普通的 就-2
                    }
                } else if (fgrow.length == 2) {//合并2列的情况 
                    afindex = afindex - 2;//如果是普通的 就-2 
                } else if (fgrow.length == 1) {//合并1列的情况 
                    afindex = afindex - 2;//如果是普通的 就-2 
                }
                //小计追加的位置是 当前行号 + 累计追加过的计行数 + 要合的并的行数 - 自已和小计行所占的2行
                $(".ctable tbody tr").eq(afindex).after(renderRow(fgobj.values, sumtemp));
            }
        }
        for (var tdi = fgrow.length - 1; tdi > -1; tdi--) {
            var fgobj = fgrow[tdi];
            if (fgobj.rowspan > 1 && fgobj.text && fgobj.values) {//在本行都渲染追加小计行以后 
                sumcount++;//累计已经追加的小计行数
            }
        }
    }

    //追加总计
    $(".ctable tbody").append(renderRow(sumvalues, sumtemp));

    //处理千分位 万元
    $(".ctable .comdify").each(function (ci, cv) {
        $(cv).text(comdify($(cv).text()));
    });
    //处理千分位 亿元
    $(".ctable .comdify2").each(function (ci, cv) {
        $(cv).text(comdify2($(cv).text()));
    });
    //处理比例
    $(".ctable tbody td.ratio").each(function (ci, cv) {
        var txt = $(cv).text();
        if (txt) {
            if (txt == "0" || txt == "非数字" || txt == "正无穷大") {
                $(cv).text("");
            } else {
                $(cv).text($(cv).text() + "%");
            }
        }
    });

    $("td[dateformat]").each(function (i, v) {//日期格式化
        $(v).html(dateformat($(v).text(), $(v).attr("dateformat"))).removeAttr("dateformat");
    });
});

/*单行渲染*/
renderRow = function (datai, render) {
    var row = render;
    for (var attr in datai) {
        if (datai[attr] == null)
            datai[attr] = "";
        row = row.replace(new RegExp("{{" + attr + "}}", 'g'), datai[attr]);
    }
    return row;
};
/*数组渲染*/
render = function (data, render) {
    var tmp = [];
    for (var i = 0; i < data.length; i++) {
        var datai = data[i];//当前行 
        datai.datai = i;
        tmp.push(renderRow(datai, render));
    }
    return (tmp.join(''));
};
dateformat = function (value, dateformat) {
    if (value && dateformat) {
        var reg = /(\d{4})\S(\d{1,2})\S(\d{1,2})[\S\s](\d{1,2}):(\d{1,2}):(\d{1,2})/;
        var regdate = /(\d{4})\S(\d{1,2})\S(\d{1,2})/;
        if (reg.test(value) && value.toString().length < 20) {
            var result = value.match(reg);
            dateformat = dateformat.replace("yyyy", result[1]); //代表年
            dateformat = dateformat.replace("MM", result[2]);   //代表月
            dateformat = dateformat.replace("dd", result[3]);   //代表日
            dateformat = dateformat.replace("hh", result[4]);   //代表时
            dateformat = dateformat.replace("mm", result[5]);   //代表分
            dateformat = dateformat.replace("ss", result[6]);   //代表秒

            return dateformat;
        } else if (regdate.test(value) && value.toString().length < 20) {
            var result = value.match(regdate);
            dateformat = dateformat.replace("yyyy", result[1]); //代表年
            dateformat = dateformat.replace("MM", result[2]);   //代表月
            dateformat = dateformat.replace("dd", result[3]);   //代表日  

            return dateformat;
        }
    }
    return value;
};

function output(tableid) {//导出EXCEL 
    try {
        var ua = window.navigator.userAgent;
        if (ua.indexOf("Firefox") > -1 || ua.indexOf("Chrome") > -1) {//如果是好浏览器 就导出插件版 
            tableToExcel(tableid);
        } else {
            alert("请复制表格粘贴到EXCEL即可");
        }
    } catch (ex) {
        alert("导出失败,请复制表格粘贴到EXCEL即可");
    }
};

var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,',
            template = '<html><head><meta charset="UTF-8"></head><body><table border="1">{table}</table></body></html>',
            base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
            format = function (s, c) {
                return s.replace(/{(\w+)}/g,
                        function (m, p) { return c[p]; })
            }
    return function (table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
        window.location.href = uri + base64(format(template, ctx))
    }
})();
function comdify(n) {//处理千分位 
    if (!n || n == "0")//如果n为空 就直接返回0
        return "";

    var wn = parseFloat(n + "");
    wn = (wn / 10000.00).toFixed(2);//转换为万元单位

    var re = /\d{1,3}(?=(\d{3})+$)/g;
    return (wn + "").replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });

    return n1;
};
function comdify2(n) {//处理千分位 
    if (!n || n == "0")//如果n为空 就直接返回0
        return "";

    var wn = parseFloat(n + "");
    wn = (wn / 100000000.00).toFixed(2);//转换为亿元单位

    var re = /\d{1,3}(?=(\d{3})+$)/g;
    return (wn + "").replace(/^(\d+)((\.\d+)?)$/, function (s, s1, s2) { return s1.replace(re, "$&,") + s2; });

    return n1;
};