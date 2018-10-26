//以下是程序引用页面的定义
var filetype; //文件类型
var savetype; //文件保存类型
var IsFileOpened;  //控件是否打开文档
var savePage = "WebOfficeSave.aspx"; //保存文档程序程序

function getOcx() {
    return document.getElementById("TANGER_OCX");
}
function getValue(objId) {
    var obj = document.getElementById(objId);
    return !!obj ? obj.value : "";
}
function resizeView() {
    var ocxObj = getOcx();
    try {
        ocxObj.style.height = document.documentElement.clientHeight;
    } catch (e) { }
}

function setBookMark(mark) {
    var m1 = mark.split("$");
    var markname = m1[0];
    var tblname = m1[1];
    var fieldName = m1[2];

    var inputValue = window.parent._getCtlValueByFieldName(fieldName);
    var ocxObj = getOcx();

    try {
        var bkmkObj = ocxObj.ActiveDocument.BookMarks(markname);
        var saverange = bkmkObj.Range
        saverange.Text = inputValue;
        ocxObj.ActiveDocument.Bookmarks.Add(markname, saverange);
    }
    catch (e) {
        alert("Word 模板中不存在名称为：\"" + markname +"\"的书签！");
    }

}

function setBookMarkValues(mark) {
    var ocxObj = getOcx();
    if (ocxObj) {
        var m1 = mark.split("$");
        var markname = m1[0];
        var tblname = m1[1];
        var fieldName = m1[2];

        var inputValue = "";
        if (!!window.parent["_sys"]) {
            var _sys = window.parent._sys;
            var field = _sys.getField(fieldName);
            if (!field) return;

            if (field.dispstyle == "023") {
                var fileNames = window.parent._getFileNames(fieldName);
                var arr = [];
                for (var i = 1; i <= fileNames.length; i++) {
                    arr.push(i + "." + fileNames[i - 1]);
                }
                inputValue = arr.join("\r\n");
            }
            else {
                inputValue = _sys.getValue(fieldName);
            }
        }
        else {
            inputValue = window.parent._getCtlValueByFieldName(fieldName);
        }
        inputValue = inputValue == "srkjdslABHSAS" ? "" : inputValue;
        if (inputValue == "") return;
        //alert(markname+"="+inputValue);
        //获取书签集合对象
        var BK = getOcx().ActiveDocument.Bookmarks;
        if (BK.Exists(markname)) {
            getOcx().SetBookmarkValue(markname, inputValue);
        }
    }
}
var newwin, newdoc;
function erropen(retHTML) {
    newwin = window.open("", "_blank", "left=200,top=200,width=400,height=300,status=0,toolbar=0,menubar=0,location=0,scrollbars=1,resizable=1", false);
    newdoc = newwin.document;
    newdoc.open();
    newdoc.write("<html><head><title>返回的数据</title></head><body><center><hr/>")
    newdoc.write(retHTML + "<hr/>");
    newdoc.write("<input type='button' value='关闭窗口' onclick='window.close();'>");
    newdoc.write('</center></body></html>');
    newdoc.close();
}

