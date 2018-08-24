/**
 * 获取警员信息
 * @param {*} page_num 
 * @param {*} pageSize_num 
 */
function GetPolice(page_num, pageSize_num) {
    var pageFilter = new Object();
    pageFilter.page = page_num;
    pageFilter.pageSize = pageSize_num;
    var list = load.PostData("sys/staff/filter", pageFilter, function (result) {
        dataPolice = result.data;
        laytab.loadTab();   
        // layui.use('table', function () {
        //     var table = layui.table;
        //     table.reload('idTest', {
        //         // page:true,
        //         // limit:10;
        //         data: dataPolice
        //     });
        // });
    });
}
