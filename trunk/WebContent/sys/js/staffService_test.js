/**
 * init police info
 * @param {*} page_num 
 * @param {*} pageSize_num 
 */
function GetPolice(page_num, pageSize_num, condition) {
    let pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    SelectPoliceNum(pageSize_num, null);
    load.PostData("staff/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        sessionStorage.setItem("pageLimit", pageFilter.pageSize);
        loadTab();
    });

}

/**
 * paging query
 * @param {*} obj 
 */
function PagiNationSelect(obj, cobj) {

    let pageFilter = new Object();

    if (obj != null) {
        let data = eval(obj);
        let page_num = data.curr;

        let pageSize_num = data.limit;
        SelectPoliceNum(pageSize_num, null);

        pageFilter.page = page_num;
        pageFilter.pageSize = pageSize_num;
    }

    if (cobj != null) {
        //搜索条件
        console.log(cobj.conditions);
        pageFilter.page = cobj.pageNum;
        pageFilter.pageSize = cobj.pageSize

        if (sessionStorage.getItem("stationId") != null) {
            if ($("#station_select_ztree").val() == "") {
                cobj.conditions.stationName = "";
                // 清理缓存
                sessionStorage.removeItem("stationId");
            } else {
                cobj.conditions.stationName = sessionStorage.getItem("stationId");
                console.log("/////" + cobj.conditions.stationName);
            }
        }

        // cobj.conditions.code=$("#station_select_ztree").attr("stationId");
        let arr = [
            { "fieldName": "name", "fieldType": "string", "opt": "=", "value": cobj.conditions.policeName },
            { "fieldName": "stationId", "fieldType": "integer", "opt": "=", "value": cobj.conditions.stationName },
            { "fieldName": "code", "fieldType": "string", "opt": "=", "value": cobj.conditions.code },
            { "fieldName": "state", "fieldType": "string", "opt": "=", "value": cobj.conditions.stateId },
            { "fieldName": "positionName", "fieldType": "string", "opt": "=", "value": cobj.conditions.stationId },   
            // { "fieldName": "state", "fieldType": "string", "opt": "=", "value": stateId },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": telNumber },
        ]
        arr = arr.filter((item) => { return item.value !== "" });
        pageFilter.conditions = arr;
        SelectPoliceNum(cobj.pageSize, pageFilter);//给搜索警员数量conditions
        sessionStorage.setItem("search_conditions", JSON.stringify(pageFilter));//刷新所需条件
    }
    // sessionStorage.setItem("conditions",pageFilter)
    load.PostData("staff/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        sessionStorage.setItem("pageLimit", pageFilter.pageSize);
        loadTab();
    });
}

/**
 * query how pages pageNums
 */
function SelectPoliceNum(limitNum, sobj) {
    let pageFilter = new Object();
    let num;
    // let limitNum=sobj.pageSize;
    if (sobj != null) {
        pageFilter = sobj;

    }
    load.PostData("staff/staff/filterCount", pageFilter, function (result) {
        policeNum = result.data; //条
        $("#layui_getSelectNums_btn").html("总共:"+policeNum+"项");
        var y = policeNum % limitNum //余
        var policePageNum = parseInt(policeNum / limitNum); //页
        policePageNum = y > 0 ? policePageNum + 1 : policePageNum;
        if (window.sessionStorage) {
            sessionStorage.setItem("policeNums", policeNum)
            sessionStorage.setItem("pageNums", policePageNum)
        } else {
            alert('This browser does NOT support localStorage');
        }
        console.log("限制:" + limitNum);
        console.log(policeNum + "条");
        console.log(policePageNum + "页" + y + "条");
    });
}

/**
 * edit and save this select condition is edit_id
 */
function AddNewPolice(formData) {
    if (sessionStorage.getItem("edit_id") != null) {
        formData.id = sessionStorage.getItem("edit_id");
    }
    let pageFilter = new Object();
    pageFilter = formData;
    sessionStorage.setItem("skip_stationName", formData.stationId);
    console.log(formData.stationId);
    load.PostData("staff/staff/save", pageFilter, function (result) {
        if (result.message == "Success") {
            if (sessionStorage.getItem("search_conditions") != null) {
                let condition = JSON.parse(sessionStorage.getItem("search_conditions"));
                load.PostData("staff/staff/filter", condition, function (result) {
                    dataPolice = result.data;
                    console.log(dataPolice);
                    sessionStorage.setItem("pageLimit", condition.pageSize);
                    loadTab();
                });
            } else {
                GetPolice(1, 25);
            }
        } else {

        }
    });
}


/**
 * add police load selector
 */
function loadTreeSelect(data) {
    var indDB = new IndexDB();
    indDB.GetData("AllStation", function (datas) {
        _allStations = datas;
        $("#station_select_ztree2").empty();
        for (let item of _allStations) {
            // console.log(eval(item).name + "_" + eval(item).id);
            var op = $("<option></option>");
            op.attr("value", eval(item).id);
            op.append(eval(item).name);
            $("#station_select_ztree2").append(op);
        }
        layui.use('form', function () {
            var form = layui.form;
            if (data != null) {
                $("#station_select_ztree2").val(data.stationId);
            }
            form.render('select', 'add_form');
        });
        if (_allStations == null) {
            _allStations = new Array();
            console.log("null");
            return;
        }
    });
}

/**
 * del police
 */
function deletePolice(policeId) {
    load.PostData("staff/staff/delete", policeId, function (result) {
        if (result.message == "Success") {
            if (sessionStorage.getItem("search_conditions") != null) {
                let condition = JSON.parse(sessionStorage.getItem("search_conditions"));
                load.PostData("staff/staff/filter", condition, function (result) {
                    dataPolice = result.data;
                    console.log(dataPolice);
                    sessionStorage.setItem("pageLimit", condition.pageSize);
                   loadTab();  
                });
            } else {
                GetPolice(1, 25);
            }
        } else {

        }
    });
}