//当前表单不可编辑,当整个表单只读时调用
function FormDisabled(bool)
{ 
    var formid = document.forms.item(0)
    var elelength = formid.length;
    for (var i=0; i<elelength; i++)
    { formid.elements[i].disabled = bool; }

    //下面是控件标题栏,状态栏,工具栏,菜单栏不显示
    var ocxObj = getOcx();
    ocxObj.TitleBar = !bool;
    ocxObj.Statusbar = !bool;
    ocxObj.ToolBars = !bool;
    ocxObj.Menubar = !bool;
    document.getElementById("editmain_left").style.display = "none";
    document.getElementById("editmain_right").style.width = "95%";
}
//示例程序帮助文档
function NtkoHelp()
{
    window.open("help.htm","help");
}
//编辑文档
function editOffice(fname,newofficetype)
{
    var ocxObj = getOcx();
    //根据文档URL和newofficetype编辑文档,如果有url是编辑已有文档,如果为空根据newofficetype新建文档
    if( (typeof(fname) != "undefined") && (fname != "") )
	{
	    var filename = getValue("fileid");
	    var url = "FileDown.aspx?fileid=" + filename + "&t=" + Math.random() + _cookie;
	    try {
	        if (newofficetype == ".pdf") {

	            //如果是平台版本，可以通过插件打开
                try{
                    ocxObj.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", "4.0.0.1", "NtkoOffice/NTKOOleDocAll.cab", 51, true);
                    ocxObj.BeginOpenFromURL(url);
	            } catch (err) {
	                //浏览器内嵌式打开
	                window.open(url+"&inline=1","_self");
                }
	        }
	        else {
	            ocxObj.BeginOpenFromURL(url);
	        }
        }catch(err){};
	}
    else {
        
        //打开模板
        var mburl = getValue("hiddenMbUrl");
        if (mburl != "") {
            var url = "FileDown.aspx?fileid=" + mburl + "&t=" + Math.random() + _cookie;
            try { ocxObj.BeginOpenFromURL(url); } catch (err) { };
            return;
        }
        //新建文档
        switch (newofficetype) {
            case "1":
                //ocxObj.CreateNew("word.document");//word文档
                try { ocxObj.BeginOpenFromURL("NtkoOffice/blank.doc"); } catch (err) { };
                break
            case "2":
                //ocxObj.CreateNew("excel.sheet");//excel电子表格
                try { ocxObj.BeginOpenFromURL("NtkoOffice/blank.xls"); } catch (err) { };
                break;
            case "3":
                //ocxObj.CreateNew("PowerPoint.Show");//微软幻灯片
                try { ocxObj.BeginOpenFromURL("NtkoOffice/blank.ppt"); } catch (err) { };
                break;
            case "4":
                var ver = ocxObj.GetWPSVer();
                if (ver == 100) {
                    alert("请安装 WPS OFFICE 软件");
                }
                else if (ver == 9) {
                    try { ocxObj.BeginOpenFromURL("NtkoOffice/blank.wps", true, false, "KWPS.Document"); }
                    catch (err) { alert("加载WPS文档时出错"); };
                }
                else {
                    try { ocxObj.BeginOpenFromURL("NtkoOffice/blank.wps", true, false, "WPS.Document"); }
                    catch (err) { alert("加载WPS文档时出错"); };
                }
                //ocxObj.CreateNew("WPS.Document"); //金山文档
                break
            case "5":
                ocxObj.CreateNew("ET.WorkBook"); //金山电子表格
                break;
            default:
                alert("文档编辑出错!");
                break
        }
    }
}
function intializePage(fileUrl)
{
	var ocxObj = getOcx();
	TANGER_OCX_OpenDoc(fileUrl);
	if (!ocxObj.IsNTKOSecSignInstalled()) {   
		document.getElementById("addSecSignFromUrl").disabled = true;
		document.getElementById("addSecSignFromLocal").disabled = true;
		document.getElementById("addSecSignFromEkey").disabled = true;
		document.getElementById("handSecSign").disabled = true;
	}
    if (!ocxObj.IsPDFCreatorInstalled())
	{
	    document.getElementById("savePdfTOUrl").disabled = true;
	}
}
//文档编辑页面关闭事件
function onPageClose()
{
    var ocxObj = getOcx();
    if (IsFileOpened)
    {
	    if(!ocxObj.ActiveDocument.Saved) {
	        var readonly = document.getElementById("hiddenReadonly").value;
	        if (readonly != "1") {
	            if (confirm("文档修改过,还没有保存,是否需要保存?")) {
	                saveFileToUrl();
	            }
	        }
	    }
	}
}

function TANGER_OCX_OpenDoc(fileUrl) {
    var ocxObj = getOcx();
    if(fileUrl!=null||fileUrl!="")
    {
        ocxObj.BeginOpenFromURL(fileUrl);
	}
	else
	{
	    ocxObj.BegingOpenFromURL("templateFile/newWordTemplate.doc")
    }
}

