/*!
* 基础JS模型 及JS选择器组件 表格、表单/usr/local/tomcat/webapps/root/
*/
//声明zjs命名空间
if (!window.zjs) { zjs = {}; };
if (!window.zjss) { zjss = {} };
if (!window.zjsss) { zjsss = {} };

zjs.cmdurl = "/ajax/Handler.ashx";      //默认命令指向地址  
zjs.fileurl = "/ajax/uploadfile.ashx";  //文件上传地址      

zjs.cmdtype = "POST";                   //默认命令以POST方式处理
zjs.cachePage = 10;                    //表格默认缓存页数 100页 设置为1即可不缓存
zjs.isredirect = true;                 //是否有伪静态 有伪静态时需要处理参数 没有就不需要处理
zjs.treeroot = 0;                       //树根节点默认值 .NET里用的是0 JAVA用的是1 特殊的用的是
zjs.rootdir = "/";                       //静态资源根目录 

zjs.checkrep = function (rep) {         //判断返回的code什么情况下是失败 .NET下0成功 >0都是各种失败  JAVA的是0失败 1成功
    if (rep > 0)
        return true;
    else
        return false;
};

//常用字典 字典格式:0值|1文本, 
zjs.xb = '男,女';
zjs.marital = '未婚,已婚,离异';
zjs.educational = "大专以下,大专,本科,硕士,博士,博士以上"; 
zjs.CorpForm = "有限责任公司,股份有限公司,合伙企业"; 
zjs.FondCorpForm = "契约制,合伙制,公司制";
zjs.FundGradw = "母基金,子基金,专项基金";
zjs.CorpProperty = "国有控股,民营,合资,其他"; 
zjs.Trade = "农/林/牧/渔业,采矿业,制造业,电力/热力/燃气及水生产和供应业,建筑业,批发和零售业,交通运输/仓储和邮政业,住宿和餐饮业,信息传输/软件和信息技术服务业,金融业,房地产业,租赁和商务服务业,科学研究和技术服务业,水利/环境和公共设施管理业,居民服务/修理和其他服务业,教育,卫生和社会工作,文化/体育和娱乐业,公共管理/社会保障和社会组织,国际组织";
zjs.CorpScale = "大型,中型,小型,微型";
zjs.sslx = "诉讼,仲裁,复议,纠纷";
zjs.zxqklx = "涉法涉诉,政策法规遵守,合同约定遵守,职责履行,其他";
zjs.czjgczfs = "现金,物品,技术,其他";
zjs.dzzt = "在职,离职";
zjs.ProType = "0|股权类,1|担保,2|融资租赁";
zjs.MoneySource = "自有资金,基金";
zjs.InvestStyle = "股权,债权,股债混合";
zjs.ProState = "0|正常,1|关注,2|损失";
zjs.ProStage = "0|拟投,1|已投,2|退出";
zjs.ProPoint00 = "0|初选,1|路演,2|初调,3|立项,4|尽调,5|内部评审,6|风评,7|投资谈判,8|投决,9|基金投决,10|协议签订,11|划款条件,12|项目划款";
zjs.ProPoint01 = "20|工商变更,21|委派董监高,22|三会受理登记,23|项目巡查登记,24|项目定期报告,25|重大事项报告,26|增值服务,27|企业报告收集,28|项目待办提醒,29|企业用款监管,30|项目年度审计,31|项目收益,32|风险登记";
zjs.ProPoint02 = "50|项目退出决议,51|项目退出";
zjs.ProPoint10 = "0|初选,2|初调,3|立项,4|尽调,5|风险评审,6|项目评审,10|协议签订,11|抵质押登记办理,12|保证金收取,13|担保费用收取,14|签发放款通知书";
zjs.ProPoint20 = "0|初选,3|立项,4|尽调,8|投决,10|协议签订,12|放款";
zjs.tcfs = "回购,转让,上市,并购重组,清算";
zjs.pjdzt = "完成,中止,终止";
zjs.pspzt = "通过,暂缓,终止";
zjs.jjczqkjs = "LP,GP";
zjs.jjczqkzt = "签约,潜在,意向,其他";
zjs.tjwxyjs = "管理人员,投决委员,风控委员,咨询委员,董事会成员,监事会成员,股东成员";
zjs.jjzjlslx = "借,贷";
zjs.jjsxgzzd = "重大事项";
zjs.pjpscyjs = "评委,列席";
zjs.czjgsj = "实际控制人";
zjs.czjglx = "法人,自然人";
zjs.zjlgjs = "董事,监事,理事,高管";
zjs.qysxgzlx = "法务,担保,抵押,征信,行政处罚,其他";

//常用正则表达式
zjs.validatorRules = {
    "required": {
        "alertText": "* 必填 "
    },
    "equals": {
        "alertText": "* 输入不一致"
    },
    "isnumber": {
        "alertText": "* 无效的数字"
    },
    "length": {
        "alertText": "* 只能输入　@v　个字符"
    },
    "between": {
        "alertText": "* 必须在　@v　之间"
    },
    "phone": {
        "regex": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{7,27})((x|ext|extension)[ ]?[0-9]{1,4})?$/,
        "alertText": "* 无效的电话号码"
    },
    "integer": {
        "regex": /^[\-\+]?\d+$/,
        "alertText": "* 不是有效的整数"
    },
    "zinteger": {
        "regex": /^\d+$/,
        "alertText": "* 请输入数字"
    },
    "number": {
        "regex": /^[\-\+]?(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/,
        "alertText": "* 无效的数字"
    },
    "znumber": {
        "regex": /^(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/,
        "alertText": "* 无效的数字"
    },
    "date": {
        "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/,
        "alertText": "* 无效的日期，格式必需为 YYYY-MM-DD"
    },
    "ipv4": {
        "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
        "alertText": "* 无效的 IP 地址"
    },
    "code": {
        "regex": /\d{17}[\d|X]|\d{15}/,
        "alertText": "* 身份证号格式不正确"
    },
    "money": {
        "regex": /^\d{1,10}(?:\.\d{1,2})?$/,
        "alertText": "* 金额输入错误"
    },
    "email": {
        "regex": /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,
        "alertText": "* 邮件地址无效"
    },
    "url": {
        "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
        "alertText": "* URL错误 如：http://www.uizjs.cn"
    }
};