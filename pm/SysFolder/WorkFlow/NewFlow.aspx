<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="NewFlow.aspx.cs" ValidateRequest="false" Inherits="EZ.WebBase.SysFolder.WorkFlow.NewFlow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程发起</title>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/wfStyle.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/kindeditor-4.1.10/themes/default/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <script type="text/javascript" src="../../js/jquery.tablednd.0.8.min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/kindeditor-min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script type="text/javascript" src="../../js/jquery.qtip.min.js"></script>
    <script type="text/javascript" src="../../Js/DateExt.js"></script>
    <%=customScript%>
    <style type="text/css"> 
	    #maindiv{<%=formWidth%>}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="wfheader">
        <table style="margin-left:auto;margin-right:auto;">
        <tr>
            <td height="40" style="width:80px;">任务名称:</td>
            <td style="width:300px;" valign="middle">
                <asp:TextBox Width="280px"  CssClass="TextBoxInChar" ID="txtInstanceName" runat="server"></asp:TextBox>
            </td>
            <td align="right" style="width:80px;">重要程度：</td>
            <td align="left"  style="width:120px;">
                <asp:DropDownList Width="100px"  ID="selImportance" runat="server">
                </asp:DropDownList>
            </td>
            <td align="right" style="width:76px;">督办期限：</td>
            <td align="right">
                <asp:TextBox Width="120px"  CssClass="Wdate TextBoxInDate"  ID="txtDealline" runat="server"></asp:TextBox>
            </td>
        </tr>
        </table>
    </div>
    <div id="maindiv" style="padding-bottom:30px;">
        <br />
        <% =tblHTML%>
        <div class="relationpanel">
            <ul class="tabs" >
                <li class="selected"><a href="#tabpage1">
                <button id="btnRelation"  type="button" title="添加参考流程" style="margin:0px;border-width:0px;height:20px;padding:2px;background:transparent;cursor:hand;">
                    <img alt="添加参考流程" style="vertical-align:middle;cursor:hand;" src="../../img/common/add_small.png" />添加参考流程
                </button>
                </a>
                </li>
            </ul>
            <div id="tabControl" style="margin-left:auto;margin-right:auto;text-align:left;">
                <div class="refList">
                </div>
            </div>
        </div>
        <div class="wfdealinfo" style="text-align:left;padding:5px 0px;">
        <table width="100%">
           <tr>
            <td height="20">
                <table width="100%">
                    <tr>
                        <td><h5 style="font-size:10pt;">备注信息：</h5></td>
                        <td width="530" id="tdTmpl"><%=SuggestTmpl %></td>
                        <td style="background:#f5fffa;padding:2px 5px;text-align:right;">
						<a href="javascript:;" class="linkbtn linkidea" title="编辑意见模板">意见模板</a>
						<a href="javascript:;" class="linkbtn linkattach" title="添加意见附件">意见附件</a>
						</td>
                    </tr>
                </table>
                
            </td>
         </tr>
         <tr>
            <td>
            <asp:TextBox CssClass="TextBoxInArea" TextMode="MultiLine" Rows="3"  ID="txtRemark" runat="server"></asp:TextBox>            
            </td>
         </tr>
         <tr>
            <td style="padding-top:8px;">
            <div style="font-weight:bold;font-size:10pt;float:left;margin-top:5px;">下一步：</div>
            <div style="float:left;">
                <%=NextActivityList%>  
            </div>
            <div id="docZone" class="hidden"><%=NodeDocHtml %></div>
            </td>
        </tr>
        <tr>
            <td style="padding:3px 0px;">

            <div style="clear:both;border:1px solid #ddd;padding:2px 4px;height:30px;line-height:30px;background:#efefef;margin-top:3px;">
                <span style="float:left;">
                    <asp:Button ID="btnSubmit" CssClass="btn01" runat="server" Text="提 交" OnClick="btnSubmit_Click" UseSubmitBehavior="false"/>
                    <asp:Button ID="btnTempSave" CssClass="btn01" runat="server" Text="暂 存" OnClick="btnTempSave_Click" UseSubmitBehavior="false"/>&nbsp;
                    <button type="button" id="btnClose" class="btn01">关 闭</button>
                </span>
                <span style="float:right;">
                选择岗位：
                <asp:DropDownList ID="PositionList" runat="server" AutoPostBack="True" onselectedindexchanged="PositionList_SelectedIndexChanged">
                </asp:DropDownList>
			    <em class="split">|</em>
			    <a class="linkbtn"  href="NewBefore.aspx?view=1&workflowid=<%=workflowId %>" target="_blank" >填报须知</a>
			    <em class="split">|</em>
                <a class="linkbtn linkchart"  href="FlowChart.aspx?workflowid=<%=workflowId%>" target="_blank" >查看流程图</a>
			    <em class="split">|</em>
                <a class='linkbtn' style="" href="../../LoginAuth.aspx" target="_blank">请求协助</a>
                &nbsp;
                </span>
            </div>

            </td>
        </tr>
        </table>
        </div>

    </div>
    <input type="hidden" id="titleFlag" name="titleFlag" value="" />
    </form>
