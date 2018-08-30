
var _serviceUrl = "http://218.85.92.186:8081/api/";
var tokenCode='63506c19-d281-41e2-87fd-89b6d3aa2794';


function loadData() {}

/**
 * 警员搜索
 * @param {*} method 
 * @param {*} data 
 * @param {*} callback 
 */
loadData.prototype.PostData = function (method, data, callback) {
    console.log(data);   
    let datajson = JSON.stringify(data);
    let url = _serviceUrl + method;

    $.ajax({
        cache: false,
        type: "POST",
        async: true,
        headers: { 'token': tokenCode, "userId": "0" },
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

/**
 * 查询警员数量
 * @param {*} method 
 * @param {*} data 
 * @param {*} callback 
 */
loadData.prototype.GetPoliceNum=function (method, data, callback) {
    console.log(data);   
    let datajson = JSON.stringify(data);
    let url = _serviceUrl + method;

    // let promise=new promise((resolve,reject)=>{
    //     $.ajax({
    //         cache: false,
    //         type: "POST",
    //         async: true,
    //         headers: { 'token': tokenCode, "userId": "1" },
    //         url: url,
    //         data: datajson, // JSON.stringify(obj),
    //         contentType: "application/json",
    //         dataType: "json",
    //         success: function (result) {
    //             console.log(result.data);
    //             callback(result);
    //         }
    
    //     });
    // })
    // return promise

    $.ajax({
        cache: false,
        type: "POST",
        async: true,
        headers: { 'token': tokenCode, "userId": "0" },
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



var dataTest=[
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