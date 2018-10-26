<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>红色预警巡防部署</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/fastReverseShift.css">
<link rel="stylesheet" href="../layui/css/formSelects-v4.css">
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>
<script src="../js/jquery/jquery.js"></script>
<style>
table thead, tbody {
    display:table;
    width:100%;
    table-layout:fixed;
}

.layui-table{
	margin:0
}

.table-head{background-color:#999;color:#000;border-left: 1px solid #ccc;text-align: center;}
.table-body{width:100%; height:500px;overflow-y:scroll;overflow-x:hidden;border-right: 1px solid #ccc;border-left: 1px solid #ccc;border-bottom: 1px solid #ccc;}
.table-head table,.table-body table{width:100%;}
.table-head::-webkit-scrollbar{
	width: 0;
}
.table-body::-webkit-scrollbar{
	width: 0;
}

.input-border {
	border: none;
}

.layui-table td{
	padding: 9px 0;
}

.layui-input{
	padding-left: 0;
	text-align: center;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/redWarnMenu.jsp"%>
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
							style="position: fixed; width: auto ; height: auto; z-index: 2; right: 30px; background: white; border-radius: 5px; padding: 5px;">
							<form class="layui-form" action="">
								<div class="layui-inline">
									<div class="layui-input-inline" style="margin-top: 5px;">
										<input type="checkbox" name="like1[write]" lay-skin="primary"
											title="<img src='../images/gray.png'><img src='../images/blue.png'>&nbsp;部署点 ">
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="fromDate"
											placeholder="yyyy-MM-dd">
									</div>
									<label>-</label>
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="toDate"
											placeholder="yyyy-MM-dd">
									</div>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="mapSearchClick(1);">搜索</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="mapSearchClick(2);">前一天</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="mapSearchClick(3);">后一天</button>
								</div>
								<div class="layui-inline">
									<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="mapSearchClick(4);">今天</button>
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
						<label class="layui-form-label">点位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="name" id="name" autocomplete="off"
								class="layui-input">
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
								style="background: #4472ca;" id="savePopedomMessId">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;" id="stop">停用</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="divTree"
		style="position: absolute; overflow: auto; border: solid 1px #ccc; background-color: #fff; height: 150px; min-width: 278px; z-index: 2;">
		<ul id="tree" class="ztree" style="z-index: 2;"></ul>
	</div>
	<div id="staffDiv"
		style="position: absolute; display: none; border: solid 1px #ccc; background-color: #fff; width: 350px; z-index: 1;">
		<div class="layui-form-item" style="width: 300px; margin: 5px auto;">
			<label class="layui-form-label" style="text-align: left; width: auto">单位</label>
			<div class="layui-input-inline" style="float: right;">
				<input readonly="readonly" onclick="showTreemMean(this)"
					autocomplete="off" class="layui-input" style="width: 200px;"
					id="selectStaionName">
			</div>
		</div>
		<div style="width: 300px; margin: 5px auto;">
			<select id="staffMess" xm-select="selectStaff" xm-select-search=""
				xm-select-create="" xm-select-height="36px">
			</select>
		</div>
		<div style="float: right; padding-bottom: 5px; margin-right: 25px;">
			<button class="layui-btn layui-btn-primary" id="ensure">确定</button>
		</div>
	</div>	
</body>
<script src="../layui/formSelects-v4.js"></script>
<script src="../js/common/stationSelectorItem.js"></script>
<script src="../js/pgis/DrawPGISInfo.js"></script>
<script type="text/javascript">
var formSelects = layui.formSelects;
var map;
var drawMarkerHandle;
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
						elem : '#fromDate',
						theme : '#4472ca',
						value: new Date(),
						formart:'yyyy-MM-dd'
					});
					laydate.render({
						elem : '#toDate',
						theme : '#4472ca',
						value: new Date(),
						formart:'yyyy-MM-dd'
					});
					
					form.on('submit', function(data){
					    return false;
					});					
				
					window.layuiRender = function() {
						form.render();
						table.render();
						element.init();
						ChangeTableHeight();
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
								elem : '#timespan_'+identify+'_'+i,
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
	drawMarkerHandle=DrawPGISInfo.Init(map);
});
function AfterInitial() {		
	SelectorItem= new stationSelectorItem();		
}
// 点击排班出现操作栏
function makeOrder(identify) {
	var fromDate = document.getElementById("searchBegin_"+identify).value;
	var toDate = document.getElementById("searchEnd_"+identify).value;
	var makeSave = document.getElementById("makeSave_"+identify);
	var makeOrder = document.getElementById("makeOrder_"+identify);
	if(fromDate!=toDate){
		ShowTip("温馨提示","单天状态下才能排班!");
		return;
	}
	changeTable(fromDate,toDate,identify,0);	
	addTimeSpanRender(identify);
	makeSave.removeAttribute("style");
	makeOrder.style.display = "none";
	editTimeSpanRender(identify,whole_timeSpanIDMap.get(identify));
	ChangeTableHeight();
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
	var fromDate = document.getElementById("searchBegin_"+identify).value;
	var toDate = document.getElementById("searchEnd_"+identify).value;
	var makeSave = document.getElementById("makeSave_"+identify);
	var makeOrder = document.getElementById("makeOrder_"+identify);
	if(fromDate!=toDate){
		return;
	}
	changeTable(fromDate,toDate,identify,1);
	addTimeSpanRender(identify);
	makeOrder.removeAttribute("style");
	makeSave.style.display = "none";
	
	editTimeSpanRender(identify,whole_timeSpanIDMap.get(identify));
	ChangeTableHeight();
}
</script>
<script type="text/javascript">
var whole_shiftId;// 字典排班类型code
var whole_stationId;// 字典单位code
var whole_formDiv = document.getElementById("formDiv");// 详细信息框
var whole_topName = document.getElementById("topName");// 详细框信息名称
var whole_number = document.getElementById("number");// 编号
var whole_name = document.getElementById("name");// 巡逻区域
var whole_latitude = document.getElementById("latitude");// x坐标
var whole_longitude = document.getElementById("longitude");// y坐标
var whole_stationName = document.getElementById("stationName");// 关联单位
var whole_stationId;// 关联单位id
var whole_memo = document.getElementById("memo");// 备注
var whole_stop = document.getElementById("stop");// 停用
var whole_savePopedomMess = document.getElementById("savePopedomMessId");// 保存信息按钮
var whole_subStationMap=new Map();
var whole_pointInfoMap=new Map();
var showClickTimes = 1;// 点击显示表格标识
var whole_ClickMenuMap  =new Map();//选项卡对应数据
var whole_addTimeSpanMap = new Map();// 新增时间段list
var whole_timeSpanIDMap=new Map();//时间控件map
var whole_TopstationId=1;//组织架构数的顶点
var whole_shiftTypeIdMap = new Map();// 存放排班类型id
// 获取分局信息
$(function() {	
	var strValue = "'红色预警巡防班'";
	PostData("duty/shiftType/filter", createRequest(0, 1000, "id",
			"name,string,in,"+strValue+""),
			function(result) {
		var data = result.data;
		for(var i=0;i<data.length;i++){
			whole_shiftTypeIdMap.set(data[i].name,data[i].id);
		}
	},false);
	PostData("base/baseDict/filter", createRequest(0, 1000, "id",
			"DictName,string,=,PointInfo"),
			function(result) {					
				for (var i=0;i<result.data.length;i++) {
					if(result.data[i].name == "红色预警巡防部署"){
						whole_shiftId = result.data[i].id;
						whole_pointInfoMap.set(result.data[i].name,result.data[i].id);
					}
				}
				whole_pointInfoMap = getPointInfo(result.data, whole_shiftId, whole_pointInfoMap);
				whole_stationId = whole_pointInfoMap.get("分局");
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
								if(!whole_subStationMap.has(stationMess.id)){
									whole_subStationMap.set(stationMess.id,stationMess.name);
								}
								html += '<li id="station_'
										+ stationMess.id
										+ '" onclick="showAll(this)">'
										+ stationMess.name
										+ '<img class="common_img" src="../images/starlogo.png" onclick="showTable('+stationMess.id+',2,\''+stationMess.name+'\')">';
								html += '<ul style="display: none; width: 100%; background: white;" onclick="cancelBubble()">';
								html += '<li style="width: 100%; height: auto; background: white;">';
								/*html += '<div>分局(队伍驻地):</div>';
								html += '<form class="layui-form" style="padding-bottom: 8px; width: 227px; margin-left: 20px;">';
								html += '<textarea id="textarea_' + stationMess.id + '" class="layui-textarea" style="resize: none;">';
								if(typeof(stationMess.memo)!="undefined"){
									html += stationMess.memo;
								}
								html += '</textarea>';
								html += '<button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit="" style="width: 227px; margin-top: 5px;" onclick="saveResidentMess('
										+ stationMess.id + ')">保存信息</button>';
								html += '</form>';
								html += '<div>';*/
								html += '<button class="layui-btn layui-btn-primary" onclick="showMess('
										+ stationMess.id
										+ ',0)">增加巡逻点</button>';
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
				 getAllPointInfo();
			});
});

