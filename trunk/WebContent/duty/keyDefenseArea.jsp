<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>重点防务区排班</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/fastReverseShift.css">
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>

<script src="../js/jquery/jquery.js"></script>
<style>
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/keyDefenseAreaMenu.jsp"%>
		<div id="mainBody">
			<div class="layui-tab" lay-filter="demo" lay-allowclose="true">
				<ul class="layui-tab-title" style="background: #92b4f4;"
					id="tabTitle">
					<li class="layui-this">地图</li>
				</ul>
				<div class="layui-tab-content"
					style="border: 1px solid #ccc; border-top: none;" id="tabContent">
					<div class="layui-tab-item layui-show">
						<div id="mapTop"
							style="position: fixed; width: 60%; height: auto; z-index: 2; right: 30px; background: white; border-radius: 5px; padding: 5px;">
							<form class="layui-form" action="">
								<div class="layui-inline">
									<div class="layui-input-inline" style="margin-top: 5px;">
										<input type="checkbox" name="" lay-skin="primary"
											title="<img src='../images/gray.png'><img src='../images/blue.png'>&nbsp;重点防务区">
									</div>
								</div>
								<div class="layui-inline" style="z-index: 5;">
									<div class="layui-input-inline">
										<ul>
											<li class="liStyle">排班
												<ul class="ulStyle">
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="有排班 "></li>
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="无排班"></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline" style="z-index: 5;">
										<ul>
											<li class="liStyle">勤务车辆
												<ul class="ulStyle">
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="在线 "></li>
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="离线"></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline" style="z-index: 5;">
									<div class="layui-input-inline">
										<ul>
											<li class="liStyle">勤务人员
												<ul class="ulStyle">
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="在线 "></li>
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="离线 "></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline" style="z-index: 5;">
									<div class="layui-input-inline">
										<ul>
											<li class="liStyle">摄像头
												<ul class="ulStyle">
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="高空枪机 "></li>
													<li><input type="checkbox" name="like1[write]"
														lay-skin="primary" title="模拟球机 "></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test1"
											placeholder="yyyy-MM-dd">
									</div>
									<label>-</label>
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test2"
											placeholder="yyyy-MM-dd">
									</div>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">搜索</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">前一天</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">后一天</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">今天</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">本周</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm">本月</button>
								</div>
							</form>
						</div>
						<div id="mapDiv"></div>
					</div>
				</div>
			</div>
			<div id="formDiv">
				<div id="formTop">
					<span>机场辖区</span><img src="../images/starlogo.png"><span
						onclick="closeMess()">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">编号</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">巡逻区域</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">区域以辐射范围</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">区域类型</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">X坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Y坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">关联单位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">代码</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电台值守组</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline" style="width: 278px;">
							<textarea name="desc" placeholder="请输入内容" class="layui-textarea"
								style="width: 100%; resize: none;"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"></label>
						<div class="layui-input-inline" style="width: 278px;">
							<button class="layui-btn" lay-submit lay-filter="formChose"
								style="background: #4472ca;">选择坐标</button>
							<button class="layui-btn" lay-submit lay-filter="formSave"
								style="background: #4472ca;">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;">停用</button>
						</div>
					</div>
				</form>
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
						});
						laydate.render({
							elem : '#test2',
							theme : '#4472ca'
						});
					});

	$(function() {
		var height = $(window).height();
		var width = $(window).width() - 300;
		var mainBody = document.getElementById("mainBody");
		var mapDiv = document.getElementById("mapDiv");
		var content = document.getElementsByClassName("layui-tab-content");
		mainBody.style.height = height * 0.85 + "px";
		mainBody.style.width = width + "px";
		for (var i = 0; i < content.length; i++) {
			content[i].style.height = (height * 0.8 - 30) + "px";
		}
		mapDiv.style.height = (height * 0.8 - 30) + "px";
		mapDiv.style.width = (width - 20) + "px";
		mapTop.style.maxWidth = (width - 50) + "px";
		var map = PGISHelper.Init("mapDiv");
	});

	// 关闭详情页
	function closeMess() {
		var formDiv = document.getElementById("formDiv");
		formDiv.style.display = "none";
	}

	//提取不重复的数据存入数组
	function isInArray(arr, value) {
		for (var i = 0; i < arr.length; i++) {
			if (value === arr[i]) {
				return true;
			}
		}
		return false;
	}

	// 添加排班
	function makeOrder() {
		var makeSave = document.getElementById("makeSave");
		var makeOrder = document.getElementById("makeOrder");
		makeSave.removeAttribute("style");
		makeOrder.style.display = "none";
	}

	// 保存排班
	function makeSave() {
		var makeSave = document.getElementById("makeSave");
		var makeOrder = document.getElementById("makeOrder");
		makeOrder.removeAttribute("style");
		makeSave.style.display = "none";
	}

	// 取消排班
	function makeCancel() {
		var makeSave = document.getElementById("makeSave");
		var makeOrder = document.getElementById("makeOrder");
		makeOrder.removeAttribute("style");
		makeSave.style.display = "none";
	}
