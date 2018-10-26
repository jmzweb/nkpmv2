<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZJEdit.aspx.cs" Inherits="NTJT.Web.WorkAsp.Extend.ZJEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资金报表</title>
    <link href="/iconfont/iconfont.css" rel="stylesheet" />
    <link href="../../css/zjs.layout.css" rel="stylesheet" />
    <link href="../../css/ZJEdit.css" rel="stylesheet" />
    <script src="../../js/jQuery-2.1.4.min.js"></script> 
    <script src="../../js/jquery.zjs.js"></script>

    <script src='../../js/m.cselector.config.js'></script>
    <script src="../../js/m.cselector.js"></script>

    <link href="../../Css/uploadify-3.2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.uploadify-3.2.js"></script>
    <script type="text/javascript" src="../../js/lhgdialog.min.js"></script>
      
</head>
<body>
    <script src="../../js/p.WdatePicker.js"></script>
    <form id="cwqkzcAdd" class="cform formtable">
        <script type="text/javascript">
            function lxconchange($t, $input, $id) {
                $(".hide").hide();
                if ($id.val() == "年报"||$id.val() == "半年报") {
                    $('#yue').val('').trigger("change");
                    $('#jidu').val('').trigger("change");
                }
                if ($id.val() == "季报") {
                    $(".jdshow").show().trigger("change");
                    $('#yue').val('').trigger("change");
                }
                if ($id.val() == "月报") {
                    $(".ydshow").show().trigger("change");
                    $('#jidu').val('').trigger("change");
                }
            };
            $(function() {
                $(".tabbtns a").click(function() {
                    $(this).addClass("select").siblings().removeClass("select");
                    $(".tabitem").eq($(this).index()).show().siblings().hide();
                    //$(".abs").eq($(this).index()).show().siblings().hide();
                    $('.mb').show();
                });
                $(".tabbtns a").first().trigger("click");
                $('.mb').show();
                var NowDate = new Date();
                var eyear='<%=EditYear %>';
                if(!eyear){
                    $('#nian').val(NowDate.getFullYear());
                }
                $('#yue').val('<%=EditMonth %>').trigger("change");
                $('#jidu').val('<%=EditQueater %>').trigger("change");
            });
        </script>
        <div class="menubar">
            <div class="topnav">
                <span style="margin-left: 5px; display: inline; float: left; line-height: 30px; top: 0px;">
                    <a class='linkbtn' href="javascript:" id="submit">保存</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="javascript:" onclick="_appClose();" id="btnClose" name="btnClose">关闭</a>
                    <em class="split">|</em>
                    <a class='linkbtn' href="../../DownLoad/导入模板下载.rar" target="_blank">下载导入模板</a>
                </span>
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="12" class="" style="width: auto; float: left;margin:10px 0 15px 10px;">
            <tr>
                <td style="width: 80px;text-align:right;">财报类型：</td>
                <td style="width: 230px">
                    <input id="cblx" type="text" rule="length:25" class="cselectorRadio" mode="" 
                        values="年报,半年报,季报,月报" conchange="lxconchange()" value='<%=EditType %>'/>

                </td>

                <td class="wfs4" style="width: 55px;text-align:right;">年度：</td>
                <td class="" style="width: 200px">
                    <input id="nian" type="text" rule="length:25" value='<%=EditYear %>' onclick="WdatePicker({ dateFmt: 'yyyy' })" /></td>
                <td class="wsf4 jdshow hide" style="width: 55px;text-align:right;">季度：</td>
                <td class="w2 jdshow hide" style="width: 200px">
                    <input id="jidu" type="text" rule="length:25" class="cselector" mode="" 
                        values="|-请选择-,第1季度,第2季度,第3季度,第4季度" value='<%=EditQueater %>' /></td>

                <td class="wsf4 ydshow hide" style="width: 55px;text-align:right;">月度：</td>
                <td class="w2 ydshow hide" style="width: 200px">
                    <input id="yue" type="text" rule="length:25" class="cselector" mode="" 
                        values="|-请选择-,01月,02月,03月,04月,05月,06月,07月,08月,09月,10月,11月,12月" value='<%=EditMonth %>' />

                </td>
            </tr>
        </table>
    </form>
     
    <div class="subtitlespt">
        <div class="tabbtns subbtns"><a>资产负债表</a><a>利润表</a><a>现金流量表</a></div>
        <div class="UpA abs">
            <a id="InA1" style="z-index: 100;">
                <input type="file" style="display: none;" name="uploadify1" id="uploadify1" /></a>
            <a id="InA2">
                <input type="file" style="display: none;" name="uploadify2" id="uploadify2" /></a>
            <a id="InA3">
                <input type="file" style="display: none;" name="uploadify3" id="uploadify3" /></a>
        </div>
    </div>
    <div class="tabbox">
        <div class="tabitem">

            <%=tblHTML1 %>
        </div>
        <div class="tabitem">

            <%=tblHTML2 %>
        </div>
        <div class="tabitem">

            <%=tblHTML3 %>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    var AID='<%=MainAID %>';
    var mainid1='<%=appId1 %>';
    var mainid2='<%=appId2 %>';
    var mainid3='<%=appId3 %>';
    var auid = "<% = Session.SessionID %>";
    var auth = "<% = Request.Cookies[FormsAuthentication.FormsCookieName]==null ? string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value %>";
    //保存数据
    jQuery(function () {
    
        if('<%=IsNew %>'==''){ 
        }
        $('#submit').click(function () {
            if($('#cblx').val()==""){
                alert("财报类型不能为空");
                return false;
            } 
            if($('#nian').val()==""){
                alert("年度不能为空");
                return false;
            }
            if($('#cblx').val()!=""){
                if($('#cblx').val()=="季报" && $('#jidu').val()==""){
                    alert("季度不能为空");
                    return false;
                }
                if($('#cblx').val()=="月报" && $('#yue').val()==""){
                    alert("月度不能为空");
                    return false;
                }
            }
            SaveData();

        });
           
        try {$('#uploadify1').uploadify('destroy');}catch(e){}

        $("#uploadify1").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=<%=folderId %>',
            'formData': {appName:"<%=appName1 %>",appId:"<%=appId1 %>",folder:"<%=folder %>",'ASPSESSID': auid, 'AUTHID': auth},
            'buttonText': '导入资产负债表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts':"<%=ext %>",
                'fileSizeLimit': "<%=limit %>",
            'folder': '<%=folder %>',
            //'queueID': 'fileQueue',
            'auto': true,
            'multi': <%=multi %>,
            'overrideEvents':['onUploadSuccess','onQueueComplete','onSelectError'],               
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
               
            } ,
            onQueueComplete:function(){
                //window.location.reload();
                //$("#fileQueue").addClass("hidden");
            },
            onUploadSuccess:function(fileObj,response, data) {
                var fileId=response;
                $.ajax({
                    type: 'post',
                    url: 'ZJEdit.aspx',
                    data: { 't': 'dr','appid':mainid1, 'tblName':'<%=appName1 %>','Code':'<%=Code %>','SType':$('#cblx').val(),"Year":$('#nian').val(),"Quarter":$('#jidu').val(),"Month":$('#yue').val(),'AID':AID ,'Tags':'<%=Tag %>'},
                        success: function (data) {
                            var ret = eval('(' + data + ')');
                            if (ret.success) {
                                var mod = ret.msg;
                                var obj = $('.tabitem').eq(0);
                                //mainid1= mod._AutoID;
                                obj.find("#input02").val(mod.CurrentAssets||"");obj.find("#input03").val(mod.Cash||"");obj.find("#input04").val(mod.JYMonetaryAssets||"");obj.find("#input05").val(mod.NoteReceivable||"");obj.find("#input06").val(mod.Receivables||"");obj.find("#input07").val(mod.AdvancePayment||"");obj.find("#input08").val(mod.InterestReceivable||"");obj.find("#input09").val(mod.DividendReceivable||"");obj.find("#input010").val(mod.OtherReceivables||"");obj.find("#input011").val(mod.Inventory||"");obj.find("#input012").val(mod.NonCurrentAssets||"");obj.find("#input013").val(mod.OtherCurrentAssets||"");obj.find("#input014").val(mod.TotalCurrentAssets||"");obj.find("#input015").val(mod.CurrentLia||"");obj.find("#input016").val(mod.ShortBorrM||"");obj.find("#input017").val(mod.FinancialLiability||"");obj.find("#input018").val(mod.NotePayable||"");obj.find("#input019").val(mod.AccountsPayable||"");obj.find("#input020").val(mod.AdvanceReceipt||"");obj.find("#input021").val(mod.PayrollPayable||"");obj.find("#input022").val(mod.TaxPayable||"");obj.find("#input023").val(mod.InterestPayabl||"");obj.find("#input024").val(mod.DividendsPayable||"");obj.find("#input025").val(mod.OtherPayables||"");obj.find("#input026").val(mod.NoncurrentLia||"");obj.find("#input027").val(mod.OtherCurrentLia||"");obj.find("#input028").val(mod.TotalCurrentLia||"");obj.find("#input029").val(mod.NCurrentAssets||"");obj.find("#input030").val(mod.CSMonetaryAssets||"");obj.find("#input031").val(mod.ExpireInvest||"");obj.find("#input032").val(mod.LongReceivables||"");obj.find("#input033").val(mod.LongEquityInvest||"");obj.find("#input034").val(mod.InvestRealEstate||"");obj.find("#input035").val(mod.FixedAssets||"");obj.find("#input036").val(mod.Construction||"");obj.find("#input037").val(mod.ConstMaterials||"");obj.find("#input038").val(mod.OtherIlliquidAssets||"");obj.find("#input039").val(mod.ClearAssets||"");obj.find("#input040").val(mod.BiologicalAssets||"");obj.find("#input041").val(mod.OilGasAssets||"");obj.find("#input042").val(mod.IntangibleAssets||"");obj.find("#input043").val(mod.ExploitExpend||"");obj.find("#input044").val(mod.Goodwill||"");obj.find("#input045").val(mod.LongoBligation||"");obj.find("#input046").val(mod.DeferredTaxAssets||"");obj.find("#input047").val(mod.TotalIlliquidAssets||"");obj.find("#input048").val(mod.NCurrentLia||"");obj.find("#input049").val(mod.LongTermLoan||"");obj.find("#input050").val(mod.BondPayable||"");obj.find("#input051").val(mod.LongTermPayable||"");obj.find("#input052").val(mod.SpecialPayable||"");obj.find("#input053").val(mod.AnticipationLia||"");obj.find("#input054").val(mod.DeferredTaxLia||"");obj.find("#input055").val(mod.OtherNCurrentLia||"");obj.find("#input056").val(mod.TotalNCurrentLia||"");obj.find("#input057").val(mod.TotalLiability||"");obj.find("#input058").val(mod.Equity||"");obj.find("#input059").val(mod.Capital||"");obj.find("#input060").val(mod.CapitalReserve||"");obj.find("#input061").val(mod.TreasuryStock||"");obj.find("#input062").val(mod.SurplusReserves||"");obj.find("#input063").val(mod.UndistributedProfits||"");obj.find("#input064").val(mod.TotalEquity||"");obj.find("#input065").val(mod.TotalProperty||"");obj.find("#input066").val(mod.Total||"");
                                //obj.find("#input067").val('<%=EmployeeName %>');obj.find("#input068").val(GetTime());

                            } else {
                                if(ret.mag!="")
                                    alert(ret.msg);
                                else
                                    alert("保存失败");
                            }
                        }
                    });
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

        try {$('#uploadify2').uploadify('destroy');}catch(e){}

        $("#uploadify2").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=<%=folderId %>',
            'formData': {appName:"<%=appName2 %>",appId:"<%=appId2 %>",folder:"<%=folder %>",'ASPSESSID': auid, 'AUTHID': auth},
            'buttonText': '导入利润表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 95,
            'fileTypeExts':"<%=ext %>",
                'fileSizeLimit': "<%=limit %>",
            'folder': '<%=folder %>',
            //'queueID': 'fileQueue',
            'auto': true,
            'multi': <%=multi %>,
            'overrideEvents':['onUploadSuccess','onQueueComplete','onSelectError'],
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
            } ,
            onQueueComplete:function(){
                //window.location.reload();
                //$("#fileQueue").addClass("hidden");
            },
            onUploadSuccess:function(fileObj,response, data) {
                var fileId=response;
                $.ajax({
                    type: 'post',
                    url: 'ZJEdit.aspx',
                    data: { 't': 'dr','appid':mainid2, 'tblName':'<%=appName2 %>','Code':'<%=Code %>','SType':$('#cblx').val(),"Year":$('#nian').val(),"Quarter":$('#jidu').val(),"Month":$('#yue').val(),'AID':AID ,'Tags':'<%=Tag %>'},
                        success: function (data) {
                            var ret = eval('(' + data + ')');
                            if (ret.success) {
                                var mod = ret.msg;
                                var obj = $('.tabitem').eq(1);
                                //mainid2= mod._AutoID;
                                obj.find("#input02").val(mod.Taking||"");obj.find("#input03").val(mod.OperatingCosts||"");obj.find("#input04").val(mod.SalesTax||"");obj.find("#input05").val(mod.SellMoney||"");obj.find("#input06").val(mod.ManagerMoney||"");obj.find("#input07").val(mod.FinancialMoney||"");obj.find("#input08").val(mod.PropertyLoss||"");obj.find("#input09").val(mod.AlterationIncome||"");obj.find("#input010").val(mod.InvestIncome||"");obj.find("#input011").val(mod.OtherInvestIncome||"");obj.find("#input012").val(mod.TradingProfit||"");obj.find("#input013").val(mod.NonbusinessIncome||"");obj.find("#input014").val(mod.NonbusinessOutlay||"");obj.find("#input015").val(mod.DisposalLoss||"");obj.find("#input016").val(mod.TotalProfit||"");obj.find("#input017").val(mod.IncomeTaxFee||"");obj.find("#input018").val(mod.NetMargin||"");obj.find("#input019").val(mod.EPS||"");obj.find("#input020").val(mod.BasicEPS||"");obj.find("#input021").val(mod.DilutedEPS||"");
                                //obj.find("#input022").val('<%=EmployeeName %>');obj.find("#input023").val(GetTime());

                            } else {
                                if(ret.mag!="")
                                    alert(ret.msg);
                                else
                                    alert("保存失败");
                            }
                        }
                    });
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

        try {$('#uploadify3').uploadify('destroy');}catch(e){}

        $("#uploadify3").uploadify({
            'swf': '<%=Resource_Root %>/js/uploadify-3.2.swf',
            'uploader': '../../FancyUpload.axd?folderId=<%=folderId %>',
            'formData': {appName:"<%=appName3 %>",appId:"<%=appId3 %>",folder:"<%=folder %>",'ASPSESSID': auid, 'AUTHID': auth},
            'buttonText': '导入现金流量表',
            'buttonImage': '<%=Resource_Root %>/img/common/browser.png',
            'buttonClass': 'flashbtn',
            'height': 24,
            'width': 130,
            'fileTypeExts':"<%=ext %>",
                'fileSizeLimit': "<%=limit %>",
            'folder': '<%=folder %>',
            //'queueID': 'fileQueue',
            'auto': true,
            'multi': <%=multi %>,
            'overrideEvents':['onUploadSuccess','onQueueComplete','onSelectError'],
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
            } ,
            onQueueComplete:function(){
                //window.location.reload();
                //$("#fileQueue").addClass("hidden");
            },
            onUploadSuccess:function(fileObj,response, data) {
                var fileId=response;
                $.ajax({
                    type: 'post',
                    url: 'ZJEdit.aspx',
                    data: { 't': 'dr','appid':mainid3, 'tblName':'<%=appName3 %>','Code':'<%=Code %>','SType':$('#cblx').val(),"Year":$('#nian').val(),"Quarter":$('#jidu').val(),"Month":$('#yue').val(),'AID':AID ,'Tags':'<%=Tag %>'},
                        success: function (data) {
                            var ret = eval('(' + data + ')');
                            if (ret.success) {
                                var mod = ret.msg;
                                var obj = $('.tabitem').eq(2);
                                //mainid3= mod._AutoID;
                                obj.find("#input02").val(mod.RunFlows||"");obj.find("#input03").val(mod.CollectSellLabourC||"");obj.find("#input04").val(mod.RefundsTaxe||"");obj.find("#input05").val(mod.OtherCollectC||"");obj.find("#input06").val(mod.TotalCash||"");obj.find("#input07").val(mod.PaySellLabourC||"");obj.find("#input08").val(mod.PayStaffC||"");obj.find("#input09").val(mod.PayTaxes||"");obj.find("#input010").val(mod.PayOhterC||"");obj.find("#input011").val(mod.OtherPayC||"");obj.find("#input012").val(mod.CashFlowNetAmo||"");obj.find("#input013").val(mod.InvestFlows||"");obj.find("#input014").val(mod.CollecInvestC||"");obj.find("#input015").val(mod.ColInvestIncomeC||"");obj.find("#input016").val(mod.CollPropertyNC||"");obj.find("#input017").val(mod.CollSubsidiaryNC||"");obj.find("#input018").val(mod.CollOtherC||"");obj.find("#input019").val(mod.CollTotalInvesC||"");obj.find("#input020").val(mod.PropertyPC||"");obj.find("#input021").val(mod.InvestPC||"");obj.find("#input022").val(mod.PaySubsidiaryNC||"");obj.find("#input023").val(mod.PayOtherC||"");obj.find("#input024").val(mod.PayTotalInvesC||"");obj.find("#input025").val(mod.InvestNC||"");obj.find("#input026").val(mod.FinancingFlows||"");obj.find("#input027").val(mod.CollInvestC||"");obj.find("#input028").val(mod.CollBorrowC||"");obj.find("#input029").val(mod.CollFinancingC||"");obj.find("#input030").val(mod.ToCollFinancingC||"");obj.find("#input031").val(mod.payDebtC||"");obj.find("#input032").val(mod.InterestOutlayC||"");obj.find("#input033").val(mod.PayFinancingC||"");obj.find("#input034").val(mod.ToPayFinancingC||"");obj.find("#input035").val(mod.FinancingNC||"");obj.find("#input036").val(mod.ChangeImpact||"");obj.find("#input037").val(mod.NetIncrease||"");obj.find("#input038").val(mod.SRemainingSum||"");obj.find("#input039").val(mod.ERemainingSum||"");
                                //obj.find("#input040").val('<%=EmployeeName %>');obj.find("#input041").val(GetTime());

                            } else {
                                if(ret.mag!="")
                                    alert(ret.msg);
                                else
                                    alert("保存失败");
                            }
                        }
                    });
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
        //if (!!window.ActiveXObject || "ActiveXObject" in window)
        //    var a='';
        //else
        //    $('.swfupload').css("margin-left","-39px");

            
    }); 
    function SaveData(){ 
            var Json="";
            $('.tabitem').each(function(i,e){
                if (i == 0) {
                    //if ($(e).find('#input02').val()!="")
                        Json = Json + '{"AID":"'+mainid1+'","CurrentAssets":"' + $(e).find('#input02').val() + '","Cash":"' + $(e).find('#input03').val() + '","JYMonetaryAssets":"' + $(e).find('#input04').val() + '","NoteReceivable":"' + $(e).find('#input05').val() + '","Receivables":"' + $(e).find('#input06').val() + '","AdvancePayment":"' + $(e).find('#input07').val() + '","InterestReceivable":"' + $(e).find('#input08').val() + '","DividendReceivable":"' + $(e).find('#input09').val() + '","OtherReceivables":"' + $(e).find('#input010').val() + '","Inventory":"' + $(e).find('#input011').val() + '","NonCurrentAssets":"' + $(e).find('#input012').val() + '","OtherCurrentAssets":"' + $(e).find('#input013').val() + '","TotalCurrentAssets":"' + $(e).find('#input014').val() + '","CurrentLia":"' + $(e).find('#input015').val() + '","ShortBorrM":"' + $(e).find('#input016').val() + '","FinancialLiability":"' + $(e).find('#input017').val() + '","NotePayable":"' + $(e).find('#input018').val() + '","AccountsPayable":"' + $(e).find('#input019').val() + '","AdvanceReceipt":"' + $(e).find('#input020').val() + '","PayrollPayable":"' + $(e).find('#input021').val() + '","TaxPayable":"' + $(e).find('#input022').val() + '","InterestPayabl":"' + $(e).find('#input023').val() + '","DividendsPayable":"' + $(e).find('#input024').val() + '","OtherPayables":"' + $(e).find('#input025').val() + '","NoncurrentLia":"' + $(e).find('#input026').val() + '","OtherCurrentLia":"' + $(e).find('#input027').val() + '","TotalCurrentLia":"' + $(e).find('#input028').val() + '","NCurrentAssets":"' + $(e).find('#input029').val() + '","CSMonetaryAssets":"' + $(e).find('#input030').val() + '","ExpireInvest":"' + $(e).find('#input031').val() + '","LongReceivables":"' + $(e).find('#input032').val() + '","LongEquityInvest":"' + $(e).find('#input033').val() + '","InvestRealEstate":"' + $(e).find('#input034').val() + '","FixedAssets":"' + $(e).find('#input035').val() + '","Construction":"' + $(e).find('#input036').val() + '","ConstMaterials":"' + $(e).find('#input037').val() + '","OtherIlliquidAssets":"' + $(e).find('#input038').val() + '","ClearAssets":"' + $(e).find('#input038').val() + '","BiologicalAssets":"' + $(e).find('#input040').val() + '","OilGasAssets":"' + $(e).find('#input041').val() + '","IntangibleAssets":"' + $(e).find('#input042').val() + '","ExploitExpend":"' + $(e).find('#input043').val() + '","Goodwill":"' + $(e).find('#input044').val() + '","LongoBligation":"' + $(e).find('#input045').val() + '","DeferredTaxAssets":"' + $(e).find('#input046').val() + '","TotalIlliquidAssets":"' + $(e).find('#input047').val() + '","NCurrentLia":"' + $(e).find('#input048').val() + '","LongTermLoan":"' + $(e).find('#input049').val() + '","BondPayable":"' + $(e).find('#input050').val() + '","LongTermPayable":"' + $(e).find('#input051').val() + '","SpecialPayable":"' + $(e).find('#input052').val() + '","AnticipationLia":"' + $(e).find('#input053').val() + '","DeferredTaxLia":"' + $(e).find('#input054').val() + '","OtherNCurrentLia":"' + $(e).find('#input055').val() + '","TotalNCurrentLia":"' + $(e).find('#input056').val() + '","TotalLiability":"' + $(e).find('#input057').val() + '","Equity":"' + $(e).find('#input058').val() + '","Capital":"' + $(e).find('#input059').val() + '","CapitalReserve":"' + $(e).find('#input060').val() + '","TreasuryStock":"' + $(e).find('#input061').val() + '","SurplusReserves":"' + $(e).find('#input062').val() + '","UndistributedProfits":"' + $(e).find('#input063').val() + '","TotalEquity":"' + $(e).find('#input064').val() + '","TotalProperty":"' + $(e).find('#input065').val() + '","Total":"' + $(e).find('#input066').val()  + '"},';
                    //else
                    //    Json = Json + "{},";
                   
                } else if (i == 1) {
                    //if ($(e).find('#input02').val() != "")
                        Json = Json + '{"AID":"'+mainid2+'","Taking":"' + $(e).find('#input02').val() + '","OperatingCosts":"' + $(e).find('#input03').val() + '","SalesTax":"' + $(e).find('#input04').val() + '","SellMoney":"' + $(e).find('#input05').val() + '","ManagerMoney":"' + $(e).find('#input06').val() + '","FinancialMoney":"' + $(e).find('#input07').val() + '","PropertyLoss":"' + $(e).find('#input08').val() + '","AlterationIncome":"' + $(e).find('#input09').val() + '","InvestIncome":"' + $(e).find('#input010').val() + '","OtherInvestIncome":"' + $(e).find('#input011').val() + '","TradingProfit":"' + $(e).find('#input012').val() + '","NonbusinessIncome":"' + $(e).find('#input013').val() + '","NonbusinessOutlay":"' + $(e).find('#input014').val() + '","DisposalLoss":"' + $(e).find('#input015').val()+ '","TotalProfit":"' + $(e).find('#input016').val()+ '","IncomeTaxFee":"' + $(e).find('#input017').val() + '","NetMargin":"' + $(e).find('#input018').val()+ '","EPS":"' + $(e).find('#input019').val()  + '","BasicEPS":"' + $(e).find('#input020').val() + '","DilutedEPS":"' + $(e).find('#input021').val() + '"},';
                    //else
                    //    Json = Json + "{},";
                    
                } else if (i == 2) {
                    //if ($(e).find('#input02').val() != "")
                        Json = Json + '{"AID":"'+mainid3+'","RunFlows":"' + $(e).find('#input02').val() + '","CollectSel":"' + $(e).find('#input03').val() + '","Refund":"' + $(e).find('#input04').val() + '","OtherColl":"' + $(e).find('#input05').val() + '","TotalCash":"' + $(e).find('#input06').val() + '","PaySell":"' + $(e).find('#input07').val() + '","PayStaffC":"' + $(e).find('#input08').val() + '","PayTaxes":"' + $(e).find('#input09').val() + '","PayOhterC":"' + $(e).find('#input010').val() + '","OtherPayC":"' + $(e).find('#input011').val() + '","CashFlowNetAmo":"' + $(e).find('#input012').val() + '","InvestFlows":"' + $(e).find('#input013').val() + '","CollecInvestC":"' + $(e).find('#input014').val() + '","ColInvestIncomeC":"' + $(e).find('#input015').val() + '","CollPropertyNC":"' + $(e).find('#input016').val() + '","CollSubsidiaryNC":"' + $(e).find('#input017').val() + '","CollOtherC":"' + $(e).find('#input018').val() + '","CollTotalInvesC":"' + $(e).find('#input019').val() + '","PropertyPC":"' + $(e).find('#input020').val() + '","InvestPC":"' + $(e).find('#input021').val() + '","PaySubsidiaryNC":"' + $(e).find('#input022').val() + '","PayOtherC":"' + $(e).find('#input023').val() + '","PayTotalInvesC":"' + $(e).find('#input024').val() + '","InvestNC":"' + $(e).find('#input025').val() + '","FinancingFlows":"' + $(e).find('#input026').val() + '","CollInvestC":"' + $(e).find('#input027').val() + '","CollBorrowC":"' + $(e).find('#input028').val() + '","CollFinancingC":"' + $(e).find('#input029').val() + '","ToCollFinancingC":"' + $(e).find('#input030').val() + '","payDebtC":"' + $(e).find('#input031').val() + '","InterestOutlayC":"' + $(e).find('#input032').val() + '","PayFinancingC":"' + $(e).find('#input033').val() + '","ToPayFinancingC":"' + $(e).find('#input034').val() + '","FinancingNC":"' + $(e).find('#input035').val() + '","ChangeImpact":"' + $(e).find('#input036').val() + '","NetIncrease":"' + $(e).find('#input037').val() + '","SRemainingSum":"' + $(e).find('#input038').val() + '","ERemainingSum":"' + $(e).find('#input039').val() + '"}';
                    //else
                    //    Json = Json + "{}";

                }
            });
            Json = '{"Code":"<%=Code %>","Tags":"<%=Tag %>","Type":"'+$('#cblx').val()+'","Year":"'+$('#nian').val()+'","MainID":"'+AID+'","Quarter":"'+$('#jidu').val()+'","Month":"'+$('#yue').val()+'","data":['+Json+']}';
            $.ajax({
                type: 'post',
                url: 'ZJEdit.aspx',
                data: { 't': 'save', 'JsonData': escape(Json) },
                success: function (data) {
                    var ret = eval('(' + data + ')');
                    if (ret.success) {
                        alert('保存成功')
                        _appClose();
                    }else{
                        if(ret.mag!="")
                            alert(ret.msg);
                    }
                }
            });
        }

        //生成GUID
        function _newGuid() {
            var guid = "";
            for (var i = 1; i <= 32; i++) {
                var n = Math.floor(Math.random() * 16.0).toString(16);
                guid += n;
                if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                    guid += "-";
            }
            return guid;
        }
        function GetTime() {
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1; //js从0开始取 
            var date1 = date.getDate();
            var hour = date.getHours();
            var minutes = date.getMinutes();
            var second = date.getSeconds();
            if (month < 10) {
                month = "0" + month;
            }
            if (date1 < 10) {
                date1 = "0" + date1;
            }
            if (hour < 10) {
                hour = "0" + hour;
            }
            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (second < 10) {
                second = "0" + second;
            }

            var result = year + "-" + month + "-" + date1;
            return result;
        }
        //关闭窗口
        function _appClose(){
            if(!!frameElement){
                if(!!frameElement.lhgDG)
                    frameElement.lhgDG.cancel();
                else{ 
                    if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                        window.parent.CloseLayer();
                    }else if(window.parent.parent.CloseLayer){
                        window.parent.parent.CloseLayer();
                    }
                } 
                window.close();
            }
            else{
                if(window.parent.CloseLayer){//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                    window.parent.CloseLayer();
                }else if(window.parent.parent.CloseLayer){
                    window.parent.parent.CloseLayer();
                }
                // window.close();
            }
        }
</script>