function getAllPointInfo(dateOne,dateTwo){
	var nowDate=new Date().Format("yyyy-MM-dd");
	var fromDate=nowDate;
	var toDate=nowDate;
	if(dateOne!=null && dateTwo!=null && dateOne.length>0 && dateTwo.length>0){
		fromDate=dateOne;
		toDate=dateTwo;
	}
	//135所有的辖区
	var pointTypes = whole_pointInfoMap.get("辖区");
	var strConditions = "Type,string,=," + pointTypes+";state,string,=,启用";
	PostData(
			"point/point/filter",
			createRequest(0, 1000, "id",
					strConditions),
			function(result) {
				var allPointinfo=result.data;
				if(allPointinfo.length==0){
					return;
				}
				var strPointId="";
				for(var i=0;i<allPointinfo.length;i++){						
					strPointId += allPointinfo[i].id + ",";						
				}
				if(strPointId.length>0){
					strPointId=strPointId.substr(0,strPointId.length-1);
				}
				var arrangeInfos=getArrangeInfosData(fromDate,toDate,strPointId);				
				//查找是否有排班
				var arrngeInfosMap=new Map();					
				for(var i=0;i<arrangeInfos.length;i++){
					var key=arrangeInfos[i].pointInfoId;
					if(!arrngeInfosMap.has(key)){
						arrngeInfosMap.set(key,arrangeInfos[i].shiftType);
					}
				}				
				map.RemoveMarkByType("redWarning");
				for(var i=0;i<allPointinfo.length;i++){
					var item=new Object();
					item.lng=allPointinfo[i].latitude;
					item.lat=allPointinfo[i].longitude;
					item.name=allPointinfo[i].name;
					item.type="redWarning";
					item.ID=allPointinfo[i].id;
					item.lineid=allPointinfo[i].pid;
					item.content="";
					item.iconUrl="../images/"+getIconFromPointInfo(allPointinfo[i],arrngeInfosMap);
					if(typeof item.lng !="undefined" && item.lng!=0){
						map.AddMark(item);	
					}
				}				
			});
}


