<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>组织管理</title>
    <script src="../js/jquery/jquery.js"></script>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/policeStationScheduling.css">
    <link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="../js/layui2/layui.js"></script>


    <style>
        html 
                {  
                    overflow: hidden;
                    overflow-y: auto;
                }

                body {
                    --nav-height: 110px;
                    --aside-width: 276px;
                    --section-height: 770px;
                    --screen-width: 100%;
                }

                .nav {
                    position: absolute;
                    top: 0px;
                    left: 0px;
                    width: var(--screen-width);
                    height: var( --nav-height);
                }

                /* .container{
                        position: ablsolute;
                        width: 1500px;
                        height: 1080px;
                        overflow: hidden;
                    } */

                .aside {
                    /* position: absolute;
                    top: var(--nav-height);
                    left: 0px; */
                    float: left;
                    width: var(--aside-width);
                    height: var(--section-height);
                    overflow: hidden;
                }

                .aside_select_tree {
                    position: absolute;
                    top: 0px;
                    left: 0px;
                }

                .section {
                    /* position: absolute;
                    top: var(--nav-height);
                    left: var(--aside-width); */
                    float: left;
                    width: calc(var(--screen-width) - var(--aside-width) - 130px);
                    height: var(--section-height);
                    margin-left: 20px;
                    margin-top: 10px;
                    border: solid 1px #cccccc;
                    border-radius: 15px;

                    --fileTree-width: 200px;
                }

                .fileTree {
                    float: left;
                    width: var(--fileTree-width);
                    height: var(--section-height);
                    border: 1px solid yellows;
                }

                .inputForm {
                    float: left;
                    width: calc(90% - var(--fileTree-width));
                    height: var(--section-height);
                    border: 1px solid blueviolet;
                }

                #treeDemo {
                    position: absolute;
                    width: var(--fileTree-width);
                }

                .manager_form {
                    position: relative;
                    top: 20px;
                    left: 20px;
                    width: 900px;
                    margin-top:40px;
                }

                .manager_btn {
                    position: relative;
                    top: 20px;
                    left: 20px;
                    width: 500px;
                }

                .manager_tip {
                    position: relative;
                    top: 20px;
                    left: 20px;
                    width: 20px;
                }

                .layui-form-checked[lay-skin=primary] i {
                    border-color: #90B2F1;
                    background-color: #90B2F1;
                    color: #fff;
                }
                  
</style>
    <style>
        .menu_top {
	width: 100%;
	height: 3%;
	text-align: center;
	margin-top: 6%;
	color: white;
	border-bottom: #ccc 2px solid;
}
#tree {
	color: white;
}
#stationSelect .layui-input
{
	border-bottom:1px solid #cccccc;
	border-radius:0 10px 10px 0;
}
#divTree::-webkit-scrollbar {
        display: none;
    }
#stationSelect .layui-anim-upbit{
	width:100%;
}
#stationSelect .layui-anim-upbit::-webkit-scrollbar {
        display: none;
    }
    
#width_left {
	background: #ffffff;
	width: auto;
	padding-right: 10px;
	margin-top: 40px;
}
</style>
</head>

