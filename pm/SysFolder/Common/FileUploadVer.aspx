<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUploadVer.aspx.cs" Inherits="EZ.WebBase.SysFolder.Common.FileUploadVer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>上传新版本</title>
    <link href="../../Css/Huploadify.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.Huploadify.js"></script>

	<style type="text/css">

	a.hover {
	color: red;
    }
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
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
            var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
            var ASPSESSID = "<%= Session.SessionID %>";
			var up = $('#upload').Huploadify({
				auto:false,
				uploader: '../../FancyUpload.axd?folderId=<%=folderId %>&fileCode=<%=fileCode %>',
				fileTypeExts:"<%=ext %>",
                formData: {'break':1, 'point':0.1, appName:"<%=appName %>",appId:"<%=appId %>",folder:"<%=folder %>",'ASPSESSID': ASPSESSID, 'AUTHID': auth},
				multi:false,
				fileSizeLimit: 1024*1024*1024,
				breakPoints:true,
                fileSplitSize: 1024*1024,
				saveInfoLocal:true,
				showUploadedPercent:true,//是否实时显示上传的百分比，如20%
				showUploadedSize:true,
				removeTimeout: 9999999,
				onUploadStart:function(){

				},
				onUploadSuccess:function(file){

				},
				onUploadComplete:function(){
				
                },
				getUploadedSize:function(file){
					var data = {
						fileName : file.name,
						lastModifiedDate : file.lastModifiedDate.getTime()
					};
                    var ret = EZ.WebBase.SysFolder.Common.FileListFrame.GetUploadedSize("<%=appId %>",file.name);
                    if(ret.error){
                        return 0;
                    }
					return parseInt(ret.value);
				},
				onSelect:function(){
                    $(".uploadify-button").hide();
                }	
			});
		});

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="upload" style="padding:5px;overflow:auto;">
    </div>
    </form>
</body>
</html>