</body>
</html>
    <script type="text/javascript" language="javascript">
        $("dl").KandyTabs({ trigger: "click" });
		//window.history.forward();
        function _appSave()
        {
            _saveAction = "2";
            if(_sysSave())
            {
                alert("保存成功!");
                window.close();
            }
        }
        var tempUser="",tempPos="";
        function seluser(nodeCode, scope)
        {
            var pid="pid"+nodeCode;
            var pname="pname"+nodeCode;
            var ppos="ppos"+nodeCode;

            tempUser=$("#"+pid).val();
            tempPos=$("#"+ppos).val();

            var url="../Common/UserTree.aspx?callback=onUserChange&queryfield=empid,empname,posid&cid="+pid+","+pname+","+ppos;
            if(scope == "1")
                url += "&flowId=<%=workflowId%>&actId="+nodeCode+"&method=3";
            else
                url += "&method=1";

            _openCenter(url,"_blank",640,460);
            //layer.open({type: 2,title: '选择处理人',shade: false,area: ['640px', '520px'],content: url});
        }
        function onUserChange(cidArr)
        {
            var newVal = $("#"+cidArr[0]).val();
            var newPos = $("#"+cidArr[2]).val();
            if(newVal.length == 0)
            {
                $("#"+cidArr[0]).val(tempUser);
                $("#"+cidArr[2]).val(tempPos);
                return;
            }
            //如果选择了处理人
            if(tempUser.length>0)
            {
                newVal=tempUser+","+newVal;
                newPos=tempPos+","+newPos;
            }
            $("#"+cidArr[0]).val(newVal);
            $("#"+cidArr[2]).val(newPos);

            var nodeId=cidArr[0].substring(3);
            var arr=[];
            var names=$("#"+cidArr[1]).val().split(",");
            for(var i=0;i<names.length;i++)
            {
                arr.push("<span class='performer' title='点击删除' actId='"+nodeId+"'>"+names[i]+"<img  src='../../img/common/close.png'></span>");
            }
            $("#userPanel"+nodeId).append(arr.join(""));

            var arrFlag = $("#tranact"+nodeId).val().split("|");
            arrFlag[2]="1";
            $("#tranact"+nodeId).val(arrFlag.join("|"));
        }
        function ReLoadIdea(){
            var ideaList=_curClass.GetSuggestTmpl().value;
            var arrHtml=[];
            if(ideaList.length>0){
                var arrIdea=ideaList.split("|");
                for (var i = 0; i < arrIdea.length; i++) {
                    if(arrIdea[i].length>8)
                        arrHtml.push("<a class='tmplitem' href='javascript:' title='"+arrIdea[i]+"'>"+arrIdea[i].substr(0,7)+"…</a>");
                    else
                        arrHtml.push("<a class='tmplitem' href='javascript:' title='"+arrIdea[i]+"'>"+arrIdea[i]+"</a>");
                }
            }
            $("#tdTmpl").html(arrHtml.join(""));
        }
        jQuery(function($){
            if($("#docZone").html().length>0)
                $("#docZone").show();

            $("#btnSubmit")[0].onclick = null;
            $("#btnTempSave")[0].onclick = null;

            $("#txtRemark").prop({"title":"输入备注信息","placeholder":"输入备注信息"});
            $(window).resize(function(){
                $(".wfpage").height($(document.body).height()-70);
            });
            $(".wfpage").height($(document.body).height()-70);
            $("#btnRelation").click(function(){
                _openCenter("flowRelation.aspx","_blank",800,600);
            });
            $(".performer").live("click",function(){
                var actId = $(this).attr("actId");
                var index = $(this).index();
                var arr = $("#pid"+actId).val().split(",");
                var arr2 = $("#ppos"+actId).val().split(",");
                arr.splice(index,1);
                arr2.splice(index,1);
                $("#pid"+actId).val(arr.join(","));
                $("#ppos"+actId).val(arr2.join(","));
                $(this).remove();

                //更新处理人标志
                var arrFlag = $("#tranact"+actId).val().split("|");
                arrFlag[2]="1";
                $("#tranact"+actId).val(arrFlag.join("|"));
            });
            $("#txtInstanceName").change(function(){
                $("#titleFlag").val("1");
            });
            $("#txtDealline").focus(function(){
                WdatePicker({isShowClear:true});
            }).click(function(){
                WdatePicker({isShowClear:true});
            });
            $("#btnClose").click(function(){
                //window.close();
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
            $(".linkidea").dialog({ title: '意见模板编辑', maxBtn: false, page: 'IdeaTemplate.aspx'
                , btnBar: false, cover: false, lockScroll: true, width: 600, height: 400, bgcolor: 'black'
            });
			$(".linkattach").click(function(){
				if($("#ideaAttach").length==0){
					$("#txtRemark").before("<iframe id='ideaAttach' frameborder='0' scrolling='auto'  src='../Common/FileListFrame.aspx?appName=<%=TblName%>&appId=<%=MainId%>&read=0&frmId=ideaAttach' width='100%' height='80'></iframe>")
				}
				else{
					$("#ideaAttach").toggle();
				}
			});
            $(".tmplitem").live("click",function(){
                $("#txtRemark").val(this.title);
            });
            //发起审批
	        $("#btnSubmit").click(function(){

                $(this).prop("disabled",true);
                if(!confirm("您确认提交审批吗?")){
                    $(this).prop("disabled",false);
                    return false;
                }
	            if(!$("#txtInstanceName").val())
                {
                    alert("请填写任务名称");
                    $(this).prop("disabled",false);
                    return false;
                }

                _saveAction = "1";
                var safe = false;
                try { safe = _sysSave(); } catch (err) {alert("提交过程中出现异常：" + err.message + "\r\n请尝试重新提交，或者联系管理员。");}

                if(safe){
                    //保存成功之后，要到数据端验证一下
                    var r = _curClass.CheckData(_mainTblName,_mainId);
                    if (r.error) {
                        alert(r.error.Message);
                        $(this).prop("disabled",false);
                        return false;
                    }
                    else {
                        if(parseInt(r.value) == 1){
                            __doPostBack("btnSubmit","");
                            return true;
                        }
                        else{
                            alert("提交过程中出现异常，请重新提交");
                            $(this).prop("disabled",false);
                        }
                    }

                }
                $(this).prop("disabled",false);
                return false;
	        });
            //暂存
            $("#btnTempSave").click(function(){
	           if(!$("#txtInstanceName").val())
               {
                    alert("请填写任务名称");
                    return false;
                }
                _saveAction = "2";

                var safe = false;
                try { safe = _sysSave(); } catch (err) { alert("提交过程中出现异常：" + err.message+"\r\n请尝试重新提交，或者联系管理员。");}
                if(safe){
                    __doPostBack("btnTempSave","");
                }
                return safe;
	        });

            $(".refDel").live("click",function(){
                if(confirm("确认删除本条参考流程吗?")){
                    $(this).parent().remove();
                }
            });
        });
		function _genInstanceName(){
		    var insName="<%=InstanceName%>";
			var reg = /{([\w_1-9]+)}/gi;
			var matches = insName.match(reg);
			if(matches != null)
			{
				for(var i=0;i<matches.length;i++){
					var fldName =matches[i].substr(1,matches[i].length-2);
					insName = insName.replace(matches[i],_sys.getValue(fldName));
				}
			}
			$("#txtInstanceName").val(insName);
		}
        //选择参考流程后
        function referSelect(selArr){
            var referArr=[];
            for(var i=0;i<selArr.length;i++){
                var pArr=selArr[i].split("|");
                var bt="⊙&nbsp;"+pArr[1];
                if(pArr[2].length>0)
                   bt = bt + "（"+pArr[2]+"）";
                referArr.push("<div class='refItem'><a class='refLink' href='../AppFrame/AppWorkFlowInfo.aspx?instanceId=" ,pArr[0],"' target='_blank'>" ,bt,"</a>");
                referArr.push("<input type='hidden' name='wfRefer' value='",selArr[i],"' />");
                referArr.push("&nbsp;<span class='refDel' style='color:gray;cursor:hand;' title='删除参考'>[删除]</span></div>");
            }
            $(".refList").append(referArr.join(""));
        }

        function app_query(tName){
            var listHtml = _curClass.GetListHtml("<%=TblName %>",tName,_mainId,_sIndex).value;
            $("#"+tName).before(listHtml).remove();
        }

        var _appRoot = '<%=ResolveUrl("~") %>';
        var _isNew = <%=isNew %>;
        var _mainTblName = "<%=TblName %>";
        var _mainId = "<%=MainId %>";
        var _sIndex = "<%=sIndex %>";
        var _saveAction = "1";
        var _nodeId ="Start", _nodeCode ="<%=nodeCode %>", _workflowCode ="<%=workflowCode %>", _taskId = "", _taskName = "开始";
        var _curClass =EZ.WebBase.SysFolder.WorkFlow.NewFlow;
        <%=this.sbmodel.ToString() %>
        var _xmlData =jQuery(jQuery.parseXML('<xml><%= xmlData %></xml>'));

    </script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script src="../../Js/SysFunction.js?v=<%=SysFuncEtag %>" type="text/javascript"></script>
    <script type="text/javascript">
        var insName="<%=InstanceName%>";
		var reg = /{([\w_1-9]+)}/gi;
		var matches = insName.match(reg);
		if(matches != null)
		{
			for(var i=0;i<matches.length;i++){
				var fldName =matches[i].substr(1,matches[i].length-2);
                var fldOrder = _getFieldOdr(fldName);
                if (fldOrder == -1)
                    continue;
                var ctlName = "input0" + fldOrder;
                var ctlArr = $("input[name='" + ctlName + "'],select[name='" + ctlName + "']");
				ctlArr.each(function(){
                    $(this).change(function(){
						_genInstanceName();
					}).blur(function(){
						_genInstanceName();
					});
				});

			}
		}
        _genInstanceName();
    </script>
    <script type="text/javascript">
        <%=editScriptBlock %> 
    </script>