<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="DealFlow.aspx.cs" ValidateRequest="false" Inherits="EZ.WebBase.SysFolder.WorkFlow.DealFlow" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=curInstance.InstanceName %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <meta http-equiv="Pragma" content="no-cache"/>
    <link type="text/css" rel="stylesheet" href="../../Css/kandytabs.css"  />
    <link type="text/css" rel="stylesheet" href="../../Css/wfStyle.css" />
    <link type="text/css" rel="stylesheet" href="../../Css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" href="../../Editor/kindeditor-4.1.10/themes/default/default.css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/kandytabs.pack.js"></script>
    <script type="text/javascript" src="../../js/jquery.tablednd.0.8.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.notice.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/kindeditor-min.js"></script>
    <script type="text/javascript" src="../../Editor/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script type="text/javascript" src="../../js/jquery.qtip.min.js"></script>
    <script type="text/javascript" src="../../Js/DateExt.js"></script>
    <%=customScript%>
    <style type="text/css"> 
	    #maindiv{<%=formWidth%>}
	    .extBtn{width:48px;}
	    #fixedBar{position: fixed; bottom: 40px; right: 30px; display: none;}
	    #fixedBar a{
	        display: block;width:50px;height:50px;
	        text-align:center;
	        background:#90ee90;
	        margin-top:3px;}
	    #fixedBar a:hover{background:#32cd32;}
	    #fixedBar a span{
	        font-family:'Microsoft Yahei',"微软雅黑",arial,"宋体",sans-serif;
	        font-size:14px;color:#fff;
	        display:none;
	        cursor:pointer;
	        line-height:18px;
	        padding-top:6px}
	    #fixedBar a:hover span{display:block;}
    </style>  
