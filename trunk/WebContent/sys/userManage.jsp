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

    <!-- <link rel="stylesheet" href="./js/ztree/demo.css" type="text/css">
    <link rel="stylesheet" href="./js/ztree/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="./js/ztree/jquery.ztree.core.js"></script> -->

    <style>
        html {
                    font-family: "Times New Roman", Georgia, Serif;
                }

                /* 行高 */
                .layui-table-cell {
                    height: 50px;
                }

                /*分页条共同class*/
                /* .layui-laypage-default {

                } */

                /* 查看后的tr颜色条 */
                /* .layui-table-cell{
                    background-color: #D6DBEC!important;
                } */

                /* 消除边界隐藏 */
                .layui-table-view {
                    position: relative;
                    margin: 10px 0;
                    overflow: visible;
                }

                .layui-laypage a,
                .layui-laypage span {
                    margin: 0px 10px 5px 10px;
                    border: 0px solid blue
                }

                a.layui-laypage-prev {
                    background-color: #3F69BA;
                    color: white;
                }

                a.layui-laypage-next {
                    background-color: #3F69BA;
                    color: white;
                }

                .layui-laypage select {
                    margin: 0 10px 5px 10px;
                }

                .search_bar {
                    font-weight: bolder
                }

                /*表格数据操作按钮*/
                .layui_edit_btn {
                    background-color: #3F69BA;
                    width:50px;
                    height:40px;
                    padding:0px;
                    margin:0px;
                }

                .layui_del_btn {
                    background-color: #90B2F1;
                    width:50px;
                    height:40px;
                    padding:0px;
                }

                .layui-table-cell{
                   padding:0px;
                 }

                /*表格按钮组*/
                #layui_getSelectData_btn {
                    background-color: #3F69BA;
                }

                #layui_getSelectNums_btn {
                    background-color: #90B2F1;
                }

                #layui_allSelect_btn {
                    background-color: #3F69BA;
                }

                #addPolice {
                    background-color: #3F69BA;
                }

                #ztree_select {
                    display: none;
                    overflow: hidden;
                    border: 1px solid #e6e6e6;
                }

                .laytable {
                    position: absolute;
                    left: 0px;
                    top: 100px;
                }

                th {
                    background-color: #90B2F1;
                }

                .page_head_btn {
                    width: 55x;
                    height: 28px;
                    border: 0px solid blue;
                    background-color: #3F69BA;
                    color: white;
                    margin-top: 10px;
                    margin-right: 10px;
                }
                .layui-inline{
                  width:206px;
                }
            </style>
</head>

<!--单位下拉列表-->
<div id="ztree_select">
    <%@ include file="./ztreeCtrl.jsp"%>
</div>

<!--新增警员-->
<div id="add_police_view" style="display:none">
    <form class="layui-form" action="" lay-filter="add_form" id="add_police_form">
        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                    flex-flow:row column nowrap;align-items: center;justify-content :center;
                    height: 38px;"><span
                    style="">警号</span></div>
            <div class="layui-col-md6">
                <input type="text" name="code" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                        height: 38px;"><span
                    style="">姓名/名称</span></div>
            <div class="layui-col-md6">
                <input type="text" name="name" required lay-verify="required" placeholder="请输入标题" autocomplete="off"
                    class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                            height: 38px;"><span
                    style="">单位</span></div>
            <div class="layui-col-md6">
                <!-- <input type="text" name="stationId" required lay-verify="required" placeholder="请输入标题" autocomplete="off"
                    class="layui-input"> -->
                <select name="stationId" lay-filter="stationId" lay-search="" lay-verify="required" id="station_select_ztree2">
                    <option value="">直接选择或搜索选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-col-md3" style="display:-webkit-flex;
                    flex-flow:row column nowrap;align-items: center;justify-content :center;
                    height: 38px;"><span
                    style="">岗位</span></label>
            <div class="layui-col-md6">
                <select name="position" lay-verify="required">
                    <option value=""></option>
                    <option value="0">无岗位</option>
                    <option value="1">警员</option>
                    <option value="2">值班领导</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                                flex-flow:row column nowrap;align-items: center;justify-content :center;
                                height: 38px;"><span
                    style="">电话</span></div>
            <div class="layui-col-md6">
                <input type="text" name="telephone" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                                    flex-flow:row column nowrap;align-items: center;justify-content :center;
                                    height: 38px;"><span
                    style="">领导职务</span></div>
            <div class="layui-col-md6">
                <input type="text" name="leaderPost" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                                        height: 38px;"><span
                    style="">非领导职位</span></div>
            <div class="layui-col-md6">
                <input type="text" name="nonLeaderPost" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-row">
            <div class="layui-col-md3" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                    style="">身份证</span></div>
            <div class="layui-col-md6">
                <input type="text" name="idCode" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <input type="button" class="layui-btn" lay-submit lay-filter="formDemo" style="text-align:center;width:70px;height:50px;background-color:#3F69BA;position:absolute;top:200px;right:40px"
            value="保存" />
