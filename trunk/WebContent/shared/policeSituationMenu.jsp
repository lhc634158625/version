<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
<style>

.menu_top{
	width: 100%;
	height: 5%;
	text-align: center;
	margin-top: 6%;
	margin:6%;
	color: #000;
	border-bottom: #ccc 2px solid;
}
.button {
    background-color: #33D1FF; /* Green */
    border: none;
    color: #fff;
    margin:4px 0 8px 20px;
    padding: 7px 30px;
    font-size: 10px;
    border-radius: 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
}
.common{
	color:#000;
	line-height: 25px;
}
a{color:#000}
a:hover{color:#01AAED} 


.color{
	color:#01AAED
}

-->
</style>
<style>
.menu_top {
	width: 100%;
	height: 3%;
	text-align: center;
	margin-top: 6%;
	color: white;
	border-bottom: #ccc 2px solid;
	color: #000;
	border-radius: 0 10px 10px 0;
	border: 1px #cccccc solid;
	margin: 19px 0 2px 0;
	height: 4%;
	background: #ffffff;
}

#tree {
	color: white;
}

#stationSelect .layui-input {
	border-bottom: 1px solid #cccccc;
	border-radius: 0 10px 10px 0;
}

#divTree::-webkit-scrollbar {
	display: none;
}

#width_left {
	width: auto;
	padding-right: 10px;
	margin-top: 40px;
	background-color: transparent;
}

#left_mean_body {
	border: solid 1px #cccccc;
	border-radius: 0 10px 10px 0;
	background: #ffffff;
}
#polSomeMessage li{
	padding:4px;
	border-bottom:1px solid #ccc;
}
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div class="menu_top">
				<span id="show_span" style="line-height: 30px;">警情分析</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body" style="width:300px;">
				<div id="案件类型">
					<span class="common">案件类型：</span> <span class="common"><a
						href="#" onclick="aClick(event)">求助</a></span>
				</div>
				<div id="区域">
					<span class="common">区域：</span> <span class="common"><a
						href="#" onclick="aClick(event)">鼓浪屿</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">中华</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">滨海</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">梧村</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">鼓浪屿</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">中华</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">滨海</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">梧村</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">鼓浪屿</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">中华</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">滨海</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">梧村</a></span>
				</div>
				<div id="时间">
					<span class="common">时间：</span> <span class="common"><a
						href="#" onclick="aClick(event)">今日</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">昨天</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">本周</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">上周</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">上月</a></span> <span class="common"><a
						href="#" onclick="aClick(event)">自定义</a></span>
				</div>
				<div class="button" id="btn" onclick="showtext();">开始查询</div>
				<div style="height:100px; padding:6px; border:1px solid #ccc">
					<ul>
						<li></li>
					</ul>
				</div>
				<div style="height:400px; padding:6px; border:1px solid #ccc;overflow: auto;">
					<ul id="polSomeMessage">
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>
						<li>04-28 20d5x49 XXXX  xxx181</li>					
					</ul>
				</div>
				
			</div>
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
		window.onload = function() {
			onExpandforchangeWidth();
		}

		//随左侧菜单栏的变化，右边主页面宽度随之改变
		function onExpandforchangeWidth() {
			var width_left = document.getElementById("width_left");
			var width_right = document.getElementById("width_right");
			if (width_left != null && width_right != null) {
				var wd = width_left.offsetWidth;
				var windowWidth = window.innerWidth;
				var wr = windowWidth - wd;
				width_right.style.width = wr + "px";
			}

		}
	</script>
	<script>
		function showAndHidMean() {
			var lt_mean_body = document.getElementById('left_mean_body');
			var sw_span = document.getElementById('show_span')
			if (lt_mean_body.style.display == 'block'
					|| lt_mean_body.style.display == "") {
				lt_mean_body.style.display = 'none';
				sw_span.style.display = 'none';
			} else {
				lt_mean_body.style.display = 'block';
				sw_span.style.display = 'inline';
			}
			onExpandforchangeWidth();
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
</aside>