<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
            <title>警员列表</title>
            <script src="../js/jquery/jquery.js"></script>
            <link rel="stylesheet" href="../layui/css/layui.css">
            <link rel="stylesheet" href="../css/policeStationScheduling.css">

            <style>
                /* 行高 */
                .layui-table-cell {
                    height: 50px;
                }

                /* 表格自带分页条 */
                #layui-table-page2 {
                    position: absolute;
                    top: -50px;
                    left: 1000px;
                    display: none;

                }

                /* 查看后的tr颜色条 */
                /* .layui-table-cell{
                    background-color: #FFEEE8!important;
                } */

                /* 消除边界隐藏 */
                .layui-table-view {
                    position: relative;
                    margin: 10px 0;
                    overflow: visible;
                }
            </style>
        </head>

        <body class="layui-layout-body">
            <div class="layui-layout layui-layout-admin">
                <%@ include file="../shared/pageHeader.jsp"%>
                    <%@ include file="../shared/policeStationSchedulingMenu.jsp"%>
                        <div class="layui-body">
                            <!-- 内容主体区域 -->
                            <div>

                                <div class="layui-btn-group demoTable">
                                    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
                                    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
                                    <button class="layui-btn" data-type="isAll">验证是否全选</button>
                                </div>

                                <div id="demo7"></div>

                                <table class="layui-table" lay-data="{width: 1800, page:true, id:'idTest'}" lay-filter="demo">
                                    <thead>
                                        <tr>
                                            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
                                            <th lay-data="{width:278,align:'center', toolbar: '#barDemo'}">操作</th>
                                            <th lay-data="{field:'code', width:80, sort: true}">警号</th>
                                            <th lay-data="{field:'name', width:100}">姓名/名称</th>
                                            <th lay-data="{field:'gender', width:80}">单位</th>
                                            <th lay-data="{field:'gender', width:80}">岗位</th>
                                            <th lay-data="{field:'telephone', width:160}">电话</th>
                                            <th lay-data="{field:'leaderPost', width:100}">领导职位</th>

                                            <th lay-data="{field:'nonLeaderPost', width:100}">非领导职务</th>
                                            <th lay-data="{field:'idCode', width:135}">身份证</th>
                                            <th lay-data="{field:'gender', width:80}">角色</th>
                                            <th lay-data="{field:'deviceInfos', width:80}">设备</th>
                                            <th lay-data="{field:'state', width:100}">当前状态</th>
                                            <th lay-data="{width:123,align:'center', toolbar: '#barDemo1'}">排班情况</th>
                                            <th lay-data="{width:123,align:'center', toolbar: '#barDemo2'}">工作日志</th>

                                        </tr>
                                    </thead>
                                </table>
                                <%@ include file="../shared/pageFooter.jsp"%>
                            </div>
                        </div>
            </div>
            <script type="text/html" id="barDemo" style="width:200px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="barDemo1" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">排班情况</a>
            </script>
            <script type="text/html" id="barDemo2" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">工作日志</a>
            </script>
            <script src="../My97DatePicker/WdatePicker.js"></script>
            <script src="../js/layui2/layui.js"></script>

            <script>

                var data_lists;

                function initData() { }
                initData.prototype.policeList = function (fromRecord, toRecord, pageSize) {
                    console.log(toRecord);
                    // $.ajax({
                    //     url: "${APP_PATH}/UserOK",
                    //     type: "get",
                    //     data: "empName=" + empName,
                    //     success: function (result) {
                    //         if (result.code == 100) {

                    //         } else {

                    //         }
                    //     },
                    // });
                };
                var init = new initData();

                //jq初始化加载 
                $(function () {
                    init.policeList(1, 1000, 10);
                });



                //layui表格渲染和控制
                layui.use('table', function () {
                        var table = layui.table;
                        //分页
                        var laypage = layui.laypage
                            , layer = layui.layer;
                        laypage.render({
                            elem: 'demo7'
                            , count: 100
                            , layout: ['count', 'prev', "page",'next', 'limit', 'refresh', 'skip']
                            , limit:10
                            , limits:	[25, 50, 100, 150]
                            , groups:1
                            , jump: function (obj) {//回调
                                console.log(obj)
                            }
                        });

                        table.reload('idTest', {
                            // page:true,
                            // limit:10;
                            data: [
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
                        });


                        //分页条
                        // layui.use('laypage', function () {
                        //     var laypage = layui.laypage;
                        //     //执行一个laypage实例
                        //     laypage.render({
                        //         elem: 'layui-laypage-1' //注意，这里的 test1 是 ID，不用加 # 号
                        //         , count: 50 //数据总数，从服务端得到
                        //         ,prev:"上一页"
                        //     });
                        // });
                        //完整功能


                        //监听表格复选框选择
                        table.on('checkbox(demo)', function (obj) {
                            console.log(obj)
                        });
                        //监听工具条
                        table.on('tool(demo)', function (obj) {
                            var data = obj.data;
                            if (obj.event === 'detail') {
                                layer.msg('ID：' + data.id + ' 的查看操作');
                            } else if (obj.event === 'del') {
                                layer.confirm('真的删除行么', function (index) {
                                    obj.del();
                                    layer.close(index);
                                });
                            } else if (obj.event === 'edit') {
                                layer.alert('编辑行：<br>' + JSON.stringify(data))
                            }
                        });

                        var $ = layui.$, active = {
                            getCheckData: function () { //获取选中数据
                                var checkStatus = table.checkStatus('idTest')
                                    , data = checkStatus.data;
                                layer.alert(JSON.stringify(data));
                            }
                            , getCheckLength: function () { //获取选中数目
                                var checkStatus = table.checkStatus('idTest')
                                    , data = checkStatus.data;
                                layer.msg('选中了：' + data.length + ' 个');
                            }
                            , isAll: function () { //验证是否全选
                                var checkStatus = table.checkStatus('idTest');
                                layer.msg(checkStatus.isAll ? '全选' : '未全选')
                            }
                        };

                        $('.demoTable .layui-btn').on('click', function () {
                            var type = $(this).data('type');
                            active[type] ? active[type].call(this) : '';
                        });
                    });
            </script>
        </body>

        </html>