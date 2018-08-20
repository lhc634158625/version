<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>警员列表</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/policeStationScheduling.css">
    <script src="../js/jquery/jquery.js"></script>
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

                </div>
            </div>
            <%@ include file="../shared/pageFooter.jsp"%>
        </div>
    </div>
</div>
</body>


<script src="../My97DatePicker/WdatePicker.js"></script>
<script>

</script>
</html>
