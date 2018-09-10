<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>节假日机关增援基层</title>
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
		<%@ include file="../shared/holidaySupportMenu.jsp"%>
		<div id="mainBody">
			<div class="layui-tab" lay-filter="demo" lay-allowclose="true">
				<ul class="layui-tab-title" style="background: #92b4f4;"
					id="tabTitle">
					<li class="layui-this">地图</li>
				</ul>
				<div class="layui-tab-content"
					style="border: 1px solid #ccc; border-top: none;" id="tabContent">
					<div class="layui-tab-item layui-show">
						<div id="mapDiv"></div>
					</div>
				</div>
			</div>
			<div id="pointDiv">
				<div id="formTop">
					<span>机场辖区</span><img src="../images/starlogo.png"><span
						onclick="closeMess(1)">X</span>
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
						<label class="layui-form-label">点位名称</label>
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
						<label class="layui-form-label">关联单位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="showTree" onclick="showTreemMean(this,this.id)"
								type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责领导</label>
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
							<input onclick="selectMapLG()" type="button" class="layui-btn"
								value="选择坐标" style="background: #4472ca; width: 92px;"></input>
							<button class="layui-btn" lay-submit lay-filter="formSave"
								style="background: #4472ca;">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;">停用</button>
						</div>
					</div>
				</form>
			</div>
			<div id="taskDiv">
				<div id="formTop">
					<span>机场辖区</span><img src="../images/starlogo.png"><span
						onclick="closeMess(2)">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">名称</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">起始时间</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">截至时间</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电话</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">联系人</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">要求人数</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电话</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" placeholder="请输入标题"
								autocomplete="off" class="layui-input">
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
						<div class="layui-input-inline"
							style="width: 354px; margin-right: 25px; float: right;">
							<input onclick="selectMapLG()" type="button" class="layui-btn"
								value="选择坐标" style="background: #4472ca; width: 92px;"></input>
							<button class="layui-btn" lay-submit lay-filter="formSave"
								style="background: #4472ca;">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="shiftTypeByTask"
								style="background: #4472ca;">排班</button>
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
						laydate.render({
							elem : '#date1',
							theme : '#4472ca'
						});
						laydate.render({
							elem : '#date2',
							theme : '#4472ca'
						});
						//监听提交
						form.on('submit(_search)', function(data) {
							return false;
						});
						form.on('submit(_new)', function(data) {
							showMessByTask();
							return false;
						});
						form
								.on(
										'submit(shiftTypeByTask)',
										function(data) {
											var tabTitles = document
													.getElementById("tabTitle").children;
											var tabContents = document
													.getElementById("tabContent").children;
											for (var i = 0; i < tabTitles.length; i++) {
												tabTitles[i].classList
														.remove("layui-this");
											}
											for (var j = 0; j < tabContents.length; j++) {
												tabContents[j].classList
														.remove("layui-show");
											}
											var html1 = "";// tabTitle
											var html2 = "";// tabContent
											html1 += "<li class='layui-this'>抗战胜利日排班</li>"
											$("#tabTitle").append(html1);
											html2 += "<div class='layui-tab-item layui-show'>";
											html2 += "<div class='layui-inline' id='makeOrder'>";
											html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeOrder()'>排班</button><button class='layui-btn layui-btn-primary layui-btn-sm'>导出</button>";
											html2 += "</div>";
											html2 += "<div class='layui-inline' id='makeSave' style='display: none;'>";
											html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeSave()'>保存</button>";
											html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeCancel()'>取消</button>";
											html2 += "</div><div class='layui-inline' style='width: 100%;'><div class='tableTitle'>机场辖区排班安排表</div></div>";
											html2 += "<table class='layui-table' style='text-align: center;'>";
											html2 += "<tbody>";
											html2 += "<tr>";
											html2 += "<td colspan='11'>抗战胜利日排班表2018-08-27</td>";
											html2 += "</tr>"
											html2 += "<tr>";
											html2 += "<td rowspan='2'>分局</td>";
											html2 += "<td rowspan='2'>勤务位置</td>";
											html2 += "<td rowspan='2'>具体区位、点位</td>";
											html2 += "<td rowspan='2'>部署警力数</td>";
											html2 += "<td colspan='2'>市局支援单位</td>";
											html2 += "<td colspan='2'>执勤人员名单</td>";
											html2 += "<td rowspan='2'>勤务时段</td>";
											html2 += "<td colspan='2'>基层所队负责领导</td>";
											html2 += "</tr>";
											html2 += "<tr>";
											html2 += "<td>名称</td>";
											html2 += "<td>人数</td>";
											html2 += "<td>上半段</td>";
											html2 += "<td>下半段</td>";
											html2 += "<td>姓名</td>";
											html2 += "<td>手机号</td>";
											html2 += "</tr>";
											html2 += "</tbody>";
											html2 += "</table>";
											html2 += "</div>";
											$("#tabContent").append(html2);
											layui
													.use(
															[ 'form',
																	'layedit',
																	'laydate',
																	'element' ],
															function() {
																var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
																var element = layui.element;
																element.init();
																laydate
																		.render({
																			elem : '#test3',
																			theme : '#4472ca'
																		});
																laydate
																		.render({
																			elem : '#test4',
																			theme : '#4472ca'
																		});
																laydate
																		.render({
																			elem : '#test5',
																			theme : '#4472ca'
																		});
																laydate
																		.render({
																			elem : '#test6',
																			theme : '#4472ca'
																		});
															});
											return false;
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
		map = PGISHelper.Init("mapDiv");
	});

	// 关闭详情页
	function closeMess(obj) {
		var pointDiv = document.getElementById("pointDiv");
		var taskDiv = document.getElementById("taskDiv");
		if (obj == 1) {
			pointDiv.style.display = "none";
		} else if (obj == 2) {
			taskDiv.style.display = "none";
		}
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

