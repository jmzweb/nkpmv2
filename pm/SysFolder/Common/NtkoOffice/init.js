//请勿修改，否则可能出错
var userAgent = navigator.userAgent,
rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
rFirefox = /(firefox)\/([\w.]+)/,
rOpera = /(opera).+version\/([\w.]+)/,
rChrome = /(chrome)\/([\w.]+)/,
rSafari = /version\/([\w.]+).*(safari)/;

var browser;
var version;
var ua = userAgent.toLowerCase();
function uaMatch(ua) {
    var match = rMsie.exec(ua);
    if (match != null) {
        return { browser: "ie", version: match[2] || "0" };
    }
    var match = rFirefox.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rOpera.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rChrome.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rSafari.exec(ua);
    if (match != null) {
        return { browser: match[2] || "", version: match[1] || "0" };
    }
    return { browser: "", version: "0" };
}

var browserMatch = uaMatch(userAgent.toLowerCase());
if (browserMatch.browser) {
    browser = browserMatch.browser;
    version = browserMatch.version;
}

function addEvent(element, type, handler) {
    if (element.attachEvent) {
        element.attachEvent(type, handler);
    }
    else if (element.addEventListener) {
        element.addEventListener(type, handler, false);
    }
}

if (browser == "ie") {
    document.write('<!-- 用来产生编辑状态的ActiveX控件的JS脚本-->   ');
    document.write('<!-- 因为微软的ActiveX新机制，需要一个外部引入的js-->   ');
    document.write('<object id="TANGER_OCX" classid="clsid:' + _config.classid + '"');
    document.write('codebase="' + _config.codebase + '" width="100%" height="100%">   ');
    document.write('<param name="IsUseUTF8URL" value="-1">   ');
    document.write('<param name="IsUseUTF8Data" value="-1">   ');
    document.write('<param name="BorderStyle" value="1">   ');
    document.write('<param name="BorderColor" value="14402205">   ');
    document.write('<param name="TitlebarColor" value="15658734">   ');
    document.write('<param name="isoptforopenspeed" value="0">   ');

    document.write('<param name="ProductCaption" value="' + _config.caption + '"> ');
    document.write('<param name="ProductKey" value="' + _config.key + '">');

    document.write('<param name="Titlebar" value="0"> ');
    document.write('<param name="Toolbars" value="' + _config.tool + '"> ');
    document.write('<param name="Menubar" value="' + _config.menu + '">');

    document.write('<param name="TitlebarTextColor" value="0">   ');
    document.write('<param name="MenubarColor" value="14402205">   ');
    document.write('<param name="MenuButtonColor" VALUE="16180947">   ');
    document.write('<param name="MenuBarStyle" value="1">   ');
    document.write('<param name="MenuButtonStyle" value="7">   ');
    //document.write('<param name="WebUserName" value="NTKO">   ');
    document.write('<param name="Caption" value="' + _config.title + '">   ');
    document.write('<SPAN STYLE="color:red">不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</SPAN>   ');
    document.write('</object>');

} 
else if (browser == "chrome") {
    document.write('<object id="TANGER_OCX" clsid="{' + _config.classid + '}" ');
    document.write('ForOnSaveToURL="fnFileCommand" ForOnBeginOpenFromURL="OnComplete" ForOnDocumentOpened="fnDocumentOpened"');
    document.write('ForOnpublishAshtmltourl="publishashtml"');
    document.write('ForOnpublishAspdftourl="publishaspdf"');
    document.write('ForOnSaveAsOtherFormatToUrl="saveasotherurl"');
    document.write('ForOnDoWebGet="dowebget"');
    document.write('ForOnDoWebExecute="webExecute"');
    document.write('ForOnDoWebExecute2="webExecute2"');
    document.write('ForOnFileCommand="fnFileCommand"');
    document.write('ForOnCustomFileMenuCmd="fnCustomFileMenuCmd"');
    document.write('ForOnCustomMenuCmd2="fnCustomMenuCmd2"');


    document.write('_ProductCaption="' + _config.caption + '" ');
    document.write('_ProductKey="' + _config.key + '"');

    document.write('codebase="' + _config.codecrx + '" width="100%" height="100%" type="application/ntko-plug" ');
    document.write('_IsUseUTF8URL="-1"   ');
    document.write('_IsUseUTF8Data="-1"   ');
    document.write('_Titlebar="0"   ');
    document.write('_BorderStyle="1"   ');
    document.write('_BorderColor="14402205"   ');
    document.write('_MenubarColor="14402205"   ');
    document.write('_MenuButtonColor="16180947"   ');
    document.write('_MenuBarStyle="1"  ');
    document.write('_MenuButtonStyle="7"   ');
    //document.write('_WebUserName="NTKO"   ');
    document.write('_Caption="' + _config.title + '">    ');
    document.write('<SPAN STYLE="color:red">尚未安装NTKO Web Chrome跨浏览器插件。请 <a style="color:blue;" href="' + _config.codecrx + '">点击</a> 安装组件</SPAN>   ');
    document.write('</object>');
}
else if (browser == "firefox") {
    document.write('<object id="TANGER_OCX" type="application/ntko-plug"  codebase="' + _config.codexpi + '" width="100%" height="100%"');
    document.write('ForOnSaveToURL="fnFileCommand" ForOnBeginOpenFromURL="OnComplete" ForOndocumentopened="fnDocumentOpened"');
    document.write('ForOnpublishAshtmltourl="publishashtml"');
    document.write('ForOnpublishAspdftourl="publishaspdf"');
    document.write('ForOnSaveAsOtherFormatToUrl="saveasotherurl"');
    document.write('ForOnDoWebGet="dowebget"');
    document.write('ForOnDoWebExecute="webExecute"');
    document.write('ForOnDoWebExecute2="webExecute2"');
    document.write('ForOnFileCommand="fnFileCommand"');
    document.write('ForOnCustomFileMenuCmd="fnCustomFileMenuCmd"');
    document.write('ForOnCustomMenuCmd2="fnCustomMenuCmd2"');
    document.write('_IsUseUTF8URL="-1"   ');


    document.write('_ProductCaption="' + _config.caption + '" ');
    document.write('_ProductKey="' + _config.key + '"');

    document.write('_IsUseUTF8Data="-1"   ');
    document.write('_BorderStyle="1"   ');
    document.write('_BorderColor="14402205"   ');
    document.write('_Titlebar="0"   ');
    document.write('_MenubarColor="14402205"   ');
    document.write('_MenuButtonColor="16180947"   ');
    document.write('_MenuBarStyle="1"  ');
    document.write('_MenuButtonStyle="7"   ');
    //document.write('_WebUserName="NTKO"   ');
    document.write('clsid="{' + classid + '}" >');
    document.write('<SPAN STYLE="color:red">尚未安装NTKO Web FireFox跨浏览器插件。请 <a style="color:blue;" href="' + _config.codexpi + '">点击</a> 安装组件</SPAN>   ');
    document.write('</object>   ');

} 
else if (Sys.opera) {
    alert("sorry,ntko web印章暂时不支持opera!");
} 
else if (Sys.safari) {
    alert("sorry,ntko web印章暂时不支持safari!");
}

