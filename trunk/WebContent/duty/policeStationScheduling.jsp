<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>派出所排班</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/policeStationScheduling.css">
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

.table-head{padding-right:17px;background-color:#999;color:#000;}
.table-body{width:100%; height:450px;overflow-y:scroll;overflow-x:hidden;}
.table-head table,.table-body table{width:100%;}
#table-top1{
	margin-bottom:10px;
}
#table-top2{
	margin-bottom:10px;
}

.layui-table thead a{
	color: white;
	cursor: pointer;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<jsp:include page="../shared/policeStationSchedulingMenu.jsp" flush="true">
		<jsp:param name="multi" value="0"/>
		</jsp:include>
		<div class="" id="width_right" style="float:right;margin-top: 10px;">
			<!-- 内容主体区域 -->
			<div>
				<div class="layui-row layui-col-space1">
					<div id="mianBody">
						<input id="stationName" class="layui-input" style="display: none;" />
						<input id="id" class="layui-input" style="display: none;" />
						<div class="layui-fluid"
							style="height: 22px; padding-top: 10px; padding-bottom: 5px; background-color: #92b4f4">
							<div class="layui-col-md1" style="top: 1%;">排班登记</div>
						</div>
						<div class="div_table">
							<form class="layui-form" action="" method="post">
								<div style="margin-bottom: 10px;">
									<div class="layui-form">
										<div class="layui-form-item">
											<div class="layui-inline" id="selectTime" style="float: left;">
												<label class="layui-form-label" style="width: 50px">日期</label>
												<div class="layui-input-inline" style="min-width: 212px;">
													<input id="d121" class="layui-input" type="text"
														onfocus="WdatePicker({isShowWeek:true,onpicked:funccc,errDealMode:3})" />
													<input id="d122" class="layui-input" style="display: none;" />
													<input id="d123" class="layui-input" style="display: none;" />
												</div>
											</div>
											<div class="layui-inline" style="float: left;">
												<label class="layui-form-label" style="width: 50px">时段</label>
												<div class="layui-input-inline" style="min-width: 212px;">
													<input type="text" class="layui-input" id="test9"
														placeholder=" - ">
												</div>
											</div>
											<div class="layui-inline" style="float: left;">
												<div class="layui-input-inline" style="width: 100px;">
													<button class="layui-btn layui-btn-primary layui-btn-lg"
														type="button" lay-submit="find" lay-filter="find">查询</button>
												</div>
											</div>
											<div class="layui-inline" id="selectMan" style="float: left;">
												<div id="selectMan1" style="display:block;">
													<label class="layui-form-label" style="width: 50px">警员</label>
													<div class="layui-input-inline"
														style="min-width: 300px;">
														<select name="category1" id="category1" lay-filter="category1"
															aria-invalid="false" multiple lay-search lay-case>
														</select>
													</div>
												</div>
												<div id="selectMan2" style="display:none;">
													<label class="layui-form-label" style="width: 50px">警员</label>
													<div class="layui-input-inline"
														style="min-width: 300px;">
														<select name="category2" id="category2" lay-filter="category2"
															aria-invalid="false" multiple lay-search lay-case>
														</select>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
							<div class="layui-form">
								<div class="layui-form-item" style="text-align: center;">
									<div class="layui-inline" id="selectTime">
										<div class="grid-demo grid-demo-bg1"
											style="font-size: 20px; cursor: pointer;" id="titleName"></div>
									</div>
								</div>
							</div>
							<div class="layui-form-item" style="width: 100%;">
								<div class="layui-inline" style="float: left;">
									<div class="layui-inline" style="display: none;" id="dayOrWeek">
										<div style="display: none;" id="week">
											<button class="layui-btn layui-btn-primary layui-btn-sm"
													onclick="_turn('week')">切换至周表</button>
										</div>
										<div style="display: block;" id="day">
											<button class="layui-btn layui-btn-primary layui-btn-sm"
													onclick="_turn('day')">切换至日表</button>
										</div>
									</div>
								</div>
								<div class="layui-inline" style="float: left;">
									<div class="layui-btn-group demoTable">
										<button class="layui-btn layui-btn-primary layui-btn-sm" lay-submit lay-filter="exportExcel">导出</button>
									</div>
								</div>
								<div class="layui-inline" id="tableTop2" style="float: right;width: 25%;margin-left: 10px;">
									<table class="layui-table" id="table-top11"></table>
									<table class="layui-table" id="table-top22" style="display: none;" ></table>
								</div>
								<div class="layui-inline" id="tableTop1" style="float: right;width: calc(65% - 130px);">	
									<table class="layui-table" id="table-top1"></table>	
									<table class="layui-table" id="table-top2" style="display: none;" ></table>
								</div>
							</div>
							<div id="table1"></div>
							<div id="table2" style="display: none;"></div>								
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>


<script src="../My97DatePicker/WdatePicker.js"></script>
<script>
	layui.use(['layer', 'form', 'laydate', 'code' ],function() {
		var form = layui.form, $ = layui.$;
		var laydate = layui.laydate;
		var layer = layui.layer;
		//时间范围
		laydate.render({
			elem : '#test9',
			type : 'time',
			range : true
		});
		laydate.render({
			elem : '#test12',
			format : 'yyyy-MM-dd'
		});
		// 代码块
		layui.code({
			title : 'html',
			encode : true,
			about : false
		});
		var category = 0;
        var categoryName = '';
        form.on('select(category1)', function (data) {
            category = data.value;
            var tab = document.getElementById("tableBody1").getElementsByClassName("layui-table");
            for(var m=0;m<tab.length;m++){
            	var a = tab[m].getElementsByTagName("a");
                for(var k=0;k<a.length;k++){
                	if(a[k].childElementCount>=1){
                		a[k].firstChild.style.backgroundColor="transparent";
                	}
                }
            }
            if(category.length!=0){
                for(var j=0;j<category.length;j++){
                	categoryName = category[j];
                	for(var m=0;m<tab.length;m++){
                    	var a = tab[m].getElementsByTagName("a");
                        for(var k=0;k<a.length;k++){
                        	if(a[k].text==categoryName){
                        		a[k].firstChild.style.backgroundColor="white";
                        	}	
                        }
                    }
                }
            }
			return false;
        });	
        
        form.on('select(category2)', function (data) {
            category = data.value;
            var tab = document.getElementById("tableBody2").getElementsByClassName("layui-table");
            for(var m=0;m<tab.length;m++){
            	var a = tab[m].getElementsByTagName("a");
                for(var k=0;k<a.length;k++){
                	if(a[k].childElementCount>=1){
                		a[k].firstChild.style.backgroundColor="transparent";
                	}
                }
            }
            if(category.length!=0){
                for(var j=0;j<category.length;j++){
                	categoryName = category[j];
                	for(var m=0;m<tab.length;m++){
                    	var a = tab[m].getElementsByTagName("a");
                        for(var k=0;k<a.length;k++){
                        	if(a[k].text==categoryName){
                        		a[k].firstChild.style.backgroundColor="white";
                        	}	
                        }
                    }
                }
            }
			return false;
        });	
        form.on('select(stationSearch)', function (data) {
        	var select = data.value;
        	stationSelector.openNode(select);
        	return false;
        });
		form.on('submit(find)', function (data) {
			SelectStation(null);
			return false;
        });	
		form.on('submit(exportExcel)', function (data) {
			if(type==0){
				exportExcel('table1');
			}else{
				exportExcel('table2');
			}
			
			return false;
        });	
		window.selectRender = function(){
			form.render();	
			ChangeTableHeight();
		};
	});
	//调整内容表格的最大高度
	function ChangeTableHeight(){
		var h= document.documentElement.clientHeight || document.body.clientHeight;	
		var tb=document.getElementsByClassName("table-body");
		if(tb!=null){	
			for(var i=0;i<tb.length;i++){				
				if(tb[i].offsetTop!=0 && h!=(tb[i].offsetHeight+tb[i].offsetTop+30)){
					var offset=h-tb[i].offsetTop-30;
					if(offset>0){
						tb[i].style.height=offset+'px';						
					}		
				}	
			}
		}
	}
</script>
<script>
	var id;//单位id
	var stationN;//单位名称
	var type=0;// 周的标识
	var arr;//一周的日期
	var type1=0;
	var shiftTypeId = -1;
	var arr_isShow = -1;

	//一进来就根据用户信息加载表格信息
	$(function (){
		var station = new Object();
	    var result = sessionStorage.getItem("result");
	    var dataObj;
		if(result != null){
			dataObj =eval("("+result+")");
		};
		stationN = dataObj.stationName;
		id = dataObj.stationId;
		arr = funccc();
		var fromDt = arr[0] + " 00:00:00";
		var toDt = arr[6] + " 23:59:59";
		getStationName(stationN);
		GetArrangeReport( fromDt, toDt, id);
		
	}); 
	
	// 点击树节点加载
	function SelectStation(obj) {
		if(obj!=null&&obj!=""){
			document.getElementById("id").value=obj.id;
			document.getElementById("stationName").value=obj.name;
			id=obj.id;
			stationN=obj.name;
		}
		arr = funccc();
		var fromDt = arr[0] + " 00:00:00";
		var toDt = arr[6] + " 23:59:59";
		getStationName(stationN);
		GetArrangeReport( fromDt, toDt, id);
	}
	
	//根据单位名称判断警员搜索隐藏和显示
	function getStationName(obj) {
		var timeSpan=document.getElementById("test9").value;
		var day=document.getElementById("d122").value;
		$("#titleName").empty();
		var html = "厦门公安局";
		if(stationN=="厦门公安局"){
			html += "";
		}else if(stationN=="分局"){
			html += "各分局";
		}else{
			html += stationN;
		}
		html += "勤务安排表";
		if(type==0){
			html += "("+arr[0]+"至"+arr[6]+")<div>"+timeSpan+"</div>"
		}else if(type==1){
			html += "("+day+")<div>"+timeSpan+"</div>"
		}
		$("#titleName").append(html);
		var selectMan = document.getElementById("selectMan");
		if(obj=="厦门公安局"||obj=="分局"){
			selectMan.style.display="none";
		}else{
			selectMan.style.display="block";
		}
	}
	
	// 根据单位id和时间段获取警员数据
	function GetArrangeReport( fromDt, toDt, stationId){
		var request=new Object();
		var request1=new Object();
		var request2=new Object();
		var request3=new Object();
		var request4=new Object();	
		var oneDay = document.getElementById("d122").value;
		var timeSpan = document.getElementById("test9").value;
		var fromTime;
		var toTime;
		if(timeSpan!=null&timeSpan!=""){
			fromTime = timeSpan.split(" - ")[0];
			toTime = timeSpan.split(" - ")[1];
		}
		$("#table-top1").empty();
		$("#table-top11").empty();
		$("#table-top2").empty();
		$("#table-top22").empty();
		$("#table1").empty();
		$("#table2").empty();
		$("#category1").empty();
		$("#category2").empty();
		
		var html1 = "";
		var html2 = "";
		var html3 = "";
		var html4 = "";
		var html5 = "";
		var html6 = "";	
		var html7 = "";
		var html8 = "";

		request.fromDt=fromDt;
		request.toDt=toDt;
		request.stationId=stationId;
		
		request4.fromDt=oneDay + " 00:00:00";
		request4.toDt=oneDay + " 23:59:59";
		request4.stationId=stationId;
		
		request2.fromDt=fromDt;
		request2.toDt=toDt;
		request2.stationId=stationId;
		
		request3.fromDt=oneDay + " 00:00:00";
		request3.toDt=oneDay + " 23:59:59";
		request3.stationId=stationId;

		request1.fromDt=oneDay + " 00:00:00";
		request1.toDt=oneDay + " 23:59:59";
		request1.stationId=stationId;
		if(shiftTypeId!=-1){
			request.shiftTypeIdPath=shiftTypeId;
			request1.shiftTypeIdPath=shiftTypeId;
			request2.shiftTypeIdPath=shiftTypeId;
			request3.shiftTypeIdPath=shiftTypeId;
			request4.shiftTypeIdPath=shiftTypeId;
		}
		
		if(arr_isShow!=-1){
			request.isShow=arr_isShow;
			request1.isShow=arr_isShow;
			request2.isShow=arr_isShow;
			request3.isShow=arr_isShow;
			request4.isShow=arr_isShow;
		}
		
		if(fromTime!=null&&fromTime!=""){
			request.fromTime=fromTime;
			request1.fromTime=fromTime;
			request2.fromTime=fromTime;
			request3.fromTime=fromTime;
			request4.fromTime=fromTime;
		}
		if(toTime!=null&&toTime!=""){
			request.toTime=toTime;
			request1.toTime=toTime;
			request2.toTime=toTime;
			request3.toTime=toTime;
			request4.toTime=toTime;
		}
		type1=0;
		if(type==0&&type1==0){
			document.getElementById("selectMan1").style.display="block";
		}
		if(type==0){
			PostData("duty/arrange/stationShiftTypeCount",request2,function(result){
				var typeNum = result.data;
				if(typeNum.length==0){
					return;
				}
				document.getElementById("dayOrWeek").style.display="block";
				html4 += "<tr>";
				for(var i=0;i<typeNum.length;i++){
					if(typeNum[i].type=="警员"){
						html4 += "<td>"+typeNum[i].stationName+"("+typeNum[i].count+")</td>";					
					}
				}
				html4 += "</tr>";
				$("#table-top1").append(html4);
				html7 += "<tr>";
				for(var i=0;i<typeNum.length;i++){
					if(typeNum[i].type=="班别"){
						html7 += "<td><a onclick='searchShiftState(\""+typeNum[i].stationName+"\")'>"+typeNum[i].stationName+"("+typeNum[i].count+")</a></td>";										
					}
				}
				html7 += "</tr>";
				$("#table-top11").append(html7);
			});
		}else if(type==1){
			PostData("duty/arrange/stationShiftTypeCount",request3,function(result){
				var typeNum = result.data;
				if(typeNum.length==0){
					return;
				}
				document.getElementById("dayOrWeek").style.display="block";
				html5 += "<tr>";
				for(var i=0;i<typeNum.length;i++){
					if(typeNum[i].type=="警员"){
						html5 += "<td>"+typeNum[i].stationName+"("+typeNum[i].count+")</td>";					
					}
					
				}
				html5 += "</tr>";
				$("#table-top2").append(html5);
				html8 += "<tr>";
				for(var i=0;i<typeNum.length;i++){
					if(typeNum[i].type=="班别"){
						html8 += "<td><a onclick='searchShiftState(\""+typeNum[i].stationName+"\")'>"+typeNum[i].stationName+"("+typeNum[i].count+")</a></td>";							
					}
					
				}
				html8 += "</tr>";
				$("#table-top22").append(html8);
			});
		}
		if(stationN!="厦门公安局"&&stationN!="分局"){
			if((stationN.split("分局").length==2&&(stationN.split("分局")[1]==null||stationN.split("分局")[1]==""))||stationN=="支队"){
				type1=1;
				document.getElementById("selectMan1").style.display="none";
				if(type==0){
					PostData("duty/arrange/stationStaffCount",request,function(result){	
						var typeNum = result.data.length;
						if(typeNum==0){
							return;
						}
						// alert(result.data.length);
						// 画周表
						html1 += CreateTableByStation1(result.data,getTitleItem(result.data));
						$("#table1").append(html1);
						selectRender();
					});
				}else if(type==1){
					PostData("duty/arrange/stationStaff",request4,function(result){
						var typeNum = result.data.length;
						if(typeNum==0){
							return;
						}
						// 画日表
						html2 += CreateTableByStation2(result.data,getTitleItem(result.data));
						$("#table2").append(html2);
						// 画警员搜索
						html6 += selectMan(result.data);
						$("#category2").append(html6);
						selectRender();				
					});
				}
			}else{
				if(type==0){
					PostData("duty/arrange/stationStaff",request,function(result){
						var typeNum = result.data.length;
						if(typeNum==0){
							return;
						}
						document.getElementById("dayOrWeek").style.display="block";	
						// alert(result.data.length);
						// 画周表
						html1 += CreateTable1(getTitleItem(result.data),result.data);
						$("#table1").append(html1);
						var tbody=document.getElementById("table1_tbody");
						var maxRows=getMaxRows(result.data);
						for(var i=0;i<maxRows-1;i++){
							autoRowSpan(tbody,0,i+1);
						}
						// 画警员搜索
						html3 += selectMan(result.data);
						$("#category1").append(html3);
						selectRender();
					});
				}else if(type==1){
					PostData("duty/arrange/stationStaff",request4,function(result){
						var typeNum = result.data.length;
						if(typeNum==0){
							return;
						}
						document.getElementById("dayOrWeek").style.display="block";
						// 画日表
						html2 += CreateTable2(result.data,getTitleItem(result.data));
						$("#table2").append(html2);
						// 画警员搜索
						html6 += selectMan(result.data);
						$("#category2").append(html6);
						selectRender();
					});
				}
			}
		}else{
			if(type==0){
				PostData("duty/arrange/stationStaffCount",request,function(result){	
					var typeNum = result.data.length;
					if(typeNum==0){
						return;
					}
					document.getElementById("dayOrWeek").style.display="block";
					// alert(result.data.length);
					// 画周表
					html1 += CreateTableByStation1(result.data,getTitleItem(result.data));
					$("#table1").append(html1);
					selectRender();
				});
			}else if(type==1){
				PostData("duty/arrange/stationStaffCount",request1,function(result){
					var typeNum = result.data.length;
					if(typeNum==0){
						return;
					}
					document.getElementById("dayOrWeek").style.display="block";	
					// alert(result.data.length);
					// 画日表
					html2 += CreateTableByStation1(result.data,getTitleItem(result.data));
					$("#table2").append(html2);
					selectRender();
				});
			}
		}
		shiftTypeId = -1;
		arr_isShow = -1;		
	}
	
	function getMaxRows(data){
		var itemList=new Array();
	    var maxRows=1;	    
		for(var i=0;i<data.length;i++){			
			if(data[i].namePath.split(",").length>maxRows){
				maxRows=data[i].namePath.split(",").length;
			}
		}
		return maxRows;
	}
	function getTitleItem(data){
		var length=data.length;
		var itemList=new Array();
		var itemIdList=new Array();
		var itemRowslist=new Array();
	    var maxRows=1;
	    var sortList=new Array();
		var sortIdList=new Array();
		var itemMapIdlist=new Array();//用于去重
		
		for(var i=0;i<data.length;i++){
			if(!isInArray(itemList,data[i].namePath)){					
				itemList.push(data[i].namePath);
				itemIdList.push(data[i].idPath);
				if(data[i].namePath.split(",").length>maxRows){
					maxRows=data[i].namePath.split(",").length;
				}
			}
		}
		//排序并分组标记组个数，以及组内最大长度
		var selectedIdList=new Array();
		var flagList =new Array();
		var m=0;
		for(var i=0; i<itemIdList.length; i++){
			if(!isInArray(selectedIdList,i)){
				var length=itemIdList[i].split(",").length;
				selectedIdList.push(i);				
				sortIdList.push(itemIdList[i]);
				sortList.push(itemList[i]);
				var tempItem=itemIdList[i];				
				var cnt=1;
				var maxLen=length;
				for(var j=0; j<itemIdList.length; j++){
					if(!isInArray(selectedIdList,j)){							
						var paraItemId =itemIdList[j].split(",")[0];						
						if(paraItemId==tempItem.split(",")[0]){//判断第一个ID是否一样
							sortIdList.push(itemIdList[j]);
							sortList.push(itemList[j]);							
							selectedIdList.push(j);							
							cnt++;
							if(itemIdList[j].split(",").length>maxLen){
								maxLen=itemIdList[j].split(",").length;
							}
						}						
					}
				}//统计数量
				flagList[m] = itemIdList[i] + ";" + cnt + ";" + maxLen;
				m++;
			}
		}
		var i=0;
		for(var n=0; n<flagList.length; n++){
			var flagitem = flagList[n].split(";");
			var cnt = Number(flagitem[1]);
			var maxLen = Number(flagitem[2]);
			var sumCnt = i+cnt;
			for(;i<sumCnt; i++){
				var sortItem=sortList[i];
				var sortIdItem=sortIdList[i];
				var item =sortItem.split(",");
				var itemId=sortIdItem.split(",");
				var itemLast=item[item.length-1];
				var itemIdLast=itemId[itemId.length-2];//默认一个班别id一个逗号
				if(itemId.length<maxLen){//追加idpath需要合并的类
					for(var m=0; m<maxLen-itemId.length; m++){
						sortItem += ","+itemLast;
						sortIdItem += itemIdLast+",";
					}
					item =sortItem.split(",");
					itemId=sortIdItem.split(",");
				}				
				for(var j=0;j<item.length;j++){
					if(itemRowslist[j]==null){					
						itemRowslist[j]=new Array();
						itemMapIdlist[j]=new Map();
					}
					var row=1;
					if(item.length==1){
						row=maxRows;
					}
					else if(item.length>1 && j==0){
						row=maxRows-item.length+1;
					}
					var idPath="";
					if(item.length == 1){
						idPath=sortIdItem;
					}
					else{
						for(var k=0;k<=j;k++){
							idPath += (itemId[k] + ",");
						}
					}
					var key=item[j]+','+row;
					var value="";
					var keyId=idPath+','+row;					
					if(itemMapIdlist[j].has(keyId)){
						var cow = 1 + Number(itemMapIdlist[j].get(keyId).split(";")[0]);
						value=cow +";"+idPath;
						itemRowslist[j].remove(key + ";" + itemMapIdlist[j].get(keyId));
						itemRowslist[j].push(key+";"+value);
						itemMapIdlist[j].set(keyId,value);
					}
					else{
						value=1+";"+idPath;						
						itemMapIdlist[j].set(keyId,value);
						itemRowslist[j].push(key+";"+value);
					}
				}				
			}
		}
		return itemRowslist;
	}
	
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
	
	function getShiftId(data){
		var itemMap=new Map();
		for(var i=0;i<data.length;i++){
			var key=data[i].shiftName;					
			if(!itemMap.has(key)){
				itemMap.set(key,data[i].idPath);
			}
		}
		return itemMap;
	}
	
	function getBodyItem(itemRowslist){
		var length=itemRowslist.length;
		var lastShiftType=new Array();
		var lastpos=0;
		if(itemRowslist.length>=2){
			for(var i=0;i<itemRowslist[0].length;i++){
				 var item=itemRowslist[0][i].split(";");
				 var cols=item[1];
				 var idPath=item[2];
				 var rows=item[0].split(",")[1];
				 if(cols==1&&rows==length){
					 lastShiftType.push(idPath);	
				 }
				 else{
					 for(var j=0;j<itemRowslist[length-1].length;j++){
						 var itemlast=itemRowslist[length-1][j].split(";");						
						 var idPathlast=itemlast[2];						 
						 if(idPathlast.split(",")[0]==idPath.split(",")[0]){//判断最后一行的第一个版本ID是否和第一行的一样
							 lastShiftType.push(idPathlast);
						 }
					 }
				 }
			}
		}else if(itemRowslist.length==1){
			for(var i=0;i<itemRowslist[0].length;i++){
				lastShiftType.push(itemRowslist[0][i].split(";")[2]);			
			}
		}
		return lastShiftType;
	}
	
	function getShiftType(data,date,time){
		var mapitem=new Map();//把DATA按照警察局+班别序号分类
		var stationNamelist=new Array();
		for(var i=0;i<data.length;i++){
			if(data[i].workDt==date){	
				var time1 = (data[i].fromTime.split(" ")[1].replace(".0","")+" - "+data[i].toTime.split(" ")[1].replace(".0",""));
				if(time==null||time==""||time==time1){
					var key=data[i].stationName + "," + data[i].shiftName;			
					if(mapitem.has(key)){
						mapitem.set(key,mapitem.get(key) + "," + i);
					}
					else{
						mapitem.set(key,i);
					}
				}
			}
		}
		return mapitem;
	}
	//获取表内容单元格中排版数据
	function getShiftTypeAndDate(data){
		var mapitem=new Map();//把DATA按照班别+日期分类
		for(var i=0;i<data.length;i++){
			var dateFrom;
			if(data[i].fromTime!=""&&data[i].fromTime!=null){
				dateFrom = data[i].fromTime.substr(0,10);
			}
			var dateTo;
			if(data[i].toTime!=""&&data[i].toTime!=null){
				dateTo = data[i].toTime.substr(0,10);
			}
			if(dateFrom!=dateTo){//跨日排班需要多加一天显示
				var key1=data[i].idPath + ";" + dateTo;
				if(mapitem.has(key1)){
					mapitem.set(key1,mapitem.get(key1) + "," + i);
				}
				else{
					mapitem.set(key1,i);
				}
			}
			var key=data[i].idPath + ";" + dateFrom;				
			if(mapitem.has(key)){
				mapitem.set(key,mapitem.get(key) + "," + i);
			}
			else{
				mapitem.set(key,i);
			}
		}
		return mapitem;
	}
	
	// 单位、班别做key，数目做value
	function getShiftTypeByStation(data){
		var mapitem=new Map();
		for(var i=0;i<data.length;i++){
			var key=data[i].stationName + ";" + data[i].idPath;				
			if(!mapitem.has(key)){
				mapitem.set(key,data[i].count);
			}
		}
		return mapitem;
	}
	
	// 单位、班别做key，staffId做value
	function getShiftTypeByStation2(data){
		var mapitem=new Map();
		for(var i=0;i<data.length;i++){
			var key=data[i].stationName + ";" + data[i].idPath;				
			if(mapitem.has(key)){
				mapitem.set(key,mapitem.get(key)+","+i);
			}else{
				mapitem.set(key,i);
			}
		}
		return mapitem;
	}
	
	function getTimeShiftType(data,date){
		var mapitem=new Map();//把DATA按照警察局+班别序号分类
		for(var i=0;i<data.length;i++){
			var fromTime;
			if(data[i].fromTime!=null&&data[i].fromTime!=""){
				fromTime=data[i].fromTime.split(" ")[1].replace(".0","");
			}
			var toTime;
			if(data[i].toTime!=null&&data[i].toTime!=""){
				toTime=data[i].toTime.split(" ")[1].replace(".0","");
			}
			if(data[i].fromTime<date){
				fromTime="00:00:00";
			}
			else if(data[i].toTime>date+" 23:59:59"){
				toTime="23:59:59";
			}
			var timeft = fromTime + " - " + toTime;	
			
			var time = timeft.substr(0,5)+timeft.substr(8,8);			
			var key=time + ";" + data[i].idPath;			
			if(mapitem.has(key)){
				mapitem.set(key,mapitem.get(key) + "," + i);
			}
			else{
				mapitem.set(key,i);
			}
		}
		return mapitem;
	}
	
	//获取时间段
	function getTimes(data,date){
		var timelist=new Array();
		for(var i=0;i<data.length;i++){
			var fromTime;
			if(data[i].fromTime!=null&&data[i].fromTime!=""){
				fromTime=data[i].fromTime.split(" ")[1].replace(".0","");
			}
			var toTime;
			if(data[i].toTime!=null&&data[i].toTime!=""){
				toTime=data[i].toTime.split(" ")[1].replace(".0","");
			}
			if(data[i].fromTime<date){
				fromTime="00:00:00";
			}
			else if(data[i].toTime>date+" 23:59:59"){
				toTime="23:59:59";
			}
			var timeft = fromTime + " - " + toTime;	
			
			var timesub = timeft.substr(0,5)+timeft.substr(8,8);
			if(!isInArray(timelist,timesub)){
				timelist.push(timesub);
			}
		}
		return timelist;
	}
	
	function getStation(data) {
		var itemList = new Array();
		for(var i=0;i<data.length;i++){
			if(!isInArray(itemList,data[i].stationName)){					
				itemList.push(data[i].stationName);
			}
		}
		return itemList;
	}	
	
	// 获取单位对应的id
	function getStationId(data) {
		var itemList = new Map();
		for(var i=0;i<data.length;i++){
			var key=data[i].stationName;
			if(!itemList.has(key)){
				itemList.set(key,data[i].stationId);
			}
		}
		return itemList;
	}
	function changeTime(sDate,Time){
		var fromTime = sDate+" 00:00:00.0";
		var toTime = sDate+" 23:59:59.0";
		if(Time != null && Time !="")
		{
			var times =Time.split(" - ");
			fromTime = sDate+" "+times[0]+".0";
			toTime = sDate+" "+times[1]+".0";
			if(times[0]>=times[1]){
				toTime=sDate+" 23:59:59.0";
			}
		}
		return fromTime + "," + toTime;		
	}
	
	
	// 画日表
	function CreateTable2(data,itemRowslist){
		var time1 = document.getElementById("d122").value;//日期
		var time = document.getElementById("test9").value;//时间段
		var maptimeitem = getTimeShiftType(data,time1);
		var timeList = getTimes(data,time1);
		var lastShiftType = getBodyItem(itemRowslist);		
		var maxRow=itemRowslist.length;		
		var html = "<div class='table-head'><table class='layui-table'><thead>";
		
		for(var i=0;i<maxRow;i++){			
			var listItemTitle=itemRowslist[i];
			html += "<tr>";
			if(i==0){
				html += "<th rowspan='" + maxRow + "'>时间段</th>"
			}
			for(var k=0;k<listItemTitle.length;k++){
				 var item=listItemTitle[k].split(";");			
				 var shiftIdPath = item[2];
				 var cols = item[1];
				 var rows = item[0].split(",")[1];
				 var name = item[0].split(",")[0];	
				 var isChildShiftType=0;
				 html+="<th rowspan='" + rows + "' colspan='" + cols +"'><a onclick='showTypeShift(\""+shiftIdPath+"\")'>" + name + "</a>";
				 var num = 0;
				 if(i==maxRow-rows){
					if(shiftIdPath.split(",")[0]==shiftIdPath.split(",")[1]){
						shiftIdPath=shiftIdPath.split(",")[0]+",";
					}
					var sumPeople  = Enumerable.From(data).Where("x=>x.idPath=="+"'"+shiftIdPath+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;					 
					html += "<div><a onclick='messByNum("+id+",\""+shiftIdPath+"\","+isChildShiftType+")'>("+sumPeople+"人)</a></div>";
				 }else{
					var sumPeople = 0;
					for(var j=0;j<lastShiftType.length;j++){
						if(shiftIdPath==lastShiftType[j].split(",")[0]+","){
							var shiftIdPath1=lastShiftType[j];
							if(lastShiftType[j].split(",")[0]==(lastShiftType[j].split(",")[1])){
								shiftIdPath1=lastShiftType[j].split(",")[0]+",";
								isChildShiftType=1;
							}
						sumPeople += Enumerable.From(data).Where("x=>x.idPath=="+"'"+shiftIdPath1+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;	
						}
					}
					html += "<div><a onclick='messByNum("+id+",\""+shiftIdPath+"\","+isChildShiftType+")'>("+sumPeople+"人)</a></div>";
				 }
				 html+="</th>";
			}
			html+="</tr>";
		}			
		html += "</thead></table></div>";
		html += "<div class='table-body' id='tableBody2'><table class='layui-table'><tbody>";	
		for(var i=0;i<timeList.length;i++){
			html += "<tr>";
			var num = 0;
			var timeLs = timeList[i].split(" - ");
			var timeFrom = time1+" "+timeLs[0]+":00.0";
			var timeTo = time1+" "+timeLs[1]+":00.0";
			var sumPe=0;
			if(timeLs[0] =="00:00"){				
				sumPe = Enumerable.From(data).Where("x=>x.fromTime <="+"'"+timeFrom+"'"+" && x.toTime=="+"'"+timeTo+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;
			}else if (timeLs[1] =="23:59"){
				sumPe = Enumerable.From(data).Where("x=>x.fromTime =="+"'"+timeFrom+"'"+" && x.toTime>="+"'"+timeTo+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;
			}else{
				sumPe = Enumerable.From(data).Where("x=>x.fromTime=="+"'"+timeFrom+"'"+" && x.toTime=="+"'"+timeTo+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;
			}
			if(sumPe==0){
				break;
			}
			var chooseDay=document.getElementById("d122").value;
			html += "<td>"+timeList[i]+"<div><a style='cursor: pointer;' onclick='messByNum("+id+",\"\",\"\",\""+chooseDay+"\",\""+timeList[i]+"\")'>("+sumPe+"人)<div></td>";
			for(var j=0;j<lastShiftType.length;j++){
				html += "<td>";
				maptimeitem.forEach(function (value, key, map) {
					var temp= key.split(";");					 
					var timeft=temp[0];
					var shiftIdPath=temp[1];	
					var mess= (value+"").split(",");
					if(lastShiftType[j]==shiftIdPath&&timeList[i]==timeft){
						html += showShiftTimeStaff(data,mess,i,time1);
					}
					if(lastShiftType[j].split(",")[0]==lastShiftType[j].split(",")[1]&&(lastShiftType[j].split(",")[1]+",")==shiftIdPath&&timeList[i]==timeft){				
						html += showShiftTimeStaff(data,mess,i,time1);	
					}
				});
				html += "</td>";
			}
			html += "</tr>";
		}	
		html += "</tbody></table></div>";
		return html;
	}
	
	// 厦门公安局、分局显示数量表格
	function CreateTableByStation1(data,itemRowslist){
		//var shiftIdMap = getShiftId(data);
		var mapitem = getShiftTypeByStation(data);
		var itemList = getStation(data);
		var lastShiftType = getBodyItem(itemRowslist);
		var maxRow=itemRowslist.length;
		var html = "<div class='table-head'><table class='layui-table'><thead>";
		var stationMap = getStationId(data);
		for(var i=0;i<maxRow;i++){			
			var listItemTitle=itemRowslist[i];
			html += "<tr>";
			if(i==0){
				html += "<th rowspan='" + maxRow + "'>勤务单位</th>"
			}

			for(var j=0;j<listItemTitle.length;j++){
				 var item=listItemTitle[j].split(";");
				 var idPath = item[2];
				 var cols = item[1];
				 var rows = item[0].split(",")[1];
				 var name = item[0].split(",")[0];
				 if(idPath.split(",")[0]==idPath.split(",")[1]){
					 html+="<th rowspan='" + rows + "' colspan='" + cols +"'><a onclick='showTypeShift(\""+idPath.split(",")[0]+","+"\")'>" + name + "</a>";
				 }else{
					 html+="<th rowspan='" + rows + "' colspan='" + cols +"'><a onclick='showTypeShift(\""+idPath+"\")'>" + name + "</a>";
				 }
				 var num = 0;
				 var isChildShiftType=1;
				 if(i==maxRow-rows){
					mapitem.forEach(function (value, key, map) {
							var temp= key.split(";");					 
							var stationName=temp[0];
							var idPath2=temp[1];	
							var mess= value;
							if(idPath.split(",").length>2&&idPath.split(",")[0]==idPath.split(",")[1]&&idPath.split(",")[0]+","==idPath2){
								num += value;
							}
							if(idPath2==idPath){
								num += value;
							}
					});
					if(idPath.split(",")[0]==idPath.split(",")[1]){
						idPath=idPath.split(",")[0]+",";
						isChildShiftType=0;
					}
					html += "<div><a onclick='messByNum("+id+",\""+idPath+"\","+isChildShiftType+")'>("+num+"人)</a></div>";
				 }else{
					 mapitem.forEach(function (value, key, map) {
							var temp= key.split(";");					 
							var stationName=temp[0];
							var idPath2=temp[1];	
							var mess= value;
							if(idPath2.split(",")[0]==idPath.split(",")[0]){
								num += value;
							}
					});
					if(idPath.split(",")[0]==idPath.split(",")[1]){
						idPath=idPath.split(",")[0]+",";
						isChildShiftType=1;
					}
					html += "<div><a onclick='messByNum("+id+",\""+idPath+"\","+isChildShiftType+")'>("+num+"人)</a></div>";
				 }
				 html+="</th>";
			}
			html+="</tr>";
		}			
		html += "</thead></table></div>";
		html += "<div class='table-body'id='tableBody3'><table class='layui-table'><tbody>";
		for(var i=0;i<itemList.length;i++){
			html += "<tr>";
			var num = 0;
			var isChild=1;
			if(stationN==itemList[i]){
				isChild=0;
			}
			mapitem.forEach(function (value, key, map) {
				var temp= key.split(";");					 
				var stationName=temp[0];
				var idPath=temp[1];	
				var mess= value;
				if(stationName==itemList[i]){
					num += mess;
				}
			});
			html += "<td><a onclick='showStation("+stationMap.get(itemList[i])+")'>"+itemList[i]+"</a><div>(<a onclick='messByNum("+stationMap.get(itemList[i])+",\"\","+1+","+isChild+")'>"+num+"人</a>)<div></td>";
			for(var j=0;j<lastShiftType.length;j++){
				html += "<td>";
				mapitem.forEach(function (value, key, map) {
					var temp= key.split(";");					 
					var stationName=temp[0];
					var idPath=temp[1];	
					var mess= value;
					if((lastShiftType[j]==idPath&&itemList[i]==stationName)||(lastShiftType[j].split(",")[0]==lastShiftType[j].split(",")[1]&&lastShiftType[j].split(",")[0]+","==idPath&&itemList[i]==stationName)){
						var index = 0;
						index = mess;
						html += "<a onclick='messByNum("+stationMap.get(itemList[i])+",\""+idPath+"\","+1+","+isChild+")'>"+index+"</a>";	
					}
				});
				html += "</td>";
			}
			html += "</tr>";
		}	
		html += "</tbody></table></div>";
		return html;
	}
	
	// 分局显示人名单位日表
	function CreateTableByStation2(data,itemRowslist){
		var time1 = document.getElementById("d122").value;//日期
		var time = document.getElementById("test9").value;//时间段
		var maptimeitem = getShiftTypeByStation2(data);
		var itemList = getStation(data);
		var lastShiftType = getBodyItem(itemRowslist);	
		var stationMap = getStationId(data);	
		var maxRow=itemRowslist.length;		
		var html = "<div class='table-head'><table class='layui-table'><thead>";
		
		for(var i=0;i<maxRow;i++){			
			var listItemTitle=itemRowslist[i];
			html += "<tr>";
			if(i==0){
				html += "<th rowspan='" + maxRow + "'>勤务单位</th>"
			}
			for(var k=0;k<listItemTitle.length;k++){
				 var item=listItemTitle[k].split(";");			
				 var shiftIdPath = item[2];
				 var cols = item[1];
				 var rows = item[0].split(",")[1];
				 var name = item[0].split(",")[0];
				 if(shiftIdPath.split(",")[0]==shiftIdPath.split(",")[1]){
					 html+="<th rowspan='" + rows + "' colspan='" + cols +"'><a onclick='showTypeShift(\""+shiftIdPath.split(",")[0]+","+"\")'>" + name + "</a>";
				 }else{
					 html+="<th rowspan='" + rows + "' colspan='" + cols +"'><a onclick='showTypeShift(\""+shiftIdPath+"\")'>" + name + "</a>";
				 }
				 var num = 0;
				 var isChildShiftType=1;
				 if(i==maxRow-rows){
					if(shiftIdPath.split(",")[0]==shiftIdPath.split(",")[1]){
						shiftIdPath=shiftIdPath.split(",")[0]+",";
						 isChildShiftType=0;
					}
					var sumPeople  = Enumerable.From(data).Where("x=>x.idPath=="+"'"+shiftIdPath+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;					 
					html += "<div><a onclick='messByNum("+id+",\""+shiftIdPath+"\","+isChildShiftType+")'>("+sumPeople+"人)</a><div>";
				 }else{
					var sumPeople = 0;
					for(var j=0;j<lastShiftType.length;j++){
						if(shiftIdPath==lastShiftType[j].split(",")[0]+","){
							var shiftIdPath1=lastShiftType[j];
							if(lastShiftType[j].split(",")[0]==(lastShiftType[j].split(",")[1])){
								shiftIdPath1=lastShiftType[j].split(",")[0]+",";
							}
						sumPeople += Enumerable.From(data).Where("x=>x.idPath=="+"'"+shiftIdPath1+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;					 
						}
					}
					html += "<div><a onclick='messByNum("+id+",\""+shiftIdPath+"\","+isChildShiftType+")'>("+sumPeople+"人)</a><div>";
				 }
				 html+="</th>";
			}
			html+="</tr>";
		}			
		html += "</thead></table></div>";
		html += "<div class='table-body' id='tableBody2'><table class='layui-table'><tbody>";	
		for(var i=0;i<itemList.length;i++){
			html += "<tr>";
			var sumPe=0;
			var isChild=1;
			if(itemList[i]==stationN){
				isChild=0;
			}
			sumPe = Enumerable.From(data).Where("x=>x.stationId =="+"'"+stationMap.get(itemList[i])+"'&& x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;		
			html += "<td><a onclick='showStation("+stationMap.get(itemList[i])+")'>"+itemList[i]+"</a><a style='cursor: pointer;' onclick='messByNum("+stationMap.get(itemList[i])+",\"\","+1+","+isChild+")'><div>("+sumPe+"人)</div></td>";
			for(var j=0;j<lastShiftType.length;j++){
				html += "<td>";
				maptimeitem.forEach(function (value, key, map) {
					var temp= key.split(";");					 
					var stationName=temp[0];
					var shiftIdPath=temp[1];	
					var mess= (value+"").split(",");
					if(lastShiftType[j].split(",")[0]==lastShiftType[j].split(",")[1]){
						lastShiftType[j]=lastShiftType[j].split(",")[0]+",";
					}
					if(lastShiftType[j]==shiftIdPath&&itemList[i]==stationName){
						html += showShiftTimeStaff(data,mess,i,time1);
					}
				});
				html += "</td>";
			}
			html += "</tr>";
		}	
		html += "</tbody></table></div>";
		return html;
	}
	
	//现有排班namePath排序
	function getShiftypeRow(lastShiftType,data){			
		var itemList1=new Array();	
		var itemIdList1=new Array();	
		for(var i=0;i<data.length;i++){
			if(!isInArray(itemList1,data[i].namePath)){					
				itemList1.push(data[i].namePath);
				itemIdList1.push(data[i].idPath);
			}
		}
		var itemList=new Array();
		var itemIdList=new Array(); 
		for(var i=0;i<itemIdList1.length;i++){
			if(!isInArray(itemIdList,itemIdList1[i])){					
				itemList.push(itemList1[i]);
				itemIdList.push(itemIdList1[i]);
			}
			for(var j=0;j<itemIdList1.length;j++){
				if(i==j||itemIdList1[i].split(",")[0]!=itemIdList1[j].split(",")[0]){
					continue;
				}
				if(!isInArray(itemIdList,itemIdList1[j])){					
					itemList.push(itemList1[j]);
					itemIdList.push(itemIdList1[j]);
				}
			}
		}
		
		for(var i=0;i<itemIdList.length;i++){
			if(itemIdList[i].split(",").length>2){
				for(var j=0;j<itemIdList.length;j++){
					if(itemIdList[j].split(",").length==2&&itemIdList[i].split(",")[0]==itemIdList[j].split(",")[0]){
						itemList[j]=itemList[j].split(",")[0] + "," + itemList[j].split(",")[0]; 
						itemIdList[j]="" + itemIdList[j] + itemIdList[j]; 
					}
				}
			}
		}
		
		var rowList=new Array();
		for(var i=0;i<itemList.length;i++){
			var temp=itemList[i].split(",");			
			for(var j=0;j<lastShiftType.length;j++){
				if(itemIdList[i]==lastShiftType[j]){
					rowList.push(itemList[i]);
					break;
				}
			}
		}
		return rowList;			
	}
	
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
	
	// 画周表
	function CreateTable1(itemRowslist,data){		
		var time = document.getElementById("test9").value;//时间段
		var mapItem = getShiftTypeAndDate(data);
		var date1 = arr;
		var week = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
		var lastShiftType = getBodyItem(itemRowslist);
		var rowList = getShiftypeRow(lastShiftType,data);//排版顺序
		var maxRow=itemRowslist.length;
		//开始画表头
		var html = "<div class='table-head'><table class='layui-table'><thead><tr>";
		html += "<th><div>序号</div></th>";
		html += "<th colspan='"+maxRow+"'><div>班别</div></div></th>";
		for(var m=0;m<7;m++){//计算人数
			var timeft = changeTime(date1[m],time);			
			var timefts = timeft.split(",");
			var sumPeople  = Enumerable.From(data).Where("x=>x.fromTime<='"+timefts[1]+"' && x.toTime>='"+timefts[0]+"' && x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;			
			html += "<th><div>"+week[m]+"</div><div>("+date1[m]+")</div>";
			var shiftId = "";
			html += "<div><a onclick='messByNum("+id+",\""+shiftId+"\",1,1,\""+date1[m]+"\")'>("+sumPeople+"人)</a></div></th>";
		}
		html += "</tr></thead></table></div>";
		//开始画表内容
		html += "<div class='table-body' id='tableBody1'><table class='layui-table' id='table1_tbody'><tbody>";
		for(var i=0;i<rowList.length;i++){
			var rows = rowList[i].split(",");
			var idPath=lastShiftType[i];
			html += "<tr>";
			html += "<td colspan='1'>"+(i+1)+"</td>";
			var isChildShiftType=1;
			for(var j=0;j<rows.length;j++){
				if(j == 0){
					var indexsum = 0;	
					for(var k=0;k<lastShiftType.length;k++){
						if(idPath.split(",")[0]==lastShiftType[k].split(",")[0]){
							var idPath1=lastShiftType[k];
							if(lastShiftType[k].split(",")[0]==lastShiftType[k].split(",")[1]){
								idPath1=lastShiftType[k].split(",")[0]+",";
							}
							indexsum+=Enumerable.From(data).Where("x=>x.idPath=='"+idPath1+"' && x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;
						}
					}
					html+="<td colspan='" + (maxRow-rows.length+1) + "' rowspan='1'><a style='cursor: pointer;' onclick='showTypeShift(\""+idPath.split(",")[0]+","+"\")'>" + rows[j] + "</a><a style='cursor: pointer;' onclick='messByNum("+id+",\""+idPath.split(",")[0]+","+"\","+isChildShiftType+")'>("+indexsum+"人)</a></td>";
				}else{
					var idPath1=lastShiftType[i];
					if(lastShiftType[i].split(",")[0]==lastShiftType[i].split(",")[1]){
						idPath1=lastShiftType[i].split(",")[0]+",";
						isChildShiftType=0;
					}
					var indexsum = Enumerable.From(data).Where("x=>x.idPath=='"+idPath1+"' && x.staffId!=0").Distinct("x=>x.staffId").ToArray().length;				
					html+="<td colspan='1' rowspan='1'><a style='cursor: pointer;' onclick='showTypeShift(\""+idPath1+"\")'>" + rows[j] + "</a><div><a style='cursor: pointer;' onclick='messByNum("+id+",\""+idPath1+"\","+isChildShiftType+")'>("+indexsum+"人)</a></div></td>";
				}
			}
			for(var k=0;k<7;k++){
				html += "<td>";				
				mapItem.forEach(function (value, key, map) {
					var temp= key.split(";");
					var idPath=temp[0];
					var date2=temp[1];	
					var mess= (value+"").split(",");
					if(lastShiftType[i]==idPath&&date1[k]==date2){						
						html += showShiftTimeStaff(data,mess,i,date2);	
					}
					if(lastShiftType[i].split(",")[0]==lastShiftType[i].split(",")[1]&&(lastShiftType[i].split(",")[1]+",")==idPath&&date1[k]==date2){				
						html += showShiftTimeStaff(data,mess,i,date2);	
					}
				});
				html += "</td>";
			}
			html+="</tr>";	
		}			
		html += "</tbody></table></div>";
		return html;
	}
	
	// 控制周表日表隐藏显示
	function _turn(obj) {
		var week = document.getElementById("week");
		var day = document.getElementById("day");
		var table1 = document.getElementById("table1");
		var table2 = document.getElementById("table2");
		var tableTop1 = document.getElementById("table-top1");
		var tableTop11 = document.getElementById("table-top11");
		var tableTop2 = document.getElementById("table-top2");
		var tableTop22 = document.getElementById("table-top22");
		var category1 = document.getElementById("selectMan1");
		var category2 = document.getElementById("selectMan2");		
		if (obj == "week") {
			tableTop1.style.display = "block";
			tableTop11.style.display = "block";
			tableTop2.style.display = "none";
			tableTop22.style.display = "none";
			if(type1==0){
				category1.style.display = "block";
			}
			category2.style.display = "none";
			table1.removeAttribute("style");
			table2.style.display = "none";
			week.style.display = "none";
			day.style.display = "block";
			type=0;
			document.getElementById("d121").value = document.getElementById("d123").value;
		} else if (obj == "day") {
			tableTop2.style.display = "block";
			tableTop22.style.display = "block";
			tableTop1.style.display = "none";
			tableTop11.style.display = "none";
			category2.style.display = "block";
			category1.style.display = "none";
			table2.removeAttribute("style");
			table1.style.display = "none";
			week.style.display = "block";
			day.style.display = "none";
			type=1;
			document.getElementById("d121").value = document.getElementById("d122").value;
		}
		SelectStation(null);
	}
	
	// 画警员搜索
	function selectMan(data) {
		var manList=new Array();
		for(var i=0;i<data.length;i++){
			if(!isInArray(manList,data[i].staffName)){					
				manList.push(data[i].staffName);
			}
		}
		var html = "";
		html += "<option value=''>人物搜索</option>";
		for(var j=0;j<manList.length;j++){
			html += "<option>"+manList[j]+"</option>";		
		}		
		return html;
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
	
	function funccc() {
		var date = new Date();
		var dValue = document.getElementById("d121").value;
		if(dValue!=null&&dValue!=""){
			if(dValue.indexOf("至")!=-1){
				dValue = document.getElementById("d122").value;
			}
			date = new Date(dValue.replaceAll("-","/"));
		}
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
		}
		if(type==0){
			document.getElementById("d121").value = arr[0] + "至" + arr[6] + "("
			+ week + ")";
		}else if(type==1){
			document.getElementById("d121").value = date1;
		}
		document.getElementById("d122").value = date1;
		document.getElementById("d123").value = arr[0] + "至" + arr[6] + "("
				+ week + ")";
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
	
	// 根据警员id获取详细信息
	function details(obj){
		var request=new Object();
		PostData("sys/staff/get",obj,function(result){
			var mess = result.data;
			
			if(mess.position ==2) mess.nonLeaderPost = mess.leaderPost;
			if(typeof(mess.nonLeaderPost) == "undefined" ) mess.nonLeaderPost ="";
			var html = '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">姓名：'+mess.name+'<br>';
			html += '照片：';
			if(mess.pic!=null&&mess.pic!=""){
				html += '<img src="'+mess.pic+'" style="width:80px;height:100px;"><br>';
			}else{
				html += '<img src="../images/default_pic.png" style="width:80px;height:100px;"><br>';
			}
			html += '警号：'+mess.code+'<br>岗位：'+ mess.nonLeaderPost+'<br>电话：'+mess.telephone+'<br>';
			html += '班别：'+mess.shiftInfos+'<br>设备：'+mess.deviceInfos+'</div>';
		    //示范一个公告层
		    layer.open({
		       type: 1
		        ,title: false //不显示标题栏
		        ,closeBtn: false
		        ,area: '300px;'
		        ,shade: 0.8
		        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
		        ,btn: ['关闭']
		        ,btnAlign: 'c'
		        ,moveType: 1 //拖拽模式，0或者1
		        ,content: html
		        ,success: function(layero){
		          var btn = layero.find('.layui-layer-btn');
		          btn.find('.layui-layer-btn0').attr({
		          });
		        }
		    });
		});
	}
	
	// 根据单位id、工作时段、班别获取人员信息
	function messByNum(id,shiftId,isChildShiftType,isChild,dayTime,daySpan){
		var oneDay = document.getElementById("d122").value;
		var timeSpan = document.getElementById("test9").value;
		var fromDt = oneDay + " 00:00:00";
		var toDt = oneDay + " 23:59:59";
		var fromTime;
		var toTime;
		if(timeSpan!=null&&timeSpan!=""){
			fromTime = timeSpan.split(" - ")[0];
			toTime = timeSpan.split(" - ")[1];
		}
		if(daySpan!=null&&daySpan!=""){
			fromTime = daySpan.split(" - ")[0];
			toTime = daySpan.split(" - ")[1];
		}
		if(type==0){
			fromDt = arr[0] + " 00:00:00";
			toDt = arr[6] + " 23:59:59";
		}
		if(dayTime!=null&&dayTime!=""){
			fromDt = dayTime + " 00:00:00";
			toDt = dayTime + " 23:59:59";
		}
		var request=new Object();
		if(id!=null&&id!=""){
			request.stationId=id;
		}
		if(fromDt!=null&&fromDt!=""){
			request.fromDt=fromDt;
		}
		if(toDt!=null&&toDt!=""){
			request.toDt=toDt;
		}
		if(fromTime!=null&&fromTime!=""){
			request.fromTime=fromTime;
		}
		if(toTime!=null&&toTime!=""){
			request.toTime=toTime;
		}
		if(shiftId!=null&&shiftId!=""){
			request.shiftTypeIdPath=shiftId;
		}
		if(isChildShiftType==0){
			request.isChildShiftType=isChildShiftType;
		}
		if(isChild==0){
			request.isChild=isChild;
		}
		PostData("duty/arrange/stationStaff",request,function(result){
			var mess = result.data;
			var itemMap = new Map();
			for(var i=0;i<mess.length;i++){
				if(mess[i].staffId==0){
					continue;
				}
				var key = mess[i].staffId + "," + mess[i].idPath;
				if(!itemMap.has(key)){
					itemMap.set(key,mess[i].staffName + ";" + mess[i].staffCode + ";" + 
							mess[i].post + ";" + mess[i].staffPhone + ";" + 
							mess[i].shiftName + ";" + mess[i].lastPosTime + ";" + mess[i].deviceInfos);
				}
			}
		    //示范一个公告层
		    var html = "<table class='layui-table'>";
			html += "<thead><tr><th>序号</th><th>警员姓名</th><th>警号</th><th>岗位</th><th>电话</th><th>当前勤务</th><th>最近定位时间</th><th>设备</th></tr></thead>";
			html += "<tbody>";
			var index = 1;
			itemMap.forEach(function (value, key, map) {
				html += "<tr>";
				var obj = value.split(";");
				for(var j=0;j<obj.length;j++){
					if(j==0){
						html += "<td>"+index+"</td>";
						index++;
					}
					html += "<td>"+obj[j]+"</td>";
				}
				html += "</tr>";
			});
			html += "</tbody>";
			html += "</table>";
			layer.open({
			       type: 1
			        ,title: false //不显示标题栏
			        ,closeBtn: false
			        ,area: ['1200px', '500px']
			        ,shade: 0.8
			        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
			        ,btn: ['关闭']
			        ,btnAlign: 'c'
			        ,moveType: 1 //拖拽模式，0或者1
			        ,content: html
			        ,success: function(layero){
			          var btn = layero.find('.layui-layer-btn');
			          btn.find('.layui-layer-btn0').attr({
			          });
			        }
			    });
		    
		});
	}
	function getTimebyDateTime(datetime){
		if(datetime==null||datetime==""){
			return;
		}
		return datetime.split(" ")[1].replace(".0","");
	}
	function showShiftTimeStaff(data,Idx,row,date){
		var html ="";
		var mapItem = new Map();
		for(var i=0;i<Idx.length;i++){	
			var flag = 0;//是否需要加*
			var dataItem = data[Idx[i]];
			if(dataItem.staffId==0){
				break;
			}
			var fromTime=getTimebyDateTime(dataItem.fromTime);
			var toTime=getTimebyDateTime(dataItem.toTime);
			if(dataItem.fromTime < date){
				fromTime="00:00:00";
				flag=1;
			}
			else if(dataItem.toTime > date+" 23:59:59"){
				toTime="23:59:59";
				flag=2;
			}
			var timeft = fromTime + "-" + toTime;				
			var timeSpan = timeft.substr(0,5)+timeft.substr(8,6);
			if(flag==1){
				timeSpan="*"+timeSpan;
			}
			else if(flag==2){
				timeSpan=timeSpan+"*";
			}

			var staffName = dataItem.staffName;	
			var value =dataItem.staffId + ";" + staffName;
			if(mapItem.has(timeSpan)){
				mapItem.set(timeSpan,mapItem.get(timeSpan) + "," + value);
			}
			else{
				mapItem.set(timeSpan,value);
			}
		}
		var n=0;		
		mapItem.forEach(function (value, key, map){			
			html += "<a name='"+key+"'><div>" + key +"</div></a> ";
			var nameAndId=value.split(",");
			var itemList = new Array();
			for(var i=0;i<nameAndId.length;i++){
				if(!isInArray(itemList,nameAndId[i])){					
					itemList.push(nameAndId[i]);
				}
			}
			for(var i=0;i<itemList.length;i++){
				var item=itemList[i].split(";");
				html += "<a name='"+item[1]+"' onclick='details("+item[0]+")'><div>"+item[1]+"</div></a> ";	
				if(n==4 && Idx.length>5){
					html += "<div class='more"+row+"'>";
					html += "<a onclick=showMore("+row+")>...more...</a> ";
					html += "</div>";
					html += "<div style='display:none' class='less"+row+"'>";
				}	
				n++;
			}			
		});					
	
		if(n>4 && Idx.length>5){
			html += "<a onclick=showLess("+row+")>...less...</a> ";
			html += "</div>";
		} 
		return html;
	}
	// 显示单位
	function showStation(id) {
		stationSelector.openNode(id);
		onExpandforchangeWidth();
	}
</script>
<script>
	function showLess(id){
		//var more = document.getElementById('more'+id);
		//more.style.display='none';
		//var less = document.getElementById('less'+id);
		//less.style.display='block';
		var lessid = 'less'+id;
		var moreid = 'more'+id;
		$("."+lessid).css("display","none");
		$("."+moreid).css("display","block");
		
	}
	function showMore(id){
		//var less = document.getElementById('less'+id);
		//less.style.display='none';
		//var more = document.getElementById('more'+id);
		//more.style.display='block';
		var lessid = 'less'+id;
		var moreid = 'more'+id;

		$("."+moreid).css("display","none");
		$("."+lessid).css("display","block");
	}
	
	function showTypeShift(shiftId) {
		shiftTypeId = shiftId;
		arr_isShow = 1;
		SelectStation(null);
	}
	function searchShiftState(stateParam){
		var request=new Object();
		request.shiftState=stateParam;
		request.stationId=id;
		PostData("staff/staff/shiftState",request,function(result){
			var mess = result.data;
			var itemMap = new Map();
			for(var i=0;i<mess.length;i++){
				var key = mess[i].staffId + "," + mess[i].idPath;
				if(!itemMap.has(key)){
					itemMap.set(key,mess[i].staffName + ";" + mess[i].staffCode + ";" + 
							mess[i].post + ";" + mess[i].staffPhone + ";" + 
							mess[i].shiftName + ";" + mess[i].lastPosTime + ";" + mess[i].deviceInfos);
				}
			}
		    //示范一个公告层
		    var html = "<table class='layui-table'>";
			html += "<thead><tr><th>序号</th><th>警员姓名</th><th>警号</th><th>岗位</th><th>电话</th><th>当前勤务</th><th>最近定位时间</th><th>设备</th></tr></thead>";
			html += "<tbody>";
			var index = 1;
			itemMap.forEach(function (value, key, map) {
				html += "<tr>";
				var obj = value.split(";");
				for(var j=0;j<obj.length;j++){
					if(j==0){
						html += "<td>"+index+"</td>";
						index++;
					}
					html += "<td>"+obj[j]+"</td>";
				}
				html += "</tr>";
			});
			html += "</tbody>";
			html += "</table>";
			layer.open({
			       type: 1
			        ,title: false //不显示标题栏
			        ,closeBtn: false
			        ,area: ['1200px', '500px']
			        ,shade: 0.8
			        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
			        ,btn: ['关闭']
			        ,btnAlign: 'c'
			        ,moveType: 1 //拖拽模式，0或者1
			        ,content: html
			        ,success: function(layero){
			          var btn = layero.find('.layui-layer-btn');
			          btn.find('.layui-layer-btn0').attr({
			          });
			        }
			    });
		});
	}
	//日期类型 加减
</script>
<script language="JavaScript" type="text/javascript">
//JS将table导出为Excel
 var idTmr;
 function  getExplorer() {
     var explorer = window.navigator.userAgent ;
     //ie
     if (explorer.indexOf("MSIE") >= 0) {
         return 'ie';
     }
     //firefox
     else if (explorer.indexOf("Firefox") >= 0) {
         return 'Firefox';
     }
     //Chrome
     else if(explorer.indexOf("Chrome") >= 0){
         return 'Chrome';
     }
     //Opera
     else if(explorer.indexOf("Opera") >= 0){
         return 'Opera';
     }
     //Safari
     else if(explorer.indexOf("Safari") >= 0){
         return 'Safari';
     }
 }
 function exportExcel(tableid) {
     if(getExplorer()=='ie')
     {
         var curTbl = document.getElementById(tableid);
         var oXL = new ActiveXObject("Excel.Application");
         var oWB = oXL.Workbooks.Add();
         var xlsheet = oWB.Worksheets(1);
         var sel = document.body.createTextRange();
         sel.moveToElementText(curTbl);
         sel.select();
         sel.execCommand("Copy");
         xlsheet.Paste();
         oXL.Visible = true;

         try {
             var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
         } catch (e) {
             print("Nested catch caught " + e);
         } finally {
             oWB.SaveAs(fname);
             oWB.Close(savechanges = false);
             oXL.Quit();
             oXL = null;
             idTmr = window.setInterval("Cleanup();", 1);
         }

     }
     else
     {
         tableToExcel(tableid)
     }
 }
 function Cleanup() {
     window.clearInterval(idTmr);
     CollectGarbage();
 }
 
 var tableToExcel = (function() {
     var uri = 'data:application/vnd.ms-excel;base64,',
             template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
             base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
             format = function(s, c) {
            	 var str=s.replace(/{(\w+)}/g,
                         function(m, p) { return c[p]; }) 
                         return str;}
                 
     return function(table, name) {
         if (!table.nodeType) table = document.getElementById(table)
        	 var inner = table.innerHTML;
        	 var str = inner.replace(/...less.../g," ").replace(/...more.../g," ");
        	 var ctx = {worksheet: name || 'Worksheet', table: str}
               
         window.location.href = uri + base64(format(template, ctx))
     }
 })()

</script>
</html>
