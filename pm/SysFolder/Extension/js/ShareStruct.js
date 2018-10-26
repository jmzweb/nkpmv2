
//画箭头 流程设计
(function (window, document) {
    if (window.mapleque == undefined)
        window.mapleque = {};
    if (window.mapleque.arrow != undefined)
        return;

    /**
     * 组件对外接口
     */
    var proc = {
        /**
        * 接收canvas对象，并在此上画箭头（箭头起止点已经设置）
        * @param context
        */
        paint: function (context, isfinish, zb, txt, txt1, colortype) { paint(this, context, isfinish, zb, txt, txt1, colortype); },
        /**
        * 设置箭头起止点
        * @param sp起点
        * @param ep终点
        * @param st强度
        */
        set: function (sp, ep, st) { init(this, sp, ep, st); },
        /**
        * 设置箭头外观
        * @param args
        */
        setPara: function (args) {
            this.size = args.arrow_size;//箭头大小
            this.sharp = args.arrow_sharp;//箭头锐钝
        }
    };

    var init = function (a, sp, ep, st) {
        a.sp = sp;//起点
        a.ep = ep;//终点
        a.st = st;//强度
    };
    var paint = function (a, context, isfinish, zb, txt, txt1, colortype) {
        var sp = a.sp;
        var ep = a.ep;
        if (context == undefined)
            return;
        //画箭头主线
        context.beginPath();
        var isdrow = false;//是否画过了 默认没画 只需要处理需要画的即可
        if (isfinish) {
            //画完的状态下 需要计算一下折线逻辑 
            var zbs = zb || 0.3;
            var px3 = Math.abs(sp.x - ep.x) * zbs;//x轴的3分之1位置
            var py3 = Math.abs(sp.y - ep.y) * zbs;//x轴的3分之1位置
            var miny = (sp.y > ep.y ? ep.y : sp.y) - 25;
            var maxy = (sp.y > ep.y ? sp.y : ep.y) + 10;
            var minx = (sp.x > ep.x ? ep.x : sp.x) - 5;
            var maxx = (sp.x > ep.x ? sp.x : ep.x) + 5;
            if (sp.position == "bottom" && ep.position == "top" && sp.y < ep.y && sp.x != ep.x) {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x, sp.y + py3);//第一个折点 
                context.lineTo(ep.x, sp.y + py3);
                context.lineTo(ep.x, ep.y);

                sp = { x: ep.x, y: sp.y + py3 };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "top" && ep.position == "top") {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x, miny);
                context.lineTo(ep.x, miny);
                context.lineTo(ep.x, ep.y);

                sp = { x: ep.x, y: miny };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "bottom" && ep.position == "bottom") {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x, maxy);
                context.lineTo(ep.x, maxy);
                context.lineTo(ep.x, ep.y);

                sp = { x: ep.x, y: maxy };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "left" && ep.position == "left") {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(minx, sp.y);
                context.lineTo(minx, ep.y);
                context.lineTo(ep.x, ep.y);

                sp = { x: minx, y: ep.y };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "right" && ep.position == "right") {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(maxx, sp.y);
                context.lineTo(maxx, ep.y);
                context.lineTo(ep.x, ep.y);

                sp = { x: maxx, y: ep.y };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "right" && ep.position == "left" && sp.x < ep.x && sp.y != ep.y) {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x + px3, sp.y);//第一个折点
                context.lineTo(sp.x + px3, ep.y);
                context.lineTo(ep.x, ep.y);

                sp = { x: sp.x + px3, y: ep.y };//箭头方向调正
                isdrow = true;
            }
            if (sp.position == "left" && ep.position == "right" && sp.x > ep.x && sp.y != ep.y) {
                //开始节点在上 结束节点在下  箭头从下画上这种情况
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x - px3, sp.y);//第一个折点
                context.lineTo(sp.x - px3, ep.y);
                context.lineTo(ep.x, ep.y);

                sp = { x: sp.x - px3, y: ep.y };//箭头方向调正
                isdrow = true;
            }
            if ((sp.position == "bottom" && ep.position == "right" && sp.y < ep.y && sp.x > ep.x) ||
                (sp.position == "bottom" && ep.position == "left" && sp.y < ep.y && sp.x < ep.x)) {
                //开始节点在上 结束节点在下  箭头从下画左这种情况 
                context.moveTo(sp.x, sp.y);
                context.lineTo(sp.x, ep.y);//第一个折点  
                context.lineTo(ep.x, ep.y);

                sp = { x: sp.x, y: ep.y };//箭头方向调正
                isdrow = true;
            }
            if ((sp.position == "right" && ep.position == "top" && sp.y < ep.y && sp.x < ep.x) ||
                (sp.position == "left" && ep.position == "top" && sp.y < ep.y && sp.x > ep.x)) {
                //开始节点在上 结束节点在下  箭头从下画左这种情况 
                context.moveTo(sp.x, sp.y);
                context.lineTo(ep.x, sp.y);//第一个折点  
                context.lineTo(ep.x, ep.y);

                sp = { x: ep.x, y: sp.y };//箭头方向调正
                isdrow = true;
            }
            if ((sp.position == "right" && ep.position == "bottom" && sp.y > ep.y && sp.x < ep.x) ||
                (sp.position == "left" && ep.position == "bottom" && sp.y > ep.y && sp.x > ep.x)) {
                //开始节点在上 结束节点在下  箭头从下画左这种情况 
                context.moveTo(sp.x, sp.y);
                context.lineTo(ep.x, sp.y);//第一个折点  
                context.lineTo(ep.x, ep.y);

                sp = { x: ep.x, y: sp.y };//箭头方向调正
                isdrow = true;
            }
        }

        if (!isdrow) {
            //如果没画过 就画直线
            context.moveTo(sp.x, sp.y);
            context.lineTo(ep.x, ep.y);
        }
        //画箭头头部
        var h = _calcH(a, sp, ep, context);
        context.moveTo(ep.x, ep.y);
        context.lineTo(h.h1.x, h.h1.y);
        context.moveTo(ep.x, ep.y);
        context.lineTo(h.h2.x, h.h2.y);
        context.strokeStyle = '#000000';//默认股权
        context.fillStyle = '#000000';//默认股权
        if (colortype) {
            switch (colortype) {
                //case "受托人"://受托
                //    context.strokeStyle = '#f15a22';
                //    context.fillStyle = '#f15a22';
                //    break
                case "GP"://gp
                    context.strokeStyle = '#0687a4';
                    context.fillStyle = '#0687a4';
                    break
            }
        }
        context.lineWidth = 1;
        if (txt) {//如果有要渲染的文本 就渲染 只画结束节点方位的上 左 右
            switch (ep.position) {
                case "top":
                    context.fillText(txt, ep.x + 5, ep.y - 10);//x轴居中 y轴向上
                    break;
                case "left":
                    context.fillText(txt, ep.x - 15 - (txt.length * 5), ep.y - 5);//x轴向右 y轴向上
                    break;
                case "right":
                    context.fillText(txt, ep.x + 10, ep.y - 5);//x轴向右 y轴向上
                    break;
                case "bottom":
                    context.fillText(txt, ep.x + 5, ep.y + 15);//x轴居中 y轴向上
                    break;
            }
        }
        if (txt1) {//如果有要渲染的文本 就渲染 只画结束节点方位的上 左 右
            switch (ep.position) {
                case "top":
                    context.fillText(txt1, ep.x + 5, ep.y - 10 - 15);//x轴居中 y轴向上
                    break;
                case "left":
                    context.fillText(txt1, ep.x - 15 - (txt1.length * 5), ep.y - 5 - 15);//x轴向右 y轴向上
                    break;
                case "right":
                    context.fillText(txt1, ep.x + 10, ep.y - 5 - 15);//x轴向右 y轴向上
                    break;
                case "bottom":
                    context.fillText(txt1, ep.x + 5, ep.y + 15 + 15);//x轴居中 y轴向上
                    break;
            }
        }
        context.stroke();
    };
    //计算头部坐标
    var _calcH = function (a, sp, ep, context) {
        var theta = Math.atan((ep.x - sp.x) / (ep.y - sp.y));
        var cep = _scrollXOY(ep, -theta);
        var csp = _scrollXOY(sp, -theta);
        var ch1 = { x: 0, y: 0 };
        var ch2 = { x: 0, y: 0 };
        var l = cep.y > csp.y ? 120 : -120;//var l=cep.y - csp.y; 原写法为 画的超长 箭头越大 现写法固定150
        ch1.x = cep.x + l * (a.sharp || 0.025);
        ch1.y = cep.y - l * (a.size || 0.05);
        ch2.x = cep.x - l * (a.sharp || 0.025);
        ch2.y = cep.y - l * (a.size || 0.05);
        var h1 = _scrollXOY(ch1, theta);
        var h2 = _scrollXOY(ch2, theta);
        return {
            h1: h1,
            h2: h2
        };
    };
    //旋转坐标
    var _scrollXOY = function (p, theta) {
        return {
            x: p.x * Math.cos(theta) + p.y * Math.sin(theta),
            y: p.y * Math.cos(theta) - p.x * Math.sin(theta)
        };
    };

    var arrow = new Function();
    arrow.prototype = proc;
    window.mapleque.arrow = arrow;
})(window, document);

