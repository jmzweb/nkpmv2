<%@ Page language="c#" Codebehind="UserTreeInOne.aspx.cs" AutoEventWireup="false" Inherits="EZ.WebBase.SysFolder.Common.UserTreeInOne" enableViewState="True"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择用户</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link rel="stylesheet" type="text/css" href="../../css/appstyle.css"/>    
    <link rel="stylesheet" type="text/css" href="../../css/tree.css"/>
     <style type="text/css">
     	#tree
	    {
	        border:#c3daf9 1px solid;
	        padding:5px;
	        margin:5px;
			height:300px;
			overflow:auto;
	    }
		.centerZone
		{
			border:#c3daf9 1px solid;
	        padding:5px;
	        margin-top:5px;
			height:300px;
			overflow:auto;
			background:white;
		}
		.radioSpan label{cursor:hand;}
		.mostPanel,.groupPanel1,.groupPanel2{
		    display:block;
		    width:180px;
		    float:left;
		    word-break:keep-all;
		    white-space:nowrap;
		    overflow:hidden;
		    text-overflow:ellipsis;
			padding:0px;
			margin:0px;
			height:24px;
			line-height:24px;
		}
		.mostUse,.searchZone{margin:8px;clear:both;}
		label{cursor:pointer;}
		label.mysel{color:Red;}
		.searchZone label{color:blue;padding-left:1px;}
		#searchInfo{font-weight:bold;color:green;}
		.item{padding:2px;cursor:hand;text-decoration:none;color:black;}
		.item:hover{color:red;}
		.mainPanel{clear:both;}
		#txtSearch,#newGroup{border:1px solid gray;padding:3px;}
		#btnSearch,#btnconfirm,#btnclose{
		    padding:3px 8px 3px 8px;
			margin:1px 0px 1px 0px;
			width: auto;
			line-height:14px;
			height:26px;
		    overflow:visible; 
		}
		.newGroupPanel{display:none;padding:20px;}
		
     </style>
	</head>
	<body >
		<form id="Form1" method="post" runat="server">
            <div style="padding:6px;">
				<div style="padding:3px;margin:0px 5px;height:26px;border:1px solid gray;background-color:#f2f4fb;">
					<span  class="radioSpan"  style="float:left;">&nbsp;&nbsp;&nbsp;类型:
						<input type="radio" name="selType" id="selType0"  value="0" checked="checked" /><label for="selType0">常用联系人</label>
						<input type="radio" name="selType" id="selType1"  value="1" /><label for="selType1">组织机构树</label>
						<input type="radio" name="selType" id="selType2"  value="2" /><label for="selType2">用户组</label>
					</span>
					<span style="float:right;">
						<input class="defaultbtn" id="btnconfirm" type="button" value="确 定"/>
						<input class="defaultbtn" id="btnclose" type="button" value="关 闭"/>
					</span>
                    <div style="clear:both;"></div>
				</div>

				<div class="mainPanel">
					<div class="centerZone">
						<div class="searchTop" style="border-bottom:1px solid #eee;padding:3px;vertical-align:middle;line-height:30px;height:30px;">
							搜索：<input type="text" id="txtSearch"/>
							<input type="button" value="查 询" id="btnSearch"/>
							<span id="searchInfo"></span>
						</div>
						<div class="searchZone"></div>
						<div class="mostUse">
							<%=sbMostUse%>
						</div>
					</div>
					<div id="tree" class="centerZone hidden">
					</div>
					<div class="centerZone hidden" style="padding:10px;">
                        <!--<%=sbGroup%>-->

                        <table border="0" width="580" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="242">用户组 \ 角色（单击）</td>
                                <td width="242">用户列表（双击添加）</td>
                                <td ></td>
                            </tr>
                             <tr>
                                <td>
                                    <select id="selgroup1" size="16" style="width:240px;height:260px;padding:3px 5px;border:1px solid gray;">
                                        <optgroup label="---用户组">
                                        <%=opGroup %>
                                        </optgroup>
                                        <optgroup label="---角色">
                                        <%=opRole %>
                                        </optgroup>
                                    </select>
                                </td>
                                <td>
                                    <select id="selgroup2" size="16" multiple="multiple" style="width:240px;height:260px;padding:3px 5px;border:1px solid gray;">
                                        <option value=""></option>
                                    </select>
                                </td>
                                <td valign="top">
                                    <button class="defaultbtn" type="button" id="btnAddAll">添加全部</button><br />
                                    <button class="defaultbtn" type="button" id="btnSelAll">全部选中</button><br />
                                    <button class="defaultbtn" type="button" id="btnCancel">取消选中</button><br />
                                    <button class="defaultbtn" type="button" style="color:Blue;" id="btnAdd">确认添加</button>
                                </td>
                            </tr>
                        </table>
                    </div>
				</div>

				<table width="100%" border="0">
					<tr>
					<td height="25">
					<span style="font-size:12px;font-weight:bold;">已选择&nbsp;<b id="selNum" style="color:Red;">0</b>&nbsp;人：</span>
					<a href="javascript:" id='linkOnline'>所有在线用户</a>&nbsp;
					<a href="javascript:" id='linkGroupSave'>[保存为组]</a>&nbsp;
					<a href="javascript:" id='linkClear'>[清空]</a>
					</td>
					<td style="color:green;text-align:right;">双击可以删除下面选中的人员</td>
					</tr>
				</table>

				<div id="selPanel" style="border:1px solid gray;background-color:white;padding:2px;margin:3px;height:60px;overflow:auto;">
				
				</div>
        </div>
        <div class="newGroupPanel">
            <div>
                <label for="newGroup">分组名称：</label>
                <input type="text" id="newGroup" />
            </div>
            <div style="margin:15px 0px 0px 10px;text-align:center;height:30px;">
                <button style="width:60px;" id="btnGroupYes">  确 定  </button>&nbsp;&nbsp;
                <button style="width:60px;" id="btnGroupNo">  取 消  </button>
            </div>
        </div>
		</form>
	</body>
