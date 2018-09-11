/**
 * 初始化获取警员信息
 * @param {*} page_num 
 * @param {*} pageSize_num 
 */
function GetPolice(page_num, pageSize_num, condition) {
    let pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    SelectPoliceNum(pageSize_num);
    load.PostData("sys/staff/filter", pageFilter, function (result) {
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
        SelectPoliceNum(pageSize_num)

        pageFilter.page = page_num;
        pageFilter.pageSize = pageSize_num;
    }

    if (cobj != null) {
        //搜索条件
        console.log(cobj.conditions);
        pageFilter.page=cobj.pageNum;
        pageFilter.pageSize=cobj.pageSize
        let arr = [
            { "fieldName": "name", "fieldType": "string", "opt": "=", "value": cobj.conditions.policeName },
            { "fieldName": "stationId", "fieldType": "integer", "opt": "=", "value": cobj.conditions.stationName },
            { "fieldName": "code", "fieldType": "string", "opt": "=", "value": cobj.conditions.code },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": roleId },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": dutyId },
            // { "fieldName": "state", "fieldType": "string", "opt": "=", "value": stateId },
            // { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": telNumber },
        ]
        arr=arr.filter((item)=>{return item.value!==""});
        pageFilter.conditions = arr;
        // let datajson = JSON.stringify(data);
        // console.log(datajson);
    }

    load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        sessionStorage.setItem("pageLimit", pageFilter.pageSize);
        laytab.loadTab();//上下也加载   
    });
}


/**
 * 
 */
// function* GetData(){
//     yield SelectPoliceNum(limitNum)
//     yield PagiNationSelect(obj)
// }
// let GD=GetData()
// GD.next

/**
 * 查询警员总条数,总页数
 */
function SelectPoliceNum(limitNum) {
    let pageFilter = new Object();
    let num;
    load.GetPoliceNum("sys/staff/filterCount", pageFilter, function (result) {
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
 * 编辑,添加警员(后端格式,单位下拉树)
 */
function AddNewPolice(formJson) {
    load.AddPolice("sys/staff/save", pageFiler, function (result) {

    });
}



/**
 * 条件查询
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
            //验证条件
            let _serviceUrl = "http://218.85.92.186:8081/api/";
            let result = sessionStorage.getItem("result");
            let dataObj;
            if (result != null) {
                dataObj = eval("(" + result + ")");
                console.log(dataObj)
            }
            let method = "sys/staff/filter";
            let url = _serviceUrl + method;

            console.log("roleId:" + this.roleId);
            // layui.use('form', function () {
            //     var form = layui.form;
            //     form.on('select(myselect)', function (data) {
            //         console.log(data.value.field);
            //         form.render('select');
            //     });
            // });

            //搜索条件
            let data = new Object();
            data.page = 1;
            data.pageSize = 25;
            let arr = [
                { "fieldName": "name", "fieldType": "string", "opt": "=", "value": this.policeName },
                { "fieldName": "station", "fieldType": "string", "opt": "=", "value": this.stationName },
                { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": this.stationId },
                { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": this.roleId },
                { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": this.dutyId },
                { "fieldName": "state", "fieldType": "string", "opt": "=", "value": this.stateId },
                { "fieldName": "pid", "fieldType": "string", "opt": "=", "value": this.telNumber },
            ]
            sessionStorage.setItem("conditions", arr);
            data.conditions = arr;
            let datajson = JSON.stringify(data);
            console.log(datajson);

            //请求
            $.ajax({
                cache: false,
                type: "POST",
                async: true,
                headers: {
                    'token': dataObj.token,
                    "userId": dataObj.id
                },
                url: url,
                data: datajson,
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    console.log(result.data);
                }

            });

        }

    },
    mounted: function () {

    }
})
