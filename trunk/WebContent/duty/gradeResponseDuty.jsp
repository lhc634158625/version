<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>等级响应值班情况</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<style>
#mainBody {
	position: fixed;
	right: 10px;
}

ul.layui-tab-title li:first-child i {
	display: none;
}

.layui-this {
	background: white;
}

#formDiv {
	position: fixed;
	border: 1px #ccc solid;
	bottom: 50px;
	margin-left: 10px;
	background: white;
	border-radius: 5px;
	width: 450px;
	bottom: 50px;
	display: none;
	z-index: 3;
}

.layui-input:-webkit-autofill {
	-webkit-box-shadow: 0 0 0px 1000px white inset;
}

.layui-form-label {
	width: 120px;
}

#formTop {
	width: 100%;
	height: 40px;
	background: #4472ca;
	border-radius: 5px;
	margin-bottom: 10px;
	line-height: 40px;
	font-size: 16px;
	color: white;
}

#formTop span:FIRST-CHILD {
	margin-left: 1em;
}

#formTop span:LAST-CHILD {
	float: right;
	font-size: 20px;
	margin-right: 26px;
	cursor: pointer;
}

#formTop img {
	width: 15px;
	height: 15px;
	margin-left: 15px;
}
#right_top{
	padding:10px 0 18px 0;
	height:30px;
	width:100%;
	font-size: 16px;
}
#right_all_one ul  li{
	padding-bottom:4px;
}
.layui-form-label{
	width:80px;
}
.layui-form-item{
	margin-bottom:10px;
}
.layui-table tr th,td{
	text-align: center;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/policeFunctionMenu.jsp"%>
		<div id="mainBody">
			<div class="layui-tab" lay-filter="demo" lay-allowclose="true">
				<ul class="layui-tab-title" style="background: #92b4f4;">
					<li class="layui-this" lay-id="11">案件回访</li>
				</ul>
				<div class="layui-tab-content"style="border: 1px solid #ccc; border-top: none;">
					<div class="layui-tab-item layui-show" >
						<div id="body_main_right">
							<div id="right_top">
								公安局办公室
							</div>
							<div id="buttom_caseList">						
								<div id="right_all_caseList_one" style="auto;width:100%;">
								<form class="layui-form" action="" lay-filter="example">
									<div class="layui-form-item">
									    <label class="layui-form-label">时间段：</label>
									    <div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test1"
											placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label" style="width: 10px; padding-left: 0;">-</label>
										<div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="test2"
												placeholder="yyyy-MM-dd">
										</div>
										<div class="layui-inline" style="float: right;">
											<div class="layui-btn-group demoTable" style="float: right;">
											    <button class="layui-btn layui-btn-primary">导入</button>
											    <button class="layui-btn layui-btn-primary">导出</button>
											    <button class="layui-btn layui-btn-primary">生成模板</button>
											    <button class="layui-btn layui-btn-primary">下载模板</button>
											</div>
										</div>
									</div>																
								</form>								
								</div>
								<div id="right_all_caseList_two">
									<table class="layui-table">
										<thead>
											<tr>
												<th>序号</th>
												<th>级别</th>
												<th>星期日</th>
												<th>星期一</th>
												<th>星期二</th>
												<th>星期三</th>
												<th>星期四</th>
												<th>星期五</th>
												<th>星期六</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>一级加强</td>
												<td></td>
												<td></td>
												<td></td>
												<td><div>张三,18842000334;</div><div>李四,18439920003;</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>1</td>
												<td>一级</td>
												<td></td>
												<td></td>
												<td><div>张三,18842000334;</div><div>李四,18439920003;</div></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>1</td>
												<td>二级</td>
												<td></td>
												<td><div>张三,18842000334;</div><div>李四,18439920003;</div></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>1</td>
												<td>三级</td>
												<td><div>张三,18842000334;</div><div>李四,18439920003;</div></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div id="buttom_backMessage"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	layui
			.use(
					[ 'form', 'layedit', 'laydate' ],
					function() {
						var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
						//自定义颜色
						laydate.render({
							elem : '#test1',
							theme : '#4472ca'
						});//自定义颜色
						laydate.render({
							elem : '#test2',
							theme : '#4472ca'
						});
					});

	$(function() {
		var height = $(window).height();
		var width = $(window).width() - 300;
		var mainBody = document.getElementById("mainBody");
		var content = document.getElementsByClassName("layui-tab-content");
		mainBody.style.height = height * 0.85 + "px";
		mainBody.style.width = width + "px";
		for (var i = 0; i < content.length; i++) {
			content[i].style.height = (height * 0.8 - 30) + "px";
		}
	});	
</script>
<script>
//调整内容表格的最大高度
function ChangeTableHeight(){
	var h= document.documentElement.clientHeight || document.body.clientHeight;	 
	var bdr = document.getElementById('mainBody');
	var bdrh = bdr.offsetTop;
	var htwo = document.getElementById('right_all_caseList_two');
	var ht = htwo.offsetTop;
	var tb=document.getElementsByClassName("layui-table-main");
	if(tb!=null){	
		for(var i=0;i<tb.length;i++){				
			if(tb[i].offsetTop!=0 && h!=(tb[i].offsetHeight+tb[i].offsetTop+30)){
				var offset=h-bdrh-ht-140;
				if(offset>0){
					tb[i].style.height=offset+'px';						
				}		
			}	
		}
	}
}
</script>
</html>
