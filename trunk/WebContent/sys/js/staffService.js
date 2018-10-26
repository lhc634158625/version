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
        // loadTab();
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
        laytab.loadTab();
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
                    laytab.loadTab();
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
                    laytab.loadTab();  
                });
            } else {
                GetPolice(1, 25);
            }
        } else {

        }
    });
}


/**
 * search bar of selector
 */
const vue = new Vue({
    el: ".search_bar",
    data: {
        //警员名称
        policeName: '',
        //警号
        code: '',
        //单位
        stationName: '',
        //岗位下拉列表
        allStations:
            [
                { id: 1, name: '无岗位' },
                { id: 2, name: '警员' },
                { id: 3, name: '值班领导' }
            ],
        stationId: '',
        //角色下拉列表
        allRoles:
            [
                { id: 1, name: '管理员' },
                { id: 2, name: '工作指导' },
                { id: 3, name: '分局管理员' },
                { id: 4, name: '科所队管理员' },
                { id: 5, name: '操作员' },
                { id: 6, name: '信通' },
                { id: 7, name: '指挥车' },
                { id: 8, name: '视频巡查席' },
                { id: 9, name: '值班长' },
                { id: 10, name: '特警队管理员' },
                { id: 11, name: '纪检督察' },
                { id: 12, name: '研判' }
            ],
        roleId: '',
        //当前班下拉列表
        allDutys:
            [
                { id: 1, name: '领导' },
                { id: 2, name: '正班' },
                { id: 3, name: '副班' },
                { id: 4, name: '巡逻车' },
                { id: 5, name: '摩托车' },
                { id: 6, name: '下社区班' },
                { id: 7, name: '步巡(高峰站点)' },
                { id: 8, name: '110接处警' },
                { id: 9, name: '一警' },
                { id: 10, name: '二警' },
                { id: 11, name: '三警' }
            ],
        dutyId: '',
        //状态下拉列表
        allStates:
            [
                { id: 1, name: '待警' },
                { id: 2, name: '110' },
                { id: 3, name: '自接' },
                { id: 4, name: '移交' },
                { id: 5, name: '故障' },
                { id: 6, name: '其他勤务' },
                { id: 7, name: '备勤' }
            ],
        stateId: '',
        //通信
        telNumber: '',

    },
    methods: {
        policeSearch() {

        }
    },
    mounted: function () {

    }
})
