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
<link rel="stylesheet" href="../css/fastReverseShift.css">
<link rel="stylesheet" href="../layui/css/formSelects-v4.css">
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

.layui-table-cell{
	margin-bottom: 5px;
}

.layui-table-cell{
	height: auto;
	line-height: auto;
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
				<div class="layui-tab-content" style="border: 1px solid #ccc; border-top: none;">
					<div class="layui-tab-item layui-show" >
						<div id="body_main_right">
							<div id="right_top">
								公安局办公室
							</div>
							<div id="buttom_caseList">						
								<div id="right_all_caseList_one" style="auto;width:100%;">
								<form class="layui-form" action="" lay-filter="example">
									<div class="layui-form-item">
										<div class="layui-inline" id="makeOrderOrOut">
											<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="makeArrange()">排班</button>
											<button class="layui-btn layui-btn-primary layui-btn-sm">导出</button>
										</div>
										<div class="layui-inline" id="savaOrderOrStop" style="display: none;">
											<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="saveArrange()">保存</button>
											<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="stopArrange()">取消</button>
										</div>
										<div class='layui-inline'>
										    <label class="layui-form-label">时间：</label>
										    <div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="searchTime"
												placeholder="yyyy-MM-dd">
											</div>
											<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="search()">搜索</button>
										</div>
									</div>																
								</form>								
								</div>
								<div id="right_all_caseList_two">
									<table id="gradeTable"></table>
								</div>
							</div>
							<div id="buttom_backMessage"></div>
						</div>
					</div>
				</div>
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
					autocomplete="off" class="layui-input" style="width: 200px;" id="selectStaionName">
			</div>
		</div>
		<div style="width: 300px;margin: 5px auto;">
			<select id="staffMess" xm-select="selectStaff" xm-select-search="" xm-select-create="" xm-select-height="36px">
			</select>
		</div>
		<div style="float: right;padding-bottom: 5px;margin-right: 25px;">
			<button	class="layui-btn layui-btn-primary" id="ensure">确定</button>
		</div>
	</div>
</body>
<script src="../layui/formSelects-v4.js"></script>
<script src="../js/common/stationSelectorItem.js"></script>
<script type="text/javascript">
	var whole_tdColMap = new Map();// 存放td属于列的map
	var whole_makeOrderOrOut = document.getElementById("makeOrderOrOut");// 排班按钮和导出按钮
	var whole_savaOrderOrStop = document.getElementById("savaOrderOrStop");// 保存按钮和取消按钮
	var whole_gradeTable = document.getElementById("gradeTable");// table对象
	var whole_searchTime = document.getElementById("searchTime");// 获取控件的对象
	var whole_gradeTableWidth;// table的宽
	var whole_tdId="tdId";// 定义id
	var whole_shiftTypeIdMap = new Map();// 存放排班类型id
	var whole_fieldByDayMap = new Map();// 日期和table字段绑定
	var whole_dayByFieldMap = new Map();// 日期和table字段绑定
	var whole_fieldList = ["Sun","Mon","Tus","Wed","Thu","Fri","Sat"];
	var whole_arrangeInfoJson = "";// 定义存放的json
	var whole_arrangeInfoStr = "";// 定义存放的string
	var whole_arrangeInfoIdList;// 存放表格的排班信息id数组
	var whole_weekList = new Array();// 存放一周日期
	var whole_topStationId = 1;
	var whole_topStationName = "厦门公安局";
	var formSelects = layui.formSelects;
	
	$(function() {
		var height = $(window).height();
		var width = $(window).width() - 300;
		var mainBody = document.getElementById("mainBody");
		var content = document.getElementsByClassName("layui-tab-content");
		mainBody.style.height = height * 0.85 + "px";
		mainBody.style.width = width + "px";
		whole_gradeTableWidth = Number(width)-20;
		for (var i = 0; i < content.length; i++) {
			content[i].style.height = (height * 0.8 - 30) + "px";
		}
	});	
	
	layui.use([ 'form', 'layedit', 'laydate', 'table'], function(){
		var table = layui.table;
		var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
		//自定义颜色
		laydate.render({
			elem : '#searchTime',
			theme : '#4472ca',
			value : new Date()
		});
		
		form.on('submit',function(data){
			return false;
		});
		
		getArrangeInfos(0);
		strToJson();
		table.render({
		    elem: '#gradeTable'
		    ,cols: [[ //表头
		      {field: 'id', title: '序号', width:(whole_gradeTableWidth*0.042)}
		      ,{field: 'grade', title: '级别', width:(whole_gradeTableWidth*0.11)}
		      ,{field: 'Sun', title: '星期日('+whole_weekList[0]+')', width:(whole_gradeTableWidth*0.12),event:'setSun'}
		      ,{field: 'Mon', title: '星期一('+whole_weekList[1]+')', width:(whole_gradeTableWidth*0.12),event:'setMon'} 
		      ,{field: 'Tus', title: '星期二('+whole_weekList[2]+')', width: (whole_gradeTableWidth*0.12),event:'setTus'}
		      ,{field: 'Wed', title: '星期三('+whole_weekList[3]+')', width: (whole_gradeTableWidth*0.12),event:'setWed'}
		      ,{field: 'Thu', title: '星期四('+whole_weekList[4]+')', width: (whole_gradeTableWidth*0.12),event:'setThu'}
		      ,{field: 'Fri', title: '星期五('+whole_weekList[5]+')', width: (whole_gradeTableWidth*0.12),event:'setFri'}
		      ,{field: 'Sat', title: '星期六('+whole_weekList[6]+')', width: (whole_gradeTableWidth*0.12),event:'setSat'}
		    ]]
		    ,data: whole_arrangeInfoJson
	    	,id: 'gradeTable'
		});
		window.tableEditRender = function(identify) {
			strToJson();
			table.render({
			    elem: '#gradeTable'
			    ,cols: [[ //表头
			      {field: 'id', title: '序号', width:(whole_gradeTableWidth*0.042)}
			      ,{field: 'grade', title: '级别', width:(whole_gradeTableWidth*0.11)}
			      ,{field: 'Sun', title: '星期日('+whole_weekList[0]+')', width:(whole_gradeTableWidth*0.12),event:'Sun'}
			      ,{field: 'Mon', title: '星期一('+whole_weekList[1]+')', width:(whole_gradeTableWidth*0.12),event:'Mon'} 
			      ,{field: 'Tus', title: '星期二('+whole_weekList[2]+')', width: (whole_gradeTableWidth*0.12),event:'Tus'}
			      ,{field: 'Wed', title: '星期三('+whole_weekList[3]+')', width: (whole_gradeTableWidth*0.12),event:'Wed'}
			      ,{field: 'Thu', title: '星期四('+whole_weekList[4]+')', width: (whole_gradeTableWidth*0.12),event:'Thu'}
			      ,{field: 'Fri', title: '星期五('+whole_weekList[5]+')', width: (whole_gradeTableWidth*0.12),event:'Fri'}
			      ,{field: 'Sat', title: '星期六('+whole_weekList[6]+')', width: (whole_gradeTableWidth*0.12),event:'Sat'}
			    ]]
			    ,data: whole_arrangeInfoJson
		    	,id: 'gradeTable'
		    	,done: function (res, curr, count) {
		    		if(identify == 1){
			    		var data = res.data;//返回的json中data数据
			    		for (var i = 0;i<data.length;i++) {
			    			for(var j=0;j<whole_fieldList.length;j++){
			    				var value = data[i][whole_fieldList[j]];
			    				if(value == "" || value == null){
			    					continue;
			    				}
			    				value = value.replace("<div>","").replace("</div>","");
			    				var arrangeInfo = new Object();
			    				arrangeInfo.shiftType = whole_shiftTypeIdMap.get(data[i].grade);
			    			}
			    		}
		    		}
		    	}
			});
			for(var i=0;i<whole_fieldList.length;i++){
				whole_tdColMap.set(whole_fieldList[i],i+2);
			}
			table.on('tool(gradeTable)', function(obj){
				 var data = obj.data;
				 var tdObj = obj.tr.first().children().eq(whole_tdColMap.get(obj.event));
				 showStaffMess(tdObj,whole_tdColMap.get(obj.event),data.id,data.grade,obj.event);
			});
		}
	});
</script>
<script>
	// 获取排班类型的id信息
	function getShiftTypeId() {
		var strValue = "'一级加强','一级','二级','三级'";
		PostData("duty/shiftType/filter", createRequest(0, 1000, "id","name,string,in,"+strValue+""),function(result) {
			var data = result.data;
			for(var i=0;i<data.length;i++){
				whole_shiftTypeIdMap.set(data[i].name,data[i].id);
			}
		},false);
	}
	
	// 获取排班数据
	function getArrangeInfos(isEdit) {
		whole_arrangeInfoIdList = new Array();
		getShiftTypeId();
		whole_arrangeInfoJson = "";
		whole_weekList = getWeekByDay();
		var strShiftTypeId = whole_shiftTypeIdMap.get("一级加强") + "," + whole_shiftTypeIdMap.get("一级")
							+ "," + whole_shiftTypeIdMap.get("二级") + "," + whole_shiftTypeIdMap.get("三级");
		var strCondition = "shiftType,string,in,"+strShiftTypeId+";workDt,string,>=,"+whole_weekList[0]+";workDt,string,<=,"+whole_weekList[6]+""
		PostData("duty/arrange/filter", createRequest(0, 1000, "id",strCondition),function(result) {
			var data = result.data;
			var arrangeInfoMap = new Map();
			for(var i=0;i<data.length;i++){
				whole_arrangeInfoIdList.push(data.id);
				var key = data[i].shiftType + "," +  data[i].workDt;
				var value = data[i].staffName + "," + data[i].staffPhone;
				if(arrangeInfoMap.has(key)){
					arrangeInfoMap.set(key,arrangeInfoMap.get(key) + ";" + value);
				}else{
					arrangeInfoMap.set(key,value);
				}
			}
			var arr = strShiftTypeId.split(",");
			var strShiftTypeList = ["一级加强","一级","二级","三级"];
			for(var i=0;i<arr.length;i++){
				whole_arrangeInfoStr +='{"id":"'+ (i + 1) +'","grade":"'+ strShiftTypeList[i] +'"';
				for(var j=0;j<whole_weekList.length;j++){
					var value = arrangeInfoMap.get(Number(arr[i]) + "," + whole_weekList[j]);
					if(value==""||value==null){
						continue;
					}
					whole_arrangeInfoStr += ',"' + whole_fieldByDayMap.get(whole_weekList[j]) + '":"';
					var valueList = value.split(";");
					if(isEdit == 0){
						for(var k=0;k<valueList.length;k++){
							whole_arrangeInfoStr += '<div>' + valueList[k] + '</div>';
						}
					}else{
						for(var k=0;k<valueList.length;k++){
							whole_arrangeInfoStr += '<div style=\'width: 100%;background-color: #92B4F4;margin-bottom: 5px;\'>' + valueList[k] + ';<span style=\'display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;\' onclick=\'delStaff(this)\'>x</span></div>';
						}
					}
					whole_arrangeInfoStr += '"';
				}
				whole_arrangeInfoStr +='},';
			}
		},false);
	}
	
	// 字符串转json
	function strToJson() {
		whole_arrangeInfoStr = whole_arrangeInfoStr.substring(0, whole_arrangeInfoStr.length - 1);
		whole_arrangeInfoStr = '[' + whole_arrangeInfoStr + ']';
		whole_arrangeInfoJson = JSON.parse(whole_arrangeInfoStr);
	}
	
	// 搜索排班
	function search() {
		getArrangeInfos(0);
		tableEditRender(0);
	}

	//点击排班出现操作栏
	function makeArrange() {
		whole_gradeTable.setAttribute("lay-filter","gradeTable");
		whole_savaOrderOrStop.removeAttribute("style");
		whole_makeOrderOrOut.style.display = "none";
		getArrangeInfos(1);
		tableEditRender(0);
		ChangeTableHeight();
	}

	// 保存排班
	function saveArrange() {
		whole_gradeTable.removeAttribute("lay-filter");
		whole_makeOrderOrOut.removeAttribute("style");
		whole_savaOrderOrStop.style.display = "none";
		// delArrangeInfoByIds(whole_arrangeInfoIdList);
		getArrangeInfos(0);
		tableEditRender(1);
		ChangeTableHeight();
	}

	// 取消排班
	function stopArrange() {
		whole_gradeTable.removeAttribute("lay-filter");
		whole_makeOrderOrOut.removeAttribute("style");
		whole_savaOrderOrStop.style.display = "none";
		getArrangeInfos(0);
		tableEditRender(0);
		ChangeTableHeight();
	}
	
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
	
	// 删除排班数据
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
	
	// 保存排班数据
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
	
	//
	
	function AfterInitial() {		
		SelectorItem= new stationSelectorItem();		
	}

	var whole_treeResultId="";
	function showTreemMean(obj) {
		SelectorItem.Initial(false,"tree",whole_topStationId,0,whole_topStationId);
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
	
	// 单位列表框
	function showStaffMess(tdObj,col,id,grade,type){
		$('#selectStaionName').val(whole_topStationName); 
		createStaffOption(whole_topStationId);
		tdObj.attr("id",whole_tdId);
		var offset = tdObj.offset();
		var leftv = offset.left;
		var topv = offset.top;
		var oh = tdObj.innerHeight();
		var ow = 0;
		if(col == 8){
			ow = 350 - tdObj.innerWidth();
		}
		$('#staffDiv').css({
			left : leftv - ow + "px",
			top : topv + oh + "px"
		}).slideDown("fast");
		document.getElementById("ensure").setAttribute("onclick","addStaffMess(\""+whole_tdId+"\","+id+",\""+grade+"\",\""+type+"\")");
		$("body").bind("mousedown", onBodyMouseDown);
	}
	
	// 控制单位列表框的隐藏
	function onBodyMouseDown(event,object) {
		var obj;
		if(event!=null&&event!=""){
			obj = event.target;
		}else{
			obj = object;
		}
		if(obj.id=="carOptionDiv"){
			return;
		}
		else if(obj.id=="staffDiv"){
			return;
		}else if(obj.id=="divTree"){
			return;
		}else if(obj.className=="layui-layout-body"){
			$('#staffDiv').fadeOut("fast");
			$('#carOptionDiv').fadeOut("fast");
			document.getElementById("ensure").removeAttribute("onclick");
			document.getElementById(whole_tdId).removeAttribute("id");
			$("body").unbind("mousedown", onBodyMouseDown);
			return;
		}
		onBodyMouseDown("",obj.parentNode);
	}

	function changeStation(treeNode) {
		createStaffOption(treeNode.id);
		var selectv = document.getElementById(whole_treeResultId);
		selectv.value = treeNode.name;
		whole_stationId = treeNode.id
	}
	
	// 创建警员option
	function createStaffOption(stationId) {
		PostData("staff/staff/filter", createRequest(0, 1000, "id","stationId,string,=,"+stationId+""),function(result) {
			var data = result.data;
			$("#staffMess").empty();
			var html = "";
			for(var i=0;i<data.length;i++){
				html += "<option value='"+data[i].name+","+data[i].telephone+"'>"+data[i].name+"</option>";
			}
			$("#staffMess").append(html);
			formSelects.render();
		})
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
	
	// 点击确定添加到td
	function addStaffMess(whole_tdId,id,grade,type) {
		var selectVal = formSelects.value('selectStaff');
		var tdObj = document.getElementById(whole_tdId);
		whole_arrangeInfoJson = "";
		var tdContent = tdObj.innerText;
		whole_arrangeInfoJson +='{"id":"'+ id +'","grade":"'+ grade +'","'+type+'":"';
		if(tdObj.innerText!=""||tdObj.innerText!=null){
			tdContentList = tdContent.split(";x\n");
			for(var i=0;i<tdContentList.length-1;i++){
				whole_arrangeInfoJson += '<div style=\'width: 100%;background-color: #92B4F4;margin-bottom: 5px;\'>' + tdContentList[i] + ';<span style=\'display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;\' onclick=\'delStaff(this)\'>x</span></div>';
			}
		}
		var selectVal = formSelects.value('selectStaff');
		for(var i=0;i<selectVal.length;i++){
			if(whole_arrangeInfoJson.indexOf(selectVal[i].value)==-1){
				whole_arrangeInfoJson += '<div style=\'width: 100%;background-color: #92B4F4;margin-bottom: 5px;\'>' + selectVal[i].value + ';<span style=\'display: inline-block; color:white;float: right;margin-right: 5px;cursor: pointer;\' onclick=\'delStaff(this)\'>x</span></div>';
			}
		}
		whole_arrangeInfoJson +='"},';
		tableEditRender(0);
		$('#staffDiv').fadeOut("fast");
		document.getElementById("ensure").removeAttribute("onclick");
		tdObj.removeAttribute("id");
		whole_tdId = "";
		formSelects.render("selectStaff");
		$("body").unbind("mousedown", onBodyMouseDown);
	}
	

	
	// 编辑删除人员
	function delStaff(obj) {
		var tdObj = $(obj).parent().parent().parent();
		$(obj).parent().parent().remove();
		cancelBubble();
	}
	
	// 获取一周的日期
	function getWeekByDay() {
		var date = new Date(whole_searchTime.value.replaceAll("-","/"));
		date1 = date.Format("yyyy-MM-dd");
		var date2=new Date(date.getFullYear(), 0, 1);  
	    var day1=date.getDay();  
	    if(day1==0) day1=7;  
	    else day1=7-day1;
	    x = Math.round((date.getTime() - date2.getTime()+(day1)*(24*60*60*1000)) / 86400000);    
	    week = Math.ceil(x /7);
	    
		var d = getWeekDate(date);
		var arr = [];
		for (var i = 0; i < 7; i++) {
			arr.push(new Date(d.getFullYear() + '-' + (d.getMonth() + 1) + '-'
					+ (d.getDate())).Format("yyyy-MM-dd"));
			d.setDate(d.getDate() + 1);
			whole_fieldByDayMap.set(arr[i],whole_fieldList[i]);
			whole_dayByFieldMap.set(whole_fieldList[i],arr[i]);
		}
		return arr;
	}
	
	function getWeekDate(obj) {
		day = obj.getDay(), date = obj.getDate();
		if (day == 0){
			return obj;
		}else{
			obj.setDate(date - day);
		}
		return obj;
	}
	
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
	} ;
</script>
</html>
