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

                /*分页条共同class*/
                /* .layui-laypage-default {

                } */

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




                .layui-laypage a,
                .layui-laypage span {
                    margin: 0 100px 5px 100px;
                    border: 1px solid blue
                }

                .layui-laypage select {
                    margin: 0 100px 5px 100px;
                }
            </style>
        </head>

        <!--新增警员-->
        <div id="add_police_view" style="display:none">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">输入框</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" required lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码框</label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux">辅助文字</div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">选择框</label>
                    <div class="layui-input-block">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">北京</option>
                            <option value="1">上海</option>
                            <option value="2">广州</option>
                            <option value="3">深圳</option>
                            <option value="4">杭州</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">复选框</label>
                    <div class="layui-input-block">
                        <input type="checkbox" name="like[write]" title="写作">
                        <input type="checkbox" name="like[read]" title="阅读" checked>
                        <input type="checkbox" name="like[dai]" title="发呆">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">开关</label>
                    <div class="layui-input-block">
                        <input type="checkbox" name="switch" lay-skin="switch">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">单选框</label>
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="男" title="男">
                        <input type="radio" name="sex" value="女" title="女" checked>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">文本域</label>
                    <div class="layui-input-block">
                        <textarea name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>

        <body class="layui-layout-body">
            <div class="layui-layout layui-layout-admin">
                <%@ include file="../shared/pageHeader.jsp"%>
                    <div class="layui-body">
                        <!-- 内容主体区域 -->
                        <div>
                            <!--条件查询-->
                            <div class="search_bar">
                                <form @submit.prevent="policeSearch">
                                    <div>
                                        <span>名字:</span>
                                        <input type="text" v-model="policeName" />
                                    </div>
                                    <div>
                                        <span>单位:</span>
                                        <input/>
                                    </div>
                                    <div>
                                        <span>岗位:</span>
                                        <select v-model="stationId">
                                            <option value="">未选择</option>
                                            <option v-for="(station,index) in allStations" :value="station.id" :key="index">{{station.name}}</option>
                                        </select>
                                    </div>
                                    <div>
                                        <span>角色:</span>
                                        <select v-model="roleId">
                                            <option value="">未选择</option>
                                            <option v-for="(role,index) in allRoles" :value="role.id" :key="index">{{role.name}}</option>
                                        </select>
                                    </div>
                                    <div>
                                        <span>当前班:</span>
                                        <select v-model="dutyId">
                                            <option value="">未选择</option>
                                            <option v-for="(duty,index) in allDutys" :value="duty.id" :key="index">{{duty.name}}</option>
                                        </select>
                                    </div>
                                    <div>
                                        <span>状态:</span>
                                        <select v-model="stateId">
                                            <option value="">未选择</option>
                                            <option v-for="(state,index) in allStates" :value="state.id" :key="index">{{state.name}}</option>
                                        </select>
                                    </div>
                                    <div>
                                        <span>通信:</span>
                                        <input type="text" />
                                    </div>
                                    <input type="submit" />
                                </form>
                            </div>

                            <!--表格操作,新增,批量-->
                            <div class="layui-btn-group demoTable">
                                <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
                                <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
                                <button class="layui-btn" data-type="isAll">验证是否全选</button>
                                <button class="layui-btn" id="addPolice">新增警员</button>
                            </div>



                            <!-- 分页条 -->
                            <div id="demo7"></div>
                            <!---首页尾页-->
                            <span id="first_page_btn" class="layui-btn layui-btn-primary layui-btn-sm">首页</span>
                            <span id="last_page_btn" class="layui-btn layui-btn-primary layui-btn-sm">尾页</span>


                            <table class="layui-table" lay-data="{width: 1800, page:false, id:'idTest'}" lay-filter="demo">
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

                                        <th lay-data="{field:'deviceInfos', width:123, toolbar: '#barDemo3'}">设备</th>

                                        <th lay-data="{field:'state', width:100,}">当前状态</th>
                                        <th lay-data="{width:123,align:'center', toolbar: '#barDemo1'}">排班情况</th>
                                        <th lay-data="{width:123,align:'center', toolbar: '#barDemo2'}">工作日志</th>

                                    </tr>
                                </thead>
                            </table>

                        </div>
                    </div>
            </div>
            <script type="text/html" id="barDemo" style="width:200px">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="barDemo1" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">排班情况</a>
            </script>
            <script type="text/html" id="barDemo2" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">工作日志</a>
            </script>
            <script type="text/html" id="barDemo3" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">设备编号</a>
            </script>
            <script src="./js/vue.js"></script>
            <script src="../My97DatePicker/WdatePicker.js"></script>
            <script src="../js/layui2/layui.js"></script>
            <script src="./js/staffService.js"></script>
            <script src="./js/staffDao.js"></script>
            <script>

                var data_lists;
                //警员数据
                var dataPolice = [];
                //每页限制条数
                var pageLimit = 25;
                //
                var policeNum;
                var y;
                var policePageNum;



                //jq初始化加载 
                $(function () {
                    // laytab.loadTab();//静态
                    // SelectPoliceNum(25);//总数几条
                    SelectPoliceNum(pageLimit)
                    GetPolice(1, 25);//第几页,一页几条      


                });

                function AfterInitial() {
                    stationSelector = new StationSelector();
                    //stationSelector._ismulti=true;
                    stationSelector.Initial();
                }


                //弹出添加警员界面
                $('#addPolice').on('click', function () {
                    layer.open({
                        type: 1,
                        //title:,
                        area: ['600px', '460px'],
                        shade: 0,//遮罩
                        shadeClose: false, //点击遮罩关闭
                        content: $("#add_police_view"),
                    });
                });
                //警员表单提交
                layui.use('form', function () {
                    var form = layui.form;

                    //监听提交
                    form.on('submit(formDemo)', function (data) {
                        //添加ajax
                        AddNewPolice(JSON.stringify(data.field))
                        layer.msg(JSON.stringify(data.field));
                        return false;               
                    });
                });


                //独立分页控件
                //首页尾页按钮,总数显示
                $("#first_page_btn").click(function () {
                    GetPolice(1, pageLimit);
                });
                $("#last_page_btn").click(function () {
                    GetPolice(1, 25);
                });
                // function loadPag(pageNum){
                //分页条
                layui.use(['laypage', 'layer'], function () {
                    console.log("分页条:" + policeNum)
                    var laypage = layui.laypage
                        , layer = layui.layer;
                    //只显示上一页、下一页
                    var laypage = layui.laypage;
                    laypage.render({
                        elem: 'demo7'
                        , count: 5000
                        , first: '首页'
                        , last: '尾页'
                        // , prev: '上'
                        // , next: '下'
                        , layout: ['prev', 'next', 'limit', 'skip']
                        , limit: 25
                        , limits: [25, 50, 100, 150]
                        , jump: function (obj, first) {
                            console.log(obj);
                            if (!first) {
                                layer.msg('第 ' + obj.curr + ' 页');
                                PagiNationSelect(obj);
                                //限制条数加载
                                pageLimit = eval(obj).limit;
                                console.log(eval(obj).limit);
                                SelectPoliceNum(pageLimit)
                                // laytab.loadTab();
                            }
                        }
                    });
                });
                // }



                //layui表格渲染和控制
                function layTab() { }
                layTab.prototype.loadTab = function () {
                    layui.use('table', function () {
                        var table = layui.table;
                        //表格重载,自定义表格与分页
                        table.reload('idTest', {
                            limit: pageLimit,
                            data: dataPolice//dataTest
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

                }
                var laytab = new layTab();




            </script>
        </body>

        </html>