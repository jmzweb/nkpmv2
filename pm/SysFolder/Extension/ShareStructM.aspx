<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShareStructM.aspx.cs" Inherits="NTJT.Web.SysFolder.Extension.ShareStruct"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="iconfont/iconfont.css" rel="stylesheet" />
    <link href="css/zjs.layout.css" rel="stylesheet" />
    <link href="css/ShareStruct.css" rel="stylesheet" />
    <script src="js/jquery.zjs.js"></script>
    <script src="js/m.cselector.config.js"></script>
    <script src="js/m.cselector.2.0.0.js"></script>
    <script src="js/p.jquery.event.drag-1.5.min.js"></script>
    <script src="js/ShareStruct.js"></script>
    <script type="text/javascript">
        $(function () {
            wfinit("1"); 
        });
    </script>
</head>
<body>
<%--    <textarea id="WorkFlowRules" style="height:300px;"></textarea>
    <textarea id="WorkFlowSteps" style="height:300px;"></textarea>--%>
    <div class="wfeditor"></div>
    <input id="PTYPE" type="hidden" />
    <input id="K_AUTOID" type="hidden" />
    <input id="MAXID" type="hidden" />
    <div class="fasttoolbox fasttoolboxleft1">
        <b>新增节点</b>
        <div class="clear10"></div>
        <div class="wfcontrols controls">
            <a class="" clazz="jt">
                <p>
                    <span><i class="iconfont">&#xe61e;</i>集团</span>
                </p>
            </a>
            <a class="" clazz="gs2">
                <p>
                    <span><i class="iconfont">&#xe61e;</i>二级公司</span>
                </p>
            </a>
            <a class="" clazz="gs3">
                <p>
                    <span><i class="iconfont">&#xe61e;</i>三级公司</span>
                </p>
            </a>
            <a class="" clazz="cg">
                <p>
                    <span><i class="iconfont">&#xe61e;</i>参股公司</span>
                </p>
            </a>
            <a class="" clazz="jj">
                <p>
                    <span><i class="iconfont">&#xe61e;</i>基金</span>
                </p>
            </a>
        </div>
        <div class="clear10"></div>
        <a id="fcsubmit" class="btn w100"><i class="iconfont">&#xe63a;</i> 保存</a>
    </div>
    <div class="fasttoolbox fasttoolboxright1">
        <b>节点属性</b>
        <form id="wWorkFlowTemplateStepAdd" class="cform">
            <table border="0" cellpadding="0" cellspacing="0" class="formtable">
                <tr>
                    <td>节点名称：</td>
                </tr>
                <tr>
                    <td>
                        <input id="StepDesc" type="text" rule="length:25" /></td>
                </tr>
                <tr>
                    <td>链接地址：</td>
                </tr>
                <tr>
                    <td>
                        <textarea id="SLink" class="h1"></textarea></td>
                </tr>
<%--                <tr>
                    <td>
                        <input id="ISCtrl" type="text" class="cselectorRadio" mode="" values="|默认,控股,参股"/></td>
                </tr>--%>
                <tr>
                    <td>
                        <input id="clazz" type="text" class="cselectorRadio" mode="" values="jt|集团,gs2|二级,gs3|三级,cg|参股,jj|基金"/></td>
                </tr>
            </table>
        </form>
        <form id="wWorkFlowTemplateRuleAdd" class="cform">
        </form>
        <div class="txtc m20"><a class="btn wfsaveattr">保存节点</a> <a class="btn btn-org wfcancelattr">取消</a></div>
    </div>
</body>
</html>