//设置文件是打开还是关闭
function setFileOpenedOrClosed(bool)
{
    var ocxObj = getOcx();
    IsFileOpened = bool;
	fileType = ocxObj.DocType;
}

function trim(str)
{ //删除左右两端的空格
　　return str.replace(/(^\s*)|(\s*$)/g, "");
}
//保存office文档
function saveFileToUrl(saveAlert) {
    var ocxObj = getOcx();
    if (arguments.length == 0)
        saveAlert = true;
    if (ocxObj.ActiveDocument.Saved) {
        ocxObj.CancelLastCommand = true;        
        return;
    }

	var result,filedot,fileName;
	if(IsFileOpened)
	{
	    switch (ocxObj.doctype)
		{
			case 1:
				fileType = "doc";
				filedot=".doc";
				break;
			case 2:
				fileType = "xls";
				filedot=".xls";
				break;
			case 3:
				fileType = "ppt";
				filedot=".ppt";
				break;
			case 4:
				fileType = "vso";
				filedot=".vso"
				break;
			case 5:
				fileType = "pro";
				filedot=".pro";
				break;
			case 6:
				fileType = "wps";
				filedot=".wps";
				break;
			case 7:
				fileType = "et";
				filedot=".et";
				break;
			default :
				fileType = "unkownfiletype";
				filedot=".doc";
        }

        retHTML = ocxObj.saveToURL(savePage + "?filedot=" + filedot + _cookie
		    , "fileObj" //文件域的id，类似<input type=file id=upLoadFile 中的id
		    , ""
            , ""//文件名
            , 0
		    );

		switch (ocxObj.StatusCode) {
		    case 0:
		        if (saveAlert) alert("文件保存成功");
		        ocxObj.ActiveDocument.Saved = true;
		        break;
		    default:
		        //erropen(retHTML);
		        break;
		}
		ocxObj.CancelLastCommand = true;
	}
	else
	{
        alert("不能执行保存,没有编辑文档!");
	}
}

//保存文档为html文件到服务器
function saveFileAsHtmlToUrl() {
    var fileName = trim(getValue("filetitle"));
    if (fileName.length == 0) {
        alert("请输入文件标题!");
        document.getElementById("filetitle").focus();
        return false;}//判断文件标题输入域
	var result,filedot;
	if(IsFileOpened)
	{
	    var ocxObj = getOcx();
	    switch (ocxObj.doctype)
		{
			case 1:
				fileType = "Word.Document";
				filedot=".doc";
				break;
			case 2:
				fileType = "Excel.Sheet";
				filedot=".xls";
				break;
			case 3:
				fileType = "PowerPoint.Show";
				filedot=".ppt";
				break;
			case 4:
				fileType = "Visio.Drawing";
				filedot=".vso"
				break;
			case 5:
				fileType = "MSProject.Project";
				filedot=".pro";
				break;
			case 6:
				fileType = "WPS Doc";
				filedot=".wps";
				break;
			case 7:
				fileType = "Kingsoft Sheet";
				filedot=".et";
				break;
			default :
				fileType = "unkownfiletype";
				filedot=".doc";
		}
        retHTML = ocxObj.PublishAsHTMLToURL(savePage, //提交到的url地址
		"EDITFILE",//文件域的id，类似<input type=file id=upLoadFile 中的id
		"savetype=2&fileType="+fileType,          //与控件一起提交的参数,savetype参数为要保存的文件格式office,html,pdf。filetype参数保存文件类型
		fileName+filedot+".html",    //上传文件的名称，类似<input type=file 的value
		0  //与控件一起提交的表单id，也可以是form的序列号，这里应该是0.
		);
		newwin = window.open("","_blank","left=200,top=200,width=400,height=300,status=0,toolbar=0,menubar=0,location=0,scrollbars=1,resizable=1",false);
		newdoc = newwin.document;
		newdoc.open();
		newdoc.write("<center><hr>"+retHTML+"<hr><input type=button VALUE='关闭窗口' onclick='window.close();if(window.opener){window.opener.location.reload()};'></center>");
		newdoc.close();
		window.opener.focus();
	}
	else
	{
        alert("不能执行保存,没有编辑文档!");	
	}
}

