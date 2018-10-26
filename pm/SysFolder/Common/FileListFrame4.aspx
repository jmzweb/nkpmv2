<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileListFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.FileListFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>上传文件</title>
    <link href="../../Css/AppStyle.css" rel="stylesheet" type="text/css" />
    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

	<style type="text/css">

	a.hover {
	color: red;
    }
	body{margin:0px;padding:0px;}
    .oldfilecontent
    {
        padding-left:0px;
        text-align:left;
        }
    #fileQueue{text-align:left;}
    .fileitem {color:Gray;line-height:20px;}
    .fileitem a{text-decoration:none;}
    .filelink{
        padding:0px 0px 0px 18px;
        background:transparent url(../../img/email/compose104472.png) no-repeat 0px 0px ;
        }
	.fileitem .dellink{
		text-decoration:none;
	}
	.fileitem .dellink:hover{
		text-decoration: underline;
	}
	.hidden{display:none;}
	.flashbtn{position:absolute;left:0px;top:0px;}
	.uploadify-queue{margin-bottom:3px;}
	#neatUpload{display:none1;position:absolute;left:80px;cursor:pointer; width:95px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;}
	#fromMyDoc{display:none;position:absolute;left:180px;cursor:pointer; width:100px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;<%=fromDoc%>}
	#downPacked{position:absolute;left:180px;cursor:pointer; width:90px;height:21px;line-height:120%;color:#0068B7;padding:1px 5px;z-index:99;border:1px solid #AABED3;}
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
            var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
            var ASPSESSID = "<%= Session.SessionID %>";

            try {$('#uploadify').uploadify('destroy');}catch(e){}

            $("#uploadify").uploadify({
                'swf': '../../js/uploadify-3.2.swf',
                'uploader': '../../FancyUpload.axd?folderId=<%=folderId %>',
                'formData': {appName:"<%=appName %>",appId:"<%=appId %>",folder:"<%=folder %>",'ASPSESSID': ASPSESSID, 'AUTHID': auth},
                'buttonText': ' ' + escape("选择文件"),
                'buttonImage': '../../img/common/browser.png',
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
					arr.push("<div class='fileitem'><a class='filelink' href='FileDown.aspx?fileId=");
					arr.push(fileId);
					arr.push("' target='_blank'>");
					arr.push(fileObj.name);
					arr.push("</a>");
					arr.push("&nbsp;<a class='dellink' href=\"javascript:readFile('");
					arr.push(fileId);
					arr.push("')\">[预览]</a>");
					arr.push("&nbsp;<a class='dellink' href=\"javascript:delFile('");
					arr.push(fileId);
					arr.push("')\">[删除]</a>");
					arr.push("</div>");
					$(".oldfilecontent").prepend(arr.join(""));
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
                //var ret = EZ.WebBase.SysFolder.Common.FileListFrame.PackFiles("");
                if(hasFiles())
				    window.open("FileGroup.aspx?appId=<%=appId %>","_blank");
                else
                    alert("没有可下载的文件");
            });
            jQuery("#linkSize").click(function(){
                autoFit();
            });
            setBtnState();
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
	        if (!confirm("你确认要删除这个文件吗"))
	            return;
	        var ret = EZ.WebBase.SysFolder.Common.FileListFrame.DeleteFile(fileId);
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
            var ret = EZ.WebBase.SysFolder.Common.FileListFrame.CopyFiles(arrFileId.join(","),"<%=appId %>","<%=appName %>");
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
            var ret = EZ.WebBase.SysFolder.Common.FileListFrame.CopyGroup(groupId,"<%=appId %>","<%=appName %>");
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
                $("#linkSize>img").attr("src","../../Img/common/gray_dn.jpg");
            }
            else{
                window.parent.$("#<%=frmId %>").animate({height:_hg},200);
                $("#linkSize>img").attr("src","../../Img/common/gray_up.jpg");
            }
        }
        function setBtnState(){
            $("#downPacked").prop("disabled", !hasFiles());
        }
    </script>
</head>
<body style="background:white;" >
    <form id="form1" runat="server">
    <div id="maindiv" style="padding:5px;overflow:auto;">
	<div style="<%=read%>;text-align:left;">
		<input type="file" style="display:none;" name="uploadify" id="uploadify" /> 
	    <input class="btn_sub" id="neatUpload" type="button" value="大附件上传" />
	    <input class="btn_sub" id="fromMyDoc" type="button" value="从我的文档选择" />
	    <input class="btn_sub" id="downPacked" type="button" value="打包下载" />
		<input class="btn_sub hidden" type="button" value="上传文件" onclick="javascript:UploadTest()" />
		<input class="btn_sub_DelRow hidden" type="button" value="全部取消" onclick="javascript:$('#uploadify').uploadifyClearQueue()" />
        <a id="linkSize" style="display:block;position:absolute;right:5px;top:5px;" href="javascript:" title="展开/收缩">
            <img style="border-width:0px;" alt="展开/收缩" src="../../Img/common/gray_up.jpg" />
        </a>
    </div>
    <div id="fileQueue" class="hidden"></div>
    <div class="oldfilecontent">
        <%=fileList %>
    </div>
    </div>
    </form>
</body>
</html>
