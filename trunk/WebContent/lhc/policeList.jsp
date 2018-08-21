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
        </head>

        <body class="layui-layout-body">
            <div class="layui-layout layui-layout-admin">
                <%@ include file="../shared/pageHeader.jsp"%>
                    <%@ include file="../shared/policeStationSchedulingMenu.jsp"%>
                        <div class="layui-body">
                            <!-- 内容主体区域 -->
                            <div>
                                <div class="layui-row layui-col-space1">
                                    <div id="mianBody">
                                        <div class="demoTable">
                                            搜索ID：
                                            <div class="layui-inline">
                                                <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                                            </div>
                                            <button class="layui-btn" data-type="reload">搜索</button>
                                        </div>
                                        <table class="layui-hide" id="LAY_table_user" lay-filter="user">
                                                <th lay-data="{field:'wealth'}">财富</th>
                                        </table>
                                    </div>
                                </div>
                                <%@ include file="../shared/pageFooter.jsp"%>
                            </div>
                        </div>
            </div>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
              </script>
            <script src="../My97DatePicker/WdatePicker.js"></script>
            <script src="../js/layui2/layui.js"></script>
            <script>
                layui.use('table', function () {
                    var table = layui.table;

                    //方法级渲染
                    table.render({
                        elem: '#LAY_table_user'
                        // , url: '/demo/table/user/'
                        , cols: [[
                            { field: 'id', title: 'ID', width: 80,align:"center"}
                            ,{ checkbox: true, fixed: true }
                            , { title: '操作', width: 100,align:"center"}
                            , { field: 'lbtnCode', title: '警号', width: 80,align:"center"}
                            , { field: 'lbtnName', title: '姓名/名称', width: 100,align:"center" }
                            , { field: 'lbtnStation', title: '单位', width: 80,align:"center" }
                            , { field: 'lbtnPosition', title: '岗位', width: 80,align:"center" }
                            , { field: 'lbtnTelephone', title: '电话',width: 80,align:"center" }
                            , { field: 'lbtnLeaderPost', title: '领导职务', width: 100,align:"center" }
                            , { field: 'lbtnNonLeaderPost', title: '非领导职务', width: 100,align:"center" }
                            , { field: 'lbtnIdCode', title: '身份证', width: 80,align:"center" }
                            , { field: 'lbtnRole', title: '角色', width: 80,align:"center" }
                            , { field: 'classify', title: '设备', width: 80,align:"center" }
                            , { field: 'lblCurState', title: '当前状态', width: 100,align:"center" }
                            , { field: 'classify', title: '排班情况', width: 100,align:"center" }
                            , { field: 'classify', title: '作日志证', width: 100,align:"center" }

                        ]]
                        , id: 'testReload'
                        , page: true
                        , height: 355
                        ,data:[
                        {"code":0,"msg":"","count":1000,
                        "data":[{"id":1,"username":"user-0","sex":"女","city":"城市-0","sign":"签名-0","experience":255,"logins":24,"wealth":82830700,"classify":"作家","score":57}
                        ]
                        }]
                        
                    });

                    var $ = layui.$, active = {
                        reload: function () {
                            var demoReload = $('#demoReload');

                            //执行重载
                            table.reload('testReload', {
                                page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                                , where: {
                                    key: {
                                        id: demoReload.val()
                                    }
                                }
                            });
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