//保护文档为pdf格式
function saveFileAsPdfToUrl() {
    var fileName = trim(getValue("filetitle"));
    if (fileName.length == 0) {
        alert("请输入文件标题!"); document.getElementById("filetitle").focus(); return false;
    }//判断文件标题输入域
	var result,filedot;
	var ocxObj = getOcx();
	if (IsFileOpened && ocxObj.IsPDFCreatorInstalled())
	{
	    switch (ocxObj.doctype)
		{
			case 1:
				fileType = "Word.Document";
				filedot=".doc";
				break;
			case 2:
				fileType = "Excel.Sheet";
				filedot=".xls";
				break;
			case 3:
				fileType = "PowerPoint.Show";
				filedot=".ppt";
				break;
			case 4:
				fileType = "Visio.Drawing";
				filedot=".vso"
				break;
			case 5:
				fileType = "MSProject.Project";
				filedot=".pro";
				break;
			case 6:
				fileType = "WPS Doc";
				filedot=".wps";
				break;
			case 7:
				fileType = "Kingsoft Sheet";
				filedot=".et";
				break;
			default :
				fileType = "unkownfiletype";
				filedot=".doc";
		}
        ocxObj.PublishAsPDFToURL(savePage, //提交到的url地址
		    "EDITFILE",//文件域的id，类似<input type=file id=upLoadFile 中的id
		    "savetype=3&fileType="+fileType,          //与控件一起提交的参数,savetype参数为要保存的文件格式office,html,pdf。filetype参数保存文件类型
		    fileName+filedot,    //上传文件的名称，类似<input type=file 的value
		    0,  //与控件一起提交的表单id，也可以是form的序列号，这里应该是0.
		    null, //sheetname,保存excel的哪个表格
	        true, //IsShowUI,是否显示保存界面
	        false, // IsShowMsg,是否显示保存成功信息
	        false, // IsUseSecurity,是否使用安全特性
	        null, // OwnerPass,安全密码.可直接传值
	        false,//IsPermitPrint,是否允许打印
	        true //IsPermitCopy,是否允许拷贝
		);
	}
	else
	{
        alert("不能执行保存,没有编辑文档或者没有安装PDF虚拟打印机!");	
	}
}

