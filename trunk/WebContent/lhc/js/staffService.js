/**
 * 初始化获取警员信息
 * @param {*} page_num 
 * @param {*} pageSize_num 
 */
function GetPolice(page_num, pageSize_num) {
    let pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    SelectPoliceNum(pageSize_num);
    load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;  
        sessionStorage.setItem("pageLimit",pageFilter.pageSize);  
        laytab.loadTab();  
    });
    
}

/**
 * 分页查询
 * @param {*} obj 
 */
function PagiNationSelect(obj) {
    let data = eval(obj);
    let page_num = data.curr;
    let pageSize_num = data.limit;
    SelectPoliceNum(pageSize_num)
    console.log(page_num);
    let pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        sessionStorage.setItem("pageLimit",pageFilter.pageSize);
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
            sessionStorage.setItem("pageNums",policePageNum)
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
        stationName:'',
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

    },
    methods: {
        policeSearch() {
            console.log()
            console.log(this.roleId)
        }

    },
    mounted: function () {

    }
})
