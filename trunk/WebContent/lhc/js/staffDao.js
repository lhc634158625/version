function loadData() {}
loadData.prototype.PostData = function (method, data, callback) {
    console.log(data);
    var _serviceUrl = "http://218.85.92.186:8081/api/";
    var datajson = JSON.stringify(data);
    var url = _serviceUrl + method;

    $.ajax({
        cache: false,
        type: "POST",
        async: true,
        headers: { 'token': '20199d83-f9f0-40c3-a103-eade7d1aab2a', "userId": "1" },
        url: url,
        data: datajson, // JSON.stringify(obj),
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            console.log(result.data);
            callback(result);
        }

    });
}
//加载数据
var load = new loadData();