var WorkFlowSteps = [];//节点集合 流程设计
var WorkFlowRules = [];//箭头集合 
var startdrow = false;//开始画箭头标志位 当鼠标按下时为true
var startdrowX = 0;//开始点的坐标x
var startdrowY = 0;//开始点的坐标y
var arrowLine;//当前正在画的线ID 在鼠标拖动时 其实是一直在画 一直在画的同时 要把老的删除 保证同一时刻一根线
var startid = "";//开始点的主键
var whereitem = "<div class='ssdiv' roleid='{{id}}'><a class='wfdeleteline fr'>删除线</a><b>{{ToStepDesc}}</b><table><tr><td>比例</td><td>角色</td><td>折比</td><td>类型</td></tr><tr><td><input type='text' class='ShareValue'/></td><td><input type='text' class='RoleInfo'/></td><td><input type='text' class='zb'/></td><td><input type='text' class='colortype'/></td></tr></table></div>";
var $startdiv;
//初始化画布
function wfinit(ptype) {
    $.ajax({
        type: 'post',
        url: 'ShareStructM.aspx',
        data: { 't': "ss", 'PType': ptype },
        success: function (data) {
            if (data) {
                var ds = $.evalJSON(data);
                if (ds.POINTS != "") {
                    WorkFlowSteps = $.evalJSON(ds.POINTS);
                    //画节点 绑事件
                    $(".wfeditor").append(zjs.render(WorkFlowSteps,
                        "<div class='wflaydiv {{clazz}}' style='left:{{left}};top:{{top}};' id='{{id}}'><p><i class='iconfont'>&#xe6ac;</i><span>{{StepDesc}}</span></p></div>"));
                    $(".wfeditor .wflaydiv").each(function (i, v) {
                        wfctrladd($(v));
                    });
                }
                if (ds.LINES != "") {
                    WorkFlowRules = $.evalJSON(ds.LINES);
                    //画箭头
                    for (var wri in WorkFlowRules) {
                        var wdatai = WorkFlowRules[wri];
                        wfdrawArrow(wdatai.point1, wdatai.point2, wdatai.pwidth, wdatai.pheight, wdatai.id, wdatai.zb, wdatai.ShareValue, wdatai.RoleInfo, wdatai.colortype);
                    }
                }
                $("#MAXID").val(ds.MAXID);//一直增加
                $("#K_AUTOID").val(ds.K_AUTOID);//一直增加
                $("#PTYPE").val(ds.PTYPE);//一直增加
                //$("#WorkFlowSteps").val(ds.POINTS);//一直增加
                //$("#WorkFlowRules").val(ds.LINES);//一直增加
            }
        }
    });
    $(document).bind("mousemove", function (event) {
        if (startdrow) {
            //如果开始画 
            var p2x = event.clientX;
            var p2y = event.clientY;
            if (Math.abs(p2x - startdrowX) > 5 || Math.abs(p2y - startdrowY) > 5) {
                var pwidth = (p2x > startdrowX ? p2x : startdrowX) + 50;
                var pheight = (p2y > startdrowY ? p2y : startdrowY) + 50;

                //画线
                wfdrawArrow({ x: startdrowX, y: startdrowY }, { x: p2x, y: p2y }, pwidth, pheight);

                $("div.wflaydiv.select").removeClass("select");
                $('div.wflaydiv').each(function (i, v) {
                    var p = zjs.checkPositionclient(v, event);
                    if (p) {
                        $(v).addClass("select");

                        return;
                    }
                });
            }
        }
    })
    .bind("mouseup", function (event) {
        if (startdrow) {//如果画完了
            startdrow = false;
            if ($("div.wflaydiv.select").length == 0 || startid == $("div.wflaydiv.select").attr("id")) {
                //如果没有标到节点上 或者标的是自己 那就清除  
                $("#" + arrowLine).remove();
            } else {
                //还要判断一下 如果已经存在这个规则 就不要再画了

                //开始节点的坐标 
                var right = $startdiv.offset().left + $startdiv.width() + 50;
                var bottom = $startdiv.offset().top + $startdiv.height() + 50;

                //目标节点的坐标
                var $to = $("div.wflaydiv.select");
                var tright = $to.offset().left + $to.width();
                var tbottom = $to.offset().top + $to.height();

                var point1 = zjs.pointCutPoints(startdrowX, startdrowY, $startdiv);//第一个点
                var point2 = zjs.pointCutPoints(event.clientX, event.clientY, $to);//第二个点
                var pwidth = tright > right ? tright : right;//宽
                var pheight = tbottom > bottom ? tbottom : bottom;//高
                wfdrawArrow(point1, point2, pwidth, pheight, arrowLine);

                //画完的事件里 要将箭头存到箭头集合中
                WorkFlowRules.push({
                    id: arrowLine,
                    FromStepID: startid,
                    ToStepID: $to.attr("id"),
                    ToStepDesc: $to.find("span").text(),
                    ShareValue: "",
                    RoleInfo: "",
                    colortype: "",
                    zb: "",
                    point1: point1,
                    point2: point2,
                    pwidth: pwidth,
                    pheight: pheight
                });
            }

            $("div.wflaydiv.select").removeClass("select");
            $("div.wflaydiv#" + startid).trigger("click");
        }//end if (startdrow) { 
    });

    //控件拖拽新增
    $(".wfcontrols a").live("click", function (event) {
        var $t = $(this);
        $("#MAXID").val(parseInt($("#MAXID").val() || 0) + 1);//一直增加
        var onestep = {
            id: "item" + $("#MAXID").val(),
            StepDesc: "节点" + ($("div.wflaydiv").length + 1),
            SLink: "",//链接
            ISCtrl: "",//控股还是参股
            left: "400px",
            top: "100px",//(100 + $("div.wflaydiv").length * 20)
            clazz: ($t.attr("clazz") || "")
        };
        var $dragp = $(zjs.renderRow(onestep,
            "<div class='wflaydiv {{clazz}}' style='left:{{left}};top:{{top}};' id='{{id}}'>\
                <p><i class='iconfont'>&#xe6ac;</i><span>{{StepDesc}}</span></p></div>"));
        $(".wfeditor").append($dragp);
        //向数据集中添加该节点
        WorkFlowSteps.push(onestep);
        wfctrladd($dragp);
        $dragp.trigger("click");//绑定完成后 触发一下单击事件 编辑节点属性 
    });
    //流程设计 删除规则线
    $(".wfdeleteline").live("click", function () {
        var $t = $(this).parents(".ssdiv");
        if (window.confirm("确认要删除规则线吗?")) {
            for (var i = 0; i < WorkFlowRules.length; i++) {
                var wri = WorkFlowRules[i];
                if (wri.id == $t.attr("roleid")) {
                    zjs.removeArray(WorkFlowRules, i);
                    $t.remove();
                    $(".arrows#" + $t.attr("roleid")).remove();
                }
            }
        };
    });
    //组件属性的保存事件
    $(".wfsaveattr").live("click", function () {
        var $t = $(this);
        if ($("#wWorkFlowTemplateStepAdd").attr("stepid")) {
            //保存时候要保存节点的信息 和箭头的配置信息
            var stepid = $("#wWorkFlowTemplateStepAdd").attr("stepid");
            for (var i = 0; i < WorkFlowSteps.length; i++) {
                var wfi = WorkFlowSteps[i];
                if (wfi.id == stepid) {//找到当前节点的数据 保存节点的信息
                    for (var wfdi in wfi) {
                        if ($("#wWorkFlowTemplateStepAdd").find("#" + wfdi).length > 0)
                            wfi[wfdi] = $("#wWorkFlowTemplateStepAdd").find("#" + wfdi).val();
                    }
                }
            }

            for (var i = 0; i < WorkFlowRules.length; i++) {
                var wri = WorkFlowRules[i];
                if (wri.FromStepID == stepid) {//从我出去的箭头 保存箭头的配置信息
                    var $tr = $("#wWorkFlowTemplateRuleAdd").find(".ssdiv[roleid='" + wri.id + "']");
                    wri.ShareValue = $tr.find(".ShareValue").val();//股权比例 
                    wri.RoleInfo = $tr.find(".RoleInfo").val();//角色
                    wri.zb = $tr.find(".zb").val();//角色
                    wri.colortype = $tr.find(".colortype").val();//角色
                }
            }

            for (var i = 0; i < WorkFlowRules.length; i++) {
                var wri = WorkFlowRules[i];
                if (wri.ToStepID == stepid) {//到我的箭头 保存箭头的节点名称 
                    wri.ToStepDesc = $("#wWorkFlowTemplateStepAdd").find("#StepDesc").val();
                }
            }
            $("div.wflaydiv#" + stepid + "").attr("class", "wflaydiv " + $("#wWorkFlowTemplateStepAdd").find("#clazz").val());//也修改节点的名称
            $("div.wflaydiv#" + stepid + " span").text($("#wWorkFlowTemplateStepAdd").find("#StepDesc").val());//也修改节点的名称

            //更新相关联的箭头
            for (var i = 0; i < WorkFlowRules.length; i++) {
                var wri = WorkFlowRules[i];
                if (wri.FromStepID == stepid) {
                    wfdrawArrow(wri.point1, wri.point2, wri.pwidth, wri.pheight, wri.id, wri.zb, wri.ShareValue, wri.RoleInfo, wri.colortype);
                }
                if (wri.ToStepID == stepid) {
                    //到我的箭头
                    wfdrawArrow(wri.point1, wri.point2, wri.pwidth, wri.pheight, wri.id, wri.zb, wri.ShareValue, wri.RoleInfo, wri.colortype);
                }
            }

            $(".fasttoolboxright1").hide();
            $(".wflaydiv.hover").removeClass("hover");
        }
    });
    //组件属性的取消事件
    $(".wfcancelattr").live("click", function () {
        $(".fasttoolboxright1").hide();
        $(".wflaydiv.hover").removeClass("hover");
    });
    //保存图片按钮
    $("#fcsubmit").live("click", function () {
        $.ajax({
            type: 'post',
            url: 'ShareStructM.aspx',
            //data: { 't': "sv", "POINTS": $("#WorkFlowSteps").val(), "LINES": $("#WorkFlowRules").val(), "MAXID": ($("#MAXID").val() || "0") , "K_AUTOID": $("#K_AUTOID").val(), "PTYPE": $("#PTYPE").val()},
            data: { 't': "sv", "POINTS": $.toJSON(WorkFlowSteps), "LINES": $.toJSON(WorkFlowRules), "MAXID": ($("#MAXID").val() || "0"), "K_AUTOID": $("#K_AUTOID").val(), "PTYPE": $("#PTYPE").val() },
            success: function (data) {
                if (data) {
                    alert(data);
                } else {
                    alert("保存成功");
                }
            }
        });
    });
};
//新增节点
function wfctrladd($laydiv) {
    $laydiv
    .bind("dragstart", function (event) {
        return $(event.target).is('.iconfont');
    })
    .bind("drag", function (event) {
        //拖拽
        startdrow = false;
        $("#" + arrowLine).remove();
        $(this).css({ top: event.offsetY, left: event.offsetX });
    })
    .bind("dragend", function (event) {
        //同时 在移动该节点后 也要更新数据集 同时更新相关联的箭头
        var $dragp = $(this);
        if ($('div.wflaydiv').length > 0) {
            $('div.wflaydiv').each(function (i, v) {
                var $v = $(v);
                if ($v.attr("id") != $dragp.attr("id")) {//自动吸附相近节点
                    var midleft = $v.offset().left + ($v.width() / 2) - ($dragp.width() / 2);
                    if (Math.abs(midleft - event.offsetX) < 5) {
                        $dragp.css({ left: midleft });
                    }
                    var midtop = $v.offset().top + ($v.height() / 2) - ($dragp.height() / 2);
                    if (Math.abs(midtop - event.offsetY) < 5) {
                        $dragp.css({ top: midtop });
                    }
                }
            });
        }
        var leftmove = 0;//向左的偏移量 直接x- 就好
        var topmove = 0; //向上的偏移量 直接y- 就好
        //更新数据集 
        for (var i = 0; i < WorkFlowSteps.length; i++) {
            var wfi = WorkFlowSteps[i];
            if (wfi.id == $dragp.attr("id")) {
                //节点定位取整
                var dpleft = parseInt($dragp.css("left").replace("px", "") / 10) * 10;
                var dptop = parseInt($dragp.css("top").replace("px", "") / 10) * 10;
                $dragp.css("left", dpleft);
                $dragp.css("top", dptop);

                //计算偏移量
                leftmove = dpleft - (wfi.left.replace("px", ""));
                topmove = dptop - (wfi.top.replace("px", ""));
                wfi.left = $dragp.css("left");
                wfi.top = $dragp.css("top");
            }
        }
        //更新相关联的箭头
        for (var i = 0; i < WorkFlowRules.length; i++) {
            var wri = WorkFlowRules[i];
            if (wri.FromStepID == $dragp.attr("id")) {
                //从我出去的箭头
                wri.point1.x = wri.point1.x + leftmove;
                wri.point1.y = wri.point1.y + topmove;
                var tright = $dragp.offset().left + $dragp.width();
                var tbottom = $dragp.offset().top + $dragp.height();
                wri.pwidth = tright > wri.pwidth ? tright : wri.pwidth;//宽
                wri.pheight = tbottom > wri.pheight ? tbottom : wri.pheight;//高

                wfdrawArrow(wri.point1, wri.point2, wri.pwidth, wri.pheight, wri.id, wri.zb, wri.ShareValue, wri.RoleInfo, wri.colortype);
            }
            if (wri.ToStepID == $dragp.attr("id")) {
                //到我的箭头
                wri.point2.x = wri.point2.x + leftmove;
                wri.point2.y = wri.point2.y + topmove;
                var tright = $dragp.offset().left + $dragp.width();
                var tbottom = $dragp.offset().top + $dragp.height();
                wri.pwidth = tright > wri.pwidth ? tright : wri.pwidth;//宽
                wri.pheight = tbottom > wri.pheight ? tbottom : wri.pheight;//高

                wfdrawArrow(wri.point1, wri.point2, wri.pwidth, wri.pheight, wri.id, wri.zb, wri.ShareValue, wri.RoleInfo, wri.colortype);
            }
        }
    })
    .bind("mousedown", function (event) {
        //画箭头开始事件 
        startdrow = true;
        startdrowX = event.clientX;
        startdrowY = event.clientY;
        $("#MAXID").val(parseInt($("#MAXID").val() || 0) + 1);//一直增加
        arrowLine = "arrowLine" + $("#MAXID").val();
        $startdiv = $laydiv;
        startid = $startdiv.attr("id");
    })
    .bind("click", function () {
        //组件的单击事件 单击时要切换右侧的属性面板 同时单击时 将相关箭头的z-index提高 
        var wfi = zjs.getmyobject(WorkFlowSteps, $laydiv.attr("id"), "id");
        $(".fasttoolboxright1").show();
        $("#wWorkFlowTemplateStepAdd").attr("stepid", wfi.id);
        window.cformwWorkFlowTemplateStepAdd.Data = wfi;
        window.cformwWorkFlowTemplateStepAdd.render();

        var stepid = wfi.id;
        var myrules = zjs.getmylist(WorkFlowRules, stepid, "FromStepID");
        $("#wWorkFlowTemplateRuleAdd").html(zjs.render(myrules, whereitem));
        zjs.documentReady();

        //取出来现有数据 赋值 
        for (var i = 0; i < myrules.length; i++) {
            var wri = myrules[i];
            var $tr = $("#wWorkFlowTemplateRuleAdd").find(".ssdiv[roleid='" + wri.id + "']");
            $tr.find(".ShareValue").val(wri.ShareValue);//股权比例 
            $tr.find(".RoleInfo").val(wri.RoleInfo);//角色
            $tr.find(".zb").val(wri.zb);//角色
            $tr.find(".colortype").val(wri.colortype);//角色
        }
        $laydiv.addClass("hover").siblings().removeClass("hover");
    })
    .bind("dblclick", function () {
        //双击节点 可删除
        var $t = $(this);
        if (window.confirm("确认要删除节点吗?")) {
            $t.remove();
            for (var i = 0; i < WorkFlowSteps.length; i++) {
                var wfi = WorkFlowSteps[i];
                if (wfi.id == $t.attr("id")) {
                    zjs.removeArray(WorkFlowSteps, i);
                }
            }
            //同时删除所有相关箭头 
            for (var i = 0; i < WorkFlowRules.length; i++) {
                var wri = WorkFlowRules[i];
                if (wri.FromStepID == $t.attr("id")) {
                    //从我出去的箭头 
                    zjs.removeArray(WorkFlowRules, i);
                    $("#" + wri.id).remove();
                }
                if (wri.ToStepID == $t.attr("id")) {
                    //到我的箭头 
                    zjs.removeArray(WorkFlowRules, i);
                    $("#" + wri.id).remove();
                }
            }
            $(".fasttoolboxright1").hide();
        };
    });
};
//画箭头 从点1到点2 
function wfdrawArrow(point1, point2, pwidth, pheight, drawID, zb, txt, txt1, colortype) {
    var nowdrawid = arrowLine;//如果是一根一根画 就用当前根ID
    if (drawID) {//如果是循环画 就直接画
        nowdrawid = drawID;
    }

    $("#" + nowdrawid).remove();
    if ($(".canvasbox").length > 0) {
        $(".canvasbox").prepend("<canvas class='arrows' id='" + nowdrawid + "' width='" + pwidth + "' height='" + (pheight + 100) + "'>请使用支持HTML5的浏览器</canvas>");
    } else {
        $("body").prepend("<canvas class='arrows' id='" + nowdrawid + "' width='" + pwidth + "' height='" + (pheight + 100) + "'>请使用支持HTML5的浏览器</canvas>");
    }
    var cont = document.getElementById(nowdrawid).getContext('2d');
    var a1 = new window.mapleque.arrow();
    a1.set(point1, point2);
    a1.paint(cont, drawID, zb, txt, txt1, colortype);
};

