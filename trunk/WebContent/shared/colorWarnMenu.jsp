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
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div class="menu_top">
				<span id="show_span" style="line-height: 30px;">四色预警</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				 <div class="menu_title">
	            <div class="menu_title1">备注：数据来源于回访表</div>
	            <div class="menu_title2">一级为<span style="color: red">红色</span>(巡防响应)</div>
	            <div class="menu_title2">二级为<span style="color: orange;">橙色</span>(巡防响应)</div>
	            <div class="menu_title2">三级为<span style="color: yellow;">黄色</span>(巡防响应)</div>
	            <div class="menu_title2">四级为<span style="color: green;">绿色</span>(巡防响应)</div>
            </div>
            <div style="padding: 5px">
	            <table class="layui-table">
		            <thead>
		            <tr><td>名称</td><td>数量</td><td>高发案情</td></tr>
		            </thead>
		            <tbody>
		            <tr>
		            	<td>思明4/4</td>
		            	<td>100</td>
		            	<td>咋骗(54);盗窃(42);</td>
		            </tr>
		            <tr>
		            	<td>思明4/4</td>
		            	<td>100</td>
		            	<td>咋骗(54);盗窃(42);</td>
		            </tr>
		            <tr>
		            	<td>思明4/4</td>
		            	<td>100</td>
		            	<td>咋骗(54);盗窃(42);</td>
		            </tr>
		            <tr>
		            	<td>思明4/4</td>
		            	<td>100</td>
		            	<td>咋骗(54);盗窃(42);</td>
		            </tr>
		            </tbody>
	            </table>
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