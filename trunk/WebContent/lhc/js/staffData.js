
var _serviceUrl = "http://218.85.92.186:8081/api/";
var result = sessionStorage.getItem("result");
var dataObj;
if (result != null) {
    dataObj = eval("(" + result + ")");
    console.log(dataObj)
}

function loadData() { }
/**
 * 警员数据请求
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



var dataTest = [
    {
        "address": "思明区开元街道深田社区",
        "code": "220130",
        "deviceInfos": "",
        "gender": "男",
        "id": 1,
        "idCode": "350201199001011234",
        "isDel": false,
        "lastPosTime": "2013-04-27T04:00:22Z[UTC]",
        "latitude": 24.472354499999998,
        "leaderPost": "",
        "longitude": 118.08867350000001,
        "name": "周佩荣",
        "nonLeaderPost": "主任科员",
        "pic": "",
        "position": 1,
        "pyCode": "ZPR",
        "regionId": 0,
        "serviceId": 3001458,
        "shiftInfos": "",
        "shiftType": 0,
        "state": "备勤",
        "stationId": 378,
        "telephone": "13012345678",
        "timeType": 6801
    },
    {
        "address": "思明区开元街道溪岸社区",
        "code": "240039",
        "deviceInfos": "",
        "gender": "男",
        "id": 2,
        "idCode": "350201199001011234",
        "isDel": false,
        "lastPosTime": "2013-04-27T08:28:32Z[UTC]",
        "latitude": 24.4543765,
        "leaderPost": "",
        "longitude": 118.073086,
        "name": "曾颖武",
        "nonLeaderPost": "主任科员",
        "pic": "",
        "position": 1,
        "pyCode": "ZYW",
        "regionId": 61,
        "serviceId": 3009103,
        "shiftInfos": "",
        "shiftType": 4,
        "state": "待警",
        "stationId": 373,
        "telephone": "13012345678",
        "timeType": 5246
    },
    {
        "address": "思明区开元街道西边社区",
        "code": "220227",
        "deviceInfos": "",
        "gender": "男",
        "id": 3,
        "idCode": "350201199001011234",
        "lastPosTime": "2013-04-27T05:51:46Z[UTC]",
        "latitude": 24.4598995,
        "leaderPost": "",
        "longitude": 118.094841,
        "name": "黄凌",
        "nonLeaderPost": "主任科员",
        "pic": "",
        "position": 1,
        "pyCode": "HL",
        "regionId": 0,
        "serviceId": 3008989,
        "shiftInfos": "",
        "shiftType": 8,
        "state": "备勤",
        "stationId": 378,
        "telephone": "13012345678",
        "timeType": 6804
    }]