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
                    --section-height: 643px;
                    --screen-width: 100%;
                }

                /* .container{
                        position: ablsolute;
                        width: 1500px;
                        height: 1080px;
                        overflow: hidden;
                    } */
                .nav {
                    position: absolute;
                    top: 0px;
                    left: 0px;
                    width: var(--screen-width);
                    height: var( --nav-height);
                    /* padding: 5px 0px 5px 0px;  */
                    border: 1px solid black;
                }

                .aside {
                    position: absolute;
                    top: var(--nav-height);
                    left: 0px;
                    width: var(--aside-width);
                    height: var(--section-height);
                    overflow: hidden;
                    border: 1px solid orange
                }

                .section {
                    position: absolute;
                    top: var(--nav-height);
                    left: var(--aside-width);
                    width: calc(var(--screen-width) - var(--aside-width));
                    height: var(--section-height);
                    overflow: hidden;
                    border: 1px solid red;

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
            </style>
        </head>

        <body class="layui-layout-body">
            <%@ include file="../shared/pageHeader1.jsp"%>
                <header class="nav"></header>
                <section class="section">

                </section>
                </div>
                <aside class="aside"></aside>
                <script src="./js/vue.js"></script>
                <script src="../My97DatePicker/WdatePicker.js"></script>
                <script src="../js/layui2/layui.js"></script>
                <script src="./js/staffService.js"></script>
                <script src="./js/staffData.js"></script>
                <script>



                </script>
        </body>

        </html>