var TANGER_OCX_OBJ;

function onloaded(filename, dotype) {
    resizeView();
    //插入控件样式自定义菜单
    initMenu();
    window.onresize = resizeView;

    TANGER_OCX_OBJ = getOcx();

    if (!!window.parent) {
        if (!!window.parent["_NtkoLoad"]) {
            window.parent["_NtkoLoad"](window.self, TANGER_OCX_OBJ);
        }
    }
    /*
    addEvent(TANGER_OCX_OBJ, "OnDocumentOpened", fnDocumentOpened);
    addEvent(TANGER_OCX_OBJ, "OnDocumentClosed", fnDocumentClosed);
    addEvent(TANGER_OCX_OBJ, "OnFileCommand", fnFileCommand);
    addEvent(TANGER_OCX_OBJ, "OnCustomFileMenuCmd", fnCustomFileMenuCmd);
    addEvent(TANGER_OCX_OBJ, "OnCustomMenuCmd2", fnCustomMenuCmd2);
    */
    editOffice(filename, dotype);
}

function fnCustomMenuCmd2(menuPos, submenuPos, subsubmenuPos, menuCaption, menuID) {

    if (!!window.parent) {
        if (!!window.parent["_ntkoMenuClick"]) {
            window.parent["_ntkoMenuClick"](window.self, TANGER_OCX_OBJ, menuID);
        }
    }
    if ("全网页查看" == menuCaption) objside();
    if ("恢复原大小" == menuCaption) objside2();
    if ("允许打印" == menuCaption) setFilePrint(true);
    if ("禁止打印" == menuCaption) setFilePrint(false);
    if ("页面设置" == menuCaption) TANGER_OCX_OBJ.showDialog(5);
    if ("打印预览" == menuCaption) TANGER_OCX_OBJ.PrintPreview();

    if ("禁止编辑" == menuCaption) TANGER_OCX_OBJ.SetReadOnly(true);
    if ("允许编辑" == menuCaption) TANGER_OCX_OBJ.SetReadOnly(false);
    
    var tblname = getValue("foldername");
    var yzstr = getValue("hiddenYz");
    var thstr = getValue("hiddenTh");

    if (yzstr != "" && yzstr != null) {
        var sp1 = yzstr.split("$");
        var count = sp1[0];
        var str2 = sp1[1];
        var sp2 = str2.split("|");
        var newsubsubmenuPos = 0;
        for (var i = 0; i < sp2.length; i++) {

            var str3 = sp2[i];
            var sp3 = str3.split(",");
            if (sp3[0] == menuCaption) {
                addServerSign(sp3[1]);

            }
        }
    }
    
    if (thstr != "" && thstr != null) {
        var sp1 = thstr.split("$");
        var count = sp1[0];
        var str2 = sp1[1];
        var sp2 = str2.split("|");
        var newsubsubmenuPos = 0;
        for (var i = 0; i < sp2.length; i++) {
            var str3 = sp2[i];
            var sp3 = str3.split(",");
            if (sp3[0] == menuCaption) {
                //var text = TANGER_OCX_OBJ.ActiveDocument.Content.text;
                var curSel = TANGER_OCX_OBJ.ActiveDocument.Application.Selection;
                //TANGER_OCX_SetMarkModify(false);
                curSel.WholeStory();
                curSel.Cut();

                try {
                    //TANGER_OCX_OBJ.CreateNew("word.document");
                    TANGER_OCX_OBJ.ActiveDocument.Content.Text = "";
                }
                catch (e) {
                    alert(e);
                };
                //传入fileId
                openTemplateFileFromUrl(sp3[1], false);
                //加载表单对应书签值
                var mark = document.getElementById("jstxt").value;
                if (mark != "" && mark != null) {
                    var m = mark.split("|");
                    for (var ix = 0; ix < m.length; ix++) {
                        var m1 = m[ix];
                        if (m1 != "" && m1 != null) {
                            //setBookMark(m1);
                            setBookMarkValues(m1);
                        }
                    }
                }

                try {
                    var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks("正文");
                    var saverange = bkmkObj.Range;
                    saverange.Paste();
                    TANGER_OCX_OBJ.SetBookmarkValue("正文", saverange);
                    //TANGER_OCX_SetMarkModify(true);		
                    //var BK = TANGER_OCX_OBJ.ActiveDocument.Bookmarks; 
                    //if (BK.Exists("正文")) {
                    //TANGER_OCX_OBJ.SetBookmarkValue("正文", text);
                    //}
                }
                catch (e) {
                    //alert("Word 模板中不存在名称为：\"" + markname +"\"的书签！");
                }
            }
        }
    }

    var mbstr = getValue("hiddenMb");
    if (mbstr != "" && mbstr != null) {
        var sp1 = mbstr.split("$");
        if (sp1.length > 1) {
            var count = sp1[0];
            var str2 = sp1[1];
            var sp2 = str2.split("|");
            var newsubsubmenuPos = 0;
            for (var i = 0; i < sp2.length; i++) {
                var str3 = sp2[i];
                var sp3 = str3.split(",");
                if (sp3[0] == menuCaption) openTemplateFileFromUrl(sp3[1]);
            }
        }
    }



    if ("设置修订" == menuCaption) SetReviewMode(true);
    if ("取消修订" == menuCaption) SetReviewMode(false);
    if ("显示痕迹" == menuCaption) setShowRevisions(true);
    if ("隐藏痕迹" == menuCaption) setShowRevisions(false);
}