</head>
<body>
    <!-- 工具栏 -->
    <div class="menubar">
        <div class="topnav">
			<span style="padding-left:10px;color:Gray;">流程信息：<%=wokflowName %> <span>(V<%=wfModel.Version %>)</span></span>
			<span style="right:10px;display:inline;float:right;position:fixed;line-height:30px;top:0px;">
            <a class="linkbtn linknote"  href="NewBefore.aspx?view=1&workflowid=<%=curInstance.WorkflowId %>" target="_blank" >审批须知</a>
			<em class="split">|</em>
            <a class='linkbtn' style="" href="../../LoginAuth.aspx" target="_blank">请求协助</a>
			<em class="split">|</em>
            <a class="linkbtn linkchart"  href="InstanceChart.aspx?instanceId=<%=curInstance.InstanceId%>" target="_blank" >查看流程图</a>
            <em class="split">|</em>
			<a class="linkbtn linkprint"  href="../AppFrame/AppWorkFlowPrint.aspx?instanceId=<%=curInstance.InstanceId%>"  target="_blank">打印</a>
            <em class="split">|</em>
			<a class="linkbtn linkclose"  href="javascript:">关闭</a>
            </span>
            

        </div>
    </div>
    
    <div id="maindiv">

        <div style="margin-left:auto;margin-right:auto;display:none;">
            <div style="font-family:微软雅黑,黑体;font-weight:bold;font-size:12pt;line-height:200%;"><%=curInstance.InstanceName%>
            <span style="color:red"><%=importance %></span></div>
            <div style="color:#999;text-align:center;">流程名称：<%=wokflowName%> &nbsp;
			发起人：<%=curInstance.EmployeeName%>（<%=curInstance._CreateTime.ToString("yyyy-MM-dd HH:mm")%>）
			</div>
        </div>

        <br/>
        <div id="tblHTML">
        <% =tblHTML%>
        </div>
    <form id="form1" runat="server">
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
                    <%=GetInstanceRefers() %>
                </div>
            </div>
        </div>
        <div class="wfdealinfo">
            <wf:UserDealInfo id="UserDealInfo" runat="server"></wf:UserDealInfo>
        </div>

        <div class="wfdealinfo" style="text-align:left;">
            <table width="100%">
            <tr>
                <td height="20">
                    <table width="100%">
                        <tr>
                            <td><h5 style="font-size:10pt;">处理意见：</h5></td>
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
                <td >
                    <asp:TextBox CssClass="TextBoxInArea" TextMode="MultiLine" Rows="3"  ID="txtRemark" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr class='<%=uTask.IsAssign=="1"?"hidden":"" %>'>
                <td style="padding:10px 0px;">
                <span style="font-weight:bold;font-size:10pt;float:left;margin-top:4px;">下一步：</span>
                <div style="float:left;" class="nextUserZone">
                    <%=NextActivityList%>  
                </div>
                <div id="docZone" class="hidden"><%=NodeDocHtml %></div>
                </td>
            </tr>
            <tr class="hidden">
                <td style="padding:10px 0px;">
                <div style="font-weight:bold;font-size:10pt;float:left;">本步骤处理情况：</div>
                <div style="float:left;">
                    <%=CurStepInfo%>  
                </div>
                </td>
            </tr>
            </table>
            <div class="authPanel <%=ReAuthClass %>" style="margin:2px;line-height:30px;">
                <span style="font-weight:bold;font-size:10pt;float:left;margin-top:5px;margin-right:6px;">二次认证方式：</span>
                <select id="selReAuthType" style="height:24px;"><option value="1">登录密码</option><option value="2">短信验证码</option></select>&nbsp;&nbsp;
                <label id="labelPass">密码：</label><input id="reAuthPass" type="text" title="输入后回车即可验证" style="border:1px solid #bbb;padding:2px;width:100px;"/>
                <input id="btnFetchCode" type="button" value="获取验证码" class="hidden"  style="height:26px;background:#eee none;"/>
                <span id="checkInfo" style="vertical-align:middle;font-weight:bold;font-size:10pt;color:Green">输入后回车即可验证</span>
            </div>
           <%=DealInfo %>
           <div id="bottomBar" style="margin-top:5px;border:1px solid #ddd;padding:2px;text-align:right;height:30px;line-height:30px;background:#fbfbfb;">
                <span style="float:left;">
                <asp:Button ID="btnSubmit"  CssClass="btn01" runat="server" Text="提 交" onclick="btnSubmit_Click"/>
                <asp:Button ID="btnAgree"  CssClass="btn01" runat="server" Text="同 意" onclick="btnAgree_Click"/>
                <%=ExtBtnList %>
                <asp:Button ID="btnReject"  CssClass="btn01" runat="server" Text="退 回" onclick="btnReject_Click"/>
                <asp:Button ID="btnShareTask"  CssClass="hidden" runat="server" Text="退 还" onclick="btnShareTask_Click"/>
                <asp:Button ID="btnDone"  CssClass="btn01 hidden" runat="server" Text="结 束" onclick="btnDone_Click"/>
                <button type="button" id="btnRollBack" class="btn01 <%=RollBackClass %>">退 回</button>
                <button type="button" id="btnDirect" class="btn01 <%=DirectClass %>">直 送</button>
                <button type="button" id="btnAssign" class="btn01 <%=AssignClass %>">加 签</button>
                <button type="button" id="btnRelegate" class="btn01 <%=RelegateClass %>">委 托</button>
                <asp:Button ID="btnHangUp" CssClass="btn01" runat="server" Text="挂 起" onclick="btnHangUp_Click" />
                <asp:Button ID="btnResume" CssClass="btn01" runat="server" Text="恢 复" onclick="btnResume_Click" />
                <asp:Button ID="btnStop"  CssClass="btn01" runat="server" Text="终 止" onclick="btnStop_Click" />
                <button type="button" id="btnShareTo" class="btn01" onclick="javascript:wf_share();">传 阅</button>
                <button type="button" id="btnLimit" class="btn01 <%=LimitClass %>" onclick="javascript:wf_limit();">公开范围</button>
                <button type="button" id="btnTempSave" class="btn01" onclick="_appSave(true);" >暂 存</button>
                </span>
                 <span style="font:bold 10pt/26px;color:#666">请选择岗位：</span><asp:DropDownList ID="PositionList" runat="server" Width="260" AutoPostBack="True" 
                  onselectedindexchanged="PositionList_SelectedIndexChanged"> </asp:DropDownList>
                <input type="hidden" id="Event_Arguments" name="Event_Arguments" />
            </div>
        </div>

    </form>

    </div>
    <br />
    <br />

    <div id="fixedBar">
        <a href="javascript:void(0)" id="quickSubmit" class="quickSubmit"><span>提交</span></a>
        <a href="javascript:void(0)" id="quickBack" class="quickBack"><span>退回</span></a>
        <a href="javascript:void(0)" id="quickAdvice" class="quickAdvice"><span>发表<br/>意见</span></a>
        <a href="javascript:void(0)" id="quickTop" class="quickTop"><span>返回<br/>顶部</span></a>
    </div>