</div>

</form>
</div>

<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
        <%@ include file="../shared/pageHeader1.jsp"%>

        <div class="layui-body" style="position: absolute;left:0px;">
            <!-- 内容主体区域 -->
            <div style="position:absolute;top:70px;width: 100%">

                <!--警员列表显示数量-->
                <div class="layui-row">
                </div>
                <!--表格操作,新增,批量-->
                <div class="layui-row">
                    <div class="layui-btn-group demoTable">
                        <!-- <button id="layui_getSelectData_btn" class="layui-btn" data-type="getCheckData">获取选中行数据</button>
                        <button id="layui_getSelectNums_btn" class="layui-btn" data-type="getCheckLength">获取选中数目</button>
                        <button id="layui_allSelect_btn" class="layui-btn" data-type="isAll">验证是否全选</button> -->
                        <button id="layui_getSelectData_btn" class="layui-btn">警员列表</button>
                        <button id="layui_getSelectNums_btn" class="layui-btn"></button>
                        <button class="layui-btn" id="addPolice">新增警员</button>
                    </div>
                </div>

                <!-- 分页条 -->
                <div class="layui-row">
                    <!-- <div class="layui-col-md1 layui-col-md-offset8">
                        <button id="first_page_btn" class="page_head_btn">首页</button>
                        <button id="last_page_btn" class="page_head_btn">尾页</button> 
                    </div> -->
                    <div class="layui-col-md3 layui-col-md-offset9">
                        <div id="demo7"></div>
                    </div>
                </div>

                <!--条件查询-->
                <div class="search_bar" class="layui-row">
                    <form @submit.prevent="" class="layui-form layui-row ">
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <div class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">姓名:</span></div>
                                <div class="layui-col-md10">
                                    <input name="policeName" id="search_name" type="text" v-model="policeName"
                                        autocomplete="off" class="layui-input" />
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <div class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">单位:</span></div>
                                <div class="layui-col-md10">
                                    <input id="station_select_ztree" readonly="readonly" name="stationName" type="text" v-model="stationName"
                                        autocomplete="off" class="layui-input" />
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <div class="layui-col-md2" style="display:-webkit-flex;
                                                flex-flow:row column nowrap;align-items: center;justify-content :center;
                                                height: 38px;"><span
                                        style="">警号:</span></div>
                                <div class="layui-col-md10">
                                    <input name="code" type="text" class="layui-input" autocomplete="off" v-model="code" />
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <div class="layui-col-md2" style="display:-webkit-flex;
                                                flex-flow:row column nowrap;align-items: center;justify-content :center;
                                                height: 38px;"><span
                                        style="">电话:</span></div>
                                <div class="layui-col-md10">
                                    <input name="tel" type="text" class="layui-input" autocomplete="off" v-model="telNumber" />
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">岗位:</span></label>
                                <div class="layui-col-md10">
                                    <select name="stationId" v-model="stationId" lay-filter="myselect1" class="layui-input layui-col-md12">
                                        <option value="">未选择</option>
                                        <option v-for="(station,index) in allStations" :value="station.name" :key="index">{{station.name}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">角色:</span></label>
                                <div class="layui-col-md10">
                                    <select name="roleId" v-model="roleId" lay-filter="myselect2" class="layui-input layui-col-md12">
                                        <option value="">未选择</option>
                                        <option v-for="(role,index) in allRoles" :value="role.name" :key="index">{{role.name}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <label class="layui-col-md3" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">当前班:</span></label>
                                <div class="layui-col-md9">
                                    <select name="dutyId" v-model="dutyId" lay-filter="myselect3" class="layui-input layui-col-md12">
                                        <option value="">未选择</option>
                                        <option v-for="(duty,index) in allDutys" :value="duty.name" :key="index">{{duty.name}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                        style="">状态:</span></label>
                                <div class="layui-col-md10">
                                    <select name="stateId" v-model="stateId" lay-filter="myselect4" class="layui-input layui-col-md12">
                                        <option value="">未选择</option>
                                        <option v-for="(state,index) in allStates" :value="state.name" :key="index">{{state.name}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-item layui-row">
                                <div class="layui-col-md1">
                                    <input type="button" value="搜索" id="search_btn" lay-submit lay-filter="sr" class="layui-btn"
                                        style="margin-left:10px;width:60px;height:35px;background-color:#3F69BA;" />
                                </div>
                            </div>
                        </div>
                        <!-- <div class="layui-inline">
                            <div class="content_wrap">
                                <div class="zTreeDemoBackground left">
                                    <ul class="list">
                                        <li class="title">&nbsp;&nbsp;城市：<input id="citySel" type="text" readonly value=""
                                                style="width:120px;" />
                                            &nbsp;<a id="menuBtn" href="#" onclick="showMenu(); return false;">选择</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
                                <ul id="treeDemo" class="ztree" style="margin-top:0; width:160px;"></ul>
                            </div>
                        </div> -->
                    </form>
                </div>

                <div class="layui-row">
                    <table class="layui-hide" id="list" lay-filter="test"></table>
                    <!-- <table class="layui-table" lay-data="{width: 1980, page:false, id:'idTest'}" lay-filter="demo"
                        lay-size="lg">
                        <thead>
                            <tr>
                                <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
                                <th lay-data="{width:218,align:'center', toolbar: '#barDemo'}">操作</th>
                                <th lay-data="{field:'code', align:'center',width:120}">警号</th>
                                <th lay-data="{field:'name', align:'center',width:150}">姓名/名称</th>

                                <th lay-data="{field:'stationName',align:'center', width:200}">单位</th>
                                <th lay-data="{field:'positionName', align:'center',width:100}">岗位</th>

                                <th lay-data="{field:'telephone', align:'center',width:150}">电话</th>
                                <th lay-data="{field:'leaderPost', align:'center',width:100}">领导职位</th>
                                <th lay-data="{field:'nonLeaderPost', align:'center',width:100}">非领导职务</th>
                                <th lay-data="{field:'idCode', align:'center',width:205}">身份证</th>
                                <th lay-data="{field:'gender',align:'center', width:80}">角色</th>

                                <th lay-data="{field:'deviceInfos',align:'center', width:123, toolbar: '#barDemo3'}">设备</th>

                                <th lay-data="{field:'state',align:'center', width:100,}">当前状态</th>
                                <th lay-data="{width:123,align:'center', toolbar: '#barDemo1'}">排班情况</th>
                                <th lay-data="{width:123,align:'center', toolbar: '#barDemo2'}">工作日志</th>

                            </tr>
                        </thead>
                    </table> -->
                </div>

            </div>
        </div>
    </div>
    <script type="text/html" id="barDemo" style="width:200px">
                <a class="layui-btn layui-btn-xs layui_edit_btn" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs layui_del_btn" lay-event="del">删除</a>
            </script>
    <script type="text/html" id="barDemo1" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled disabled" disabled="disabled" lay-event="detail">排班情况</a>
            </script>
    <script type="text/html" id="barDemo2" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled disabled" disabled="disabled" lay-event="detail">工作日志</a>
            </script>
    <script type="text/html" id="barDemo3" style="width:100px">
                <a class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled disabled" disabled="disabled" lay-event="detail">设备编号</a>
            </script>
    <script src="./js/vue.js"></script>
    <script src="../My97DatePicker/WdatePicker.js"></script>
    <script src="./js/layui/layui.js"></script>
    <script src="../js/IndexDB.js"></script>
    <script src="./js/staffService.js"></script>
    <script src="./js/dataInterface.js"></script>
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

        var initGT;

        // console.log(initGT);
        // console.log(initGT.next);
        // console.log(initGT.next);

        //jq初始化加载 
        $(function () {
            SelectPoliceNum(pageLimit, null)
            GetPolice(1, 25);//第几页,一页几条 
            var screen_width=screen.width;
            var screen_height=screen.height;  
            console.log("width:"+screen_width+","+"height:"+screen_height)
            sessionStorage.removeItem("cobj");
            sessionStorage.removeItem("search_conditions");
            sessionStorage.removeItem("pageLimit");
            //异步
            // function* initGenerator() {
            //     yield SelectPoliceNum(pageLimit, null)
            //     yield GetPolice(1, 25);//第几页,一页几条    
            //     yield sessionStorage.removeItem("cobj");
            //     console.log("111");
            //     yield loadTreeSelect();
            //     console.log("222");
            // }
            // initGT = initGenerator();
            // initGT;
            // initGT.next();
            // initGT.next();
            // initGT.next();
        });

        function AfterInitial() {
            stationSelector = new StationSelector();
            //stationSelector._ismulti=true;
            stationSelector.Initial();
        }





        //点击新增按钮
        $('#addPolice').on('click', function () {
            if (sessionStorage.getItem("edit_id") != null) {
                sessionStorage.removeItem("edit_id");
            }
            $("#add_police_form")[0].reset();
            openLayer();
            loadTreeSelect(null);
        });
        //点击单位下拉       
        $('#station_select_ztree').on('click', function () {
            openSelect();
        });

        //layui弹出框
        function openLayer() {
            var add_police_form = layer.open({
                type: 1,
                //title:,
                area: ['600px', '530px'],
                shade: 0,//遮罩
                scrollbar: false,
                shadeClose: false, //点击遮罩关闭
                content: $("#add_police_view"),
            });
        }
        var select_station_tree
        function openSelect() {
            $("#width_left").show();
            select_station_tree = layer.open({
                type: 1,
                //title:,
                area: ['300px', '380px'],
                offset: ['263px', '260px'],
                shade: 0,//遮罩
                scrollbar: false,
                title: false,
                closeBtn: 0,
                resize: false,
                fixed: false,
                shade: [0.0001, '#393D49'],
                shadeClose: true,
                isOutAnim: false,
                anim: -1,
                content: $("#ztree_select"),
            });
        }


        //表单提交
        layui.use('form', function () {
            var form = layui.form;
            // form.render('select')
            //新增警员提交
            form.on('submit(formDemo)', function (data) {
                //添加ajax
                // layer.msg(JSON.stringify(data.field));
                layer.closeAll();
                console.log(data.field);
                AddNewPolice(data.field);
                return false;
            });

            //警员搜索提交
            form.on('submit(sr)', function (data) {
                // layer.msg(JSON.stringify(data.field));
                sessionStorage.setItem("conditinos", data.field);
                if (sessionStorage.getItem("pageLimit") != null) {
                    pageLimit = sessionStorage.getItem("pageLimit");
                }
                let cobj = new Object()
                cobj.conditions = data.field;
                cobj.pageNum = 1;
                cobj.pageSize = parseInt(pageLimit);
                sessionStorage.cobj = JSON.stringify(cobj);
                PagiNationSelect(null, cobj)
                return false;
            });

        });




        //独立分页控件
        //首页尾页按钮,总数显示
        //清理缓存
        // if (sessionStorage.getItem("stationId") != null) {
        //     sessionStorage.removeItem("stationId");
        // }
        $("#first_page_btn").click(function () {
            if (sessionStorage.getItem("pageLimit") != null) {
                pageLimit = sessionStorage.getItem("pageLimit");
            }
            GetPolice(1, pageLimit);
            $(".layui-laypage input").val(1);
        });
        $("#last_page_btn").click(function () {
            if (sessionStorage.getItem("pageNums") != null) {
                var pageNums = sessionStorage.getItem("pageNums");
                console.log("///" + pageNums);
            }
            if (sessionStorage.getItem("pageLimit") != null) {
                pageLimit = sessionStorage.getItem("pageLimit");
            }
            GetPolice(pageNums, pageLimit);
            $(".layui-laypage input").val(pageNums);
        });

        //layui分页条
        //function loadPag() {
        layui.use(['laypage', 'layer'], function () {
            if (sessionStorage.getItem("policeNums") != null) {

                var countNums = sessionStorage.getItem("policeNums");
                console.log(countNums);
            }
            if (sessionStorage.getItem("pageLimit") != null) {
                pageLimit = sessionStorage.getItem("pageLimit");
            }

            var laypage = layui.laypage
                , layer = layui.layer;
            //只显示上一页、下一页
            var laypage = layui.laypage;
            laypage.render({
                elem: 'demo7'
                , count: countNums
                , first: '首页'
                , last: '尾页'
                // , prev: '上'
                // , next: '下'
                , layout: ['prev', 'next', 'limit', 'skip']
                , limit: pageLimit//控制刷新page显示
                , limits: [25, 50, 100, 150]
                , jump: function (obj, first) {
                    console.log(obj);
                    if (!first) {
                        layer.msg('第 ' + obj.curr + ' 页');
                        if (sessionStorage.cobj != null) {
                            let cobj = JSON.parse(sessionStorage.cobj);
                            let data = eval(obj);
                            cobj.pageNum = data.curr;
                            cobj.pageSize = data.limit;
                            console.log(cobj.conditions);
                            PagiNationSelect(null, cobj);

                        } else {
                            PagiNationSelect(obj, null);
                        }
                    }
                }
            });
        });
        //}


        var loadTab=function(){
            console.log("1111")
        };

        //改
        layui.use('table', function () {
            var table = layui.table;
            if (sessionStorage.getItem("pageLimit") != null) {
                pageLimit = sessionStorage.getItem("pageLimit");
            }
            console.log(pageLimit);
            //表格重载,自定义表格与分页
            console.log(dataPolice)
            table.render({
                elem: '#list',
                id:'list',
                width:1900,
                limit: pageLimit,
                cols: [[ //标题栏 
                    { width: 128, align: 'center', toolbar: '#barDemo', title: ' 操作' },
                    { field: 'code', align: 'center', width: 100, title: '警号' },
                    { field: 'name', align: 'center', width: 150, title: '姓名/名称' },
                    { field: 'stationName', align: 'center', width: 100, title: '单位' },
                    { field: 'positionName', align: 'center', width: 100, title: '岗位' },
                    { field: 'telephone', align: 'center', width: 150, title: '电话' },
                    { field: 'leaderPost', align: 'center', width: 100, title: '领导职位' },
                    { field: 'nonLeaderPost', align: 'center', width: 100, title: '非领导职务' },
                    { field: 'idCode', align: 'center', width: 105, title: '身份证' },
                    { field: 'gender', align: 'center', width: 80, title: '角色' },
                    { field: 'deviceInfos', align: 'center', width: 103, toolbar: '#barDemo3', title: '' },
                    { field: 'state', align: 'center', width: 100, title: '当前状态' },
                    { width: 103, align: 'center', toolbar: '#barDemo1', title: '排班情况' },
                    { width: 103, align: 'center', toolbar: '#barDemo2', title: '工作日志' }
                ]],
                data: dataPolice
            });

            loadTab1 = function () {
                table.reload('list', {
                   limit: pageLimit,//控制表格实际加载
                   data: dataPolice//dataTest
                });
            }
            window.loadTab=loadTab1;

            table.on('checkbox(demo)', function (obj) {
                console.log(obj)
            });
            //监听工具条
            table.on('tool(test)', function (obj) {
                var data = obj.data;
                if (obj.event === 'detail') {
                    // layer.msg('ID：' + data.id + ' 的查看操作');
                } else if (obj.event === 'del') {
                    layer.confirm('真的删除行么', function (index) {
                        obj.del();
                        layer.close(index);
                        deletePolice(data.id);
                    });
                } else if (obj.event === 'edit') {
                    console.log(data);
                    // layer.alert('编辑行：<br>' + JSON.stringify(data))
                    //赋值
                    layui.use('form', function () {
                        var form = layui.form;
                        form.val("add_form", {
                            "code": data.code,
                            "name": data.name,
                            "stationId": data.stationId,
                            "position": data.position,
                            "telephone": data.telephone,
                            "leaderPost": data.leaderPost,
                            "nonLeaderPost": data.nonLeaderPost,
                            "idCode": data.idCode,

                        })
                        console.log(data.stationId);
                        loadTreeSelect(data);

                    })
                    //设置数据
                    sessionStorage.setItem("edit_id", data.id);
                    //
                    openLayer();


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