function fnCustomFileMenuCmd(menuPos, menuCaption, menuID) {
    if (menuID == "1010") {
        window.open(window.location.href, "_blank"); return; 
    }
}

//菜单上自定义按钮事件
function fnCustomButtonOnMenuCmd(btnPos, btnCaption, btnId) {
    if (!!window.parent) {
        if (!!window.parent["_NtkoBtnClick"]) {
            window.parent["_NtkoBtnClick"](window.self, TANGER_OCX_OBJ, btnCaption, btnId);
        }
    }
}

//文档关闭时
function fnDocumentClosed(type, code, html) {
    setFileOpenedOrClosed(false);
}

function fnFileCommand(cmd, canceled) {

    var readonly = getValue("hiddenReadonly");
    if (cmd == 3) {
        if (readonly == 1) {
            alert("文档属性为只读,不能保存!");
        }
        else {
            saveFileToUrl();
        }
        TANGER_OCX_OBJ.CancelLastCommand = true;
    }
}

function OnComplete(type, code, html) {

}

//文档打开之后
function fnDocumentOpened(fPath, doc) {
    setFileOpenedOrClosed(true); //设置文档状态值
    with (TANGER_OCX_OBJ.ActiveDocument)//设置修订显示模式
    {
        try {
            TANGER_OCX_OBJ.ActiveDocument.CommandBars("Reviewing").Enabled = false;
            TANGER_OCX_OBJ.ActiveDocument.CommandBars("Track Changes").Enabled = false;
        } catch (e) { }
    }

    with (TANGER_OCX_OBJ.ActiveDocument.Application)//设置文档所有者名称
    {
        UserName = getValue("hiddenUserName");
    }

    var mark = getValue("hiddenMark");
    if (mark == 0) {
        SetReviewMode(false); //设置文档不在痕迹模式下编辑
        setShowRevisions(false);
    }
    else {
        SetReviewMode(true); //设置文档在痕迹模式下编辑
        setShowRevisions(true);
    }

    var saveas = getValue("hiddenSaveas");
    if (saveas == 1) {
        setFileSaveAs(true);
    }
    else {
        setFileSaveAs(false);
    }

    var filenew = getValue("hiddenFilenew");
    setFileNew(filenew == "1");

    var copy = getValue("hiddenCopy");
    setIsNoCopy(copy != "1");

    var readonly = getValue("hiddenReadonly");
    if (readonly == 0) {
        TANGER_OCX_OBJ.SetReadOnly(false);
    }
    else {
        TANGER_OCX_OBJ.Toolbars = false;
        TANGER_OCX_OBJ.Menubar = true;
        TANGER_OCX_OBJ.SetReadOnly(true);
    }

    var print = getValue("hiddenPrint");
    setFilePrint(print == 1);

    var fullscrn = getValue("hiddenFullScrn");
    TANGER_OCX_OBJ.FullScreenMode = fullscrn == "1";
    
    //如果从服务器上打开文件
    if (fPath.toLowerCase().indexOf(".aspx") > -1) {
        //saved属性用来判断文档是否被修改过,文档打开的时候设置成ture,当文档被修改,自动被设置为false,该属性由office提供.	
        TANGER_OCX_OBJ.ActiveDocument.Saved = true;

        if (2 == TANGER_OCX_OBJ.DocType) {
            try {
                TANGER_OCX_OBJ.ActiveDocument.Application.ActiveWorkbook.Saved = true;
            } catch (e) {
                alert("错误：" + err.number + ":" + err.description);
            }
        }
    }
}

