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
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
<link rel="stylesheet" href="../layui/css/formSelects-v4.css">
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>
<script src="../js/jquery/jquery.js"></script>
<style>
#pointMess {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
	padding-bottom: 10px;
}

#pointMess::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#pointMess li {
	min-height: 24px;
	height: auto;
	line-height: 24px;
	font-size: 14px;
	padding-left: 20px;
	vertical-align: middle;
}

#pointMess li a {
	display: block;
	width: 100%;
	height: 100%;
	word-break: keep-all; /* 不换行 */
	white-space: nowrap; /* 不换行 */
	overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
	text-overflow: ellipsis;
	/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
}

#pointMess li:hover {
	background: #7fa7fe;
	cursor: pointer;
}

#taskMess {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
	padding-bottom: 10px;
}

#taskMess::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#task_talbe tr:hover {
	cursor: pointer;
}

#task_talbe tr td {
	font-size: 12px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<div id="width_left" class="layui-side">
					<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
					<div
						style="color: #000; border-radius: 0 10px 10px 0; border: 1px #cccccc solid; margin: 19px 0 2px 0; height: 4%;"
						class="menu_top">
						<span id="show_span" style="line-height: 30px;">节假日机关增援基层</span> <input
							id="show_hid" onclick="showAndHidMean()" type="button"
							style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
					</div>
					<div id="left_mean_body">
						<div style="display: block; text-align: center; margin-top: 10px;">
							<button class="layui-btn" style="background: #4472ca"
								onclick="changeUl(1)">点位</button>
							<button class="layui-btn" style="background: #4472ca"
								onclick="changeUl(2)">任务</button>
						</div>
						<div id="point_btn_div"
							style="text-align: center; padding-top: 10px;">
							<button id="showAllBtn_4" class="layui-btn layui-btn-primary"
								onclick="show_all_point()">
								<img id="show_all_img" src="../images/unchecked.png">显示全部
							</button>
							<button class="layui-btn layui-btn-primary"
								onclick="showMessByPoint()">新增点位</button>
						</div>
						<ul id="pointMess" style="display: block;">
						</ul>
						<div id="taskMess" style="display: none;">
							<form class="layui-form">
								<div class="layui-inline" style="margin-top: 5px;">
									<label class="layui-form-label" style="width: 30px;">名称</label>
									<div class="layui-input-inline">
										<input id="search_task_name" type="text" autocomplete="off"
											class="layui-input">
									</div>
								</div>
								<div class="layui-inline" style="margin-top: 5px;">
									<label class="layui-form-label" style="width: 30px;">时间</label>
									<div class="layui-input-inline" style="width: 100px;">
										<input type="text" id="date1" lay-verify="date1"
											autocomplete="off" class="layui-input">
									</div>
									<label>-</label>
									<div class="layui-input-inline"
										style="width: 100px; margin-top: 5px;">
										<input type="text" id="date2" lay-verify="date2"
											autocomplete="off" class="layui-input">
									</div>
								</div>
								<div
									style="display: block; text-align: center; margin-top: 5px;">
									<button class="layui-btn layui-btn-primary"
										onclick="search_Task()">搜索</button>
									<button class="layui-btn layui-btn-primary"
										onclick="showMessByTask()">新建</button>
								</div>
							</form>
							<table class="layui-table">
								<thead>
									<tr>
										<th>名称</th>
										<th>起始时间</th>
										<th>截至时间</th>
									</tr>
								</thead>
								<tbody id="task_table">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section>
		</aside>
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
					<span>点位信息</span><img src="../images/starlogo.png"><span
						onclick="closeMess(1)">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">编号</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input hidden id="id"> <input id="code" type="text"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">点位名称</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="name" type="text" name="title" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">X坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" id="coordinateX" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Y坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" id="coordinateY" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">关联单位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="stationName" data-id=""
								onclick="showTreemMean(this,this.id)" readonly="readonly"
								type="text" name="title" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline" style="width: 278px;">
							<textarea id="memo" name="desc" class="layui-textarea"
								style="width: 100%; resize: none;"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"></label>
						<div class="layui-input-inline" style="width: 278px;">
							<input onclick="selectMapLG()" type="button" class="layui-btn"
								value="选择坐标" style="background: #4472ca; width: 92px;"></input>
							<button id="savePoint" class="layui-btn"
								onclick="update_add_Point()" style="background: #4472ca;">保存信息</button>
							<button id="state" class="layui-btn" onclick="close_open()"
								style="background: #4472ca;">停用</button>
						</div>
					</div>
				</form>
			</div>
			<div id="taskDiv">
				<div id="formTop">
					<span>任务信息</span><img src="../images/starlogo.png"><span
						onclick="closeMess(2)">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">名称</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input hidden id="task_id"> <input id="task_name"
								type="text" name="title" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">起始时间</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_start_time" type="text" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">截至时间</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_stop_time" type="text" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_leader" type="text" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电话</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_tel" type="text" name="title" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">联系人</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_linkman" type="text" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">要求人数</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="task_require_count" type="text" name="title"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">选择点位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<select id="point_select" xm-select="point_select"
								xm-select-search="" xm-select-height="36px">
							</select>
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline" style="width: 278px;">
							<textarea id="task_memo" name="desc" class="layui-textarea"
								style="width: 100%; resize: none;"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-inline"
							style="width: 354px; margin-right: 25px; float: right;">
							<!-- 							<input onclick="selectMapLG()" type="button" class="layui-btn"
								value="选择坐标" style="background: #4472ca; width: 92px;"></input> -->
							<button class="layui-btn" lay-submit lay-filter="formSave"
								id="saveTask" onclick="task_save()" style="background: #4472ca;">保存信息</button>
							<button id="scheduling" class="layui-btn" lay-submit
								lay-filter="shiftTypeByTask" style="background: #4472ca;">排班</button>
							<!-- 			<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;">停用</button> -->
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
<script src="../layui/formSelects-v4.js"></script>
<script type="text/javascript">
	var formSelects = layui.formSelects;
	var arr = new Array();
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
						laydate.render({
							elem : '#task_start_time',
							theme : '#4472ca'
						});
						laydate.render({
							elem : '#task_stop_time',
							theme : '#4472ca'
						});
						//监听提交
						form.on('submit', function(data) {
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

	/* 初始化点位和任务列表 */
	var type;
	$(function() {
		PostData("base/baseDict/filter", createRequest(0, 10, "id",
				"name,string,=,节假日机关增援基层"), function(result) {
			type = result.data[0].id;
			reset_list(1);
			reset_list(2);
		})
	})

	/* 保存或新增任务 */
	function task_save() {
		var task_id = $('#task_id').val();
		var task_name = $('#task_name').val();
		var task_start_time = $('#task_start_time').val();
		var task_stop_time = $("#task_stop_time").val();
		var task_leader = $("#task_leader").val();
		var task_tel = $("#task_tel").val();
		var task_linkman = $("#task_linkman").val();
		var task_require_count = $("#task_require_count").val();
		var task_memo = $("#task_memo").val();
		var request = new Object();
		if (task_name) {
			request.name = task_name;
		}
		if (task_start_time) {
			request.fromTime = task_start_time;
		}
		if (task_stop_time) {
			request.toTime = task_stop_time;
		}
		if (task_leader) {
			request.leader = task_leader;
		}
		if (task_tel) {
			request.phone = task_tel;
		}
		if (task_linkman) {
			request.contactPerson = task_linkman;
		}
		if (task_require_count) {
			request.count = Number(task_require_count);
		}
		if (task_memo) {
			request.memo = task_memo;
		}
		var selectVal = formSelects.value('point_select');
		request.type = type;
		if (task_id) {//update
			request.id = task_id;
			PostData("duty/interceptTask/save", request, function(result) {
				/* for(var i = 0;i<selectVal.length;i++){
					var bean = new Object();
					bean.type=type;
					bean.pointInfoId=selectVal[i].value;
					bean.interceptTaskId=id;
					PostData("duty/interceptPoint/save", bean, function(result) {
					});
				} */
				/* 批量删除，批量增加 */
				closeMess(2);
				reset_list(2);
			});
		} else {//add
			request.state = "启用";
			PostData("duty/interceptTask/save", request, function(result) {
				var interceptTaskId = result.data.id;
				/* for(var i = 0;i<selectVal.length;i++){
					var bean = new Object();
					bean.type=type;
					bean.pointInfoId=selectVal[i].value;
					bean.interceptTaskId=interceptTaskId;
					PostData("duty/interceptPoint/save", bean, function(result) {
					});
				} */
				/*批量增加 */
				closeMess(2);
				reset_list(2);
			});
		}
	}
	/* 添加或更新点位信息 */
	function update_add_Point() {
		var id = document.getElementById("id").value;
		var request = new Object();
		if (document.getElementById("code").value) {
			request.code = document.getElementById("code").value;
		}
		if (document.getElementById("coordinateX").value) {
			request.longitude = document.getElementById("coordinateX").value;
		}
		if (document.getElementById("coordinateY").value) {
			request.latitude = document.getElementById("coordinateY").value;
		}
		if (document.getElementById("memo").value) {
			request.memo = document.getElementById("memo").value;
		}
		if (document.getElementById("name").value) {
			request.name = document.getElementById("name").value;
		}
		if (document.getElementById("stationName").getAttribute("data-id")) {
			request.stationId = document.getElementById("stationName")
					.getAttribute("data-id");
		}
		request.type = type;
		if (id) {//update
			request.id = id;
			PostData("point/point/save", request, function(result) {
				closeMess(1);
				reset_list(1);
			});
		} else {//add
			request.state = "启用";
			PostData("point/point/save", request, function(result) {
				closeMess(1);
				reset_list(1);
			});
		}
	}

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

	/* 生成关联单位下拉框 */
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
		var selectv = document.getElementById('stationName');
		selectv.value = treeNode.name;
		selectv.setAttribute("data-id", treeNode.id);
	}

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

	function close_open() {
		var state = document.getElementById("state").innerHTML;
		var request = new Object();
		request.id = document.getElementById("id").value;
		request.state = state == "启用" ? "启用" : "停用";
		PostData("point/point/save", request, function(result) {
			if (document.getElementById("state").innerHTML == "启用") {
				document.getElementById("state").innerHTML = "停用";
			} else {
				document.getElementById("state").innerHTML = "启用";
			}
			reset_list(1);
			closeMess(1);
		});
	}
	/* 重置列表 */
	function reset_list(obj) {
		/* 重置点位列表 */
		if (obj == 1) {
			var strConditions
			if (document.getElementById("show_all_img").src
					.indexOf("unchecked") != -1) {
				strConditions = "Type,string,=," + type + ";state,string,=,启用";
			} else {
				strConditions = "Type,string,=," + type;
			}
			PostData("point/point/filter", createRequest(0, 1000, "id",
					strConditions), function(result) {
				var pointsMess = result.data;
				$("#pointMess").empty();
				var html = '';
				for (var i = 0; i < pointsMess.length; i++) {
					var pointMess = pointsMess[i];
					if (pointMess.name) {
						html += '<li id="point_' + pointMess.id
								+ '" onclick="showMessByPoint(' + pointMess.id
								+ ')"><a>市局_' + pointMess.name;
					} else {
						html += '<li id="point_' + pointMess.id
								+ '" onclick="showMessByPoint(' + pointMess.id
								+ ')"><a>市局_未命名';
					}
					html += '</a></li>';
				}
				$("#pointMess").append(html);
			});
			/* 重置任务列表 */
		} else if (obj == 2) {
			var strConditions2 = "Type,string,=," + type;
			PostData("duty/interceptTask/filter", createRequest(0, 1000, "id",
					strConditions2), function(result) {
				var taskArray = result.data;
				$("#task_table").empty();
				var html = '';
				for (var i = 0; i < taskArray.length; i++) {
					var taskMess = taskArray[i];
					html += '<tr onclick="showMessByTask(' + taskMess.id
							+ ')">'
					if (taskMess.name) {
						html += '<td>' + taskMess.name + '</td>';
					} else {
						html += '<td>未命名</td>';
					}
					if (taskMess.fromTime) {
						html += '<td>' + taskMess.fromTime.substring(0, 11)
								+ '</td>';
					} else {
						html += '<td></td>';
					}
					if (taskMess.toTime) {
						html += '<td>' + taskMess.toTime.substring(0, 11)
								+ '</td>';
					} else {
						html += '<td></td>';
					}
					html += '</tr>';
				}
				$("#task_table").append(html);
			});
		}
	}

	function show_all_point() {
		var strConditions
		if (document.getElementById("show_all_img").src.indexOf("unchecked") != -1) {
			strConditions = "Type,string,=," + type;
			document.getElementById("show_all_img").setAttribute("src",
					"../images/checked.png");
		} else {
			strConditions = "Type,string,=," + type + ";state,string,=,启用";
			document.getElementById("show_all_img").setAttribute("src",
					"../images/unchecked.png");
		}
		PostData("point/point/filter", createRequest(0, 1000, "id",
				strConditions), function(result) {
			var pointsMess = result.data;
			$("#pointMess").empty();
			var html = '';
			for (var i = 0; i < pointsMess.length; i++) {
				var pointMess = pointsMess[i];
				if (pointMess.name) {
					html += '<li id="point_' + pointMess.id
							+ '" onclick="showMessByPoint(' + pointMess.id
							+ ')"><a>市局_' + pointMess.name;
				} else {
					html += '<li id="point_' + pointMess.id
							+ '" onclick="showMessByPoint(' + pointMess.id
							+ ')"><a>市局_未命名';
				}
				html += '</a></li>';
			}
			$("#pointMess").append(html);
		});
	}
	function showAll(obj) {
		var tag = $(obj).parent().children();
		for (var i = 0; i < tag.length; i++) {
			if (tag[i].localName == "ul") {
				var display = tag[i].style.display;
				if (display == "block") {
					tag[i].style.display = "none";
				} else if (display == "none") {
					tag[i].style.display = "block";
				}
			}
		}
	}

	function showAllBtn(obj) {
		var src = $(obj).children().attr("src");
		if (src == "../images/checked.png") {
			$(obj).children().attr("src", "../images/unchecked.png");
		} else if (src == "../images/unchecked.png") {
			$(obj).children().attr("src", "../images/checked.png");
		}
	}

	function showMessByPoint(data) {
		var id = data;
		var pointDiv = document.getElementById("pointDiv");
		//回显数据
		if (id) {
			var strConditions = "id,string,=," + id;
			PostData(
					"point/point/filter",
					createRequest(0, 1000, "id", strConditions),
					function(result) {
						pointDiv.style.display = "block";
						document.getElementById("savePoint").innerHTML = "保存信息";
						document.getElementById("state").style.display = "inline";
						document.getElementById("id").value = result.data[0].id;
						document.getElementById("code").value = result.data[0].code == undefined ? ""
								: result.data[0].code;
						document.getElementById("coordinateY").value = result.data[0].latitude == undefined ? ""
								: result.data[0].latitude;
						document.getElementById("coordinateX").value = result.data[0].longitude == undefined ? ""
								: result.data[0].longitude;
						document.getElementById("memo").value = result.data[0].memo == undefined ? ""
								: result.data[0].memo;
						document.getElementById("name").value = result.data[0].name == undefined ? ""
								: result.data[0].name;
						document.getElementById("stationName").value = result.data[0].stationName == undefined ? ""
								: result.data[0].stationName;
						if (result.data[0].stationId) {
							document.getElementById("stationName")
									.setAttribute("data-id",
											result.data[0].stationId);
						} else {
							document.getElementById("stationName")
									.setAttribute("data-id", "");
						}
						if (result.data[0].state == "启用") {
							document.getElementById("state").innerHTML = "停用";
						} else if (result.data[0].state == "停用") {
							document.getElementById("state").innerHTML = "启用";
						}
					})
			//新增数据
		} else {
			pointDiv.style.display = "block";
			document.getElementById("state").style.display = "none";
			document.getElementById("savePoint").innerHTML = "新增保存";
			document.getElementById("code").value = "";
			document.getElementById("id").value = "";
			document.getElementById("coordinateY").value = "";
			document.getElementById("coordinateX").value = "";
			document.getElementById("memo").value = "";
			document.getElementById("name").value = "";
			document.getElementById("stationName").value = "";
			document.getElementById("stationName").setAttribute("data-id", "");
		}
	}
	/* 显示任务详细 */
	function showMessByTask(data) {
		arr = new Array();
		var taskDiv = document.getElementById("taskDiv");
		var scheduling = document.getElementById("scheduling");
		//回显数据
		if (data) {
			var id = data;
			var strConditions = "id,string,=," + id;
			PostData(
					"duty/interceptTask/filter",
					createRequest(0, 1000, "id", strConditions),
					function(result) {
						//更新点位下拉框option
						PostData("point/point/filter", createRequest(0, 1000,
								"id", "Type,string,=," + type + ""), function(
								result) {
							var data = result.data;
							$("#point_select").empty();
							var html = "";
							for (var i = 0; i < data.length; i++) {
								html += "<option value='"+data[i].id+"'>"
										+ data[i].name + "</option>";
							}
							$("#point_select").append(html);
							
							formSelects.render("point_select");
							//查找点位设置做回显
							PostData("duty/interceptPoint/filter", createRequest(0, 1000,
								"id", "Type,string,=," + type + ";interceptTaskId,string,=," + id), function(
								result) {
								var data = result.data;
								for ( var i = 0;i<data.length;i++) {
									arr[i]=data[i].pointInfoId;
								}
								formSelects.value('point_select', arr);
							});
						});
						taskDiv.style.display = "block";
						scheduling.style.display = "inline";
						document.getElementById("saveTask").innerHTML = "保存信息";
						document.getElementById("task_id").value = result.data[0].id;
						document.getElementById("task_name").value = result.data[0].name == undefined ? ""
								: result.data[0].name;
						document.getElementById("task_start_time").value = result.data[0].fromTime == undefined ? ""
								: result.data[0].fromTime.substring(0, 11);
						document.getElementById("task_stop_time").value = result.data[0].toTime == undefined ? ""
								: result.data[0].toTime.substring(0, 11);
						document.getElementById("task_leader").value = result.data[0].leader == undefined ? ""
								: result.data[0].leader;
						document.getElementById("task_tel").value = result.data[0].phone == undefined ? ""
								: result.data[0].phone;
						document.getElementById("task_linkman").value = result.data[0].contactPerson == undefined ? ""
								: result.data[0].contactPerson;
						document.getElementById("task_require_count").value = result.data[0].count == undefined ? ""
								: result.data[0].count;
						document.getElementById("task_memo").value = result.data[0].memo == undefined ? ""
								: result.data[0].memo;
					});
			//新增数据
		} else {
			//更新点位下拉框option
			PostData("point/point/filter", createRequest(0, 1000,
					"id", "Type,string,=," + type + ""), function(
					result) {
				var data = result.data;
				$("#point_select").empty();
				var html = "";
				for (var i = 0; i < data.length; i++) {
					html += "<option value='"+data[i].id+"'>"
							+ data[i].name + "</option>";
				}
				$("#point_select").append(html);
				formSelects.render("point_select");
			});
			taskDiv.style.display = "block";
			scheduling.style.display = "none";
			document.getElementById("saveTask").innerHTML = "新增保存";
			document.getElementById("task_id").value = "";
			document.getElementById("task_name").value = "";
			document.getElementById("task_start_time").value = "";
			document.getElementById("task_stop_time").value = "";
			document.getElementById("task_leader").value = "";
			document.getElementById("task_tel").value = "";
			document.getElementById("task_linkman").value = "";
			document.getElementById("task_require_count").value = "";
			document.getElementById("task_memo").value = "";

		}
	}

	function changeUl(obj) {
		var pointMess = document.getElementById("pointMess");
		var taskMess = document.getElementById("taskMess");
		var point_btn_div = document.getElementById("point_btn_div");
		if (obj == 1) {
			taskMess.style.display = "none";
			pointMess.style.display = "block";
			point_btn_div.style.display = "block";
		} else if (obj == 2) {
			pointMess.style.display = "none";
			taskMess.style.display = "block";
			point_btn_div.style.display = "none";
		}
	}

	// 请求参数
	function createRequest(page, pageSize, orderField, strCondition) {
		var request = new Object();
		var conditions = new Array();
		request.page = page;
		request.pageSize = pageSize;
		request.orderField = orderField;
		var items = strCondition.split(";")
		for (var i = 0; i < items.length; i++) {
			var temps = items[i].split(",");
			var condition = new Object();
			condition.fieldName = temps[0];
			condition.fieldType = temps[1];
			condition.opt = temps[2];
			condition.value = temps[3];
			if (temps.length > 4) {
				for (var j = 0; j < temps.length - 4; j++) {
					condition.value += "," + temps[4 + j];
				}
			}
			conditions.push(condition);
		}
		request.conditions = conditions;
		return request;
	}

	function search_Task() {
		var search_task_name = $("#search_task_name").val();
		var date1 = $("#date1").val();
		var date2 = $("#date2").val();
		var strConditions2 = "Type,string,=," + type;
		if (search_task_name) {
			strConditions2 += ";name,string,=," + search_task_name
		}
		if (date1) {
			strConditions2 += ";fromTime,string,=," + date1
		}
		if (date2) {
			strConditions2 += ";toTime,string,=," + date2
		}
		PostData("duty/interceptTask/filter", createRequest(0, 1000, "id",
				strConditions2),
				function(result) {
					var taskArray = result.data;
					$("#task_table").empty();
					var html = '';
					for (var i = 0; i < taskArray.length; i++) {
						var taskMess = taskArray[i];
						html += '<tr onclick="showMessByTask(' + taskMess.id
								+ ')">'
						if (taskMess.name) {
							html += '<td>' + taskMess.name + '</td>';
						} else {
							html += '<td>未命名</td>';
						}
						if (taskMess.fromTime) {
							html += '<td>' + taskMess.fromTime.substring(0, 11)
									+ '</td>';
						} else {
							html += '<td></td>';
						}
						if (taskMess.toTime) {
							html += '<td>' + taskMess.toTime.substring(0, 11)
									+ '</td>';
						} else {
							html += '<td></td>';
						}
						html += '</tr>';
					}
					$("#task_table").append(html);
				});
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

