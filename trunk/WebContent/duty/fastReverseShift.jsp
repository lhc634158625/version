<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>135快反圈排班</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/fastReverseShift.css">
<link rel="stylesheet" href="../layui/css/formSelects-v4.css">
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>
<style>
.input-border{
	border: none;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/fastReverseShiftMenu.jsp"%>
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
										<input type="checkbox" name="like1[write]" lay-skin="primary"
											title="<img src='../images/gray1.png'><img src='../images/blue1.png'>&nbsp;一分钟 ">
										<input type="checkbox" name="like1[read]" lay-skin="primary"
											title="<img src='../images/gray3.png'><img src='../images/blue3.png'>&nbsp;三分钟">
										<input type="checkbox" name="like1[read]" lay-skin="primary"
											title="<img src='../images/gray5.png'><img src='../images/blue5.png'>&nbsp;五分钟">
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
					<span id="topName"></span><img src="../images/starlogo.png"><span
						onclick="closeMess()">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">编号</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="number" id="number" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">巡逻区域</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="name" id="name" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">区域以辐射范围</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="description" id="description"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" style="display: none;">
						<label class="layui-form-label">区域类型</label>
						<div class="layui-input-inline" style="width: 278px;">
							<select name="patrolType" id="patrolType" lay-search="">
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">X坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="latitude" id="latitude"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Y坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="longitude" id="longitude"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">关联单位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input id="stationName" readonly="readonly" type="text"
								onclick="showTreemMean(this)" name="stationName"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" style="display: none;">
						<label class="layui-form-label">组别</label>
						<div class="layui-input-inline" style="width: 278px;">
							<select name="group" id="group" lay-search="">
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">代码</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="code" id="code" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电台值守组</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="radioGroup" id="radioGroup" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline" style="width: 278px;">
							<textarea name="memo" id="memo" class="layui-textarea"
								style="width: 100%; resize: none;"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"></label>
						<div class="layui-input-inline" style="width: 278px;">
							<button class="layui-btn" lay-submit lay-filter="formChose"
								style="background: #4472ca;" onclick="getCoordinate()">选择坐标</button>
							<button class="layui-btn" lay-submit lay-filter="formSave"
								style="background: #4472ca;" id="whole_savePopedomMess">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;" id="stop">停用</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="divTree"
		style="position: absolute; overflow: auto; border: solid 1px #ccc; background-color: #fff; height: 150px; min-width: 278px;z-index: 2;">
		<ul id="tree" class="ztree" style="z-index: 2;"></ul>
	</div>
	<div id="staffDiv" style="position: absolute;display: none; border: solid 1px #ccc; background-color: #fff;width: 350px;z-index: 1;">
		<div class="layui-form-item" style="width: 300px;margin: 5px auto;">
			<label class="layui-form-label" style="text-align: left;width: auto">单位</label>
			<div class="layui-input-inline" style="float: right;">
			<input readonly="readonly" onclick="showTreemMean(this)"
					autocomplete="off" class="layui-input" style="width: 200px;">
			</div>
		</div>
		<div style="width: 300px;margin: 5px auto;">
			<select name="city" xm-select="select9" xm-select-search="" xm-select-create="" xm-select-height="36px">
			<option value="1">北京</option>
			<option value="2">上海</option>
			<option value="3">广州</option>
			<option value="4">深圳</option>
			<option value="5">天津</option>
			</select>
		</div>
	</div>
</body>

<script src="../layui/formSelects-v4.js"></script>
<script type="text/javascript">
	var formSelects = layui.formSelects;
	formSelects.value('select9');
</script>
<script type="text/javascript">
	var map;
	layui
			.use(
					[ 'form', 'layedit', 'laydate', 'table'],
					function() {
						var form = layui.form,
						layer = layui.layer,
						layedit = layui.layedit,
						laydate = layui.laydate,
						table = layui.table,
						element = layui.element;
						//自定义颜色
						laydate.render({
							elem : '#test1',
							theme : '#4472ca'
						});
						laydate.render({
							elem : '#test2',
							theme : '#4472ca'
						});

						form.on('submit', function(data){
						    return false;
						});

						window.layuiRender = function() {
							form.render();
							table.render();
							element.init();
						};
						
						window.dateRender = function(identify) {
							laydate.render({
								elem : '#searchBegin_'+identify,
								theme : '#4472ca'
							});
							laydate.render({
								elem : '#searchEnd_'+identify,
								theme : '#4472ca'
							});
							laydate.render({
								elem : '#schedulBegin_'+identify,
								theme : '#4472ca'
							});
							laydate.render({
								elem : '#schedulEnd_'+identify,
								theme : '#4472ca'
							});
						};
						
						
						window.addTimeSpanRender = function(key) {
							var timeSpanList = whole_addTimeSpanMap.get(key);
							for(var i=0;i<timeSpanList.length;i++){
								laydate.render({
									elem : '#addTimeSpan_'+key+'_'+timeSpanList[i],
									type: 'time',
									theme : '#4472ca',
									format: 'HH:mm',
								    range: true
								});
							}
						};
						window.editTimeSpanRender = function(identify,length) {
							for(var i=0;i<length;i++){
								laydate.render({
									elem : '#timespan'+i+'-'+identify,
									type: 'time',
									theme : '#4472ca',
									format: 'HH:mm',
								    range: true
								});
							}
						};
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

	// 点击排班出现操作栏
	function makeOrder(identify) {
		var fromDate = document.getElementById("searchBegin_"+identify).value;
		var toDate = document.getElementById("searchEnd_"+identify).value;
		var makeSave = document.getElementById("makeSave_"+identify);
		var makeOrder = document.getElementById("makeOrder_"+identify);
		if(fromDate!=toDate){
			return;
		}
		var item = whole_ClickMenuMap.get(identify).split(",");
		//$('#shiftTable_'+index).remove();
		var html="<table class='layui-table' style='text-align: center;' id='shiftTable_"+identify+"'>";
		html += CreateHeadHtml(item[2],fromDate,1);
		html += CreateBodyHtml(item[0],item[1],fromDate,toDate,0,identify);
		html += "</table>";
		document.getElementById('shiftTableDiv_'+identify).innerHTML=html;
		var tbody=document.getElementById("shiftTable_"+identify);			
		if(item[2]!=1){
			autoRowSpanByPreItem(tbody,3,1);
		}
		autoRowSpan(tbody,3,0);	
		addTimeSpanRender(identify);
		makeSave.removeAttribute("style");
		makeOrder.style.display = "none";
		editTimeSpanRender(identify,whole_timeSpanIDMap.get(identify));
	}

	// 保存排班
	function makeSave(identify) {
		var makeSave = document.getElementById("makeSave_"+identify);
		var makeOrder = document.getElementById("makeOrder_"+identify);
		makeOrder.removeAttribute("style");
		makeSave.style.display = "none";
	}

	// 取消排班
	function makeCancel(identify) {
		var makeSave = document.getElementById("makeSave_"+identify);
		var makeOrder = document.getElementById("makeOrder_"+identify);
		makeOrder.removeAttribute("style");
		makeSave.style.display = "none";
	}
</script>
<script type="text/javascript">
	var whole_shiftId;// 字典排班类型code
	var whole_stationId;// 字典单位code
	var whole_patrolTypeList;// 字典两分钟、三分钟code
	var whole_typeByOne;// 字典1分钟code
	var whole_formDiv = document.getElementById("formDiv");// 详细信息框
	var whole_topName = document.getElementById("topName");// 详细框信息名称
	var whole_number = document.getElementById("number");// 编号
	var whole_name = document.getElementById("name");// 巡逻区域
	var whole_description = document.getElementById("description");// 区域及辐射范围
	var whole_patrolType = document.getElementById("patrolType");// 区域类型
	var whole_latitude = document.getElementById("latitude");// x坐标
	var whole_longitude = document.getElementById("longitude");// y坐标
	var whole_code = document.getElementById("code");// 代码
	var whole_group = document.getElementById("group");// 组别
	var whole_radioGroup = document.getElementById("radioGroup");// 电台值守组
	var whole_stationName = document.getElementById("stationName");// 关联单位
	var whole_stationId;// 关联单位id
	var whole_memo = document.getElementById("memo");// 备注
	var whole_stop = document.getElementById("stop");// 停用
	var whole_savePopedomMess = document.getElementById("whole_savePopedomMess");// 保存信息按钮
	var whole_codeId = "";// 代码id
	var whole_radioGroupId = "";// 电台值守组id
	var whole_groupId = "";// 组别id
	var whole_subStation=new Array();
	var whole_pointInfoMap=new Map();
	var showClickTimes = 1;// 点击显示表格标识
	var whole_ClickMenuMap  =new Map();//选项卡对应数据
	var whole_addTimeSpanMap = new Map();// 新增时间段list
	var whole_timeSpanIDMap=new Map();//时间控件map
	// 获取分局信息
	$(function() {
		whole_patrolTypeList = new Array()
		PostData("base/baseDict/filter", createRequest(0, 10, "id",
				"DictName,string,=,PointInfo"),
				function(result) {					
					for (var i=0;i<result.data.length;i++) {
						if(result.data[i].name == "135排班"){
							whole_shiftId = result.data[i].id;
							whole_pointInfoMap.set(result.data[i].name,result.data[i].id);
						}
					}
					whole_pointInfoMap = getPointInfo(result.data, whole_shiftId, whole_pointInfoMap);
					whole_stationId = whole_pointInfoMap.get("分局");
					var arr = ["1分钟", "3分钟", "5分钟"];
					for(var i=0;i<arr.length;i++){
						if(arr[i] != "1分钟"){
							whole_patrolTypeList.push(arr[i] + "," + whole_pointInfoMap.get(arr[i]));
						}else{
							whole_typeByOne = whole_pointInfoMap.get(arr[i]);
						}
					}
					var strConditions = "Type,string,=," + whole_stationId;
					PostData(
							"point/point/filter",
							createRequest(0, 1000, "id",
									strConditions),
							function(result) {
								var stationsMess = result.data;
								$("#stationType").empty();
								var html = '';
								for (var i = 0; i < stationsMess.length; i++) {
									var stationMess = stationsMess[i];
									whole_subStation.push(stationMess.name);
									var minutesType;
									if(stationMess.id == 1){
										minutesType = 1;
									}else{
										minutesType = 2;
									}
									html += '<li id="station_'
											+ stationMess.id
											+ '" onclick="showAll(this)">'
											+ stationMess.name
											+ '<img class="common_img" src="../images/starlogo.png" onclick="showTable('+stationMess.id+',2,'+minutesType+',\''+stationMess.name+'\')">';
									html += '<ul style="display: none; width: 100%; background: white;" onclick="cancelBubble()">';
									html += '<li style="width: 100%; height: auto; background: white;">';
									html += '<div>分局(队伍驻地):</div>';
									html += '<form class="layui-form" style="padding-bottom: 8px; width: 227px; margin-left: 20px;">';
									html += '<textarea id="textarea_' + stationMess.id + '" class="layui-textarea" style="resize: none;">';
									if(typeof(stationMess.memo)!="undefined"){
										html += stationMess.memo;
									}
									html += '</textarea>';
									html += '<button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit="" style="width: 227px; margin-top: 5px;" onclick="saveResidentMess('
											+ stationMess.id + ')">保存信息</button>';
									html += '</form>';
									html += '<div>';
									html += '<button class="layui-btn layui-btn-primary" onclick="showMess('
											+ stationMess.id
											+ ')">增加巡逻点</button>';
									html += '<button id="showAllBtn_' + stationMess.id + '" class="layui-btn layui-btn-primary" onclick="showAllBtn(this,'
											+ stationMess.id
											+')">';
									html += '<img class="form_img" src="../images/unchecked.png">显示全部';
									html += '</button>';
									html += '</div>';
									html += '<ul id="popedoms_'+stationMess.id+'">';
									html += '</ul>';
									html += '</li>';
									html += '</ul>';
									html += '</li>';
								}
								$("#stationType").append(
										html);
							});
				})
	})
	
	// 获取135排班所有的id
	function getPointInfo(result, id, pointInfoMap) {
		for(var i=0;i<result.length;i++){	
			if(result[i].pid==id){
				pointInfoMap.set(result[i].name, result[i].id);
				getPointInfo(result, result[i].id, pointInfoMap);				
			}
		}
		return pointInfoMap;
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
			if(temps.length>4){
				for(var j=0;j<temps.length-4;j++){
					condition.value +=","+temps[4+j];
				}
			}
			conditions.push(condition);
		}
		request.conditions = conditions;
		return request;
	}

	// 点击分局获取辖区
	function showAll(obj) {
		var tag = $(obj).children();
		var pid = $(obj).attr("id").replace("station_", "");
		for (var i = 0; i < tag.length; i++) {
			if (tag[i].localName == "ul") {
				var display = tag[i].style.display;
				if (display == "block") {
					$(obj).removeClass("liL1");
					document.getElementById("showAllBtn_" + pid).firstChild.src = "../images/unchecked.png";
					$("#popedoms_" + pid + "").empty();
					tag[i].style.display = "none";
				} else if (display == "none") {
					var strConditions = "pid,string,=," + pid;
					PostData(
							"point/point/filter",
							createRequest(0, 1000, "id", strConditions),
							function(result) {
								var popedoms = result.data;
								$("#popedoms_" + pid + "").empty();
								var html = '';
								for (var i = 0; i < popedoms.length; i++) {
									var popedom = popedoms[i];
									html += '<li id="popedom_'
											+ popedom.id
											+ "_"
											+ pid +'"';
									var minutesType;
									if(pid == 1){
										minutesType = 1;
									}else{
										minutesType = 2;
									}
									if(popedom.state != "启用"){
										html += 'style="display: none;"';
									}
									html += ' onclick="showMess(this,\'' + popedom.state + '\')" class="areaStyle">';
									html += '<img class="areaStyle_img" src="../images/diamond.png">';
									html += popedom.name;
									html += '<img class="common_img" src="../images/starlogo.png" onclick="showTable('+popedom.id+',3,'+minutesType+',\''+popedom.name+'\')">';
									html += '</li>';
								}
								$("#popedoms_" + pid + "").append(html);
							})
					$(obj).addClass("liL1");
					tag[i].style.display = "block";
				}
			}
		}
	}

	// 显示辖区信息或者显示添加辖区信息
	function showMess(obj,strState) {
		closeMess();
		if(strState == "停用"){
			whole_stop.innerText = "启用";
		}else if(strState == "启用"){
			whole_stop.innerText = "停用";
		}
		if (isNaN(obj)) {
			var popedom_id = $(obj).attr("id").split("_")[1];
			var station_id = $(obj).attr("id").split("_")[2];
			PostData(
					"point/point/get",
					popedom_id,
					function(result) {
						var popedom = result.data;
						if(typeof(popedom.name) != "undefined"){
							whole_topName.innerText = popedom.name;
						}
						if(typeof(popedom.code) != "undefined"){
							whole_number.value = popedom.code;
						}
						if(typeof(popedom.name) != "undefined"){
							whole_name.value = popedom.name;
						}
						if(typeof(popedom.description) != "undefined"){
							whole_description.value = popedom.description;
						}
						if(typeof(popedom.latitude) != "undefined"){
							whole_latitude.value = popedom.latitude;
						}
						if(typeof(popedom.longitude) != "undefined"){
							whole_longitude.value = popedom.longitude;
						}
						if(typeof(popedom.stationName) != "undefined"){
							whole_stationName.value = popedom.stationName;
						}
						if(typeof(popedom.stationId) != "undefined"){
							whole_stationId = popedom.stationId;
						}
						if(typeof(popedom.memo) != "undefined"){
							whole_memo.value = popedom.memo;
						}
						if(typeof(popedom.state) != "undefined"){
							whole_stop.value = popedom.state;
						}
						whole_savePopedomMess.setAttribute("onclick", "savePopedomMess("+popedom.pid+","+popedom.id+")"); 
						whole_stop.setAttribute("onclick", "stopPopedom("+popedom.pid+","+popedom.id+")"); 
						var group;
						for(var i=0;i<popedom.pointInfoDevices.length;i++){
							if(popedom.pointInfoDevices[i].deviceTypeName == "代码"){
								whole_code.value = popedom.pointInfoDevices[i].value;
								whole_codeId = popedom.pointInfoDevices[i].id;
							}
							if(popedom.pointInfoDevices[i].deviceTypeName == "电台值守组"){
								whole_radioGroup.value = popedom.pointInfoDevices[i].value;
								whole_radioGroupId = popedom.pointInfoDevices[i].id;
							}
							if(popedom.pointInfoDevices[i].deviceTypeName == "组别"){
								group = popedom.pointInfoDevices[i].value;
								whole_groupId = popedom.pointInfoDevices[i].id;
							}
						}
						if (station_id != 1) {
							createOpt(whole_patrolTypeList,popedom.type,whole_patrolType);
							layuiRender();
							whole_patrolType.parentNode.parentNode.style.display = "block";
						}else{
							var optArr = ["无,无","PTU一组,PTU一组","PTU二组,PTU二组","PTU三组,PTU三组","PTU四组,PTU四组","PTU五组,PTU五组"];
							createOpt(optArr,group,whole_group);
							layuiRender();
							whole_group.parentNode.parentNode.style.display = "block";
						}
						whole_formDiv.style.display = "block";
					})
		}else{
			whole_savePopedomMess.setAttribute("onclick", "savePopedomMess("+obj+",\"\")");
			whole_stop.setAttribute("onclick", "stopPopedom(-1)"); 
			whole_topName.innerText = "新增巡逻点";
			if (obj != 1) {
				createOpt(whole_patrolTypeList,0,whole_patrolType);
				layuiRender();
				whole_patrolType.parentNode.parentNode.style.display = "block";
			}else{
				var optArr = ["无,无","PTU一组,PTU一组","PTU二组,PTU二组","PTU三组,PTU三组","PTU四组,PTU四组","PTU五组,PTU五组"];
				createOpt(optArr,"无",whole_group);
				layuiRender();
				whole_group.parentNode.parentNode.style.display = "block";
			}
			whole_formDiv.style.display = "block";
		}
	}

	// 关闭辖区信息或者关闭添加辖区信息
	function closeMess() {
		// 清空input的值
		whole_topName.innerText = "";
		whole_number.value = "";
		whole_name.value = "";
		whole_description.value = "";
		whole_latitude.value = "";
		whole_longitude.value = "";
		whole_group.value = "";
		whole_radioGroup.value = "";
		whole_code.value = "";
		whole_stationName.value = "";
		whole_memo.value = "";
		whole_stop.innerText = "停用";// 默认停用
		whole_codeId = "";
		whole_radioGroupId = "";
		whole_groupId = "";
		// 删除巡逻类型所有option
		whole_patrolType.options.length = 0;
		// 隐藏巡逻类型select
		whole_patrolType.parentNode.parentNode.style.display = "none";
		// 删除组别所有option
		whole_group.options.length = 0;
		// 隐藏组别select
		whole_group.parentNode.parentNode.style.display = "none";
		// 隐藏详细信息框
		whole_formDiv.style.display = "none";
	}

	// 创建option
	function createOpt(optArr ,value , name) {
		for(var i=0;i<optArr.length;i++){
			if(optArr[i].split(",")[0] != "1分钟"){
				name.options.add(new Option(optArr[i].split(",")[0],optArr[i].split(",")[1]));
			}
		}
		for (var i = 0; i < name.options.length; i++) {
			if (value == name.options[i].value) {
				name.options[i].selected = 'selected';
			}
		}
	}
	
	// 显示全部
	function showAllBtn(obj,id) {
		var src;
		var popedoms = document.getElementById("popedoms_"+id).childNodes;
		if(typeof(obj)=="number"){
			src = document.getElementById("showAllBtn_"+id).getElementsByTagName("img")[0].src;
			if (src.indexOf("/images/checked.png") != -1) {
				for(var i=0;i<popedoms.length;i++){
					if(popedoms[i].hasAttribute("style")){
						popedoms[i].style.display = "block";
					}
				}
			} else if (src.indexOf("/images/unchecked.png") != -1) {
				for(var i=0;i<popedoms.length;i++){
					if(popedoms[i].hasAttribute("style")){
						popedoms[i].style.display = "none";
					}
				}
			}
		}else{
			src = $(obj).children().attr("src");
			if (src == "../images/checked.png") {
				$(obj).children().attr("src", "../images/unchecked.png");
				for(var i=0;i<popedoms.length;i++){
					if(popedoms[i].hasAttribute("style")){
						popedoms[i].style.display = "none";
					}
				}
			} else if (src == "../images/unchecked.png") {
				$(obj).children().attr("src", "../images/checked.png");
				for(var i=0;i<popedoms.length;i++){
					if(popedoms[i].hasAttribute("style")){
						popedoms[i].style.display = "block";
					}
				}
			}
		}
	}
	
	// 保存驻地信息
	function saveResidentMess(id) {
		var textarea = document.getElementById("textarea_" + id);
		var request = new Object();
		request.id = id;
		request.memo = textarea.value;
		PostData("point/point/save",request,function(result) {
		});
	}
	
	// 保存辖区信息
	function savePopedomMess(pid,id) {
		var request = new Object();
		request.pid = pid;
		var pointInfoId = "";
		if(id != "" && id != null){
			request.id = id;
			pointInfoId = id;
		}
		if(whole_number.value != "" && whole_number.value != null){
			request.code = whole_number.value;
		}
		if(whole_name.value != "" && whole_name.value != null){
			request.name = whole_name.value;
		}
		if(whole_description.value != "" && whole_description.value != null){
			request.description = whole_description.value;
		}
		if(whole_patrolType.value != "" && whole_patrolType.value != null){
			request.type = parseInt(whole_patrolType.value);
		}else{
			request.type = whole_typeByOne;
		}
		if(whole_latitude.value != "" && whole_latitude.value != null){
			request.latitude = whole_latitude.value;
		}
		if(whole_longitude.value != "" && whole_longitude.value != null){
			request.longitude = whole_longitude.value;
		}
		if(whole_stationName != "" && whole_stationName.value != null){
			request.stationId = whole_stationId;
		}
		if(whole_memo.value != "" && whole_memo.value != null){
			request.memo = whole_memo.value;
		}
		request.state = "启用";
		var strPointInfoDevice = whole_codeId + "," + pointInfoId + "," + whole_code.value + "," + whole_code.parentNode.parentNode.firstElementChild.innerText + ";" 
								+ whole_groupId + "," + pointInfoId + "," + whole_group.value + "," + whole_group.parentNode.parentNode.firstElementChild.innerText + ";" 
								+ whole_radioGroupId + "," + pointInfoId + "," + whole_radioGroup.value + "," + whole_radioGroup.parentNode.parentNode.firstElementChild.innerText;
		request.pointInfoDevices = createPointInfoDevices(strPointInfoDevice);
		PostData("point/point/save",request,function(result) {
			window.location.reload();
		});
	}
	
	// 设备信息
	function createPointInfoDevices(strPointInfoDevice) {
		var pointInfoDevices = new Array();
		var pointInfoDeviceList = strPointInfoDevice.split(";");
		for(var i=0;i<pointInfoDeviceList.length;i++){
			var temps = pointInfoDeviceList[i].split(",");
			var pointInfoDevice = new Object();
			if(temps[0] != "" && temps[0] != null){
				pointInfoDevice.id = temps[0];
			}
			if(temps[1] != "" && temps[1] != null){
				pointInfoDevice.pointInfoId = temps[1];
			}
			if(temps[2] == "" || temps[2] == null){
				continue;
			}
			pointInfoDevice.value = temps[2];
			if(temps[3] != "" && temps[3] != null){
				pointInfoDevice.deviceTypeName = temps[3];
			}
			pointInfoDevices.push(pointInfoDevice);
		}
		return pointInfoDevices;
	}
	
	// 启用停用
	function stopPopedom(stationId,id) {
		var src = document.getElementById("showAllBtn_"+stationId).getElementsByTagName("img")[0].src;
		if(id != -1){
			var request = new Object();
			request.id = id;
			request.state = whole_stop.innerText;
			if(whole_stop.innerText == "启用"){
				whole_stop.innerText = "停用";
				if(src.indexOf("/images/checked.png") == -1){
					document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("style");
				}
			}else if(whole_stop.innerText == "停用"){
				whole_stop.innerText = "启用";
				if(src.indexOf("/images/unchecked.png") != -1){
					document.getElementById("popedom_"+id+"_"+stationId).style.display = "none";
				}else{
					document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("style");
				}
			}
			PostData("point/point/save",request,function(result) {
				showAllBtn(1,stationId);
			});
		}
	}
	
	// 获取坐标
	function getCoordinate() {
		PGISHelper.Map.addMapEventListener(Ez.Event.MAP_CLICK, function (e) {
			var coordinate = e.coordinate;
			whole_latitude.value = coordinate[0];
			whole_longitude.value = coordinate[1];
		});
	}
</script>
<script type="text/javascript">
	// 画表格
	function showTable(itemId,type,minutesType,title) {		
		var identify = showClickTimes;
		showClickTimes ++;
		var NowDate=new Date().Format("yyyy-MM-dd");
		whole_ClickMenuMap.set(identify,itemId+","+type+","+minutesType);
				
		var tabTitles = document.getElementById("tabTitle").children;
		var tabContents = document.getElementById("tabContent").children;
		for (var i = 0; i < tabTitles.length; i++) {
			tabTitles[i].classList.remove("layui-this");
		}
		for (var j = 0; j < tabContents.length; j++) {
			tabContents[j].classList.remove("layui-show");
		}
		var html1 = "";// tabTitle
		var html2 = "";// tabContent
		html1 += "<li class='layui-this'>"+ title +"</li>"
		$("#tabTitle").append(html1);
		html2 += "<div class='layui-tab-item layui-show'>";
		html2 += "<div class='layui-inline' id='makeOrder_"+identify+"'>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeOrder("+identify+")'>排班</button><button class='layui-btn layui-btn-primary layui-btn-sm'>导出</button>";
		html2 += "</div>";
		html2 += "<div class='layui-inline' id='makeSave_"+identify+"' style='display: none;'>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeSave("+identify+")'>保存</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeCancel("+identify+")'>取消</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>复制排班</button>";
		html2 += "<label>原日期</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='schedulBegin_"+identify+"' placeholder='yyyy-MM-dd'></div>";
		html2 += "<label>目标日期</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='schedulEnd_"+identify+"' placeholder='yyyy-MM-dd'></div>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='CopyShiftOk("+identify+")'>确认</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm'>取消</button></div>";
		html2 += "<div class='layui-inline' style='float: right;'>";
		html2 += "<div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='searchBegin_"+identify+"' placeholder='yyyy-MM-dd' value='"+ NowDate +"'>";
		html2 += "</div><label>-</label><div class='layui-input-inline' style='width: 120px;'>";
		html2 += "<input type='text' class='layui-input' id='searchEnd_"+identify+"' placeholder='yyyy-MM-dd' value='"+ NowDate +"'></div>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",1)'>搜索</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",2)'>前一天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",3)'>后一天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",4)'>今天</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",5)'>本周</button>";
		html2 += "<button class='layui-btn layui-btn-primary layui-btn-sm' onclick='searchClick("+identify+",6)'>本月</button>";
		html2 += "</div><div class='layui-inline' style='width: 100%;'><div class='tableTitle'>"+ title +"排班表</div></div>";
		html2 += "<div id='shiftTableDiv_"+identify+"'><table class='layui-table' style='text-align: center;' id='shiftTable_"+identify+"'>";
		html2 += CreateHeadHtml(minutesType,NowDate);
		html2 += CreateBodyHtml(itemId,type,NowDate,NowDate,1,identify);		
		html2 += "</table>";
		html2 += "</div>";
		html2 += "</div>";
		html2 += "</div>";
		
		$("#tabContent").append(html2);
		
		var tbody=document.getElementById("shiftTable_"+identify);
		
		if(minutesType!=1){
			autoRowSpanByPreItem(tbody,3,1);
		}
		autoRowSpan(tbody,3,0);
		
		layuiRender();
		dateRender(identify);
		cancelBubble();

		
	}
	//复制排班
	function CopyShiftOk(index,isCover){
		var cover=false;
		var fromDate=document.getElementById('schedulBegin_'+index).value;
		var toDate=document.getElementById('schedulEnd_'+index).value;
		if(fromDate==null || toDate==null || fromDate.length==0 || toDate.length==0 || fromDate==toDate){
			alert("日期错误，请检查日期！");
			return false;
		}
		if(typeof isCover!="undefined"){
			cover=isCover
		}
		var value=whole_ClickMenuMap.get(index);
		var item=value.split(",");
		if(item.length>=3){	
			var pointInfos=getPointInfoData(item[0],item[1]);
			if(pointInfos!=null && pointInfos.length>0){
				var strPointId=getPointIdString(pointInfos);		
				var arrangeInfos=getArrangeInfosData(fromDate,fromDate,strPointId);	
				var arrangeInfosTo=getArrangeInfosData(toDate,toDate,strPointId);				
				
				if(arrangeInfos!=null &&arrangeInfos.length>0){
					var flag=0;
					if(arrangeInfosTo!=null && arrangeInfosTo.length>0){
						for(var i=0; i<arrangeInfos.length;i++){
							for(var j=0; j<arrangeInfosTo.length;j++){
								if(arrangeInfos[i].fromTime.substr(11,8)==arrangeInfosTo[j].fromTime.substr(11,8)
										&& arrangeInfos[i].toTime.substr(11,8)==arrangeInfosTo[j].toTime.substr(11,8)){
										flag=1;
										break;
									}
							}
							if(flag==1){
								break;
							}
						}
					}
					if(flag==0 || (flag==1 && cover==true)){
						if(flag==1 && cover==true){//覆盖，先删除
							delArrangeInfos(arrangeInfosTo);
							var deviceInfosTo=getDeviceInfosData(toDate,toDate,strPointId);
							delDeviceInfos(deviceInfosTo);
						}
						for(var i=0; i<arrangeInfos.length;i++){
							arrangeInfos[i].workDt=toDate;
							arrangeInfos[i].fromTime=toDate+ arrangeInfos[i].fromTime.substr(10,8);
							arrangeInfos[i].toTime=toDate+ arrangeInfos[i].toTime.substr(10,8);						
							delete arrangeInfos[i].id;
						}
						var deviceInfos=getDeviceInfosData(fromDate,fromDate,strPointId);
						for(var i=0; i<deviceInfos.length;i++){
							deviceInfos[i].workDt=toDate;
							deviceInfos[i].fromTime=toDate+ deviceInfos[i].fromTime.substr(10,8);
							deviceInfos[i].toTime=toDate+ deviceInfos[i].toTime.substr(10,8);
							deviceInfos[i].isDefault=0;
							delete deviceInfos[i].id;
						}
						//保存排班和排班设备信息
						var saveArrangeFlag=saveArrangeInfos(arrangeInfos);
						var saveDeviceFlag=saveDeviceInfos(deviceInfos);
						if(saveArrangeFlag==true && saveDeviceFlag==true){
							return true;
						}
					}
					else{
						layer.open({  
			                title: ['温馨提示'], 
			                content: '<div style="color:#767676">是否覆盖目标日期排班？</div>',  
			                btn: ['是', '否'],  
			                shadeClose: true,  
			                //回调函数  
			                yes: function(index1, layero){
			                	//setData(3);
			                	var tempitem=CopyShiftOk(index,true);
			                	layer.closeAll();
			                	if(tempitem==true){			                		
			                		ShowTip("温馨提示","<div style='color:#767676'>复制排班成功!</div>");
			                	}
			                },  
			                btn2: function(index, layero){
			                },  
			                cancel: function(index,layero){ //按右上角“X”按钮  	                     
			                },
			        	});
					}
					//重新刷新列表
					//searchClick(index,1);
				}
			}			
		}
	}
	function ShowTip(title,content){
		layer.open({  
            title: [title], 
            content: content,//'<div style="color:#767676">复制排班成功</div>',  
            btn: ['确定'],  
            shadeClose: true,  
            //回调函数  
            yes: function(index1, layero){ 
            	layer.closeAll();
            }, 
            cancel: function(index,layero){ //按右上角“X”按钮              	
            },
    	});
	}
	//保存排班数据
	function saveArrangeInfos(arrangeInfos){
		var flag=false;
		if(arrangeInfos!=null && arrangeInfos.length>0){		
			var request=arrangeInfos;		
			PostData("duty/arrange/saveList",request,function(result) {
				if(result.code==0){	
					flag= true;
				}
			},false);
		}
		return flag;
	}
	//保存排班设备数据
	function saveDeviceInfos(deviceInfos){
		var flag=false;
		if(deviceInfos!=null &&deviceInfos.length>0){
			var request=deviceInfos;		
			PostData("point/pointDevice/saveList",request,function(result) {
				if(result.code==0){
					flag=true;
				}
			},false);
		}
		return flag;
	}
	//保存排班数据
	function delArrangeInfos(arrangeInfos){
		if(arrangeInfos!=null && arrangeInfos.length>0){
			var request=new Array();
			for(var i=0 ;i<arrangeInfos.length;i++){
				request.push(arrangeInfos[i].id);
			}					
			PostData("duty/arrange/deleteList",request,function(result) {					
			},false);
			
		}
	}
	//保存排班设备数据
	function delDeviceInfos(deviceInfos){
		if(deviceInfos!=null &&deviceInfos.length>0){			
			var request=new Array();
			for(var i=0 ;i<deviceInfos.length;i++){	
				request.push(deviceInfos[i].id);
			}				
			PostData("point/pointDevice/deleteList",request,function(result) {					
			},false);			
		}
	}
	//按时间类型查找排版
	function searchClick(index,type){
		var NowDate=new Date();
		var fromDate=document.getElementById('searchBegin_'+index).value;
		var toDate=document.getElementById('searchEnd_'+index).value;
		if(type==1){//搜索按钮
			var nowDateString=NowDate.Format("yyyy-MM-dd");
			if(fromDate==null || fromDate.length==0){
				fromDate=nowDateString;
				document.getElementById('searchBegin_'+index).value=fromDate;
			}
			if(toDate==null || toDate.length==0){
				toDate=nowDateString;
				document.getElementById('searchEnd_'+index).value=toDate;
			}
		}
		else if(type==2){//前一天
			var nowDateString=NowDate.Format("yyyy-MM-dd");
			if(fromDate==null || fromDate.length==0){
				fromDate=nowDateString;
			}
			var dateTemp=new Date(fromDate);
			var preDate = new Date(dateTemp.getTime() - 24*60*60*1000); //前一天
			fromDate=preDate.Format("yyyy-MM-dd");
			toDate=fromDate;
			document.getElementById('searchBegin_'+index).value=fromDate;
			document.getElementById('searchEnd_'+index).value=toDate;
		}
		else if(type==3){//后一天
			var nowDateString=NowDate.Format("yyyy-MM-dd");
			if(fromDate==null || fromDate.length==0){
				fromDate=nowDateString;
			}
			var dateTemp=new Date(fromDate);
			var nextDate = new Date(dateTemp.getTime() + 24*60*60*1000); //hou一天
			fromDate=nextDate.Format("yyyy-MM-dd");
			toDate=fromDate;
			document.getElementById('searchBegin_'+index).value=fromDate;
			document.getElementById('searchEnd_'+index).value=toDate;
		}
		else if(type==4){//今天
			var nowDateString=NowDate.Format("yyyy-MM-dd");
			fromDate=nowDateString;
			toDate=nowDateString;
			document.getElementById('searchBegin_'+index).value=fromDate;	
			document.getElementById('searchEnd_'+index).value=toDate;			
		}
		else if(type==5){//本周	     
		    var WeekFirstDay=new Date(NowDate-(NowDate.getDay()-1)*86400000); 
		    var WeekLastDay=new Date((WeekFirstDay/1000+6*86400)*1000);		    
		    fromDate= WeekFirstDay.Format("yyyy-MM-dd");
		    toDate=WeekLastDay.Format("yyyy-MM-dd"); 
		    document.getElementById('searchBegin_'+index).value=fromDate;
			document.getElementById('searchEnd_'+index).value=toDate;
		}
		else if(type==6){//本月
			 var MonthFirstDay=new Date(NowDate.getFullYear(),NowDate.getMonth(),1);
			 var MonthNextFirstDay=new Date(NowDate.getFullYear(),NowDate.getMonth()+1,1); 
			 var MonthLastDay=new Date(MonthNextFirstDay-86400000); 
			 fromDate= MonthFirstDay.Format("yyyy-MM-dd");
			 toDate=MonthLastDay.Format("yyyy-MM-dd"); 
			 document.getElementById('searchBegin_'+index).value=fromDate;
			 document.getElementById('searchEnd_'+index).value=toDate;
		}		
		changeTable(fromDate,toDate,index);
	}
	function changeTable(fromDate,toDate,index){
		var dateshow="";
		if(fromDate==toDate){
			dateshow=fromDate;
		}
		else{
			dateshow=fromDate+"至"+toDate;
		}
		var value=whole_ClickMenuMap.get(index);
		var item=value.split(",");
		if(item.length>=3){		
			//$('#shiftTable_'+index).remove();
			var html="<table class='layui-table' style='text-align: center;' id='shiftTable_"+index+"'>";		
			html += CreateHeadHtml(item[2],dateshow);
			html += CreateBodyHtml(item[0],item[1],fromDate,toDate,1,index);
			html += "</table>";
			document.getElementById('shiftTableDiv_'+index).innerHTML=html;
			
			var tbody=document.getElementById("shiftTable_"+index);			
			if(item[2]!=1){
				autoRowSpanByPreItem(tbody,3,1);
			}
			autoRowSpan(tbody,3,0);
		}
	}
	
	function CreateHeadHtml(minutesType,strDate,type) {
		var html = "";
		if(minutesType == 1){
			html += "<tbody>";
			html += "<tr>";
			if(type == 1){
				html += "<td colspan='18'>特警支队常态化联勤武装巡逻警力部署表("+strDate+")</td>";
			}else{
				html += "<td colspan='17'>特警支队常态化联勤武装巡逻警力部署表("+strDate+")</td>";
			}
			html += "</tr>"
			html += "<tr>";
			html += "<td rowspan='2'>巡逻区域</td>";
			html += "<td rowspan='2'>1分钟快反处置范围</td>";
			html += "<td rowspan='2'>巡逻时间</td>";
			html += "<td colspan='3'>带队民警</td>";
			html += "<td rowspan='2'>责任单位</td>";
			html += "<td rowspan='2'>车号</td>";
			html += "<td colspan='3'>通信</td>";
			html += "<td colspan='2'>武装联络人</td>";
			html += "<td colspan='2'>执勤人数</td>";
			html += "<td colspan='2'>携带装备</td>";
			if(type == 1){
				html += "<td rowspan='2'>操作</td>";
			}
			html += "</tr>";
			html += "<tr>";
			html += "<td>姓名</td>";
			html += "<td>职务</td>";
			html += "<td>电话</td>";
			html += "<td>组别</td>";
			html += "<td>代码</td>";
			html += "<td>电台值守组</td>";
			html += "<td>姓名</td>";
			html += "<td>电话</td>";
			html += "<td>特警</td>";
			html += "<td>武警</td>";
			html += "<td>长枪</td>";
			html += "<td>短枪</td>";
			html += "</tr>";
			html += "</tbody>";
		}else{
			html += "<tbody>";
			html += "<tr>";
			if(type == 1){
				html += "<td colspan='17'>各分局加密巡逻安排表("+strDate+")</td>";
			}else{
				html += "<td colspan='16'>各分局加密巡逻安排表("+strDate+")</td>";
			}
			html += "</tr>"
			html += "<tr>";
			html += "<td rowspan='2'>分局(队伍驻地)</td>";
			html += "<td rowspan='2'>巡逻类型</td>";
			html += "<td rowspan='2'>巡逻区域</td>";
			html += "<td rowspan='2'>区域及辐射范围</td>";
			html += "<td rowspan='2'>巡逻时段</td>";
			html += "<td colspan='3'>带队民警</td>";
			html += "<td rowspan='2'>车号</td>";
			html += "<td colspan='2'>通信</td>";
			html += "<td colspan='3'>执勤人数</td>";
			html += "<td colspan='2'>携带装备</td>";
			if(type == 1){
				html += "<td rowspan='2'>操作</td>";
			}
			html += "</tr>";
			html += "<tr>";
			html += "<td>姓名</td>";
			html += "<td>职务</td>";
			html += "<td>电话</td>";
			html += "<td>代码</td>";
			html += "<td>电台值守组</td>";
			html += "<td>民警</td>";
			html += "<td>武警</td>";
			html += "<td>协警</td>";
			html += "<td>长枪</td>";
			html += "<td>短枪</td>";
			html += "</tr>";
			html += "</tbody>";
		}
		return html;
	}
	//得到表格主体
	//type类型：1表示点击班别（1，3，5）；2表示点击分局；3点击辖区
	//itemid ：type==1时，typePath的查询值；type==2时，分局id；type==3时，辖区id；
	function CreateBodyHtml(itemId,type,fromTime,toTime,isEdit,pageId){
		var pointInfos=getPointInfoData(itemId,type);
		var pointInfoDeviceDict=getPointInfoDeviceDict();
		if(pointInfos!=null && pointInfos.length>0){
			var strPointId=getPointIdString(pointInfos);		
			var arrangeInfos=getArrangeInfosData(fromTime,toTime,strPointId);			
			var deviceInfos=getDeviceInfosData(fromTime,toTime,strPointId);				
			var arrangeTimeSpan=getTimeSpansFromArrangeData(arrangeInfos);			
			var listRowIdx=createTableDateIdx(pointInfos,deviceInfos,arrangeTimeSpan,pointInfoDeviceDict);
			var html= "";
			if(isEdit!=0){
				html += createTableBody(listRowIdx,pointInfos,arrangeInfos,deviceInfos,whole_subStation,arrangeTimeSpan,pointInfoDeviceDict);
			}else{
				html += createTableEditBody(listRowIdx,pointInfos,arrangeInfos,deviceInfos,whole_subStation,arrangeTimeSpan,pointInfoDeviceDict,pageId)
			}
			return html;
		}
		return "";
	}
	//根据点击位置获取需要显示的辖区
	//type类型：1表示点击班别（1，3，5）；2表示点击分局；3点击辖区
	//itemid ：type==1时，typePath的查询值；type==2时，分局id；type==3时，辖区id；
	function getPointInfoData(itemId,type){	
		var strConditions="";
		var pointInfoData=new Array();
		if(type==1){//点击班别类型	itemID=81-84-85 //1分钟		
			strConditions = "typePath,string,后包含,"+itemId +";state,string,=,启用";	
		}
		else if(type==2){//点击分局
			strConditions = "PId,string,=,"+itemId +";state,string,=,启用";
		}
		else if(type==3){//点击辖区
			strConditions = "id,string,=,"+itemId +";state,string,=,启用";	
		}
		else{
			return null;
		}
		PostData("point/point/filter",createRequest(0, 1000, "id", strConditions),function(result) {
			if(result.data.length>0){
				pointInfoData= result.data;
			}
		},false);
		
		if(type==1){//点击班别根据pid排序辖区
			pointInfoData.sort(compare("pid"));
		}
		if(type==2){//点击分局根据类别排序辖区
			pointInfoData.sort(compare("type"));
		}
		return pointInfoData;
		
	}
	//获取辖区ID集合
	function getPointIdString(pointInfos){
		var strPointId="";
		if(pointInfos.length>1){		
			for(var i=0;i<pointInfos.length-1;i++){
				strPointId += pointInfos[i].id+",";
			}
			strPointId += pointInfos[pointInfos.length-1].id;
		}
		else if(pointInfos.length==1){
			strPointId += pointInfos[0].id;
		}
		return strPointId;
	}
	//获取排班数据
	function getArrangeInfosData(fromTime,toTime,strPointId){
		var arrangeInfos=new Array();	
		
		var strConditions = "pointInfoId,int,in,"+strPointId +";workDt,string,>=,"+fromTime+";workDt,string,<=,"+toTime;
		
		PostData("duty/arrange/filter",createRequest(0, 1000, "id", strConditions),function(result) {
			if(result.data.length>0){
				arrangeInfos=result.data;
			}
		},false);
		
		return arrangeInfos;
	}
	//获取辖区设备字典数据
	function getPointInfoDeviceDict(){
		var pointInfoDeviceDict=null;
		var pointInfoDeviceDictTemp=new Array();
		var strConditions = "dictName,string,=,PointInfoDevice";
		
		PostData("base/baseDict/filter",createRequest(0, 1000, "Code", strConditions),function(result) {
			if(result.data.length>0){
				pointInfoDeviceDict=result.data;
			}
		},false);
		for(var i=0;i<pointInfoDeviceDict.length;i++){
			if(typeof pointInfoDeviceDict[i].code !="undefined" && pointInfoDeviceDict[i].code.length==4)
				pointInfoDeviceDictTemp.push(pointInfoDeviceDict[i]);
		}
		return pointInfoDeviceDictTemp;
	}
	//根据排版数据按照时间段和辖区ID不一样分类
	function getTimeSpansFromArrangeData(arrangeInfos){
		var tempMap=new Map();
		var arrangeTimeSpan= new Array();		
		for(var i=0;i<arrangeInfos.length;i++){
			var fromTime=new Date(arrangeInfos[i].fromTime).Format("yyyy-MM-dd hh:mm");
			var toTime=new Date(arrangeInfos[i].toTime).Format("yyyy-MM-dd hh:mm");
			var workDt=new Date(arrangeInfos[i].workDt).Format("yyyy-MM-dd");
			var key=fromTime+"," +toTime + "," + workDt+ "," + arrangeInfos[i].pointInfoId;
			if(tempMap.has(key)){
				var value =tempMap.get(key)+","+i
				arrangeTimeSpan.remove(key+";"+tempMap.get(key));
				arrangeTimeSpan.push(key+";"+value);
				tempMap.set(key,value);
			}
			else{
				tempMap.set(key,i);
				arrangeTimeSpan.push(key+";"+i);
			}
		}
		return arrangeTimeSpan;
	}
	//获取排班设备数据
	function getDeviceInfosData(fromTime,toTime,strPointId){
		var deviceInfos=new Array();
		var strConditions = "pointInfoId,int,in,"+strPointId +";workDt,string,>=,"+fromTime+";workDt,string,<=,"+toTime;
		PostData("point/pointDevice/filter",createRequest(0, 1000, "id", strConditions),function(result) {
			if(result.data.length>0){
				deviceInfos= result.data;
			}
		},false);
		return deviceInfos;
	}
	//组织表格数据序号
	function createTableDateIdx(pointInfos,deviceInfos,arrangeTimeSpan,pointInfoDeviceDict){
		var pointCnt=pointInfos.length;
		var arrangeCnt=arrangeTimeSpan.length;
		var deviceCnt=deviceInfos.length;
		//每行的序号字符全，比如（4,6,7;1,3,9;2,4,8;5,7,10）每一个;表示一行，第一个表示排版序号，后面的表示设备序号
		var listRowIdx=new Array();
		
		for(var i=0;i<pointCnt;i++){
			listRowIdx[i]="";
			for(var j=0;j<arrangeCnt;j++){
				var key=arrangeTimeSpan[j].split(";")[0];
				var pointInfoId=key.split(",")[3];
				var workDt=key.split(",")[2];
				var toTime=key.split(",")[1];
				var fromTime=key.split(",")[0];
				if(pointInfos[i].id==pointInfoId){
					listRowIdx[i] =j+"";					
					var deviceIdxMap = new Map();
					var strDeviceIdx="";
					for(var k=0;k<deviceCnt;k++){						 
						var deviceWorkDt = new Date(deviceInfos[k].workDt).Format("yyyy-MM-dd");
						var devicefromTime = new Date(deviceInfos[k].fromTime).Format("yyyy-MM-dd hh:mm");
						var devicetoTime = new Date(deviceInfos[k].toTime).Format("yyyy-MM-dd hh:mm");
						if(pointInfos[i].id==deviceInfos[k].pointInfoId &&  workDt==deviceWorkDt &&
							fromTime==devicefromTime && toTime==devicetoTime){							
							deviceIdxMap.set(deviceInfos[k].deviceTypeCode,k); 
						}							
					}
					var key="";
					for(var m=0;m<pointInfoDeviceDict.length;m++){//按照deviceTypeCode排序						
						key=pointInfoDeviceDict[m].code;						
						if(deviceIdxMap.has(key)){
							strDeviceIdx +=","+deviceIdxMap.get(key);
						}
						else{
							strDeviceIdx +=",";
						}
					}
					listRowIdx[i] += strDeviceIdx +";";
				}				
			}
			
		}		
		return listRowIdx;
	}
	//扽到表格数据
	//substation 分局ID序列
	function createTableBody(listRowIdx,pointInfos,arrangeInfos,deviceInfos,substation,arrangeTimeSpan,pointInfoDeviceDict){
		var html="";	
		var type=2
		if(pointInfos[0].pid==1){
			type=1;
		}		
		//html += "<div class='table-body' id='tableBody2'><table class='layui-table'><tbody>";
		html += "<tbody>";
		for(var i=0;i<listRowIdx.length;i++){
			var itemLineIdx="";
			if(listRowIdx[i].length>0)
				itemLineIdx=listRowIdx[i].split(";");			
			var spanRows=itemLineIdx.length-1;
			if(spanRows>0){
				for(var j=0;j<spanRows;j++){				
					var itemIdx=itemLineIdx[j].split(",");				
					var itemPoint=pointInfos[i];
					var itemArrangeSpan=arrangeTimeSpan[Number(itemIdx[0])];
					var key=itemArrangeSpan.split(";")[0];
					var workDt=key.split(",")[2];
					var toTime=key.split(",")[1];				
					var fromTime=key.split(",")[0];
					var value=itemArrangeSpan.split(";")[1];
					var arrangeIdx=value.split(",");
					var rows =arrangeIdx.length;//				
					var itemArrange=arrangeInfos[Number(arrangeIdx[0])];				
	
					html += "<tr>";
					if(type!=1){					
						html += "<td rowspan='"+rows +"'>"+substation[Number(itemPoint.pid)-1]+"</td>";
						var type="3分钟反应圈";
						if(itemPoint.type==whole_pointInfoMap.get("5分钟"))
							type="5分钟反应圈";						
						html += "<td rowspan='"+rows +"'>" + type + "</td>";
					}
					html += "<td rowspan='"+rows +"'>"+itemPoint.name+"</td>";
					html += "<td rowspan='"+rows +"'>"+itemPoint.description+"</td>";
					html += "<td rowspan='"+rows +"'>" + workDt+" "+ fromTime.substr(11,5) + "-" + toTime.substr(11,5) + "</td>";				
					html += "<td>" + itemArrange.staffName+ "</td>";
					html += "<td>" + itemArrange.staffPost+ "</td>";
					html += "<td>" + itemArrange.staffPhone+ "</td>";
					if(type==1){
						html += "<td rowspan='"+rows +"'>" + itemPoint.stationName+ "</td>";					
						for(var m=0;m<pointInfoDeviceDict.length;m++){
							if(m==6 || m==9) continue;//跳过民警和协警
							if(itemIdx[m+1].length>0){
								html += "<td rowspan='"+rows +"'>" + deviceInfos[Number(itemIdx[m+1])].value+ "</td>";
							}
							else{
								html += "<td rowspan='"+rows +"'></td>";
							}
						}
					}
					else{
						for(var m=0;m<pointInfoDeviceDict.length;m++){
							if(m==1 || m==4 || m==5 || m==7) continue;//跳过组别和武警联络人名称电话和特警
							if(itemIdx[m+1].length>0){
								html += "<td rowspan='"+rows +"'>" + deviceInfos[Number(itemIdx[m+1])].value+ "</td>";
							}
							else{
								html += "<td rowspan='"+rows +"'></td>";
							}
						}
					}
					html += "</tr>";
					for(var k=1;k<rows;k++){
						html += "<tr>";
						html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffName+ "</td>";
						html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffCode+ "</td>";
						html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffPhone+ "</td>";
						html += "</tr>";	
					}
				}
			}
			else{
				var itemPoint=pointInfos[i];
				html += "<tr>";
				if(type!=1){					
					html += "<td>"+substation[Number(itemPoint.pid)-1]+"</td>";
					var type="3分钟反应圈";
					if(itemPoint.type==whole_pointInfoMap.get("5分钟"))
						type="5分钟反应圈";						
					html += "<td>" + type + "</td>";
				}
				html += "<td >"+itemPoint.name+"</td>";
				html += "<td >"+itemPoint.description+"</td>";
				html += "<td></td>";				
				html += "<td></td>";
				html += "<td></td>";
				html += "<td></td>";
				if(type==1){
					html += "<td>" + itemPoint.stationName + "</td>";					
					for(var m=0;m<pointInfoDeviceDict.length;m++){
						if(m==6 || m==9) continue;//跳过民警和协警
						html += "<td></td>";
					}
				}
				else{
					for(var m=0;m<pointInfoDeviceDict.length;m++){
						if(m==1 || m==4 || m==5 || m==7) continue;//跳过组别和武警联络人名称电话和特警						
						html += "<td ></td>";
					}
				}
				html += "</tr>";
			}
		}		
		//html += "</tbody></table></div>";
		html += "</tbody>";
		return html;
		
	}
	//扽到表格编制数据
	//substation 分局ID序列
	function createTableEditBody(listRowIdx,pointInfos,arrangeInfos,deviceInfos,substation,arrangeTimeSpan,pointInfoDeviceDict,pageId){
		var html="";	
		var addTimeSpanList = new Array();
		var type=2
		if(pointInfos[0].pid==1){
			type=1;
		}	
		var timeSpanIdx=0;
		//html += "<div class='table-body' id='tableBody2'><table class='layui-table'><tbody>";
		html += "<tbody>";
		for(var i=0;i<listRowIdx.length;i++){
			var itemLineIdx="";
			if(listRowIdx[i].length>0)
				itemLineIdx=listRowIdx[i].split(";");			
			var spanRows=itemLineIdx.length-1;
			if(spanRows>0){
				for(var j=0;j<spanRows;j++){				
					var itemIdx=itemLineIdx[j].split(",");				
					var itemPoint=pointInfos[i];
					var itemArrangeSpan=arrangeTimeSpan[Number(itemIdx[0])];
					var key=itemArrangeSpan.split(";")[0];
					var toTime=key.split(",")[1];				
					var fromTime=key.split(",")[0];
					var value=itemArrangeSpan.split(";")[1];
					var arrangeIdx=value.split(",");
	
					html += "<tr>";
					if(type!=1){					
						html += "<td id='areaId_"+pageId+"_"+itemPoint.id+"'>"+substation[Number(itemPoint.pid)-1]+"</td>";
						var type="3分钟反应圈";
						if(itemPoint.type==whole_pointInfoMap.get("5分钟"))
							type="5分钟反应圈";						
						html += "<td id='type_"+pageId+"_"+itemPoint.id+"'>" + type + "</td>";
					}
					html += "<td id='name_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.name+"</td>";
					html += "<td id='description_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.description+"</td>";
					html += "<td> <input type='text' class='layui-input' id='timespan"+timeSpanIdx+"-"+pageId+"' placeholder=' - ' value='" + fromTime.substr(11,5) + "-" + toTime.substr(11,5) + "'></td>";					
					timeSpanIdx++;
					var staffinfo="";
					for(var k=0;k<arrangeIdx.length;k++){						
						staffinfo +=arrangeInfos[Number(arrangeIdx[k])].staffName + arrangeInfos[Number(arrangeIdx[k])].staffPhone;						
						staffinfo += ";";
					}
					html += "<td colspan='3'>" + staffinfo + "</td>";
					if(type==1){
						html += "<td>" + itemPoint.stationName+ "</td>";					
						for(var m=0;m<pointInfoDeviceDict.length;m++){
							if(m==6 || m==9) continue;//跳过民警和协警
							if(itemIdx[m+1].length>0){
								html += "<td>" + deviceInfos[Number(itemIdx[m+1])].value+ "</td>";
							}
							else{
								html += "<td></td>";
							}
						}
					}
					else{
						for(var m=0;m<pointInfoDeviceDict.length;m++){
							if(m==1 || m==4 || m==5 || m==7) continue;//跳过组别和武警联络人名称电话和特警
							if(itemIdx[m+1].length>0){
								html += "<td>" + deviceInfos[Number(itemIdx[m+1])].value+ "</td>";
							}
							else{
								html += "<td></td>";
							}
						}
					}
					html += "<td><div class='layui-btn-group'><button class='layui-btn' onclick='addShift("+itemPoint.id+","+pageId+")'>增加</button></div>";
					html += "<div class='layui-btn-group'><button class='layui-btn'>编辑</button></div>";
					html += "<div class='layui-btn-group'><button class='layui-btn'>删除</button></div></td>";
					html += "</tr>";
					html += "<tr id='tr_"+pageId+"_"+itemPoint.id+"' style='display: none;'>";
					html += "<td><input type='text' class='layui-input input-border' id='addTimeSpan_"+pageId+"_"+itemPoint.id+"' placeholder=' - '></td>";
					html += "<td colspan='3' id='staffMess_"+pageId+"_"+itemPoint.id+"' onclick='addStaffMess("+itemPoint.id+","+pageId+")'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
					html += "<td><div class='layui-btn-group'><button class='layui-btn'>保存</button></div>";
					html += "<div class='layui-btn-group'><button class='layui-btn'>取消</button></div></td>";
					html += "</tr>";
					addTimeSpanList.push(itemPoint.id);
				}
			}
			else{
				var itemPoint=pointInfos[i];
				html += "<tr>";
				if(type!=1){					
					html += "<td id='areaId_"+pageId+"_"+itemPoint.id+"'>"+substation[Number(itemPoint.pid)-1]+"</td>";
					var type="3分钟反应圈";
					if(itemPoint.type==whole_pointInfoMap.get("5分钟"))
						type="5分钟反应圈";						
					html += "<td id='type_"+pageId+"_"+itemPoint.id+"'>" + type + "</td>";
				}
				html += "<td id='name_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.name+"</td>";
				html += "<td id='description_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.description+"</td>";
				html += "<td><input type='text' class='layui-input' id='timespan"+timeSpanIdx+"-"+pageId+"' placeholder=' - '></td>";
				timeSpanIdx++;
				html += "<td colspan='3'></td>";
				if(type==1){
					html += "<td>" + itemPoint.stationName + "</td>";					
					for(var m=0;m<pointInfoDeviceDict.length;m++){
						if(m==6 || m==9) continue;//跳过民警和协警
						html += "<td></td>";
					}
				}
				else{
					for(var m=0;m<pointInfoDeviceDict.length;m++){
						if(m==1 || m==4 || m==5 || m==7) continue;//跳过组别和武警联络人名称电话和特警						
						html += "<td ></td>";
					}
				}
				html += "<td><div class='layui-btn-group'><button class='layui-btn' onclick='addShift("+itemPoint.id+","+pageId+")'>增加</button></div>";
				html += "<div class='layui-btn-group'><button class='layui-btn'>编辑</button></div>";
				html += "<div class='layui-btn-group'><button class='layui-btn'>删除</button></div></td>";
				html += "</tr>";
				html += "<tr id='tr_"+pageId+"_"+itemPoint.id+"' style='display: none;'>";
				html += "<td><input type='text' class='layui-input input-border' id='addTimeSpan_"+pageId+"_"+itemPoint.id+"' placeholder=' - '></td>";
				html += "<td colspan='3' id='staffMess_"+pageId+"_"+itemPoint.id+"' onclick='addStaffMess("+itemPoint.id+","+pageId+")'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><input type='text' autocomplete='off'	class='layui-input input-border'></td>";
				html += "<td><div class='layui-btn-group'><button class='layui-btn'>保存</button></div>";
				html += "<div class='layui-btn-group'><button class='layui-btn'>取消</button></div></td>";
				html += "</tr>";
				addTimeSpanList.push(itemPoint.id);
			}
			whole_addTimeSpanMap.set(pageId,addTimeSpanList);
		}		
		//html += "</tbody></table></div>";
		html += "</tbody>";
		whole_timeSpanIDMap.set(pageId,timeSpanIdx);
		return html;
		
	}
	
	function addShift(id,identify) {
		var tr = document.getElementById("tr_"+identify+"_"+id);
		var areaId = document.getElementById("areaId_"+identify+"_"+id);
		var type = document.getElementById("type_"+identify+"_"+id);
		var name = document.getElementById("name_"+identify+"_"+id);
		var description = document.getElementById("description_"+identify+"_"+id);
		if(areaId!=null){
			areaId.setAttribute("rowspan",areaId.rowSpan+1);
		}
		if(type!=null){
			type.setAttribute("rowspan",type.rowSpan+1);
		}
		if(name!=null){
			name.setAttribute("rowspan",name.rowSpan+1);
		}
		if(description!=null){
			description.setAttribute("rowspan",description.rowSpan+1);
		}
		tr.removeAttribute("style");
	}
	
	function addStaffMess(id,pageId) {
		var staffId = document.getElementById("staffMess_"+pageId+"_"+id);
		var leftv = staffId.offsetLeft;
		var topv = staffId.offsetTop;
		var oh = staffId.offsetHeight;
		$('#staffDiv').css({
			left : leftv + 280 + "px",
			top : topv + oh + 110 + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyMouseDown);
	}
	
	function onBodyMouseDown(event) {
		var str = event.target.id.substring(0, 4);
		if (str == "tree" && !(event.target.id.indexOf("span") > -1)) {
			return;
		}
	}

	function hideMenu() {
		$('#divTree').fadeOut("fast");
		$('#staffDiv').fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	var compare = function (prop) {
	    return function (obj1, obj2) {
	        var val1 = obj1[prop];
	        var val2 = obj2[prop];
	        if (!isNaN(Number(val1)) && !isNaN(Number(val2))) {
	            val1 = Number(val1);
	            val2 = Number(val2);
	        }
	        if (val1 < val2) {
	            return -1;
	        } else if (val1 > val2) {
	            return 1;
	        } else {
	            return 0;
	        }            
	    } 
	};
	Array.prototype.remove = function(val) { 
		var index = -1;
		for (var i = 0; i < this.length; i++) { 
			if (this[i] == val) {
				index=i; 
				break;
			}
		} 		
		if (index > -1) { 
			this.splice(index, 1); 
		} 
	};
	// 对Date的扩展，将 Date 转化为指定格式的String
	// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
	// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
	Date.prototype.Format = function (fmt) { //author: meizz 
		var o = {
			"M+": this.getMonth() + 1, //月份 
			"d+": this.getDate(), //日 
			"h+": this.getHours(), //小时 
			"m+": this.getMinutes(), //分 
			"s+": this.getSeconds(), //秒 
			"q+": Math.floor((this.getMonth() + 3) / 3), //季度 
			"S": this.getMilliseconds() //毫秒 
		}
	
		if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			for (var k in o)
			if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	};
	// 自动合并单元格
	function autoRowSpan(tb,row,col){ 
		var lastValue=""; 
		var value=""; 
		var pos=1; 
		for(var i=row;i<tb.rows.length;i++){ 
		value = tb.rows[i].cells[col].innerText; 
			if(lastValue == value){
				var idx=i-pos;			
				tb.rows[i].deleteCell(col); 
				tb.rows[idx].cells[col].rowSpan = tb.rows[idx].cells[col].rowSpan+1;
				pos++; 	
			}else{ 
				lastValue = value; 
				pos=1; 
			} 
		} 
	}
	//当前一列数据相同时合并当前列数据
	function autoRowSpanByPreItem(tb,row,col){ 
		var lastValue=""; 
		var lastPreValue=""; 
		var value=""; 
		var PreValue="";
		var pos=1; 
		if(col==0)return;
		
		for(var i=row;i<tb.rows.length;i++){ 
			value = tb.rows[i].cells[col].innerText; 
			PreValue = tb.rows[i].cells[col-1].innerText; 
			if(lastValue == value && PreValue==lastPreValue){
				var idx=i-pos;			
				tb.rows[i].deleteCell(col); 
				tb.rows[idx].cells[col].rowSpan = tb.rows[idx].cells[col].rowSpan+1;
				pos++; 	
			}else{ 
				lastValue = value;
				lastPreValue=PreValue;
				pos=1; 
			} 
		} 
	}
	
</script>
<script>
	function showTreemMean(obj) {
		var cityObj = $(obj);
		var cityOffset = $(obj).offset();
		var leftv = cityOffset.left;
		var topv = cityOffset.top;
		var oh = cityObj.outerHeight();
		$('#divTree').css({
			left : leftv + "px",
			top : topv + oh + "px"
		}).slideDown("fast");
		;
		$("body").bind("mousedown", onBodyDown);
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
		$('#divTree').fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}

	function changeStation(treeNode) {
		var selectv = document.getElementById('stationName');
		selectv.value = treeNode.name;
		whole_stationId = treeNode.id
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
</html>

