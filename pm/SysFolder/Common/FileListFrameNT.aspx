<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileListFrameNT.aspx.cs" Inherits="EIS.WebBase.SysFolder.Common.FileListFrameNT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1">
    <title>上传文件</title>
    <link href="<%=Resource_Root %>/Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=Resource_Root %>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=Resource_Root %>/js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="<%=Resource_Root %>/js/lhgdialog.min.js"></script>

	<style type="text/css">
    *{
        margin:0;
        padding:0;
    }
    body{
        font-weight:normal;
        font-style:normal;
        font-family:Tahoma,Helvetica,Arial,sans-serif;
        font-size:12px;
        background-color:#f9fafe;
        height:96%;

    }
    .toolbar{padding:3px 0px 0px 18px;}
	a.hover {
	color: red;
    }
    .oldfilecontent
    {
        padding-left:0px;
        text-align:left;
        display:inline-block;
    }
    #fileQueue{text-align:left;}
    .fileitem {color:Gray;margin-bottom:5px;}
    .fileitem a{text-decoration:none;}
    .lnkbtn{color:#444;margin-right:5px;}
    .filelink{
        word-break:keep-all;
        white-space:nowrap;
        overflow:hidden;
        text-overflow:ellipsis;
        padding:0px 0px 0px 18px;
        line-height:1.5;
        background:transparent url(<%=Resource_Root %>/img/email/compose104472.png) no-repeat 0px 0px ;
    }
    button,input[type=button],input[type=submit]
    {
	    font-size:9pt;
        padding:3px 6px 3px 6px;
	    margin:1px 0px 1px 0px;
	    width: auto;
	    line-height:16px;
	    height:26px;
        border:#87a3c1 1px solid;
        color:#333;
        background:url(<%=Resource_Root %>/img/btn01.gif) 0px 0px;
        overflow:visible;
        cursor:pointer;
    }
    .lnkbtn:hover,.filelink:hover{color:#dc143c;}
    .rezone{padding:3px 0px 0px 18px;}
    .reinput{width:440px;padding:4px 2px;font-size:12px;background-color:#fffacd;border:1px solid #aaa;}
    a[disabled]{color:#ccc;}
	.hidden{display:none;}
	.flashbtn{position:absolute;left:0px;top:0px;    position: absolute;color:#fff;
    left: 0px;
    top: 0px;
    text-indent: 1px !important;
    height: 28px;
    line-height: 28px;
    width: 78px;
    background-image: url('') !important;  
    background-repeat: no-repeat;
    background-color: #1FB2DE;
    border-radius: 0.4em;
    margin: 0 auto;
    text-align: center;
    margin-top: 8px;
	}
    .uploadify {
       margin-bottom: -3px !important;
    }
	.uploadify-queue{margin-bottom:3px;}
	#neatUpload{display:none;position:absolute;left:80px;cursor:pointer; width:95px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;}
	#fromMyDoc{display:none;left:80px;cursor:pointer; width:100px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;<%=fromDoc%>}
	#downPacked{position:absolute;left:85px;cursor:pointer; width:90px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;}
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
            var auid = "<% = Session.SessionID %>";
            var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";

            try {$('#uploadify').uploadify('destroy');}catch(e){}

            $("#uploadify").uploadify({
                'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
                'uploader': '../../FancyUpload.axd?folderId=<%=folderId %>',
                'formData': {appName:"<%=appName %>",appId:"<%=appId %>",folder:"<%=folder %>",'ASPSESSID': auid, 'AUTHID': auth},
                'buttonText': ' ' + escape("选择文件"),
                'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
                'buttonClass': 'flashbtn',
                'height': 24,
                'width': 78,
                'fileTypeExts':"<%=ext %>",
                'fileSizeLimit': "<%=limit %>",
                'folder': '<%=folder %>',
                //'queueID': 'fileQueue',
                'auto': true,
                'multi': <%=multi %>,
                'overrideEvents':['onUploadSuccess','onQueueComplete','onSelectError'],
                onSelect:function(file){
                    //$("#fileQueue").removeClass("hidden");
                },
                onUploadStart: function (file) {
                    var cm=false;
                    $("a.filelink").each(function(){
                        if(file.name == $(this).text())
                        {
                            alert("同名文件已经存在！");
                            this.cancelUpload(file.id); 
                            $('#' + file.id).remove();
                            cm = true; 
                            return false;
                        }                    
                    });
                    if(cm) return false;

                    if("<%=multi %>"=="false"){
                        if($("a.filelink").length>0){
                            this.cancelUpload(file.id); 
                            $('#' + file.id).remove(); 
                        }
                    }
                } ,
                onQueueComplete:function(){
                    //window.location.reload();
                    //$("#fileQueue").addClass("hidden");
                },
                onUploadSuccess:function(fileObj,response, data) {
                    var fileId=response;
                    var arr=[];
                    arr.push("<div class='fileitem'>");
                    //arr.push("<a class='filelink' href='FileDown.aspx?fileId=");
                    //arr.push(fileId);
                    //arr.push("' target='_blank'>");
                    //arr.push(fileObj.name);
                    //arr.push("</a>");
                    arr.push("<div class='toolbar'>")
                    arr.push("<a class='lnkbtn downlink' href='javascript:' fileid='",fileId,"' >[下载]</a> ");
                    arr.push("<a class='lnkbtn readlink' href='javascript:' fileid='",fileId,"' >[预览]</a> ");
                    arr.push("<a class='lnkbtn dellink'  href='javascript:' fileid='",fileId,"' >[删除]</a> ");
                    arr.push("</div>");
                    arr.push("</div>");
                    $(".oldfilecontent").html(arr.join(""));
                    var frm = '<%=frmId %>';
                    var frmArr = frm.split('_');
                    parent.window.document.getElementById('input'+frmArr[1]+'1').value=fileObj.name;
                    parent.UpVer(frmArr[1]);
                    setBtnState();
                },
                //返回一个错误，选择文件的时候触发        
                onSelectError:function(file, errorCode, errorMsg){            
                    switch(errorCode) {                
                        case -100:                    
                            alert("上传的文件数量已经超出系统限制的"+$('#uploadify').uploadify('settings','queueSizeLimit')+"个文件！");                    
                            break;                
                        case -110:                    
                            alert("文件 ["+file.name+"] 大小超出系统限制的"+$('#uploadify').uploadify('settings','fileSizeLimit')+"大小！");                    
                            break;                
                        case -120:                    
                            alert("文件 ["+file.name+"] 大小异常！");                    
                            break;                
                        case -130:                    
                            alert("文件 ["+file.name+"] 类型不正确！");                    
                            break;           
                    }        
                },        
                //检测FLASH失败调用        
                onFallback:function(){            
                    //alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");        
                },
                onError: function (event, queueId, fileObj, errorObj) {
                    alert("文件【"+fileObj.name + "】上传错误");
                }
            });
            jQuery("#uploadify-button").css({"background-repeat":"no-repeat"});
            jQuery("#uploadify").css({width:"100%","margin-bottom":"3px"});

            jQuery("#neatUpload").appendTo("#uploadify").click(function(){
                var dlg = new $.dialog({ title: '大附件上传', 
                    page: '<%=Page.ResolveUrl("~") %>SysFolder/Common/NeatUpload.aspx?empId=<%=base.EmployeeID %>&deptWbs=<%=base.OrgCode %>&appName=<%=appName %>&appId=<%=appId %>&folder=<%=folder %>'
                    , btnBar: true, cover: true, width: 600, height: 260, bgcolor: 'gray', cancelBtnTxt: '关闭',maxBtn:false,resize:false,
                    onCancel: function () {
                        
                    }
                });
                dlg.ShowDialog();
            });
            jQuery("#fromMyDoc").appendTo("#uploadify").click(function(){
                var dlg = new $.dialog({ title: '从我的文档选择文件', page: '<%=Page.ResolveUrl("~") %>Doc/SelMyDocFrame.aspx'
                    , btnBar: true, cover: true, width: 800, height: 500, bgcolor: 'gray', cancelBtnTxt: '关闭',
                    onCancel: function () {
                    }
                });
                dlg.ShowDialog();
            });

            jQuery("#downPacked").appendTo("#uploadify").click(function(){
                //var ret = EIS.WebBase.SysFolder.Common.FileListFrame.PackFiles("");
                if(hasFiles())
                    window.open("FileGroup.aspx?appId=<%=appId %>","_blank");
                else
                    alert("没有可下载的文件");
            });
            jQuery("#linkSize").click(function(){
                autoFit();
            });
            setBtnState();
            jQuery(".downlink").live("click",function(){
                var fileid=$(this).attr("fileid");
                window.open("filedown.aspx?fileid="+fileid,"_blank");
            });
            jQuery(".editlink:enabled").live("click",function(){
                var fileid=$(this).attr("fileid");
                if(!!$(this).attr("disabled")) return;
                window.open("weboffice.aspx?fileid="+fileid+"&mark=1","_blank");
            });
            jQuery(".remmlink").live("click",function(){
                var fileid=$(this).attr("fileid");
                var fname=$(this).attr("fname");
                var flag=$(this).attr("flag");
                if(!!flag){
                    $(this).parent().hide().prev().show();
                }
                else{
                    var arr = [];
                    arr.push("<div class='rezone'>");
                    arr.push("<input type='text' class='reinput' value='"+fname+"' autocomplete='off' fileid='"+fileid+"'>&nbsp;");
                    arr.push("<a class='lnkbtn lnkbc' href='javascript:'>[保存]</a>");
                    arr.push("<a class='lnkbtn lnkqx' href='javascript:'>[取消]</a>");
                    arr.push("</div>");
                    $(this).attr("flag","1");
                    $(this).parent().hide().before(arr.join(""));
                }
            });
            jQuery(".readlink").live("click",function(){
                if(!!$(this).attr("disabled")) return;
                var fileid=$(this).attr("fileid");
                window.open("FileViewerGroup.aspx?fileid="+fileid,"_blank");
            });
            jQuery(".dellink").live("click",function(){
                var fileid=$(this).attr("fileid");
                delFile(fileid);
            });

            $(".lnkbc").live("click",function(){
                var input = $(this).prev(".reinput");
                var fileId = input.attr("fileid");
                var newName = input.val()

                var ret = EIS.WebBase.SysFolder.Common.FileListFrame.RenameFile(fileId, newName);
                if (ret.error) {
                    alert(ret.error.Message);
                }
                else {
                    window.location.reload();
                }

                $(this).parent().hide();                
                $(this).parent().next().show();
            });
            $(".lnkqx").live("click",function(){
                $(this).parent().hide();
                $(this).parent().next().show();
            });
            autoFit(true);

            $('.uploadify-button-text').each(function(i,e){
                $(e).html('上传文件')
            });
        });

        function overLoad() {
            if (window.opener.store != undefined) {
                window.opener.store.reload();
                window.opener.store.commitChanges();
            }
            else {
                window.opener.location.href = window.opener.location.href;
            }
            window.close();
        }
        function readFile(fileId) {
            window.open("FileViewerGroup.aspx?fileId="+fileId);
        }
        function delFile(fileId) {
            if (!confirm("你确认要删除这个文件吗？"))
                return;
            var ret = EIS.WebBase.SysFolder.Common.FileListFrame.DeleteFile(fileId);
            if (ret.error) {
                alert(ret.error.Message);
            }
            else {
                window.location.reload();
            }

            setBtnState();

        }
        //用于从我的文档插入文件
        function copyFiles(arrFileId) {
            var ret = EIS.WebBase.SysFolder.Common.FileListFrame.CopyFiles(arrFileId.join(","),"<%=appId %>","<%=appName %>");
            if (ret.error) {
                alert(ret.error.Message);
            }
            else {
                var arrFile = ret.value.split(",");
                copyAppend(arrFile);
            }
        }

        //复制文件组
        function copyGroup(groupId) {
            var ret = EIS.WebBase.SysFolder.Common.FileListFrame.CopyGroup(groupId,"<%=appId %>","<%=appName %>");
            if (ret.error) {
                alert(ret.error.Message);
            }
            else {
                var arrFile = ret.value.split(",");
                copyAppend(arrFile);
            }
        }

        function copyAppend(arrFile){
            var arr=[];
            for (var i = 0; i < arrFile.length; i++) {
                var arr2=arrFile[i];
                var fileId=arr2.split("|")[0];
                var fileName=arr2.split("|")[1];

                arr.push("<div class='fileitem'><a class='filelink' href='FileDown.aspx?fileId=");
                arr.push(fileId);
                arr.push("' target='_blank' >");
                arr.push(fileName);
                arr.push("</a>&nbsp;<a class='dellink' href=\"javascript:delFile('");
                arr.push(fileId);
                arr.push("')\">[删除]</a></div>");
            }

            $(".oldfilecontent").append(arr.join(""));
        }

        //用于必填验证
        function hasFiles(){
            return $(".filelink").length > 0 ? true : false;
        }
        //返回已经上传的附件名称数组
        function getFileNames() {
            var arr=[];
            $(".filelink").each(function(){
                arr.push($(this).text());
            });
            return arr;
        }
        var _hg = 0, _fit = false;
        function autoFit(flag){
            if(arguments.length == 0)
                flag = _fit = !_fit;
            else
                flag = _fit = true;

            if(flag){
                //var ifrm = window.parent.document.getElementById("<%=frmId %>");
                //ifrm.height = $(document).height() + 50;
                var ifrm = window.parent.$("#<%=frmId %>");
                if(_hg == 0) _hg = ifrm.height();
                ifrm.animate({height:$("#maindiv").height() + 16},200);
                $("#linkSize>img").attr("src","<%=Resource_Root %>/Img/common/gray_dn.jpg");
            }
            else{
                window.parent.$("#<%=frmId %>").animate({height:_hg},200);
                $("#linkSize>img").attr("src","<%=Resource_Root %>/Img/common/gray_up.jpg");
            }
        }
        function setBtnState(){
            if(hasFiles())
                $("#downPacked").removeAttr("disabled");
            else
                $("#downPacked").attr("disabled", "disabled");
        }
    </script>
</head>
<body style="background:white;" >
    <form id="form1" runat="server">
    <div id="maindiv" style="padding:5px;overflow:auto;">
	<div style="text-align:left;display:inline-block;width: 80px;" class="<%=read=="1"?"hidden":"" %>">
		<input type="file" style="display:none;" name="uploadify" id="uploadify" /> 
<%--	    <input class="btn_sub" id="neatUpload" type="button" value="大附件上传" />
	    <input class="btn_sub" id="fromMyDoc" type="button" value="从我的文档选择" />
	    <input class="btn_sub" id="downPacked" type="button" value="打包下载" />
		<input class="btn_sub hidden" type="button" value="上传文件" onclick="javascript:UploadTest()" />--%>
		<input class="btn_sub_DelRow hidden" type="button" value="全部取消" onclick="javascript:$('#uploadify').uploadifyClearQueue()" />
       <%-- <a id="linkSize" style="display:block;position:absolute;right:5px;top:5px;" href="javascript:" title="展开/收缩">
            <img style="border-width:0px;" alt="展开/收缩" src="<%=Resource_Root %>/img/common/gray_up.jpg" />
        </a>--%>
    </div>
    <div id="fileQueue" class="hidden"></div>
    <div class="oldfilecontent">
        <%=fileList %>
    </div>
    </div>
    </form>
</body>
</html>

