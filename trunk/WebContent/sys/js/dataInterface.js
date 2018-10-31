
var _serviceUrl = "http://218.85.92.186:8081/api/";
// var _serviceUrl = "/api/";
var result = sessionStorage.getItem("result");
var dataObj;
if (result != null) {
    dataObj = eval("(" + result + ")");
    console.log(dataObj)
}

function loadData() { }
/**
 * 数据请求
 * @param {*} method 
 * @param {*} data 
 * @param {*} callback 
 */
loadData.prototype.PostData = function (method, data, callback) {

    let datajson = JSON.stringify(data);
    console.log(datajson);
    let url = _serviceUrl + method;

    $.ajax({
        cache: false,
        type: "POST",
        async: true,
        headers: {
            'token': dataObj.token,
            "userId": dataObj.id
        },
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
//加载数据对象
var load = new loadData();


