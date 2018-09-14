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
            <script src="../js/layui2/layui.js"></script>

            <style>
                html {
                    /* width: 1920px;
                    height: 1080px; */
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
        </head>

        <body class="layui-layout-body">
            <%@ include file="../shared/pageHeader1.jsp"%>
                <header class="nav"></header>
                <div class="container">
                    <aside class="aside">
                        <div class="layui-layout layui-layout-admin aside_select_tree">
                            <jsp:include page="../shared/policeStationSchedulingMenu.jsp" flush="true">
                                <jsp:param name="multi" value="0" />
                            </jsp:include>
                        </div>
                    </aside>
                    <section class="section">
                        <div class="manager_btn">
                            <input type="button" class="layui-btn layui-btn-sm" style="background-color:#3F69BA" value="基本信息" />
                            <input type="button" class="layui-btn layui-btn-primary layui-btn-sm" value="班别设置" />
                        </div>
                        <div class="manager_tip">
                            <div style="width: 250px">
                                <input class="layui-btn layui-btn-disabled layui-row" style="border:0px;background-color:white;color:black;width: 245px" value="* 可使用拖拽节点来改变从属关系" />
                                <input class="layui-btn layui-btn-disabled layui-row" style="border:0px;background-color:white;color:black;margin: 0px" value="* 请先从左边选择一个节点" />
                            </div>
                            <div style="width: 200px;margin-left:20px "><span style="color:#3F69BA;font-size: 20px;font-weight:bolder;">新增</span></div>
                        </div>
                        <div class="manager_form">
                            <form class="layui-form" action="">

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                                        height: 38px;"><span style="">上一级</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span style="">编号</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                                flex-flow:row column nowrap;align-items: center;justify-content :center;
                                                height: 38px;"><span style="">名称</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span style="">单位号</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span style="">联系人</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                            flex-flow:row column nowrap;align-items: center;justify-content :center;
                                            height: 38px;"><span style="">电话</span></label>
                                    <div class="layui-col-md3">
                                        <input name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input" type="text">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                    flex-flow:row column nowrap;align-items: center;justify-content :center;
                                    height: 38px;"><span style="">级别</span></label>
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
                                            height: 38px;"><span style="">是否显示</span></label>
                                    <div class="layui-input-block">
                                        <input name="like1[write]" lay-skin="primary" title="" checked="" type="checkbox">
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row" pane="">
                                    <label class="layui-col-md2" style="display:-webkit-flex;
                                        flex-flow:row column nowrap;align-items: center;justify-content :center;
                                        height: 38px;"><span style="">组别</span></label>
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
                <script src="../My97DatePicker/WdatePicker.js"></script>

                <!-- <script src="./js/stationService.js"></script> -->
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
        </body>

        </html>