function addServerSecSign() {
	var signUrl = document.getElementById("secSignFileUrl").options[document.getElementById("secSignFileUrl").selectedIndex].value;
	if(IsFileOpened)
	{
	    var ocxObj = getOcx();
	    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)
		{
			try
			{ ocxObj.AddSecSignFromURL("ntko", signUrl); }
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addLocalSecSign(){
	if(IsFileOpened)
	{
	    var ocxObj = getOcx();
	    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)
		{
			try
			{ ocxObj.AddSecSignFromLocal("ntko", ""); }
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addEkeySecSign(){
	if(IsFileOpened)
	{
	    var ocxObj = getOcx();
	    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)
		{
			try
			{ ocxObj.AddSecSignFromEkey("ntko"); }
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addHandSecSign(){
	if(IsFileOpened)
	{
	    var ocxObj = getOcx();
	    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)
		{
			try
			{ ocxObj.AddSecHandSign("ntko"); }
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addServerSign(fileId){
    var signUrl = "FileDown.aspx?fileid=" + fileId + "&t=" + Math.random() + _cookie;
	if(IsFileOpened)
	{
		try
		{
			var ocxObj = getOcx();
			ocxObj.AddSignFromURL("ntko", //印章的用户名
			signUrl,//印章所在服务器相对url
			100,//左边距
			100,//上边距 根据Relative的设定选择不同参照对象
			"ntko",//调用DoCheckSign函数签名印章信息,用来验证印章的字符串
			3,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
			100,//缩放印章,默认100%
			1);   //0印章位于文字下方,1位于上方
				
		}
		catch(error){}
	}		
}

function addLocalSign(){
    var ocxObj = getOcx();
    if (IsFileOpened)
	{
			try
			{
			    ocxObj.AddSignFromLocal("ntko", //印章的用户名
					"",//缺省文件名
					true,//是否提示选择
					100,//左边距
					100,//上边距 根据Relative的设定选择不同参照对象
					"ntko",//调用DoCheckSign函数签名印章信息,用来验证印章的字符串
					3,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
					100,//缩放印章,默认100%
					1);   //0印章位于文字下方,1位于上方
			}
			catch(error){}
	}
}

function addPicFromUrl(picURL){
    var ocxObj = getOcx();
    if (IsFileOpened)
	{
	    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)
		{
			try
			{
			    ocxObj.AddPicFromURL(picURL, //图片的url地址可以时相对或者绝对地址
				false,//是否浮动,此参数设置为false时,top和left无效
				100,//left 左边距
				100,//top 上边距 根据Relative的设定选择不同参照对象
				1,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
				100,//缩放印章,默认100%
				1);   //0印章位于文字下方,1位于上方
				
			}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addPicFromLocal(){
    var ocxObj = getOcx();
    if (IsFileOpened)
	{
		try
		{
			ocxObj.AddPicFromLocal("", //印章的用户名
				true,//缺省文件名
				false,//是否提示选择
				100,//左边距
				100,//上边距 根据Relative的设定选择不同参照对象
				1,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
				100,//缩放印章,默认100%
				1);   //0印章位于文字下方,1位于上方
		}
		catch(error){}
	}
}

function TANGER_OCX_AddDocHeader(strHeader){
    var ocxObj = getOcx();
    if (!IsFileOpened)
	{return;}
	var i,cNum = 30;
	var lineStr = "";
	try
	{
		for(i=0;i<cNum;i++) lineStr += "_";  //生成下划线
		with (ocxObj.ActiveDocument.Application)
		{
			Selection.HomeKey(6,0); // go home
			Selection.TypeText(strHeader);
			Selection.TypeParagraph(); 	//换行
			Selection.TypeText(lineStr);  //插入下划线
			// Selection.InsertSymbol(95,"",true); //插入下划线
			Selection.TypeText("★");
			Selection.TypeText(lineStr);  //插入下划线
			Selection.TypeParagraph();
			//Selection.MoveUp(5, 2, 1); //上移两行，且按住Shift键，相当于选择两行
			Selection.HomeKey(6,1);  //选择到文件头部所有文本
			Selection.ParagraphFormat.Alignment = 1; //居中对齐
			with(Selection.Font)
			{
				NameFarEast = "宋体";
				Name = "宋体";
				Size = 12;
				Bold = false;
				Italic = false;
				Underline = 0;
				UnderlineColor = 0;
				StrikeThrough = false;
				DoubleStrikeThrough = false;
				Outline = false;
				Emboss = false;
				Shadow = false;
				Hidden = false;
				SmallCaps = false;
				AllCaps = false;
				Color = 255;
				Engrave = false;
				Superscript = false;
				Subscript = false;
				Spacing = 0;
				Scaling = 100;
				Position = 0;
				Kerning = 0;
				Animation = 0;
				DisableCharacterSpaceGrid = false;
				EmphasisMark = 0;
			}
			Selection.MoveDown(5, 3, 0); //下移3行
		}
	}
	catch(err){
		alert("错误：" + err.number + ":" + err.description);
	}
	finally{
	}
}

function insertRedHeadFromUrl(fileId){
    var ocxObj = getOcx();
    if (ocxObj.doctype != 1)//ocxObj.doctype=1为word文档
	{return;}
	ocxObj.ActiveDocument.Application.Selection.HomeKey(6,0);//光标移动到文档开头

	var headFileURL = "FileDown.aspx?fileid=" + fileId + "&t=" + Math.random() + _cookie;
	//alert(headFileURL);
	ocxObj.addtemplatefromurl(headFileURL);//在光标位置插入红头文档
}

function openTemplateFileFromUrl(templateUrl,asyncLoad) {
    if(arguments.length == 1)
        asyncLoad=true;
    var url = "FileDown.aspx?fileid=" + templateUrl + "&t=" + Math.random() + _cookie;
    var ocxObj = getOcx();
    try { 
        if(asyncLoad){
            ocxObj.BeginOpenFromURL(url); 
        }
        else{
            ocxObj.OpenFromURL(url);
        }
    }
    catch (err) { };
}

function doHandSign(){
    var ocxObj = getOcx();
    if (ocxObj.doctype == 1 || ocxObj.doctype == 2)//此处设置只允许在word和excel中盖章.doctype=1是"word"文档,doctype=2是"excel"文档
	{
		ocxObj.DoHandSign2(
		    "ntko",//手写签名用户名称
		    "ntko",//signkey,DoCheckSign(检查印章函数)需要的验证密钥。
		    0,//left
		    0,//top
		    1,//relative,设定签名位置的参照对象.0：表示按照屏幕位置插入，此时，Left,Top属性不起作用。1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落（为兼容以前版本默认方式）
		    100);
	}
}

function SetReviewMode(boolvalue){
    var ocxObj = getOcx();
    if (ocxObj.doctype == 1) {
        try{
    		ocxObj.ActiveDocument.TrackRevisions = boolvalue;//设置是否保留痕迹
        }
        catch(e){}
	}
} 

function setShowRevisions(boolevalue){
    var ocxObj = getOcx();
    if (ocxObj.doctype == 1) {
        try{
		    ocxObj.ActiveDocument.ShowRevisions =boolevalue;//设置是否显示痕迹
        }
        catch (e) { }
	}
}

//接受或者取消所有修订
function TANGER_OCX_AllRevisions(bool){
    var ocxObj = getOcx();
    if (bool)
    {
	    ocxObj.ActiveDocument.AcceptAllRevisions();//接受所有的痕迹修订
	}
	else
	{
	    ocxObj.ActiveDocument.Application.WordBasic.RejectAllChangesInDoc();//拒绝所有的痕迹修订
	}
}

function setFilePrint(boolvalue){
    var ocxObj = getOcx();
    ocxObj.fileprint = boolvalue; //是否允许打印
}

function setFileNew(boolvalue){
    var ocxObj = getOcx();
    ocxObj.FileNew = boolvalue; //是否允许新建
}

function setFileSaveAs(boolvalue){
    var ocxObj = getOcx();
    ocxObj.FileSaveAs = boolvalue; //是否允许另存为
}

function setIsNoCopy(boolvalue){
    var ocxObj = getOcx();
    ocxObj.IsNoCopy = boolvalue; //是否禁止粘贴
}

function DoCheckSign(){
   if(IsFileOpened)
   {
       var ocxObj = getOcx();
       var ret = ocxObj.DoCheckSign
		(
		false,/*可选参数 IsSilent 缺省为FAlSE，表示弹出验证对话框,否则，只是返回验证结果到返回值*/
		"ntko"//使用盖章时的signkey,这里为"ntko"
		);//返回值，验证结果字符串
   }
}

function setToolBar(){
    var ocxObj = getOcx();
    ocxObj.ToolBars = !ocxObj.ToolBars;
}

function setMenubar(){
    var ocxObj = getOcx();
    ocxObj.Menubar = !ocxObj.Menubar;
}

function setInsertMemu(){
    var ocxObj = getOcx();
    ocxObj.IsShowInsertMenu = !ocxObj.IsShowInsertMenu;
}

function setEditMenu(){
    var ocxObj = getOcx();
    ocxObj.IsShowEditMenu = !ocxObj.IsShowEditMenu;
}

function setToolMenu(){
    var ocxObj = getOcx();
    ocxObj.IsShowToolMenu = !ocxObj.IsShowToolMenu;
}