<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
<style>
.menu_top {
	width: 100%;
	height: 3%;
	text-align: center;
	margin-top: 6%;
	color: white;
	border-bottom: #ccc 2px solid;
}
#tree {
	color: white;
}
#stationSelect .layui-input
{
	border-bottom:1px solid #cccccc;
	border-radius:0 10px 10px 0;
}
#divTree::-webkit-scrollbar {
        display: none;
    }
#stationSelect .layui-anim-upbit{
	width:100%;
}
#stationSelect .layui-anim-upbit::-webkit-scrollbar {
        display: none;
    }
    
#width_left {
	background: #ffffff;
	width: auto;
	padding-right: 10px;
	margin-top: 40px;
}
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div style="color:#000;border-radius:0 10px 10px 0; border:1px #cccccc solid; margin:19px 0 2px 0; height:4%;" class="menu_top">
				<span id="show_span" style="line-height:30px;">行政区域</span>
				<input id="show_hid" onclick="showAndHidMean()" type="button" style="width:30px;height: 30px; border:none;border-radius: 0 10px 10px 0;float:right;background-image:url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body" style="border:solid 1px #cccccc; border-radius:0 10px 10px 0;">
				<form class="layui-form" action="" method="post">
				<div id="stationSelect">				
					<div class="layui-input-inline" style="width:100%; ">
						<select name="stationSearch" id="stationSearch" lay-filter="stationSearch" aria-invalid="false" lay-search lay-case>
						</select>
					</div>
				</div>
				</form>
				<div id="divTree" style="height:700px; overflow:auto;">
					<ul id="tree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</section>
	<script id="tmpStateOption" type="text/html">
     <option value="">全部</option>    
 {{#  layui.each(d.datas, function(index, item){ }}
     <option value="{{item.code}}">{{item.name}}</option>
     {{#  }); }}
     </script>
     <script>
     window.onload=function(){
    	 onExpandforchangeWidth1();    	 
     }
 	    
     //随左侧菜单栏的变化，右边主页面宽度随之改变
     function onExpandforchangeWidth1(){
    		var width_left = document.getElementById("width_left");
    		var width_right = document.getElementById("width_right");
    		if(width_left != null && width_right!=null ){
    			var wd = width_left.offsetWidth;   		
        		var windowWidth = window.innerWidth;
        		var wr = windowWidth - wd;
        		width_right.style.width = wr+"px";
    		}
    		
     }
     
     //树于各个显示控件联动
     function changeStation(obj){ 	 
    	var selectv = $('#stationSearch');
    	selectv.val(obj.id);
    	if(typeof selectRender =="function"){
 			selectRender();
 		}
 	 	if(typeof SelectStation =="function"){
 			SelectStation(obj);
    	 }
     }
     </script>
     <script>
    function showAndHidMean(){
    	var lt_mean_body =document.getElementById('left_mean_body');
    	var sw_span =document.getElementById('show_span')
    	if(lt_mean_body.style.display=='block' || lt_mean_body.style.display==""){
    		lt_mean_body.style.display='none';
    		sw_span.style.display='none';
    	}	
    	else{
    		lt_mean_body.style.display='block';
    		sw_span.style.display='inline';
    	}		
    	onExpandforchangeWidth1();
    }
    function AddOption(allStations) {
    	$("#stationSearch").empty();
    	var data=allStations;
 		var manList=new Array();
 		var IdList=new Array();
 		for(var i=0;i<data.length;i++){
 			// if(!isInArray(manList,data[i].staffName)){					
 			// 	manList.push(data[i].name);
 			// 	IdList.push(data[i].id);
 			// }
 		}
 		var html = "";
 		html += "<option value=''></option>";
 		for(var j=0;j<manList.length;j++){
 			html += "<option value='"+ IdList[j] +"'>"+manList[j]+"</option>";		
 		}
 		$("#stationSearch").append(html); 
 		
 		if(typeof selectRender =="function"){
 			selectRender();
 		}
 	}
     </script>
	<div class="Mask">
		<i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#x1002;</i>刷新
	</div>
	<script src="../js/jquery.ztree.all-3.1.min.js"></script>
	<script src="../js/dateTime.js"></script>
	<script src="../js/common.js?v=180725" type="text/javascript"></script>
	<script src="../js/linq/linq.min.js"></script>
	<script src="../js/dictCache.js"></script>
	<script src="../js/IndexDB.js"></script>
	<script src="../js/common/stationSelector.js?v=180612&&multi=${param.multi}" charset="gb2312"></script>
	<!-- <script src="../lhc/js/stationService.js"></script> -->
</aside>