function getIconFromPointInfo(pointInfo,arrngeInfosMap){
	var iconUrl="";
	var shiftTypeId="";
	if(arrngeInfosMap.has(pointInfo.id)){
		shiftTypeId=arrngeInfosMap.get(pointInfo.id);
	}
	var iconName = "";
	if(shiftTypeId==""){
		iconName="gray.png";
	}else{
		iconName="blue.png";
	}		
	return iconName;
}
//按时间类型查找排班
function mapSearchClick(type){
	var NowDate=new Date();
	var fromDate=document.getElementById('fromDate').value;
	var toDate=document.getElementById('toDate').value;
	if(type==1){//搜索按钮
		var nowDateString=NowDate.Format("yyyy-MM-dd");
		if(fromDate==null || fromDate.length==0){
			fromDate=nowDateString;
		}
		if(toDate==null || toDate.length==0){
			toDate=nowDateString;
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
	}
	else if(type==4){//今天
		var nowDateString=NowDate.Format("yyyy-MM-dd");
		fromDate=nowDateString;
		toDate=nowDateString;		
	}
	else if(type==5){//本周	     
	    var WeekFirstDay=new Date(NowDate-(NowDate.getDay()-1)*86400000); 
	    var WeekLastDay=new Date((WeekFirstDay/1000+6*86400)*1000);		    
	    fromDate= WeekFirstDay.Format("yyyy-MM-dd");
	    toDate=WeekLastDay.Format("yyyy-MM-dd"); 
	}
	else if(type==6){//本月
		 var MonthFirstDay=new Date(NowDate.getFullYear(),NowDate.getMonth(),1);
		 var MonthNextFirstDay=new Date(NowDate.getFullYear(),NowDate.getMonth()+1,1); 
		 var MonthLastDay=new Date(MonthNextFirstDay-86400000); 
		 fromDate= MonthFirstDay.Format("yyyy-MM-dd");
		 toDate=MonthLastDay.Format("yyyy-MM-dd"); 
	}
	 document.getElementById('fromDate').value=fromDate;
	 document.getElementById('toDate').value=toDate;
	 getAllPointInfo(fromDate,toDate);
}
// 获取重点防务区排班所有的id
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
								if(popedom.state != "启用"){
									html += 'style="display: none;"';
								}
								html += ' onclick="showMess('+pid+',' +popedom.id+',\'' + popedom.state + '\')" class="areaStyle">';
								html += '<img class="areaStyle_img" src="../images/diamond.png">';
								html += popedom.name;
								html += '<img class="common_img" src="../images/starlogo.png" onclick="showTable('+popedom.id+',3,\''+popedom.name+'\')">';
								html += '</li>';
							}
							$("#popedoms_" + pid + "").append(html);
						});
				$(obj).addClass("liL1");
				tag[i].style.display = "block";
			}
		}
	}
}

// 显示辖区信息或者显示添加辖区信息
function showMess(stationPId,stationId,strState) {
	closeMess();
	if(strState == "停用"){
		whole_stop.innerText = "启用";
	}else if(strState == "启用"){
		whole_stop.innerText = "停用";
	}
	if (stationId>0) {
		var popedom_id = stationId;
		var station_id = stationPId;
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
					whole_formDiv.style.display = "block";
				});
	}else{
		whole_savePopedomMess.setAttribute("onclick", "savePopedomMess("+stationPId+",\"\")");
		whole_stop.setAttribute("onclick", "stopPopedom(-1)"); 
		whole_topName.innerText = "新增巡逻点";
		whole_formDiv.style.display = "block";
	}
}

