/*!
* 基础JS模型 及JS选择器组件 表格、表单/usr/local/tomcat/webapps/root/
*/
//声明zjs命名空间
if (!window.zjs) { zjs = {}; };
if (!window.zjss) { zjss = {} };
if (!window.zjsss) { zjsss = {} };

zjs.cmdurl = "";      //默认命令指向地址  
zjs.fileurl = "";  //文件上传地址      

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
zjs.comeFrom = "0|PC,1|WAP,2|微信";
zjs.sex = '男,女';
zjs.xb = '男,女';
zjs.yesno = '是,否';
zjs.zcolumn = '试用,正式,借调';
zjs.zrank = '初级,中级,高级';
zjs.marital = '未婚,已婚,离异';
zjs.educational = "大专以下,大专,本科,硕士,博士,博士以上"; 

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