function publishashtml(type, code, html) {
    alert(html);
    alert("Onpublishashtmltourl成功回调");
}

function publishaspdf(type, code, html) {
    alert(html);
    alert("Onpublishaspdftourl成功回调");
}

function saveasotherurl(type, code, html) {
    alert(html);
    alert("SaveAsOtherformattourl成功回调");
}

function dowebget(type, code, html) {
    alert(html);
    alert("OnDoWebGet成功回调");
}

function webExecute(type, code, html) {
    alert(html);
    alert("OnDoWebExecute成功回调");
}

function webExecute2(type, code, html) {
    alert(html);
    alert("OnDoWebExecute2成功回调");
}

function initMenu() {
    var myobj = getOcx();
    var crt = getValue("hiddenControl");
    if (crt == 1) {
        for (var menuPos = 0; menuPos <= 3; menuPos++) {
            if (menuPos == -1) {
                myobj.AddCustomMenu2(menuPos, "打印控制" + "(&" + menuPos + ")");
                for (var submenuPos = 0; submenuPos < 4; submenuPos++) {
                    if (0 == submenuPos)//增加菜单项目
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "允许打印", false);
                    if (1 == submenuPos)//增加菜单项目
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "禁止打印", false);
                    if (2 == submenuPos)//增加菜单项目
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "页面设置", false);
                    if (3 == submenuPos)//增加菜单项目
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "打印预览", false);
                }
            }
            else if (menuPos == 0) {
                if (window.top != window.self) {
                    myobj.AddFileMenuItem("在新窗口打开", false, true, 1010);
                    myobj.AddFileMenuItem("", true);
                }
            }
            else if (menuPos == 1) {
                myobj.AddCustomMenu2(menuPos, "印章管理" + "(&" + menuPos + ")");
                var yzstr = document.getElementById("hiddenYz").value;
                if (yzstr != "" && yzstr != null) {
                    var sp1 = yzstr.split("$");
                    if (sp1.length > 1) {
                        var count = sp1[0];
                        var str2 = sp1[1];
                        var sp2 = str2.split("|");
                        for (var submenuPos = 0; submenuPos < sp2.length; submenuPos++) {
                            var str3 = sp2[submenuPos];
                            var sp3 = str3.split(",");
                            myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, sp3[0], false);

                        }
                    }
                }
                else {
                    myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "无", false);
                }
            }
            else if (menuPos == 2) {
                myobj.AddCustomMenu2(menuPos, "套红模板" + "(&" + menuPos + ")");
                for (var submenuPos = 0; submenuPos < 2; submenuPos++) {
                    if (0 == submenuPos)//增加菜单项目
                    {
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, true, "选择套红", false);
                        var thstr = document.getElementById("hiddenTh").value;

                        //增加子菜单项目
                        if (thstr != "" && thstr != null) {
                            var sp1 = thstr.split("$");
                            if (sp1.length > 1) {
                                var count = sp1[0];
                                var str2 = sp1[1];
                                var sp2 = str2.split("|");
                                for (var i = 0; i < sp2.length; i++) {
                                    var str3 = sp2[i];
                                    var sp3 = str3.split(",");
                                    myobj.AddCustomMenuItem2(menuPos, submenuPos, i, false,
										    sp3[0], false, menuPos * 100 * submenuPos * 20 + i);
                                }
                            }
                        }
                        else {
                            myobj.AddCustomMenuItem2(menuPos, submenuPos, 0, false,
			                        "无", false, menuPos * 100 * submenuPos * 20 + 0);
                        }
                    }
                    if (1 == submenuPos)//增加菜单项目
                    {
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, true, "选择模板", false);
                        var mbstr = document.getElementById("hiddenMb").value;

                        //增加子菜单项目
                        if (mbstr != "" && mbstr != null) {
                            var sp1 = mbstr.split("$");
                            if (sp1.length > 1) {
                                var count = sp1[0];
                                var str2 = sp1[1];
                                var sp2 = str2.split("|");
                                for (var i = 0; i < sp2.length; i++) {
                                    var str3 = sp2[i];
                                    var sp3 = str3.split(",");
                                    myobj.AddCustomMenuItem2(menuPos, submenuPos, i, false,
			                            sp3[0], false, menuPos * 100 * submenuPos * 20 + i);
                                }
                            }
                        }
                        else {
                            myobj.AddCustomMenuItem2(menuPos, submenuPos, 0, false,
			                        "无", false, menuPos * 100 * submenuPos * 20 + 0);
                        }
                    }

                }
            }
            else if (menuPos == 3) {
                myobj.AddCustomMenu2(menuPos, "痕迹保留" + "(&" + menuPos + ")");
                for (var submenuPos = 0; submenuPos < 4; submenuPos++) {

                    if (0 == submenuPos)
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "设置修订", false);
                    else if (1 == submenuPos)
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "取消修订", false);
                    else if (2 == submenuPos)
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "显示痕迹", false);
                    else if (3 == submenuPos)
                        myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, false, "隐藏痕迹", false);
                }
            }
        }
    }
    else {
        var count = 0;
        if (getOcx().DocType == 1) //word 
        {
            var shapes = getOcx().ActiveDocument.shapes;
            for (i = 1; i <= shapes.Count; i++) {
                //如果是控件,判断控件类型 
                if (shapes(i).Type == 12) {
                    //设置印章打印模式不打印印章，1是打印黑白电子印章，2是打印原始印章
                    shapes(i).OLEFormat.object.SetPrintMode(0);
                }

            }
        }

    }
    var mburl = document.getElementById("hiddenMbUrl").value;
    var mbload = document.getElementById("hiddenMbLoad").value;
    if (mburl != "" && mburl != null) {
        if (mbload != "1") {
            document.getElementById("hiddenMbLoad").value = 1;
            openTemplateFileFromUrl(mburl);
        }
    }
}

