jQuery.support.cors = true;
var _DataService = {
    UserName: "superadmin",
    PassWord: "abc&lt;&gt;890",
    GetData: function (q,c,p,f) {
        var soapXML =
        "<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
        "<s:Header>" +
            "<h:ServiceCredential xmlns:h=\"http://tempuri.org/\" xmlns=\"http://tempuri.org/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">" +
                "<UserName>" + this.UserName + "</UserName>" +
                "<PassWord>" + this.PassWord + "</PassWord>" +
            "</h:ServiceCredential>" +
        "</s:Header>" +
        "<s:Body xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">" +
            "<QueryData xmlns=\"http://tempuri.org/\">" +
                "<queryCode>" + q + "</queryCode>" +
                "<condStr>" + c + "</condStr>" +
                "<replacePara>" + p + "</replacePara>" +
            "</QueryData>" +
        "</s:Body>" +
        "</s:Envelope>";

        $.ajax({
            url: "http://localhost/eis/dataService.asmx?op=QueryData",
            type: "POST",
            dataType: "xml",
            contentType: "text/xml; charset=utf-8",
            data: soapXML,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('SOAPAction', 'http://tempuri.org/QueryData');
            },

            success: function (data) {
                var t = parseData(data);
                f(t);
            },
            error: function (err) {
                alert("获取数据时出错");
            }

        });

    }
}

function parseData(xml) {
    var data = {rows:[]};
    $("NewDataSet>Table", xml).each(function (i, r) {
        var row = $(r);
        row.children().each(function (i, f) {
            row[f.nodeName]=f.innerText;
        });
        data.rows.push(row);
    });

    return data;
}