// 关闭辖区信息或者关闭添加辖区信息
function closeMess() {
	// 清空input的值
	whole_topName.innerText = "";
	whole_number.value = "";
	whole_name.value = "";
	whole_latitude.value = "";
	whole_longitude.value = "";;
	whole_stationName.value = "";
	whole_memo.value = "";
	whole_stop.innerText = "停用";// 默认停用
	// 隐藏详细信息框
	whole_formDiv.style.display = "none";
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
	request.type = whole_pointInfoMap.get("辖区");
	request.state = "启用";
	
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
			if(src.indexOf("/images/checked.png") != -1){
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("style");
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("onclick");
				document.getElementById("popedom_"+id+"_"+stationId).setAttribute("onclick","showMess("+stationId+"," +id+",\"启用\")");
			}else{
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("style");
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("onclick");
				document.getElementById("popedom_"+id+"_"+stationId).setAttribute("onclick","showMess("+stationId+"," +id+",\"停用\")");
			}
		}else if(whole_stop.innerText == "停用"){
			whole_stop.innerText = "启用";
			if(src.indexOf("/images/unchecked.png") != -1){
				document.getElementById("popedom_"+id+"_"+stationId).style.display = "none";
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("onclick");
				document.getElementById("popedom_"+id+"_"+stationId).setAttribute("onclick","showMess("+stationId+"," +id+",\"停用\")");
			}else{
				document.getElementById("popedom_"+id+"_"+stationId).style.display = "none";
				document.getElementById("popedom_"+id+"_"+stationId).removeAttribute("onclick");
				document.getElementById("popedom_"+id+"_"+stationId).setAttribute("onclick","showMess("+stationId+"," +id+",\"启用\")");
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
function showTable(itemId,type,title) {		
	var identify = showClickTimes;
	showClickTimes ++;
	var NowDate=new Date().Format("yyyy-MM-dd");
	whole_ClickMenuMap.set(identify,itemId+","+type+","+title);
			
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
	html2 += "<button style='margin-right: 20px;' class='layui-btn layui-btn-primary layui-btn-sm' onclick='makeCancel("+identify+")'>返回</button>";
	html2 += "<label>复制排班：</label><label>原日期</label><div class='layui-input-inline' style='width: 120px;'>";
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
	html2 += "</div><div class='layui-inline' style='width: 100%;'></div>";
	html2 += "<div id='shiftTableDiv_"+identify+"'><div class='table-head'><table class='layui-table'>";
	html2 += CreateHeadHtml(type,title,NowDate);
	html2 += "</table></div>";
	html2 += "<div class='table-body'><table class='layui-table' style='text-align: center;' id='shiftTable_"+identify+"'>";
	html2 += CreateBodyHtml(itemId,type,NowDate,NowDate,1,identify);		
	html2 += "</table></div>";
	html2 += "</div>";
	html2 += "</div>";
	html2 += "</div>";
	
	$("#tabContent").append(html2);
	
	var tbody=document.getElementById("shiftTable_"+identify);
	autoRowSpanByPreItem(tbody,0,2);	
	autoRowSpanByPreItem(tbody,0,1);
	autoRowSpan(tbody,0,0);
	
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
		ShowTip("温馨提示","日期错误，请检查日期！");
		return false;
	}
	if(typeof isCover!="undefined"){
		cover=isCover
	}
	var value=whole_ClickMenuMap.get(index);
	var item=value.split(",");
	if(item.length>=2){	
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
					}
					for(var i=0; i<arrangeInfos.length;i++){
						arrangeInfos[i].workDt=toDate;
						arrangeInfos[i].fromTime=toDate+ arrangeInfos[i].fromTime.substr(10,8);
						arrangeInfos[i].toTime=toDate+ arrangeInfos[i].toTime.substr(10,8);						
						delete arrangeInfos[i].id;
					}
					
					//保存排班和排班设备信息
					var saveArrangeFlag=saveArrangeInfos(arrangeInfos);					
					if(saveArrangeFlag==true){
						ShowTip("温馨提示","复制排班成功!");						
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

//删除排班数据
function delArrangeInfoByIds(arrangeInfoIds){
	var flag=false;
	if(arrangeInfoIds!=null && arrangeInfoIds.length>0){		
		var request=arrangeInfoIds;		
		PostData("duty/arrange/deleteList",request,function(result) {
			if(result.code==0){	
				flag= true;
			}
		},false);
	}
	return flag;
}
//删除排班设备数据
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

//按时间类型查找排班
function searchClick(index,type){
	var makeSave = document.getElementById("makeSave_"+index);
	var makeOrder = document.getElementById("makeOrder_"+index);
	makeOrder.removeAttribute("style");
	makeSave.style.display = "none";
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
	changeTable(fromDate,toDate,index,1);
	ChangeTableHeight();
}
function changeTable(fromDate,toDate,index,isEdit){
	var dateshow="";
	if(fromDate==toDate){
		dateshow=fromDate;
	}
	else{
		dateshow=fromDate+"至"+toDate;
	}
	var value=whole_ClickMenuMap.get(index);
	var item=value.split(",");
	if(item.length>=2){		
		//$('#shiftTable_'+index).remove();
		var html="<div class='table-head'><table class='layui-table'>";			
		html += CreateHeadHtml(item[1],item[2],dateshow,isEdit);
		html += "</table></div>";
		html += "<div class='table-body' id='shiftTableBodyDiv_"+index+"'><table class='layui-table' style='text-align: center;' id='shiftTable_"+index+"'>";
		html += CreateBodyHtml(item[0],item[1],fromDate,toDate,isEdit,index);
		html += "</table></div>";
		document.getElementById('shiftTableDiv_'+index).innerHTML=html;
		
		var tbody=document.getElementById("shiftTable_"+index);			
		if(item[2]!=1){
			autoRowSpanByPreItem(tbody,0,2);				
		}
		autoRowSpanByPreItem(tbody,0,1);
		autoRowSpan(tbody,0,0);
	}
}

function CreateHeadHtml(type,title,strDate,isEdit) {
	var html = "";
	html += "<thead>";
	html += "<tr>";
	if(isEdit == 0){
		if(type==1){
			html += "<td colspan='8'>各分局红色预警巡防部署安排表("+strDate+")</td>";
		}else if(type==2||type==3){
			html += "<td colspan='8'>"+title+"红色预警巡防部署安排表("+strDate+")</td>";
		}
	}else{
		if(type==1){
			html += "<td colspan='7'>各分局红色预警巡防部署安排表("+strDate+")</td>";
		}else if(type==2||type==3){
			html += "<td colspan='7'>"+title+"红色预警巡防部署安排表("+strDate+")</td>";
		}
	}
	html += "</tr>"
	html += "<tr>";
	html += "<td rowspan='2'>分局(队伍驻地)</td>";
	html += "<td rowspan='2'>派出所</td>";
	html += "<td rowspan='2'>点位</td>";
	html += "<td rowspan='2'>巡逻时段</td>";
	html += "<td colspan='3'>执勤人员</td>";
	if(isEdit == 0){
		html += "<td rowspan='2'>操作</td>";
	}	
	html += "</tr>";
	html += "<tr>";
	html += "<td>姓名</td>";
	html += "<td>职务</td>";
	html += "<td>电话</td>";
	html += "</tr>";
	html += "</thead>";
	return html;
}
//得到表格主体
//type类型：1表示点击班别（1，3，5）；2表示点击分局；3点击辖区
//itemid ：type==1时，typePath的查询值；type==2时，分局id；type==3时，辖区id；
function CreateBodyHtml(itemId,type,fromTime,toTime,isEdit,pageId){
	var pointInfos=getPointInfoData(itemId,type);

	if(pointInfos!=null && pointInfos.length>0){
		var strPointId=getPointIdString(pointInfos);		
		var arrangeInfos=getArrangeInfosData(fromTime,toTime,strPointId);
		var arrangeTimeSpan=getTimeSpansFromArrangeData(arrangeInfos);			
		var listRowIdx=createTableDateIdx(pointInfos,arrangeTimeSpan);
		var html= "";
		if(isEdit!=0){
			html += createTableBody(listRowIdx,pointInfos,arrangeInfos,whole_subStationMap,arrangeTimeSpan);
		}else{
			html += createTableEditBody(listRowIdx,pointInfos,arrangeInfos,whole_subStationMap,arrangeTimeSpan,pageId)
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
	if(strPointId.length>0){	
		var strConditions = "pointInfoId,int,in,"+strPointId +";workDt,string,>=,"+fromTime+";workDt,string,<=,"+toTime;
		
		PostData("duty/arrange/filter",createRequest(0, 1000, "id", strConditions),function(result) {
			if(result.data.length>0){
				arrangeInfos=result.data;
			}
		},false);
	}
	
	return arrangeInfos;
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

//组织表格数据序号
function createTableDateIdx(pointInfos,arrangeTimeSpan){
	var pointCnt=pointInfos.length;
	var arrangeCnt=arrangeTimeSpan.length;
	//
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
				listRowIdx[i] +=j+";";
			}				
		}
	}		
	return listRowIdx;
}
//扽到表格数据
//substation 分局ID序列
function createTableBody(listRowIdx,pointInfos,arrangeInfos,substation,arrangeTimeSpan){
	var html="";	
	var type=2	
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
				html += "<td rowspan='"+rows +"'>"+substation.get(itemPoint.pid)+"</td>";				
				html += "<td rowspan='"+rows +"'>" + itemPoint.stationName + "</td>";
				html += "<td rowspan='"+rows +"'>"+itemPoint.name+"</td>";				
				html += "<td rowspan='"+rows +"'>"+ fromTime.substr(11,5) + "-" + toTime.substr(11,5) + "</td>";				
				html += "<td>" + itemArrange.staffName+ "</td>";
				html += "<td>" + itemArrange.staffPost+ "</td>";
				html += "<td>" + itemArrange.staffPhone+ "</td>";				
				html += "</tr>";
				for(var k=1;k<rows;k++){
					html += "<tr>";
					html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffName+ "</td>";
					html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffPost+ "</td>";
					html += "<td>" + arrangeInfos[Number(arrangeIdx[k])].staffPhone+ "</td>";
					html += "</tr>";	
				}
			}
		}
		else{
			var itemPoint=pointInfos[i];
			html += "<tr>";				
			html += "<td>"+substation.get(itemPoint.pid)+"</td>";					
			html += "<td>" + itemPoint.stationName + "</td>";
			html += "<td >"+itemPoint.name+"</td>";			
			html += "<td></td>";				
			html += "<td></td>";
			html += "<td></td>";
			html += "<td></td>";			
			html += "</tr>";
		}
	}
	html += "</tbody>";
	return html;
	
}
//扽到表格编制数据
//substation 分局ID序列
function createTableEditBody(listRowIdx,pointInfos,arrangeInfos,substation,arrangeTimeSpan,pageId){
	var html="";	
	var addTimeSpanList = new Array();
	var timeSpanIdx=0;
	html += "<tbody>";
	for(var i=0;i<listRowIdx.length;i++){
		var itemLineIdx="";
		if(listRowIdx[i].length>0)
			itemLineIdx=listRowIdx[i].split(";");			
		var spanRows=itemLineIdx.length-1;
		var temp = "";
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
				html += "<td id='areaId_"+pageId+"_"+itemPoint.pid+"'>"+substation.get(itemPoint.pid)+"</td>";				
				html += "<td id='type_"+pageId+"_"+itemPoint.id+"'>" + itemPoint.stationName + "</td>";
				html += "<td id='name_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.name+"</td>";				
				html += "<td><input type='text' class='layui-input  input-border' id='timespan_"+pageId+"_"+timeSpanIdx+"' value='" + fromTime.substr(11,5) + " - " + toTime.substr(11,5) + "'></td>";					
				var staffinfo="";
				for(var k=0;k<arrangeIdx.length;k++){	
					staffinfo +="<div id='staffinfo_"+pageId+"_"+itemPoint.id+"_"+arrangeInfos[Number(arrangeIdx[k])].id+"' style='width: 100%;background-color: #92B4F4;margin-bottom: 5px;'>";
					staffinfo +=arrangeInfos[Number(arrangeIdx[k])].staffId+",";
					staffinfo +=arrangeInfos[Number(arrangeIdx[k])].staffName +","+ arrangeInfos[Number(arrangeIdx[k])].staffPost+",";	
					staffinfo +=arrangeInfos[Number(arrangeIdx[k])].staffPhone;
					if(typeof(arrangeInfos[Number(arrangeIdx[k])].staffPositionName)!="undefined"){
						staffinfo += ","+ arrangeInfos[Number(arrangeIdx[k])].staffPositionName;
					}else{
						staffinfo += ",";
					}
					staffinfo += ";<span style='display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;' onclick='delStaff(this)'>x</span></div>";
				}
				html += "<td colspan='3' id='staffMess_"+pageId+"_"+timeSpanIdx+"' onclick='showStaffMess("+itemPoint.id+","+pageId+","+itemPoint.stationId+",\""+itemPoint.stationName+"\","+timeSpanIdx+")'>" + staffinfo + "</td>";			
				html += "<td><div style='margin-top: 5px;'><button class='layui-btn layui-btn-normal layui-btn-small' onclick='addShift("+itemPoint.pid+","+itemPoint.id+","+pageId+")'>增加</button></div>";
				html += "<div style='margin-top: 5px;'><button class='layui-btn layui-btn-warm layui-btn-small' onclick='modifyStaffAndDeviceMess("+itemPoint.id+","+pageId+","+timeSpanIdx+")'>保存</button></div>";
				html += "<div style='margin-top: 5px;'><button class='layui-btn layui-btn-small' onclick='delStaffAndDeviceMess("+itemPoint.id+",\""+fromTime+"\",\""+toTime+"\","+pageId+")'>删除</button></div></td>";
				html += "</tr>";
				addTimeSpanList.push(itemPoint.id);
				timeSpanIdx++;
			}
		}
		else{
			var itemPoint=pointInfos[i];
			html += "<tr>";				
			html += "<td id='areaId_"+pageId+"_"+itemPoint.pid+"'>"+substation.get(itemPoint.pid)+"</td>";		
			html += "<td id='type_"+pageId+"_"+itemPoint.id+"'>" + itemPoint.stationName + "</td>";
			html += "<td id='name_"+pageId+"_"+itemPoint.id+"'>"+itemPoint.name+"</td>";			
			html += "<td><input type='text' class='layui-input  input-border' id='timespan_"+pageId+"_"+timeSpanIdx+"' placeholder='00:00 - 00:00'></td>";
			html += "<td colspan='3' id='staffMess_"+pageId+"_"+timeSpanIdx+"' onclick='showStaffMess("+itemPoint.id+","+pageId+","+itemPoint.stationId+",\""+itemPoint.stationName+"\","+timeSpanIdx+")'></td>";		
			html += "<td>";
			html += "<div style='margin-top: 5px;'><button class='layui-btn layui-btn-warm layui-btn-small' onclick='modifyStaffAndDeviceMess("+itemPoint.id+","+pageId+","+timeSpanIdx+")'>保存</button></div>";
			html += "</td>";
			html += "</tr>";
			addTimeSpanList.push(itemPoint.id);
			timeSpanIdx++;
		}
		whole_addTimeSpanMap.set(pageId,addTimeSpanList);
		html += createAddTr(temp,pageId,itemPoint);
	}		
	//html += "</tbody></table></div>";
	html += "</tbody>";
	whole_timeSpanIDMap.set(pageId,timeSpanIdx);
	return html;
	
}