//增加自定义菜单
function initCustomMenus1() {
    var myobj = getOcx();
    for (var menuPos = 0; menuPos < 1; menuPos++) {
        myobj.AddCustomMenu2(menuPos, "常用功能" + "(&" + menuPos + ")");
        for (var submenuPos = 0; submenuPos < 1; submenuPos++) {
            myobj.AddCustomMenuItem2(menuPos, submenuPos, -1, true, "打印设置", false);
            //增加子菜单项目
            for (var subsubmenuPos = 0; subsubmenuPos < 3; subsubmenuPos++) {
                if (0 == subsubmenuPos)//增加子菜单项目
                {
                    myobj.AddCustomMenuItem2(menuPos, submenuPos, subsubmenuPos, false,
							"设置打印区域", false, menuPos * 100 + submenuPos * 20 + subsubmenuPos);
                }
                if (1 == subsubmenuPos)//增加子菜单项目
                {
                    myobj.AddCustomMenuItem2(menuPos, submenuPos, subsubmenuPos, false,
							"取消打印区域", false, menuPos * 100 + submenuPos * 20 + subsubmenuPos);
                }
                if (2 == subsubmenuPos) {
                    myobj.AddCustomMenuItem2(menuPos, submenuPos, subsubmenuPos, false,
							"手写批注", false, menuPos * 100 + submenuPos * 20 + subsubmenuPos);
                }
            }
        }
    }
}

//改变控件大小为当前网页可见区域
function objside() {
    var ocxObj = getOcx();
    ocxObj.style.position = "absolute";
    ocxObj.style.left = "0px";
    ocxObj.style.top = "0px";
    ocxObj.style.width = document.body.clientWidth; //网页可见区域宽
    ocxObj.style.height = document.body.clientHeight; //网页可见区域高
}

//恢复控件显示大小
function objside2() {
    var ocxObj = getOcx();
    ocxObj.style.position = "relative";
    ocxObj.style.left = "0px";
    ocxObj.style.top = "0px";
    ocxObj.style.width = "100%";
    ocxObj.style.height = "980px";
}

//显示或隐藏文档控件对象
function ObjectDisplay(boolvalue) {
    var obj = document.getElementById("objside");
    if (!boolvalue)
        obj.style.display = "none";
    else
        obj.style.display = "block";
}