function resetgs2() {
    for (var i = 0; i < WorkFlowSteps.length; i++) {
        var wfi = WorkFlowSteps[i];
        //if (wfi.clazz == "jt") {//找到当前节点的数据 保存节点的信息 
        //    wfi.left = (parseInt(wfi.left.replace("px", "")) - 10) + "px";
        //}
        //if (wfi.clazz == "gs2") {//找到当前节点的数据 保存节点的信息 
        //    wfi.left = (parseInt(wfi.left.replace("px", "")) + 10) + "px";
        //}
    }
};
//渲染画布
function wfshowinit(ptype) {
    $.ajax({
        type: 'post',
        url: 'ShareStructM.aspx',
        data: { 't': "ss", 'PType': ptype },
        success: function (data) {
            if (data) {
                var maxw = 0;//取屏幕显示的最大数
                var ds = $.evalJSON(data);
                if (ds.POINTS != "") {
                    WorkFlowSteps = $.evalJSON(ds.POINTS);
                    //画节点 绑事件
                    $(".wfeditor").append(zjs.render(WorkFlowSteps,
                        "<div class='wflaydiv readonly {{clazz}}' style='left:{{left}};top:{{top}};' id='{{id}}'><p><span><a openlayer='{{SLink}}'>{{StepDesc}}</a></span></p></div>"));

                    $(".wfeditor a[openlayer='']").removeAttr("openlayer");
                    $("a[openlayer]").click(function () {
                        OpenLayer($(this).attr("openlayer"));
                    });
                }
                if (ds.LINES != "") {
                    WorkFlowRules = $.evalJSON(ds.LINES);
                    //画箭头
                    for (var wri in WorkFlowRules) {
                        var wdatai = WorkFlowRules[wri];
                        if (wdatai.pwidth > maxw) {
                            maxw = wdatai.pwidth;
                        }
                        wfdrawArrow(wdatai.point1, wdatai.point2, wdatai.pwidth, wdatai.pheight, wdatai.id, wdatai.zb, wdatai.ShareValue, wdatai.RoleInfo, wdatai.colortype);
                    }
                    if ($(window).width() > maxw) {//如果浏览器比这个数大 就需要让body偏移一下
                        var leftw = ($(window).width() - maxw - 50) / 2;
                        if (leftw > 0) {
                            $(".bodybox").css({ "left": leftw + "px", "position": "relative" });
                        }
                    }
                }
            }
        }
    });
    $(function () {
        $("#changeview").change(function () {
            var $t = $(this);
            switch ($t.val()) {
                case "hidecg":
                    //更新数据集 
                    for (var i = 0; i < WorkFlowSteps.length; i++) {
                        var wfi = WorkFlowSteps[i];
                        if (wfi.clazz == "cg") {
                            $(".wflaydiv#" + wfi.id).hide();
                            //更新相关联的箭头
                            for (var j = 0; j < WorkFlowRules.length; j++) {
                                var wri = WorkFlowRules[j];
                                if (wri.FromStepID == wfi.id) {
                                    //从我出去的箭头
                                    $("canvas#" + wri.id).hide();
                                }
                                if (wri.ToStepID == wfi.id) {
                                    //到我的箭头
                                    $("canvas#" + wri.id).hide();
                                }
                            }
                        }
                    }
                    break;
                default:
                    //更新数据集 
                    $(".wflaydiv").show();
                    $("canvas").show();
                    break;
            }
        });
    });
};