// 编辑删除人员
function delStaff(obj) {
	var id = $(obj).parent().attr("id");
	if(typeof(id)=="undefined"){
		$(obj).parent().remove();
		cancelBubble();
		return;
	}
	var elem = document.getElementById(id);
	elem.style.display="none";
	cancelBubble();
}

// 创建隐藏的新增tr
function createAddTr(temp,pageId,itemPoint) {
	var html = "";
	var timeSpanIdx;
	html += "<tr id='tr_"+pageId+"_"+itemPoint.id+"' style='display: none;'>";
	html += "<td><input type='text' class='layui-input input-border' id='addTimeSpan_"+pageId+"_"+itemPoint.id+"' placeholder='00:00 - 00:00'></td>";
	html += "<td colspan='3' id='staffMess_"+pageId+"_"+itemPoint.id+"-' onclick='showStaffMess("+itemPoint.id+","+pageId+","+itemPoint.stationId+",\""+itemPoint.stationName+"\","+timeSpanIdx+")'></td>";	
	html += "<td><div style='margin-top: 5px;'><button class='layui-btn layui-btn-warm layui-btn-small' onclick='saveShiftAndDeviceMess(\""+temp+"\","+pageId+","+itemPoint.id+","+itemPoint.stationId+")'>保存</button></div>";
	html += "<div style='margin-top: 5px;'><button class='layui-btn layui-btn-small' onclick='cancelSaveMess("+itemPoint.pid+","+itemPoint.id+","+pageId+")'>取消</button></div></td>";
	html += "</tr>";
	return html;
}