</script>
<script type="text/javascript">
	// 画表格
	function showTable() {
		var tabTitles = document.getElementById("tabTitle").children;
		var tabContents = document.getElementById("tabContent").children;
		for(var i=0;i<tabTitles.length;i++){
			tabTitles[i].classList.remove("layui-this");
		}
		for(var j=0;j<tabContents.length;j++){
			tabContents[j].classList.remove("layui-show");
		}
		var html1 = "";// tabTitle
		var html2 = "";// tabContent
		html1 += "<li class='layui-this'>某某辖区</li>"
		$("#tabTitle").append(html1);
		html2 += "<div class='layui-tab-item layui-show'>";
		html2 += "<div class='layui-inline' id='makeOrder'>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeOrder()'>排班</button><button class='layui-btn layui-btn-primary layui-btn-sm'>导出</button>";
		html2 += "</div>";
		html2 += "<div class='layui-inline' id='makeSave' style='display: none;'>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeSave()'>保存</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeCancel()'>取消</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>复制排班</button>";
		html2 += "<label>原日期</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='test3' placeholder='yyyy-MM-dd'></div>";
		html2 += "<label>目标日期</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='test4' placeholder='yyyy-MM-dd'></div>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>确认</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>取消</button></div>";
		html2 += "<div class='layui-inline' style='float: right;'>";
		html2 += "<div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='test5' placeholder='yyyy-MM-dd'>";
		html2 += "</div><label>-</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='test6' placeholder='yyyy-MM-dd'></div>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>搜索</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>前一天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>后一天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>今天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>本周</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>本月</button>";
		html2 += "</div><div class='layui-inline' style='width: 100%;'><div class='tableTitle'>机场辖区排班安排表</div></div>";
		html2 += "<table class='layui-table' style='text-align: center;'>";
		html2 += "<tbody>";
		html2 += "<tr>";
		html2 += "<td colspan='16'>各分局加密巡逻安排表2018-08-28</td>";
		html2 += "</tr>"
		html2 += "<tr>";
		html2 += "<td rowspan='2'>分局(队伍驻地)</td>";
		html2 += "<td rowspan='2'>巡逻类型</td>";
		html2 += "<td rowspan='2'>巡逻区域</td>";
		html2 += "<td rowspan='2'>巡逻及辐射范围</td>";
		html2 += "<td rowspan='2'>巡逻时段</td>";
		html2 += "<td colspan='3'>带队民警</td>";
		html2 += "<td rowspan='2'>车号</td>";
		html2 += "<td colspan='2'>通信</td>";
		html2 += "<td colspan='3'>执勤人数</td>";
		html2 += "<td colspan='2'>携带装备</td>";
		html2 += "</tr>";
		html2 += "<tr>";
		html2 += "<td>姓名</td>";
		html2 += "<td>职务</td>";
		html2 += "<td>电话</td>";
		html2 += "<td>代码</td>";
		html2 += "<td>电台值守组</td>";
		html2 += "<td>民警</td>";
		html2 += "<td>武警</td>";
		html2 += "<td>协警</td>";
		html2 += "<td>长枪</td>";
		html2 += "<td>短枪</td>";
		html2 += "</tr>";
		html2 += "</tbody>";
		html2 += "</table>";
		html2 += "</div>";
		$("#tabContent").append(html2);
		layui.use([ 'form', 'layedit', 'laydate', 'element' ], function() {
			var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
			var element = layui.element;
			element.init();
			laydate.render({
				elem : '#test3',
				theme : '#4472ca'
			});
			laydate.render({
				elem : '#test4',
				theme : '#4472ca'
			});
			laydate.render({
				elem : '#test5',
				theme : '#4472ca'
			});
			laydate.render({
				elem : '#test6',
				theme : '#4472ca'
			});
		});
		cancelBubble();
	}
</script>
</html>
