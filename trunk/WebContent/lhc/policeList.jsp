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

                /* 分页条 */
                #layui-table-page2 {
                    position: absolute;
                    top: -50px;
                    left: 1000px;

                }
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

                                <table class="layui-table" lay-data="{width: 1700, page:true, id:'idTest'}" lay-filter="demo">
                                    <thead>
                                        <tr>
                                            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
                                            <th lay-data="{width:278,align:'center', toolbar: '#barDemo'}">操作</th>
                                            <th lay-data="{field:'id', width:80, sort: true}">警号</th>
                                            <th lay-data="{field:'username', width:100}">姓名/名称</th>
                                            <th lay-data="{field:'sex', width:80, sort: true}">单位</th>
                                            <th lay-data="{field:'city', width:80}">岗位</th>
                                            <th lay-data="{field:'sign', width:160}">电话</th>
                                            <th lay-data="{field:'experience', width:100, sort: true}">领导职位</th>

                                            <th lay-data="{field:'classify', width:100}">非领导职务</th>
                                            <th lay-data="{field:'wealth', width:135, sort: true}">身份证</th>
                                            <th lay-data="{field:'score', width:80, sort: true}">角色</th>
                                            <th lay-data="{field:'score', width:80, sort: true}">设备</th>
                                            <th lay-data="{field:'score', width:100, sort: true}">当前状态</th>

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
            <script src="../My97DatePicker/WdatePicker.js"></script>
            <script src="../js/layui2/layui.js"></script>
            <script>
                // layui.use('table', function () {
                //     var table = layui.table;

                //     //方法级渲染
                //     table.render({
                //         elem: '#LAY_table_user'
                //         // , url: '/demo/table/user/'
                //         , cols: [[
                //             { field: 'id', title: 'ID', checkbox: true, width: 80, align: "center" }
                //             , { field: 'do', title: '操作', width: 100, align: "center" }
                //             , { field: 'lbtnCode', title: '警号', width: 80, align: "center" }
                //             , { field: 'lbtnName', title: '姓名/名称', width: 100, align: "center" }
                //             , { field: 'lbtnStation', title: '单位', width: 80, align: "center" }
                //             , { field: 'lbtnPosition', title: '岗位', width: 80, align: "center" }
                //             , { field: 'lbtnTelephone', title: '电话', width: 80, align: "center" }
                //             , { field: 'lbtnLeaderPost', title: '领导职务', width: 100, align: "center" }
                //             , { field: 'lbtnNonLeaderPost', title: '非领导职务', width: 100, align: "center" }
                //             , { field: 'lbtnIdCode', title: '身份证', width: 80, align: "center" }
                //             , { field: 'lbtnRole', title: '角色', width: 80, align: "center" }
                //             , { field: 'classify', title: '设备', width: 80, align: "center" }
                //             , { field: 'lblCurState', title: '当前状态', width: 100, align: "center" }
                //             , { field: 'arrange', title: '排班情况', width: 100, align: "center" }
                //             , { field: 'workrecord', title: '作日志证', width: 100, align: "center" }

                //         ]]
                //         , id: 'testReload'
                //         , page: true
                //         , height: 355
                //         , data: [
                //             {
                //                 "code": 0, "msg": "", "count": 1000,
                //                 "data": [{ "id": 1, "username": "user-0", "sex": "女", "city": "城市-0", "sign": "签名-0", "experience": 255, "logins": 24, "wealth": 82830700, "classify": "作家", "score": 57 }
                //                 ]
                //             }]

                //     });
                layui.use('table', function () {
                    var table = layui.table;

                    table.reload('idTest', {
                        data: [{ "id": 10000, "username": "user-0", "sex": "女", "city": "城市-0", "sign": "签名-0", "experience": 255, "logins": 24, "wealth": 82830700, "classify": "作家", "score": 57 }, { "id": 10001, "username": "user-1", "sex": "男", "city": "城市-1", "sign": "签名-1", "experience": 884, "logins": 58, "wealth": 64928690, "classify": "词人", "score": 27 }, { "id": 10002, "username": "user-2", "sex": "女", "city": "城市-2", "sign": "签名-2", "experience": 650, "logins": 77, "wealth": 6298078, "classify": "酱油", "score": 31 }, { "id": 10003, "username": "user-3", "sex": "女", "city": "城市-3", "sign": "签名-3", "experience": 362, "logins": 157, "wealth": 37117017, "classify": "诗人", "score": 68 }, { "id": 10004, "username": "user-4", "sex": "男", "city": "城市-4", "sign": "签名-4", "experience": 807, "logins": 51, "wealth": 76263262, "classify": "作家", "score": 6 }, { "id": 10005, "username": "user-5", "sex": "女", "city": "城市-5", "sign": "签名-5", "experience": 173, "logins": 68, "wealth": 60344147, "classify": "作家", "score": 87 }, { "id": 10006, "username": "user-6", "sex": "女", "city": "城市-6", "sign": "签名-6", "experience": 982, "logins": 37, "wealth": 57768166, "classify": "作家", "score": 34 }, { "id": 10007, "username": "user-7", "sex": "男", "city": "城市-7", "sign": "签名-7", "experience": 727, "logins": 150, "wealth": 82030578, "classify": "作家", "score": 28 }, { "id": 10008, "username": "user-8", "sex": "男", "city": "城市-8", "sign": "签名-8", "experience": 951, "logins": 133, "wealth": 16503371, "classify": "词人", "score": 14 }, { "id": 10009, "username": "user-9", "sex": "女", "city": "城市-9", "sign": "签名-9", "experience": 484, "logins": 25, "wealth": 86801934, "classify": "词人", "score": 75 }]
                    });

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