// 创建警员option
function createStaffOption(stationId) {
	PostData("staff/staff/filter", createRequest(0, 1000, "id","stationId,string,=,"+stationId+""),function(result) {
		var data = result.data;
		$("#staffMess").empty();
		var html = "";
		for(var i=0;i<data.length;i++){
			html += "<option value='"+data[i].id+","+data[i].name+","+data[i].nonLeaderPost+","+data[i].telephone+","+data[i].position+"'>"+data[i].name+"</option>";
		}
		$("#staffMess").append(html);
		formSelects.render();
	})
}

// 点击增加按钮
function addShift(pid,id,identify) {
	var tr = document.getElementById("tr_"+identify+"_"+id);
	if(tr.style.display==""){
		return;
	}
	var areaId = document.getElementById("areaId_"+identify+"_"+pid);
	var type = document.getElementById("type_"+identify+"_"+id);
	var name = document.getElementById("name_"+identify+"_"+id);	
	if(areaId!=null){
		areaId.setAttribute("rowspan",areaId.rowSpan+1);
	}
	if(type!=null){
		type.setAttribute("rowspan",type.rowSpan+1);
	}
	if(name!=null){
		name.setAttribute("rowspan",name.rowSpan+1);
	}
	
	tr.removeAttribute("style");
}

// 取消保存
function cancelSaveMess(pid,id,identify) {
	var tr = document.getElementById("tr_"+identify+"_"+id);
	var areaId = document.getElementById("areaId_"+identify+"_"+pid);
	var type = document.getElementById("type_"+identify+"_"+id);
	var name = document.getElementById("name_"+identify+"_"+id);
	var description = document.getElementById("description_"+identify+"_"+id);
	if(areaId!=null){
		areaId.setAttribute("rowspan",areaId.rowSpan-1);
	}
	if(type!=null){
		type.setAttribute("rowspan",type.rowSpan-1);
	}
	if(name!=null){
		name.setAttribute("rowspan",name.rowSpan-1);
	}
	if(description!=null){
		description.setAttribute("rowspan",description.rowSpan-1);
	}
	tr.style.display = "none";
}

