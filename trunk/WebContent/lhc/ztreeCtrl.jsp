<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style>
        #tree {
            color: white;
        }

        #stationSelect .layui-input {
            border-bottom: 1px solid #cccccc;
            border-radius: 0 10px 10px 0;
        }

        /*定义滚动条高宽及背景*/
        #divTree::-webkit-scrollbar {
            width: 10px;
            height: 10px;
        }

        /*定义滚动滑块*/
        #divTree::-webkit-scrollbar-thumb {
            border-radius: 0px;
            -webkit-box-shadow: inset 0 0 5px #cccccc;
            background: #90B2F1;
        }

        /*滚动条里面轨道*/
        #divTree::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 5px #cccccc;
            border-radius: 0px;
            background: #EDEDED;
        }

        #stationSelect .layui-anim-upbit {
            width: 100%;
        }

        #stationSelect .layui-anim-upbit::-webkit-scrollbar {
            display: block;
        }

        #width_left {
            display: none;
            background: #ffffff;
            width: auto;
            padding-right: 10px;
            margin-top: 40px;
        }

        #left_mean_body {
            overflow: auto;
        }

        #divTree {
            height: 372px;
            width: 230px;
            overflow: auto;
            border: solid 1px #cccccc;
            border-radius: 0 10px 10px 0;
        }
    </style>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <div id="width_left">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <div id="left_mean_body" style="">
                    <div id="divTree">
                        <ul id="tree" class="ztree"></ul>
                    </div>
                </div>
            </div>
        </section>
       
        <script src="../js/layui2/layui.js"></script>
        <!--添加的-->
        <script src="../js/jquery/jquery.min.js"></script>
        <!--添加的-->
        <script src="../js/jquery.ztree.all-3.1.min.js"></script>
        <script src="../js/dateTime.js"></script>
        <script src="./js/ztreeData.js" type="text/javascript"></script>
        <script src="../js/linq/linq.min.js"></script>
        <script src="../js/dictCache.js"></script>
        <script src="../js/IndexDB.js"></script>
        <script src="./js/ztreeService.js" charset="gb2312"></script>
    </aside>