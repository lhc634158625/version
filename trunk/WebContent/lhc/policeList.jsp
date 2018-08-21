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
                                        <table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>
                                    </div>
                                </div>
                                <%@ include file="../shared/pageFooter.jsp"%>
                            </div>
                        </div>
            </div>
            <script src="../My97DatePicker/WdatePicker.js"></script>
            <script src="../js/layui2/layui.js"></script>
            <script>
                layui.use('table', function () {
                    var table = layui.table;

                    //方法级渲染
                    table.render({
                        elem: '#LAY_table_user'
                        , url: '/demo/table/user/'
                        , cols: [[
                            { checkbox: true, fixed: true }
                            , { field: 'id', title: 'ID', width: 80, sort: true, fixed: true }
                            , { field: 'username', title: '用户名', width: 80 }
                            , { field: 'sex', title: '性别', width: 80, sort: true }
                            , { field: 'city', title: '城市', width: 80 }
                            , { field: 'sign', title: '签名' }
                            , { field: 'experience', title: '积分', sort: true, width: 80 }
                            , { field: 'score', title: '评分', sort: true, width: 80 }
                            , { field: 'classify', title: '职业', width: 80 }
                            , { field: 'wealth', title: '财富', sort: true, width: 135 }
                        ]]
                        , id: 'testReload'
                        , page: true
                        , height: 315
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