// 修改排班信息
function modifyStaffAndDeviceMess(id,pageId,timeSpanIdx) {
	var shiftType=whole_shiftTypeIdMap.get("红色预警巡防班");
	var searchBegin = document.getElementById("searchBegin_"+pageId).value;// 第一个搜索时间
	var timeSpan = document.getElementById("timespan_"+pageId+"_"+timeSpanIdx).value;// 时间段
	var fromTime = "00:00:00";
	var toTime = "00:00:00";
	if(timeSpan.split(" - ").length==2){
		fromTime = searchBegin + " " + timeSpan.split(" - ")[0];
		toTime = searchBegin + " " + timeSpan.split(" - ")[1];
	}else{
		fromTime = searchBegin + " " + fromTime;
		toTime = searchBegin + " " + toTime;
	}
	var divs = document.getElementById("staffMess_"+pageId+"_"+timeSpanIdx).getElementsByTagName("div");
	var delIdList = new Array();
	var arrangeInfoList = new Array();
	for(var i=0;i<divs.length;i++){
		var arrangeInfo = new Object();
		var temp = divs[i].id.split("_");
		var item = divs[i].innerText.split(";")[0].split(",");
		if(temp.length!=0&&temp!=""){
			arrangeInfo.id = temp[3];
		}
		if(divs[i].style.display=="none"){
			delIdList.push(temp[3]);
			continue;
		}
		arrangeInfo.staffPositionName = item[4];
		arrangeInfo.fromTime = fromTime;
		arrangeInfo.toTime = toTime;
		if(item[0]!=""&&item[0]!=null){
			arrangeInfo.staffId = item[0];
		}
		arrangeInfo.staffName = item[1];
		arrangeInfo.staffPhone = item[3];
		arrangeInfo.staffPost = item[2];
		arrangeInfo.workDt = searchBegin;
		arrangeInfo.shiftType = shiftType;
		arrangeInfo.pointInfoId = id;
		arrangeInfoList.push(arrangeInfo);
	}
	delArrangeInfoByIds(delIdList);
	saveArrangeInfos(arrangeInfoList);

	makeOrder(pageId);
}

// 删除排班信息
function delStaffAndDeviceMess(pointInfoId,fromTime,toTime,pageId) {
	if(fromTime==""||fromTime==null){
		return;
	}
	if(toTime==""||toTime==null){
		return;
	}
	PostData("duty/arrange/deleteFilter",createRequestByPointInfoId(pointInfoId,fromTime,toTime),function(result) {					
	},false);
	PostData("point/pointDevice/deleteFilter",createRequestByPointInfoId(pointInfoId,fromTime,toTime),function(result) {					
	},false);
	makeOrder(pageId);
}

// 根据pointInfoId得到request
function createRequestByPointInfoId(pointInfoId,fromTime,toTime) {
	var request = new Object();
	request.pointInfoId = pointInfoId;
	request.fromTime = fromTime;
	request.toTime = toTime;
	return request;
}

// 单位列表框
function showStaffMess(id,pageId,stationId,stationName,tdId){
	whole_TopstationId=stationId;
	createStaffOption(whole_TopstationId);
	$('#selectStaionName').val(stationName);
	var staffId = document.getElementById("staffMess_"+pageId+"_"+id+"-");
	if(typeof tdId !="undefined"){
		staffId = document.getElementById("staffMess_"+pageId+"_"+tdId);
	}
	var scrollTop=document.getElementById("shiftTableBodyDiv_"+pageId).scrollTop;
	var leftv = staffId.offsetLeft;
	var topv = staffId.offsetTop;
	var ow = staffId.offsetWidth;
	var oh =staffId.offsetHeight
	$('#staffDiv').css({
		left : leftv + 290 + "px",
		top : topv + 110 + oh - scrollTop + "px"
	}).slideDown("fast");
	document.getElementById('staffMess').setAttribute("xm-select-create","");
	document.getElementById("ensure").setAttribute("onclick","addStaffMess("+id+","+pageId+","+tdId+")");
	$("body").bind("mousedown", onBodyMouseDown);
}



// 根据排班类别保存排班信息
function saveShiftAndDeviceMess(temp,pageId,pointId,stationId) {
	var shiftType=whole_shiftTypeIdMap.get("红色预警巡防班");	
	var searchBegin = document.getElementById("searchBegin_"+pageId).value;// 第一个搜索时间
	var addTimeSpan = document.getElementById("addTimeSpan_"+pageId+"_"+pointId).value;// 时间段
	var fromTime = "00:00:00";
	var toTime = "00:00:00";
	if(addTimeSpan.split(" - ").length==2){
		fromTime = searchBegin + " " + addTimeSpan.split(" - ")[0];
		toTime = searchBegin + " " + addTimeSpan.split(" - ")[1];
	}else{
		fromTime = searchBegin + " " + fromTime;
		toTime = searchBegin + " " + toTime;	
	}
	
	var arrangeInfoList = new Array();
	var divs = document.getElementById("staffMess_"+pageId+"_"+pointId+"-").getElementsByTagName("div");// 人员信息
	for(var i=0;i<divs.length;i++){
		var arrangeInfo = new Object();
		var item = divs[i].innerText.split(";x")[0].split(",");
		if(item[0]!=""&&item[0]!=null){
			arrangeInfo.staffId = item[0];
		}
		arrangeInfo.staffName = item[1];
		arrangeInfo.staffPost = item[2];
		arrangeInfo.staffPhone = item[3];
		arrangeInfo.staffPositionName = item[4];
		arrangeInfo.fromTime=fromTime;
		arrangeInfo.toTime=toTime;
		arrangeInfo.workDt=searchBegin;
		if(stationId!=""&&stationId!=null){
			arrangeInfo.stationId=stationId;
		}
		if(pointId!=""&&pointId!=null){
			arrangeInfo.pointInfoId=pointId;
		}
		if(shiftType!=""&&shiftType!=null){
			arrangeInfo.shiftType=shiftType;
		}
		arrangeInfoList.push(arrangeInfo);
	}
	saveArrangeInfos(arrangeInfoList);

	makeOrder(pageId);
}