<body class="layui-layout-body">
    <%@ include file="../shared/pageHeader1.jsp"%>
    <header class="nav"></header>
    <div class="container">
        <aside class="aside">
            <div class="layui-layout layui-layout-admin aside_select_tree">
                <section class="sidebar">
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <div id="width_left" class="layui-side">
                        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                        <div style="color:#000;border-radius:0 10px 10px 0; border:1px #cccccc solid; margin:19px 0 2px 0; height:4%;"
                            class="menu_top">
                            <span id="show_span" style="line-height:30px;">行政区域</span>
                            <input id="show_hid" onclick="showAndHidMean()" type="button" style="width:30px;height: 30px; border:none;border-radius: 0 10px 10px 0;float:right;background-image:url(../images/sh.png);"></input>
                        </div>
                        <div id="left_mean_body" style="border:solid 1px #cccccc; border-radius:0 10px 10px 0;">
                            <form class="layui-form" action="" method="post">
                                <div id="stationSelect">
                                    <div class="layui-input-inline" style="width:100%; ">
                                        <select name="stationSearch" id="stationSearch" lay-filter="stationSearch"
                                            aria-invalid="false" lay-search lay-case>
                                        </select>
                                    </div>
                                </div>
                            </form>
                            <div id="divTree" style="height:700px; overflow:auto;">
                                <ul id="tree" class="ztree"></ul>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </aside>
        <section class="section" id="width_right">
            <div class="manager_btn">
                <input type="button" class="layui-btn layui-btn-sm" style="background-color:#3F69BA" value="基本信息" />
                <input type="button" class="layui-btn layui-btn-primary layui-btn-sm" value="班别设置" />
            </div>
            <div class="manager_tip">
                <div style="width: 250px">
                    <input class="layui-btn layui-btn-disabled layui-row" style="border:0px;background-color:white;color:black;width: 245px"
                        value="* 可使用拖拽节点来改变从属关系" />
                    <input class="layui-btn layui-btn-disabled layui-row" style="border:0px;background-color:white;color:black;margin: 0px"
                        value="* 请先从左边选择一个节点" />
                </div>
                <div style="width: 200px;margin-left:20px "><span style="color:#3F69BA;font-size: 20px;font-weight:bolder;">新增</span></div>
            </div>
            <div class="manager_form">
                <form class="layui-form" action="">

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                                        height: 38px;"><span
                                style="">上一级</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                style="">编号</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                                flex-flow:row column nowrap;align-items: center;justify-content :center;
                                                height: 38px;"><span
                                style="">名称</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                style="">单位号</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                style="">联系人</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                style="">电话</span></label>
                        <div class="layui-col-md3">
                            <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input"
                                type="text">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                    flex-flow:row column nowrap;align-items: center;justify-content :center;
                                    height: 38px;"><span
                                style="">级别</span></label>
                        <div class="layui-col-md3">
                            <select name="station" lay-verify="required">
                                <option value=""></option>
                                <option value="0">北京</option>
                                <option value="1">上海</option>
                                <option value="2">广州</option>
                                <option value="3">深圳</option>
                                <option value="4">杭州</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item layui-row" pane="">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span
                                style="">是否显示</span></label>
                        <div class="layui-input-block">
                            <input name="like1[write]" lay-skin="primary" title="" checked="" type="checkbox">
                        </div>
                    </div>

                    <div class="layui-form-item layui-row" pane="">
                        <label class="layui-col-md2" style="display:-webkit-flex;
                                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                                        height: 38px;"><span
                                style="">组别</span></label>
                        <div class="layui-input-block">
                            <input name="like1[write]" lay-skin="primary" title="组织结构" checked="" type="checkbox">
                            <input name="like1[read]" lay-skin="primary" title="下拉框组" type="checkbox">
                            <input name="like1[read]" lay-skin="primary" title="警力部署组" type="checkbox">
                            <input name="like1[read]" lay-skin="primary" title="巡逻片区组" type="checkbox">
                            <input name="like1[read]" lay-skin="primary" title="电台点名" type="checkbox">
                            <input name="like1[read]" lay-skin="primary" title="辖区刑案" type="checkbox">
                        </div>
                    </div>


                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1" style="background-color: #4472CA;">更新</button>
                            <button type="reset" class="layui-btn layui-btn-primary" style="background-color: #4472CA;color: white">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <!-- <script src="./js/vue.js"></script> -->
    <script src="../js/jquery.ztree.all-3.1.min.js"></script>
    <script src="../My97DatePicker/WdatePicker.js"></script>
    <script src="../js/IndexDB.js"></script>
    <script src="./js/stationService.js"></script>
    <script src="./js/ztreeData.js"></script>
    <script src="./js/dataInterface.js"></script>
    <script>
        $("#show_hid").attr({ "disabled": "disabled" });


        layui.use(['form', 'layedit', 'laydate'], function () {
            var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , laydate = layui.laydate;

            //日期
            laydate.render({
                elem: '#date'
            });
            laydate.render({
                elem: '#date1'
            });

            //创建一个编辑器
            var editIndex = layedit.build('LAY_demo_editor');

            //自定义验证规则
            form.verify({
                title: function (value) {
                    if (value.length < 2) {
                        return '标题至少得2个字符啊';
                    }
                }
                , pass: [/(.+){6,12}$/, '密码必须6到12位']
                , content: function (value) {
                    layedit.sync(editIndex);
                }
            });

            //监听指定开关
            form.on('switch(switchTest)', function (data) {
                layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                    offset: '6px'
                });
                layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
            });

            //监听提交
            form.on('submit(demo1)', function (data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                return false;
            });

            //表单初始赋值
            form.val('example', {
                "username": "贤心" // "name": "value"
                , "password": "123456"
                , "interest": 1
                , "like[write]": true //复选框选中状态
                , "close": true //开关状态
                , "sex": "女"
                , "desc": "我爱 layui"
            })


        });

    </script>


    <script>
        window.onload = function () {
            onExpandforchangeWidth1();
        }

        //随左侧菜单栏的变化，右边主页面宽度随之改变
        function onExpandforchangeWidth1() {
            var width_left = document.getElementById("width_left");
            var width_right = $("#width_right");
            if (width_left != null && width_right != null) {
                // var sw=  parseInt(width_right.css("width"));    
                var wd = width_left.offsetWidth;
                var wm = wd - 295 + 20;
                var swn = 1800 - wd;
                width_right.css({
                    "width": swn,
                    "margin-left": wm
                });

            }

        }

        //树于各个显示控件联动
        function changeStation(obj) {
            var selectv = $('#stationSearch');
            selectv.val(obj.id);
            if (typeof selectRender == "function") {
                selectRender();
            }
            if (typeof SelectStation == "function") {
                SelectStation(obj);
            }
        }

        window.selectRender = function () {
            layui.use(['layer', 'form', 'laydate', 'code'], function () {
                var form = layui.form, $ = layui.$;
                form.render();
            });
        };
    </script>
    <script>
        function showAndHidMean() {
            var lt_mean_body = document.getElementById('left_mean_body');
            var sw_span = document.getElementById('show_span')
            if (lt_mean_body.style.display == 'block' || lt_mean_body.style.display == "") {
                lt_mean_body.style.display = 'none';
                sw_span.style.display = 'none';
            }
            else {
                lt_mean_body.style.display = 'block';
                sw_span.style.display = 'inline';
            }
            onExpandforchangeWidth1();
        }
        function AddOption(allStations) {
            $("#stationSearch").empty();
            var data = allStations;
            var manList = new Array();
            var IdList = new Array();
            for (var i = 0; i < data.length; i++) {
                if (!isInArray(manList, data[i].staffName)) {
                    manList.push(data[i].name);
                    IdList.push(data[i].id);
                }
            }
            var html = "";
            html += "<option value=''></option>";
            for (var j = 0; j < manList.length; j++) {
                html += "<option value='" + IdList[j] + "'>" + manList[j] + "</option>";
            }
            $("#stationSearch").append(html);

            if (typeof selectRender == "function") {
                selectRender();
            }
        }
    </script>
</body>

</html>