</html>

<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../../js/jquery.tree.js"></script>
<script type="text/javascript" src="../../js/jquery.zxxbox.3.0-min.js"></script>
   
<script type="text/javascript">
	var _curClass = EZ.WebBase.SysFolder.Common.UserTreeInOne;

    $("#btnGroupYes").click(function(){
        var newName = $.trim($("#newGroup").val());
        if(newName==""){
            alert("分组名称不能为空！");
        }
        else {
            var arrName=[];
            var arrId=[];
            var arrPos=[]; 
			$("#selPanel").find(".item").each(function(){
                var arr=$(this).attr("v").split("_");
				arrId.push(arr[0]);
                arrPos.push(arr[1]);
				var t=$(this).text();
				arrName.push(t.substr(0,t.length-1));
			});
            var ret = _curClass.NewGroup(newName,arrId,arrName,arrPos);
            if(ret.error){
                alert("保存出错："+ret.error.Message);
            }
            else {
                alert("保存成功！");
                $.zxxbox.hide();
            }
        }
    });
    $("#btnGroupNo").click(function(){
        $.zxxbox.hide();
    });
	function addEmployeeList(idcn)
	{
		var arr=idcn.split("|");
		var idList=arr[0].split(",");
		var cnList=arr[1].split(",");

		var posList=arr[2].split(",");
		for(var i=0;i<idList.length;i++)
		{
            var posId = ""
            if(posList.length>i){
                posId = posList[i];
            }
			var ctlId = idList[i]+"_"+posId;
			addEmployee(ctlId,cnList[i]);
		}
	}
	function addEmployee(id,text)
	{
        if(posIndex>-1){
			var k=$("#selPanel").find("a[v='"+id+"']");
			if(k.length>0) return;            
        }
        else{
            var empId=id.split("_")[0];
			var k=$("#selPanel").find("a[v^='"+empId+"']");
			if(k.length>0) return;
        }
		$("<a title='双击删除' href='javascript:' class='item'  v='"+id+"'>"+text+",</a>").dblclick(function(){
			$(this).remove();selChange();
		}).appendTo("#selPanel");

        selChange();

        if(method=="2"){
            fnReturn();
        }

	}
    function selChange(){
        $("#selNum").html($("#selPanel .item").length);
    }
	function removeEmployeeList(idcn)
	{
		var arr=idcn.split("|");
		var idList=arr[0].split(",");
		var cnList=arr[1].split(",");
		var posList=arr[2].split(",");
		for(var i=0;i<idList.length;i++)
		{
			var ctlId = idList[i]+"_"+posList[i];
			var k=$("#selPanel").find("a[v='"+ctlId+"']").remove();
		}

        selChange();
	}
		
	$(".centerZone .chkmost").live("click",function(){
		var emp=$(this).next("label").text().split(" ")[0];
		if(this.checked){
			addEmployee(this.value,emp);
		}
		else{
			var k=$("#selPanel").find("a[v='"+this.value+"']").remove();
            selChange();
		}
	});
			
	$(".mostPanel").live("mouseover",function(){
		if(!this.title)
		{
			var ctlVal = $("input.chkmost",this).val();
			var pArr=ctlVal.split("_");
			var msg = _curClass.GetTitle(pArr[0],pArr[1]).value;
			this.title = msg;
		}
	});
	$("#txtSearch").keydown(function (event) {
        if(event.keyCode==13)
        {
            $("#btnSearch").click();
            return false;
        }
    });
	$("#btnSearch").click(function(){
		var v=$("#txtSearch").val();
		if(!v){
            $("#searchInfo").html("&nbsp;查询信息不能为空");
			return;
		}
		var ret=_curClass.Search(v,"<%=self %>");
		if(ret.error){
			alert(ret.error.Message);
		}
		else{
			$(".searchZone").empty();
			var arr=ret.value.split("|");
			if(arr[0].length==0){
				$("#searchInfo").html("&nbsp;没有查找到符合条件的员工");
				return;
			}
			var idList = arr[0].split(",");
			var cnList = arr[1].split(",");
			var posList = arr[2].split(",");

			$("#searchInfo").html("&nbsp;共查找到" + idList.length + "个符合条件的员工");
			for(var i=0;i < idList.length;i++)
			{
				var cltId = idList[i] + '_' + posList[i];
				var arrUnit = ["<div class='mostPanel' title='' ><input type='checkbox' class='chkmost' value='",cltId,"' id='mostPanel", cltId, "'/><label for='mostPanel", cltId, "'>", cnList[i], "</label></div>"];

				$(".searchZone").append(arrUnit.join(""));

			}
		}
	});
	$("#linkClear").click(function(){
		$("#selPanel").empty();
        $("#selNum").html("0");
	});
	$("#linkGroupSave").click(function(){
        $.zxxbox($(".newGroupPanel"),{title:"新建分组",height:260,width:300});
    });
	$("#linkOnline").click(function(){
		var v=this.value;
		var ret=_curClass.GetOnline();
		if(ret.error){
			alert(ret.error.Message);
		}
		else{
			addEmployeeList(ret.value);
		}
	});
    $("#selgroup1").click(function(){
        var groupId = $(this).val();
        var rt = $(this).find("option:selected").attr("rt");
        if(rt == "0"){
            var ret=_curClass.GetGroup(groupId).value;
            var arr=ret.split("|");
		    var idList=arr[0].split(",");
		    var cnList=arr[1].split(",");
		    var posList=arr[2].split(",");

            var arrOp=[];
            for (var i = 0; i < idList.length; i++) {
                arrOp.push("<option value='"+idList[i]+"_"+posList[i]+"'>",cnList[i],"</option>");
            }
            $("#selgroup2").html(arrOp.join(""));
        }
        else if(rt == "1"){
            var ret=_curClass.GetRoleUser(groupId).value;
            var arr=ret.split("|");
		    var idList=arr[0].split(",");
		    var cnList=arr[1].split(",");
		    var posList=arr[2].split(",");

            var arrOp=[];
            for (var i = 0; i < idList.length; i++) {
                arrOp.push("<option value='"+idList[i]+"_"+posList[i]+"'>",cnList[i],"</option>");
            }
            $("#selgroup2").html(arrOp.join(""));
        }
    });
    $("#selgroup2").dblclick(function(){
        var op = $(this).find("option:selected");
        addEmployee(op.val(),op.text());
    });
    $("#btnSelAll").click(function(){
        $("#selgroup2>option").prop("selected",true);
    });
    $("#btnCancel").click(function(){
        $("#selgroup2>option").prop("selected",false);    
    });
    $("#btnAddAll").click(function(){
        $("#selgroup2>option").each(function(){
            var op = $(this);
            addEmployee(op.val(),op.text());
        });
    });
    $("#btnAdd").click(function(){
        $("#selgroup2>option:selected").each(function(){
            var op = $(this);
            addEmployee(op.val(),op.text());
        });   
    });

    //选择公共组
	$(".groupPanel1 .chkgroup").click(function(){
		var v=this.value;
		var ret=_curClass.GetGroup(v);
		if(ret.error){
			alert(ret.error.Message);
		}
		else{
			if(this.checked)
				addEmployeeList(ret.value);
			else
				removeEmployeeList(ret.value);
		}
	});
    //选择个人组
	$(".groupPanel2 .chkgroup").click(function(){
		var v=this.value;
		var ret=_curClass.GetPosition(v);
		if(ret.error){
			alert(ret.error.Message);
		}
		else{
			if(this.checked)
				addEmployeeList(ret.value);
			else
				removeEmployeeList(ret.value);
		}
	});
    //切换选择方式
	$(".radioSpan input").click(function () {
	    var i = this.value;
		$(".mainPanel>div").hide();
		var k=$(".mainPanel div:eq("+i+")").html();
		$(".mainPanel>div:eq("+i+")").show();
	});
    
    var _opent = !!window.parent.layer ? "2":"1";
    var _parent = _opent == "2" ? window.parent : window.opener;

    function _getInput(inputId){
        return _parent.document.getElementById(inputId);
    }

    function _close(){
        if(_opent == "2")
        {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        }
        else{
            window.close();
        }
    }

    $("#btnclose").click(function(){
        _close();
    });
    $("#btnconfirm").click(function(e){
        fnReturn();
    });

    function fnReturn(){
        var arrName=[];
        var arrId=[];
        var arrCode=[];
        var arrPos=[];
             
		$("#selPanel").find(".item").each(function(){
            var arr = $(this).attr("v").split("_");
			arrId.push(arr[0]);
            arrPos.push(arr[1]);
			var t = $(this).text();
			arrName.push(t.substr(0,t.length-1));
		});

        if(idIndex > -1){
            var pctl = _getInput(bizfields[idIndex]);
            if(pctl){
                var pv = pctl.value;
                pctl.value = arrId.join(",");
                try { _parent.$(pctl).change();} catch (e) {}
             }
        }

        if(nameIndex > -1){
            var pctl = _getInput(bizfields[nameIndex]);
            if(pctl){
                var pv = pctl.value;
                 pctl.value = arrName.join(",");
                try { _parent.$(pctl).change();} catch (e) {}
            }
        }

        if(posIndex > -1){
            var pctl = _getInput(bizfields[posIndex]);
            if(pctl){
                var pv = pctl.value;
                pctl.value = arrPos.join(",");
             }
        }

        if(arrId.length == 1){
            var fullInfo = null;
            jQuery.each(empAttrList,function(i,n){
                fillInfo(n,arrId[0],arrPos[0],fullInfo);
            });
        }
        else{
            if(codeIndex > -1){
                var codeArr=[];
                codeArr = _curClass.GetEmployeeCodes(arrId.join(",")).value;
                var pctl = _getInput(bizfields[codeIndex]);
                if(pctl){
                    var pv = pctl.value;
                    pctl.value = codeArr.join(",");
                    try { _parent.$(pctl).change();} catch (e) {}
                }
            }
        }

        if('<%=Request["callback"] %>'!="")
        {
            _parent["<%=Request["callback"] %>"](bizfields,arrId,arrName);
        }
        _close();
    }

    function psetVal(pname, pval) {
        var p$ = _parent.$;
        if (p$("#" + pname).length == 1)
        {
            p$("#" + pname).val(pval);
            try { p$("#" + pname).change(); } catch (e) { }
        }
        else{
            var ctlArr = p$("input[name='" + pname + "']");
            if (ctlArr.length > 1) {
                var vals = pval.split(",");
                ctlArr.each(function (i, ctl) {
                    p$(ctl).prop("checked", $.inArray(ctl.value, vals) > -1);
                });
            }
        }
    }


    function fillInfo(pname,empId,posId,fullInfo){
        var pIndex =jQuery.inArray(pname,qryfields);
        if(pIndex > -1){
            if(fullInfo == null) 
                fullInfo = _curClass.GetEmployeeAttr(empId,posId).value.split("|");

            var pctl = bizfields[pIndex];
            var rIndex = jQuery.inArray(pname,empAttrList)
            psetVal(pctl, fullInfo[rIndex]);
        }
    }

    var empAttrList=["empcode","email","ophone","mphone","posname","deptcode","deptname","deptcodex","deptnamex","compcode","compname","idcard","deptfzr","compfzr","sex"];

    var method ='<%=Request["method"]%>';
    var bizfields = "<%=cid %>".split(",");
    var qryfields = "<%=queryfield %>".split(",");
    var idIndex = jQuery.inArray("empid",qryfields);
    var codeIndex = jQuery.inArray("empcode",qryfields);
    var nameIndex = jQuery.inArray("empname",qryfields);
    var posIndex = jQuery.inArray("posid",qryfields);
    if(method == "3"){
        $("#selType1,#selType2").prop("disabled",true);
        $(".searchTop").hide();
    }
    var userAgent = window.navigator.userAgent.toLowerCase();
    $.browser.msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
    $.browser.msie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
    $.browser.msie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
    <%=treedata %>

    function load() {
        var o = { showcheck: true,
        onnodeclick:function(item){},
		aftercheck:function(item){
			if(item.id.length == 36 || item.id.length == 20){
				if(item.checkstate==1){
					var empName = item.text.split(" ")[0];
					var ctlId = item.id+"_"+item.value;
					addEmployee(ctlId,empName);
				}
				else{
					var ctlId = item.id+"_"+item.value;
					var k=$("#selPanel").find("a[v='"+ctlId+"']").remove();
				}
			}
		},
        blankpath:"../../Img/common/",
        cbiconpath:"../../Img/common/",
        url:"../Common/TreeData.ashx?queryid=DeptAndEmployeeByDeptID"
        };
        o.data = treedata;                  
        $("#tree").treeview(o);

        //加载老数据
        if('<%=Request["callback"] %>'=='' && (method=="1" || method==""))
        {
            if(idIndex > -1 ){
                var idList = _getInput(bizfields[idIndex]).value;
                if(idList.length > 0)
                {
                    var posList=""; 
                    var nameList = _getInput(bizfields[nameIndex]).value;
                    if(posIndex > -1)
                        posList = _getInput(bizfields[posIndex]).value;

                    addEmployeeList(idList+"|"+nameList+"|"+posList);
                }
            }
            else if(codeIndex > -1){
                var codeList = _getInput(bizfields[codeIndex]).value;
                if(codeList.length == 0) return;

                var posList=""; 
                var idList = _curClass.GetEmployeeIds(codeList).value.join(",");
                var nameList = _getInput(bizfields[nameIndex]).value;
                if(posIndex > -1)
                    posList = _getInput(bizfields[posIndex]).value;

                addEmployeeList(idList+"|"+nameList+"|"+posList);

            }
        }

    }

    if( $.browser.msie6){
        load();
    }
    else{
        $(document).ready(load);
    }
</script>