// 控制单位列表框的隐藏
function onBodyMouseDown(event,object) {
	var obj;
	if(event!=null&&event!=""){
		obj = event.target;
	}else{
		obj = object;
	}
	if(obj.id=="staffDiv"){
		return;
	}else if(obj.id=="divTree"){
		return;
	}else if(obj.className=="layui-layout-body"){
		$('#staffDiv').fadeOut("fast");
		document.getElementById("ensure").removeAttribute("onclick");
		$("body").unbind("mousedown", onBodyMouseDown);
		return;
	}
	onBodyMouseDown("",obj.parentNode);
}

// 将选择的警员加入td
function addStaffMess(id,pageId,tdId) {
	var tdContent = document.getElementById("staffMess_"+pageId+"_"+id+"-");

	if(typeof(tdId)!="undefined"){
		tdContent = document.getElementById("staffMess_"+pageId+"_"+tdId);
	}
	var divsMap = new Map();
	var divs = tdContent.children;
	for(var i=0;i<divs.length;i++){
		if(divs[i].style.display=="none"){
			divsMap.set(divs[i].innerText.replace(";x",""),divs[i].id);
		}
	}
	var tdContentVal = tdContent.innerHTML;
	var selectVal = formSelects.value('selectStaff');
	var strStaff = "" + tdContent.innerHTML;
	for(var i=0;i<selectVal.length;i++){
		if(strStaff.indexOf(selectVal[i].value)==-1){
			strStaff += "<div style='width: 100%;background-color: #92B4F4;margin-bottom: 5px;'>";
			if(selectVal[i].value.split(",").length!=5){
				strStaff += ","+selectVal[i].name+",,,;";				
			}else{
				strStaff += selectVal[i].value+";";				
			}
			strStaff += "<span style='display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;' onclick='delStaff(this)'>x</span></div>";
		}else{
			var id = divsMap.get(selectVal[i].value);
			if(id!=null&&id!=""){
				strStaff += "<div style='width: 100%;background-color: #92B4F4;margin-bottom: 5px;'>";
				strStaff += selectVal[i].value+";";
				strStaff += "<span style='display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;' onclick='delStaff(this)'>x</span></div>";
			}
		}
	}
	tdContent.innerHTML = strStaff;
	$('#staffDiv').fadeOut("fast");
	document.getElementById("ensure").removeAttribute("onclick");
	formSelects.render("selectStaff");
	$("body").unbind("mousedown", onBodyMouseDown);
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
	};

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
		var tdCnt=tb.rows[i].cells.length;//td个数
		if(tdCnt==3 || tb.rows[i].style.display == "none"){
			pos++;			
			continue;
		}
		value = tb.rows[i].cells[col].innerText; 			
		if(lastValue == value){
			var idx=i-pos;	
			var spanCnt=tb.rows[i].cells[col].rowSpan;
			if(spanCnt==null || spanCnt==""){
				spanCnt=1;
			}
			tb.rows[i].deleteCell(col); 
			tb.rows[idx].cells[col].rowSpan = tb.rows[idx].cells[col].rowSpan+spanCnt;
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
		var tdCnt=tb.rows[i].cells.length;//td个数
		if(tdCnt==3 ||  tb.rows[i].style.display == "none"){
			pos++;			
			continue;
		}
		value = tb.rows[i].cells[col].innerText; 
		PreValue = tb.rows[i].cells[col-1].innerText; 
		if(lastValue == value && PreValue==lastPreValue){
			var idx=i-pos;	
			var spanCnt=tb.rows[i].cells[col].rowSpan;
			if(spanCnt==null || spanCnt==""){
				spanCnt=1;
			}
			tb.rows[i].deleteCell(col);
			tb.rows[idx].cells[col].rowSpan = tb.rows[idx].cells[col].rowSpan + spanCnt;
			pos++; 	
		}else{ 
			lastValue = value;
			lastPreValue=PreValue;
			pos=1; 
		} 
	} 
}
//调整内容表格的最大高度
function ChangeTableHeight(){
//	var h= document.documentElement.clientHeight || document.body.clientHeight;	
	var tb=document.getElementsByClassName("table-body");
	//var head=document.getElementsByClassName("layui-header");
	//var headheight=head[0].offsetHeight;
	var tabContent=document.getElementById("tabContent");
	var tabTitle=document.getElementById("tabTitle");		
	var heightbody=tabContent.offsetHeight+tabTitle.offsetHeight;
	if(tb!=null){	
		for(var i=0;i<tb.length;i++){				
			if(tb[i].offsetTop!=0 && heightbody!=(tb[i].offsetHeight+tb[i].offsetTop+5)){
				var offset=heightbody-tb[i].offsetTop-5;
				if(offset>0){
					tb[i].style.height=offset+'px';						
				}		
			}	
		}
	}
}

</script>
<script>
var whole_treeResultId="";
function showTreemMean(obj) {
	treeSelectId = obj.id;
	if(treeSelectId=="stationName"){
		SelectorItem.Initial(false,"tree",1,0,1);
	}else{
		SelectorItem.Initial(false,"tree",whole_TopstationId,0,whole_TopstationId); 	
	}
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
	whole_treeResultId=obj.id;
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
	createStaffOption(treeNode.id);
	var selectv = document.getElementById(whole_treeResultId);
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

