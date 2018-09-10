<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>综合武装设卡盘查</title>
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
		<%@ include file="../shared/armedCheckMenu.jsp"%>
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
							style="position: fixed; width: auto; height: auto; z-index: 2; right: 30px; background: white; border-radius: 5px; padding: 5px;">
							<form class="layui-form" action="">
								<div class="layui-inline">
									<div class="layui-input-inline" style="margin-top: 5px;">
										<input type="checkbox" name="like1[read]" lay-skin="primary"
											title="<img src='../images/gray.png'><img src='../images/blue.png'>&nbsp;检查站">
										<input type="checkbox" name="like1[read]" lay-skin="primary"
											title="<img src='../images/gray.png'><img src='../images/blue.png'>&nbsp;临时">
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
								<div class="layui-inline" style="z-index: 5;">
									<div class="layui-input-inline">
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
						<label class="layui-form-label">设卡点位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">X坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" id="coordinateX" name="title" required
								lay-verify="required" placeholder="请输入标题" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Y坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" id="coordinateY" name="title" required
								lay-verify="required" placeholder="请输入标题" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">卡点类型</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="showTree" onclick="showTreemMean(this,this.id)"
								type="text" name="title" required lay-verify="required"
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
							<button onclick="selectMapLG()" class="layui-btn" lay-submit
								lay-filter="formSave" style="background: #4472ca;">选择坐标</button>
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
	<div id="textTree"
		style="position: absolute; overflow: auto; border: solid 1px #ccc; background-color: #fff; height: 200px;">
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
<script type="text/javascript">
	var map;
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
		map = PGISHelper.Init("mapDiv");
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
	function showTable(obj) {
		var tabTitles = document.getElementById("tabTitle").children;
		var tabContents = document.getElementById("tabContent").children;
		for (var i = 0; i < tabTitles.length; i++) {
			tabTitles[i].classList.remove("layui-this");
		}
		for (var j = 0; j < tabContents.length; j++) {
			tabContents[j].classList.remove("layui-show");
		}
		var html1 = "";// tabTitle
		var html2 = "";// tabContentTop
		var html3 = "";// tabContentBody
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
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>本月</button></div>";
		html2 += "<div id='tableDiv'></div>";
		$("#tabContent").append(html2);
		if (obj == 1) {
			html3 += "<div class='layui-inline' style='width: 100%;margin-top: 20px;'><div style='float:right'><button id='temporary' onclick='creatTable(2)' class='layui-btn layui-btn-primary'>临时卡点</button></div></div>";
			html3 += "<table class='layui-table' style='text-align: center;'>";
			html3 += "<tbody>";
			html3 += "<tr>";
			html3 += "<td colspan='14'>检查站路面综合设卡武装盘查工作表</td>";
			html3 += "</tr>"
			html3 += "<tr>";
			html3 += "<td rowspan='2'>分局</td>";
			html3 += "<td rowspan='2'>卡点类型</td>";
			html3 += "<td rowspan='2'>设卡点位</td>";
			html3 += "<td rowspan='2'>组织单位</td>";
			html3 += "<td rowspan='2'>行动日期</td>";
			html3 += "<td rowspan='2'>行动时间</td>";
			html3 += "<td colspan='3'>带队领导</td>";
			html3 += "<td colspan='3'>出动警力(名)</td>";
			html3 += "<td rowspan='2'>简要战果</td>";
			html3 += "<td rowspan='2'>备注</td>";
			html3 += "</tr>";
			html3 += "<tr>";
			html3 += "<td>姓名</td>";
			html3 += "<td>职务</td>";
			html3 += "<td>电话</td>";
			html3 += "<td>民警</td>";
			html3 += "<td>特警</td>";
			html3 += "<td>协警</td>";
			html3 += "</tr>";
			html3 += "</tbody>";
			html3 += "</table>";
			html3 += "</div>";
		} else if (obj == 2) {
			html3 += "<div class='layui-inline' style='width: 100%;margin-top: 20px;'><div style='float:right'><button id='temporary' onclick='creatTable(1)' class='layui-btn layui-btn-primary'>检查站</button></div></div>";
			html3 += "<table class='layui-table' style='text-align: center;'>";
			html3 += "<tbody>";
			html3 += "<tr>";
			html3 += "<td colspan='13'>临时卡点路面综合设卡武装盘查工作表</td>";
			html3 += "</tr>"
			html3 += "<tr>";
			html3 += "<td rowspan='2'>分局</td>";
			html3 += "<td rowspan='2'>组织单位</td>";
			html3 += "<td rowspan='2'>行动日期</td>";
			html3 += "<td rowspan='2'>行动时间</td>";
			html3 += "<td rowspan='2'>设卡点位</td>";
			html3 += "<td colspan='3'>带队领导</td>";
			html3 += "<td colspan='3'>出动警力(名)</td>";
			html3 += "<td rowspan='2'>简要战果</td>";
			html3 += "<td rowspan='2'>备注</td>";
			html3 += "</tr>";
			html3 += "<tr>";
			html3 += "<td>姓名</td>";
			html3 += "<td>职务</td>";
			html3 += "<td>电话</td>";
			html3 += "<td>民警</td>";
			html3 += "<td>特警</td>";
			html3 += "<td>协警</td>";
			html3 += "</tr>";
			html3 += "</tbody>";
			html3 += "</table>";
			html3 += "</div>";
		}
		$("#tableDiv").append(html3);
		layui
				.use(
						[ 'form', 'layedit', 'laydate', 'element' ],
						function() {
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

	function creatTable(obj) {
		$("#tableDiv").empty();
		var html = "";
		if (obj == 1) {
			html += "<div class='layui-inline' style='width: 100%;margin-top: 20px;'><div style='float:right'><button id='temporary' onclick='creatTable(2)' class='layui-btn layui-btn-primary'>临时卡点</button></div></div>";
			html += "<table class='layui-table' style='text-align: center;'>";
			html += "<tbody>";
			html += "<tr>";
			html += "<td colspan='14'>临时卡点路面综合设卡武装盘查工作表</td>";
			html += "</tr>"
			html += "<tr>";
			html += "<td rowspan='2'>分局</td>";
			html += "<td rowspan='2'>卡点类型</td>";
			html += "<td rowspan='2'>设卡点位</td>";
			html += "<td rowspan='2'>组织单位</td>";
			html += "<td rowspan='2'>行动日期</td>";
			html += "<td rowspan='2'>行动时间</td>";
			html += "<td colspan='3'>带队领导</td>";
			html += "<td colspan='3'>出动警力(名)</td>";
			html += "<td rowspan='2'>简要战果</td>";
			html += "<td rowspan='2'>备注</td>";
			html += "</tr>";
			html += "<tr>";
			html += "<td>姓名</td>";
			html += "<td>职务</td>";
			html += "<td>电话</td>";
			html += "<td>民警</td>";
			html += "<td>特警</td>";
			html += "<td>协警</td>";
			html += "</tr>";
			html += "</tbody>";
			html += "</table>";
			html += "</div>";
		} else if (obj == 2) {
			html += "<div class='layui-inline' style='width: 100%;margin-top: 20px;'><div style='float:right'><button id='temporary' onclick='creatTable(1)' class='layui-btn layui-btn-primary'>检查站</button></div></div>";
			html += "<table class='layui-table' style='text-align: center;'>";
			html += "<tbody>";
			html += "<tr>";
			html += "<td colspan='13'>临时卡点路面综合设卡武装盘查工作表</td>";
			html += "</tr>"
			html += "<tr>";
			html += "<td rowspan='2'>分局</td>";
			html += "<td rowspan='2'>组织单位</td>";
			html += "<td rowspan='2'>行动日期</td>";
			html += "<td rowspan='2'>行动时间</td>";
			html += "<td rowspan='2'>设卡点位</td>";
			html += "<td colspan='3'>带队领导</td>";
			html += "<td colspan='3'>出动警力(名)</td>";
			html += "<td rowspan='2'>简要战果</td>";
			html += "<td rowspan='2'>备注</td>";
			html += "</tr>";
			html += "<tr>";
			html += "<td>姓名</td>";
			html += "<td>职务</td>";
			html += "<td>电话</td>";
			html += "<td>民警</td>";
			html += "<td>特警</td>";
			html += "<td>协警</td>";
			html += "</tr>";
			html += "</tbody>";
			html += "</table>";
			html += "</div>";
		}
		$("#tableDiv").append(html);

	}
</script>
<script>
	function showTreemMean(obj, Id) {
		var cityObj = $("#" + Id);
		var cityOffset = $("#" + Id).offset();
		var leftv = cityOffset.left;
		var topv = cityOffset.top;
		var oh = cityObj.outerHeight();
		$('#textTree').css({
			left : leftv + "px",
			top : topv + oh + "px"
		}).slideDown("fast");
		;
		$("body").bind("mousedown", onBodyDown);
		gTargetId = Id;
	}

	function onBodyDown(event) {
		var str = event.target.id.substring(0, 4);
		if (str == "tree" && !(event.target.id.indexOf("span") > -1)) {
			return;
		} else {
			hideMenu();
		}
	}

	function hideMenu() {
		$('#textTree').fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}

	function changeStation(treeNode) {
		var selectv = document.getElementById('showTree');
		selectv.value = treeNode.name;
	}
</script>
<script>
	//点击事件变量，为true时在，则将坐标值赋予X，Y坐标
	var select_mapLG = false;
	var move = false;
	//选择坐标点击事件，修改变量select_mapLG 为true
	function selectMapLG() {
		if (move) {
			//delete
			var CoordinateY = document.getElementById('coordinateY');
			var CoordinateX = document.getElementById('coordinateX');
			map.PanAndZoom(CoordinateX.value, CoordinateY.value);
		}
		select_mapLG = true;

	}

	//赋予坐标行函数
	function getMapLGByClickFromOther(obj) {
		if (select_mapLG) {
			var CoordinateY = document.getElementById('coordinateY');
			var CoordinateX = document.getElementById('coordinateX');
			CoordinateX.value = obj[0];
			CoordinateY.value = obj[1];
		}
		select_mapLG = false;
		move = true;
	}
</script>
<script src="../js/jquery.ztree.all-3.1.min.js"></script>
<script src="../js/dateTime.js"></script>
<script src="../js/common.js?v=180725" type="text/javascript"></script>
<script src="../js/linq/linq.min.js"></script>
<script src="../js/dictCache.js"></script>
<script src="../js/IndexDB.js"></script>
<script src="../js/common/stationSelector.js?v=180612" charset="gb2312"></script>
</html>