</body>
</html>
    <script type="text/javascript">
        var alertbs = "<%=SubmitConfirm %>"=="是";

        $("dl").KandyTabs({ trigger: "click" });

        $(".tabZone .btbtn").click(function () {
            var pt = $(this).parent();
            $(".tabon", pt).removeClass("tabon");
            $(this).addClass("tabon");
            var i = $(this).index();
            var blist = pt.next().children();
            blist.hide();
            blist.eq(i).show();
        });

        //告知
        function wf_share()
        {
            var reason=document.getElementById("txtRemark").value;
            window.open("FlowShareTo.aspx?taskId=<%=taskId %>&reason="+escape(reason),"_blank");
        }
        //保存
        function _appSave(nclose)
        {
            //保存意见
            if($("#txtRemark").val()!=""){
                var ret = _curClass.SaveAdvice("<%=uTaskId%>",$("#txtRemark").val());
            }
            _saveAction = "2";
            if(_sysSave())
            {
                alert("保存成功!");
                if(!!!nclose)
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
                url += "&insId=<%=curInstance.InstanceId%>&actId="+nodeCode+"&method=3";
            else
                url += "&method=1";
            //_openCenter(url,"_blank",640,460);
            layer.open({type: 2,title: '选择处理人',shade: false,area: ['640px', '520px'],content: url});
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

            if(!_saveBeforeSubmit)
                $("#btnTempSave").hide();
            if("<%=ReAuthClass %>"==""){
                $("#btnSubmit,#btnAgree,#btnReject,#btnRollBack,#btnDirect,.extBtn").attr("disabled",true);
            }
            $(window).resize(function(){
                $(".wfpage").height($(document.body).height()-60);
            });
            $(".wfpage").height($(document.body).height()-60);

            $(".btn01").hover(function(){
                this.className="btn02";
            },function(){
                this.className="btn01";
            });

            $("#btnRelation").click(function(){
                _openCenter("flowRelation.aspx","_blank",800,600);
            });
            $(".linkMemo").click(function(){$(this).next("p").toggle();});
            $(".uMemo").click(function(){$(this).toggle();});

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
            $(".extBtn").click(function(){
                if(alertbs && !confirm("您确定提交吗？"))
                    return false;
                $("#Event_Arguments").val($(this).attr("prop"));

                _saveAction = "1";
                if(_saveBeforeSubmit)
                    return _sysSave();
                else
                    return true;

            });
            $("#btnSubmit").click(function(){
                if(alertbs && !confirm("您确定选择【"+jQuery(event.srcElement).val()+"】吗？"))
                    return false;

                if(!chkRet()) return false;

                _saveAction = "1";
                if(_saveBeforeSubmit)
                    return _sysSave();
                else
                    return true;
            });
            
            $("#btnDone").click(function(){
                if(alertbs && !confirm("您确定选择【"+jQuery(event.srcElement).val()+"】吗？"))
                    return false;

                if(!chkRet()) return false;

                _saveAction = "1";
                if(_saveBeforeSubmit)
                    return _sysSave();
                else
                    return true;
            });

            $("#btnAgree").click(function(){
                if(alertbs && !confirm("您确定选择【"+jQuery(event.srcElement).val()+"】吗？"))
                    return false;
                _saveAction = "1";
                if(_saveBeforeSubmit)
                    return _sysSave();
                else
                    return true;
            });

            $("#btnReject").click(function(){
                if(alertbs && !confirm("您确定选择【"+jQuery(event.srcElement).val()+"】吗？"))
                    return false;
                var reason=$("#txtRemark").val();
                if(reason == "")
                {
                    alert("【退回】操作必须填写意见");
                    return false;
                }
                return true;
            });

            //回退
            $("#btnRollBack").click(function(){
                if(alertbs && !confirm("您确定选择【"+event.srcElement.innerText+"】吗？"))
                    return;
                var reason=$("#txtRemark").val();
                if(reason=="")
                {
                    alert("【退回】操作必须填写意见");
                    return;
                }
                window.open("FlowTaskRollBack.aspx?taskId=<%=taskId %>&reason="+escape(reason),"_self");
            });

            //终止
            $("#btnStop").click(function(){
                var reason=$("#txtRemark").val();
                if(reason == "")
                {
                    alert("【终止】操作必须填写原因");
                    return false;
                }
                if(!confirm("您确定终止任务吗？"))
                    return false;
            });

            //直送
            $("#btnDirect").click(function(){
                //_openCenter("FlowTaskDirect.aspx?taskId=<%=taskId %>","_blank",500,500);
                var reason=document.getElementById("txtRemark").value;

                if(alertbs && !confirm("您确定选择【直送】吗？"))
                    return;
                if(reason=="")
                {
                    alert("【直送】操作必须填写意见");
                    return;
                }

                window.open("FlowTaskDirect.aspx?taskId=<%=taskId %>&reason="+escape(reason),"_self");
            });
            //加签
            $("#btnAssign").click(function(){
                var reason = document.getElementById("txtRemark").value;
                window.location = "FlowAssign.aspx?taskId=<%=taskId %>&reason="+escape(reason);
            });

            //委托
            $("#btnRelegate").click(function(){
                var reason=document.getElementById("txtRemark").value;
                window.open("FlowDelegate.aspx?taskId=<%=taskId %>&reason="+escape(reason),"_self");
            });
            //同意时不能填写处理意见，不同意一定要填写意见
            $("#txtRemark").change(function(){
                return;
                if(this.value)
                {
                    $("#btnSubmit").attr("disabled","true");
                    $("#btnReject").removeAttr("disabled","false");
                }
                else
                {
                    $("#btnSubmit").removeAttr("disabled");
                    $("#btnReject").attr("disabled","true");
                }
            });
            $(".toggleTable").click(function(){
                $("#tblHTML").toggle("slow");
            });
            $(".tmplitem").live("click",function(){
                $("#txtRemark").val(this.title);
            });
            $("#txtDealline").focus(function(){
                WdatePicker({isShowClear:false});
            });
            $(".linkclose").click(function(){
                var newwin = window.open("","_parent","");  
                newwin.close();  
            });
			$(".linkidea").dialog({ title: '意见模板编辑', maxBtn: false, page: 'IdeaTemplate.aspx'
                , btnBar: false, cover: false, lockScroll: true, width: 600, height: 400, bgcolor: 'black'
            });
			$(".linkattach").click(function(){
				if($("#ideaAttach").length==0){
					$("#txtRemark").before("<iframe id='ideaAttach' frameborder='0' scrolling='auto'  src='../Common/FileListFrame.aspx?appName=<%=tblName%>&appId=<%=uTaskId%>&read=0&frmId=ideaAttach' width='100%' height='100'></iframe>")
				}
				else{
					$("#ideaAttach").toggle();
				}
			});

            $("#selReAuthType").change(function(){
                var v=$("#selReAuthType").val();
                if(v=="1"){
                    $("#btnFetchCode").hide();
                    $("#labelPass").html("密码：");
                }else{
                    $("#labelPass").html("验证码：");
                    $("#btnFetchCode").show();                
                }
                $("#checkInfo").html("");
            });
            $("#btnFetchCode").click(function(){
                //获取验证码
                var ret =_curClass.SendSms();
                if(ret.error){
                    $("#checkInfo").html(ret.error.Message).css("color","red");
                }else{
                    $("#checkInfo").html("验证码已经成功发送，请注意查看").css("color","green");
                }
            });
            $("#reAuthPass").change(function(){
                //开始验证
                var t=$("#selReAuthType").val();
                var ret =_curClass.ReAuth(t,this.value);
                if(ret.error){
                    $("#checkInfo").html("验证时出错："+ret.error.Message).css("color","red");
                }
                else{
                    if(ret.value=="1"){
                        //alert("验证码正确");
                        $(".authPanel").slideUp();
                        $("#btnSubmit,#btnAgree,#btnReject,#btnRollBack,#btnDirect,.extBtn").attr("disabled",false);                    
                    }
                    else{
                        $("#checkInfo").html("验证码不正确").css("color","red");
                    }
                }
            }).keydown(function(event){
                if(event.keyCode == 13){
                    $(this).change();
                    return false;
                }
            });

            $("#txtRemark").limitTextarea({maxNumber:1000,position:"bottom",afterHtml:''});
            $(".addComment").click(function(){
                var taskId=$(this).attr("taskid");
                $(this).after("<div class='commentArea'><textarea></textarea><div style='text-align:right;'><input class='btnComment' taskid='" + taskId + "' type='button' value='提 交'/></div></div>");
            });
            $(".btnComment").live("click",function(){
                var pp = $(this).parent().parent();
                var ta = $(this).parent().prev("textarea").val();
                var taskId = $(this).attr("taskid");
                var ret = _curClass.SaveComment(taskId,ta);
                if(ret.error)
			    {
			        alert("保存出错："+ret.error.Message);
			    }
			    else
			    {
                    $.noticeAdd({ text: '保存成功！',stayTime:500,onClose:function(){
                        pp.remove();
                        $("#anchor_"+taskId).before("<div class='comment'>"+ta+"<span class='ucomment'><%=base.EmployeeName%></span><span class='tcomment'></span></div>");
                    }});
			    }
            });
            //设置查阅权限
            $("#btnLimit").dialog({ title: '设置公开范围', maxBtn: false, page: 'QueryLimitSet.aspx?insId=<%=curInstance.InstanceId%>'
                , btnBar: false, cover: true, lockScroll: true, width: 800, height: 500, bgcolor: 'black'
            });

            $(".refDel").live("click",function(){
                if(confirm("确认删除本条参考流程吗?")){
                    $(this).parent().remove();
                }
            });

        });
        function chkRet(){
            var list = $("[name=chkstep]:checked");
            var m=0,n=0;
            for (var i = 0; i < list.length; i++) {
                if($(list[i]).attr("ret") == "1")
                    m++;
                else
                    n++;
            }
            if(m>0 && n>0)
            {
                alert("后续步骤选择有误，不能同时选择。");
                return false;
            }
            else
                return true;
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
            var listHtml = _curClass.GetListHtml("<%=tblName %>",tName,_mainId,_sIndex).value;
            $("#"+tName).before(listHtml).remove();
        }

        var _isNew = false;
        var _appRoot = '<%=ResolveUrl("~") %>';
        var _saveBeforeSubmit=<%=SaveBeforeSubmit %>;
        var _mainTblName = "<%=tblName %>";
        var _mainId = "<%=MainId %>";
        var _sIndex = "<%=sIndex %>";
        var _saveAction = "1";
        var _workflowCode ="<%=workflowCode %>";
        var _nodeCode ="<%=nodeCode %>";
        var _nodeId ="<%=curTask.ActivityId %>";
        var _taskId = "<%=taskId %>";
        var _taskName = "<%=curTask.TaskName %>";
        var _isAssign = "<%=uTask.IsAssign %>"=="1";
        var _curClass =EZ.WebBase.SysFolder.WorkFlow.DealFlow;
        <%=this.sbmodel.ToString() %>
        var _xmlData =jQuery(jQuery.parseXML('<xml><%=xmlData %></xml>'));
    </script>
    <script type="text/javascript" src="../../js/layer/3.0.2/layer.js"></script>
    <script src="../../Js/SysFunction.js?v=<%=SysFuncEtag %>" type="text/javascript"></script>
    <script type="text/javascript">
        <%=editScriptBlock %>    
    </script>