<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileListFrame.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.FileListFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>上传文件</title>
    <link href="../../Css/AppStyle.css" rel="stylesheet" type="text/css" />
    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>

	<style type="text/css">

	a.hover {
	color: red;
    }
	body{margin:0px;padding:0px;}

    #fileQueue{text-align:left;}
    .filelink{
        text-decoration:none;
        padding:1px;
        }
    .filelink:hover{
        text-decoration:none;
        }
	.dellink{
		text-decoration:none;
	}
	.dellink:hover{
		text-decoration: underline;
	}
	.hidden{display:none;}
	.flashbtn{position:absolute;left:3px;top:3px;}
	#uploadify{float:left;width:30px;}
	.uploadify-queue{display:none1;}
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
            
            var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
            var ASPSESSID = "<%= Session.SessionID %>";

            $("#uploadify").uploadify({
                'swf': '../../js/uploadify-3.2.swf',
                'uploader': '../../FancyUpload.axd',
                'formData': {appName:"<%=appName %>",appId:"<%=appId %>",folder:"<%=folder %>",'ASPSESSID': ASPSESSID, 'AUTHID': auth},
                'buttonText': ' ' + escape("选择文件"),
                'buttonImage': '../../img/common/add_small.png',
                'buttonClass': 'flashbtn',
                'height': 24,
                'width': 24,
                'fileTypeExts':"<%=ext %>",
                'fileSizeLimit': "<%=limit %>",
                'folder': '<%=folder %>',
                'auto': true,
                'multi': <%=multi %>,
                'overrideEvents':['onUploadSuccess','onQueueComplete','onSelectError'],
				onSelect:function(file){
				},
                onUploadStart: function (file) { 
                    if($("a.filelink:contains('"+file.name+"')").length>0){
                        alert("同名文件已经存在！");
                        this.cancelUpload(file.id); 
                        $('#' + file.id).remove(); 
                    }
                    if("<%=multi %>"=="false"){
                        if($("a.filelink").length>0){
                            this.cancelUpload(file.id); 
                            $('#' + file.id).remove(); 
                        }
                    }
                } ,
				onQueueComplete:function(){

				},
                onUploadSuccess:function(fileObj,response, data) {
					var fileId=response;
					var arr=[];
					arr.push("<a class='filelink' title='点击下载' href='FileDown.aspx?fileId=");
					arr.push(fileId);
					arr.push("' target='_blank'>");
					arr.push(fileObj.name);
					arr.push("</a>&nbsp;<a class='dellink' href=\"javascript:delFile('");
					arr.push(fileId);
					arr.push("')\">[删除]</a>");
					$("#form1").append(arr.join(""));
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
                    alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");        
                },
                onError: function (event, queueId, fileObj, errorObj) {
                    alert("文件【"+fileObj.name + "】上传错误");
                }
            });
            jQuery("#uploadify-button").css({"background-repeat":"no-repeat"});
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
    </script>
</head>
<body style="background:white;padding-top:3px;" >
    <form id="form1" runat="server">
    <input type="file" style="<%=read%>;" name="uploadify" id="uploadify" /> 
    <%=fileList%>
    </form>
</body>
</html>
