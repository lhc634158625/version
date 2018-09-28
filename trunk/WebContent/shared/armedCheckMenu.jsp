<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
<!-- Left side column. contains the logo and sidebar -->
<style>
#stationL1 {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
}

#stationL1::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#stationL1 li {
	min-height: 32px;
	height: auto;
	line-height: 32px;
	font-size: 16px;
	vertical-align: middle;
	text-indent: 20px;
}

#stationL1 li img {
	width: 15px;
	height: 15px;
	float: right;
	margin-right: 20px;
	margin-top: 8px;
}

#stationL1 li:hover {
	background: #7fa7fe;
	cursor: pointer;
}

#stationL2{
	background-color:#fff;
	display: none;
}

#stationL2 li {
	min-height: 28px;
	height: auto;
	line-height: 28px;
	font-size: 14px;
	vertical-align: middle;
	text-indent: 36px;
}

#stationL3{
	display: none; 
	background-color: white;
}

#stationL3 li {
	min-height: 24px;
	height: auto;
	line-height: 24px;
	font-size: 12px;
	vertical-align: middle;
	text-indent: 50px;
}
#stationL3 span:hover {
	background: #7fa7fe;
	cursor: pointer;
}

#stationL3 li img {
	width: 15px;
	height: 15px;
	float: right;
	margin-right: 20px;
	margin-top: 4px;
}

#stationL3 li span {
	display: inline-block;
	width: 80%;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 1;
	overflow: hidden;
	float: left;
}
</style>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div
				style="color: #000; border-radius: 0 10px 10px 0; border: 1px #cccccc solid; margin: 19px 0 2px 0; height: 4%;"
				class="menu_top">
				<span id="show_span" style="line-height: 30px;">综合武装设卡盘查</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<ul id="sType">
					<li><button class="layui-btn" style="background: #4472ca">分局盘查勤务查看</button></li>
				</ul>
				<ul id="stationL1">
				
				</ul>
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
	
		function showAllBtn(obj) {
			var src = $(obj).children().attr("src");
			if (src == "../images/checked.png") {
				$(obj).children().attr("src", "../images/unchecked.png");
			} else if (src == "../images/unchecked.png") {
				$(obj).children().attr("src", "../images/checked.png");
			}
		}

		function showMess() {
			var formDiv = document.getElementById("formDiv");
			formDiv.style.display = "block";
			cancelBubble();
		}
	</script>
</aside>