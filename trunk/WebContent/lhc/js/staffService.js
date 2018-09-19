/**
 * 初始化获取警员信息
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
        laytab.loadTab();
    });

}

/**
 * 分页查询
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
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": roleId },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": dutyId },
            // { "fieldName": "state", "fieldType": "string", "opt": "=", "value": stateId },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": telNumber },
        ]
        arr = arr.filter((item) => { return item.value !== "" });
        pageFilter.conditions = arr;
        SelectPoliceNum(cobj.pageSize, pageFilter);//给搜索警员数量conditions
    }
    load.PostData("staff/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        sessionStorage.setItem("pageLimit", pageFilter.pageSize);
        laytab.loadTab();//上下也加载   
    });
}

/**
 * 查询警员总条数,总页数
 */
function SelectPoliceNum(limitNum, sobj) {
    let pageFilter = new Object();
    let num;
    // let limitNum=sobj.pageSize;
    if (sobj != null) {
        pageFilter = sobj;

    }
    load.GetPoliceNum("staff/staff/filterCount", pageFilter, function (result) {
        policeNum = result.data; //条
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
 * 添加警员(无id),编辑警员(有id)
 */
function AddNewPolice(formData) {
    if (sessionStorage.getItem("edit_id") != null) {
        formData.id = sessionStorage.getItem("edit_id");
    } 
    let pageFilter = new Object();
    pageFilter = formData;
    sessionStorage.setItem("add_new_name", formData.name);
    console.log(typeof formData.name);
    load.AddPolice("staff/staff/save", pageFilter, function (result) {
        if (result.message == "Success") {
            $("#search_name").val(sessionStorage.getItem("add_new_name"));
            $('#search_btn').trigger("click");
        } else {

        }
    });
}

/**
 * 编辑警员,多一个id
 */
// function UpdatePolice(obj) {
//     let pageFilter = new Object();
//     // $("#emps_table tbody").empty();
//     pageFilter = formData;
//     sessionStorage.setItem("add_new_name", formData.name);
//     load.AddPolice("staff/staff/save", pageFilter, function (result) {
//         if (result.message == "Success") {
//             $("#search_name").val(sessionStorage.getItem("add_new_name"));
//             $('#search_btn').trigger("click");
//         } else {

//         }
//     });
// }

/**
 * 新增警员,加载树的搜索下拉框
 */
function loadTreeSelect() {
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
 * 条件查询下拉
 */
const vue = new Vue({
    el: ".search_bar",
    data: {
        //警员名称
        policeName: '',
        //单位
        stationName: '',
        //岗位下拉列表
        allStations: [{ id: 1, name: '无岗位' }, { id: 2, name: '警员' }, { id: 3, name: '值班领导' }],
        stationId: '',
        //角色下拉列表
        allRoles: [{ id: 1, name: '通信' }, { id: 2, name: '值班长' }, { id: 3, name: '指挥车' }],
        roleId: '',
        //当前班下拉列表
        allDutys: [{ id: 1, name: '领导' }, { id: 2, name: '正班' }, { id: 3, name: '副班' }],
        dutyId: '',
        //状态下拉列表
        allStates: [{ id: 1, name: '待警' }, { id: 2, name: '110' }, { id: 3, name: '自接' }],
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
