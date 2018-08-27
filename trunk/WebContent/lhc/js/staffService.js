/**
 * 初始化获取警员信息
 * @param {*} page_num 
 * @param {*} pageSize_num 
 */
function GetPolice(page_num, pageSize_num) {
    let pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        laytab.loadTab();   
    });
}

/**
 * 分页查询
 * @param {*} obj 
 */
function PagiNationSelect(obj){
    let data=eval(obj);
    let page_num=data.curr;
    let pageSize_num=data.limit;
    console.log(page_num);
    let pageFilter=new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        laytab.loadTab();   
    });
}



/**
 * 条件查询
 */
const vue=new Vue({
    el:".search_bar",
    data:{
        //警员名称
        policeName:'',
        //岗位下拉列表
        allStations:[{id:1,name:'无岗位'},{id:2,name:'警员'},{id:3,name:'值班领导'}],
        stationId:'',
        //角色下拉列表
        allRoles:[{id:1,name:'通信'},{id:2,name:'值班长'},{id:3,name:'指挥车'}],
        roleId:'',
        //当前班下拉列表
        allDutys:[{id:1,name:'领导'},{id:2,name:'正班'},{id:3,name:'副班'}],
        dutyId:'',
        //状态下拉列表
        allStates:[{id:1,name:'待警'},{id:2,name:'110'},{id:3,name:'自接'}],
        stateId:'',
        
    },
    methods:{
        policeSearch(){
            console.log()
            console.log(this.roleId)
        }

    },
    mounted:function(){

    }
})
