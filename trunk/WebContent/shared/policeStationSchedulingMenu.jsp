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
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div class="layui-side" style="background: #0f1b33">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div class="menu_top">派出所排班</div>
			<div id="divTree">
				<ul id="tree" class="ztree"></ul>
			</div>
		</div>
	</section>
	<script id="tmpStateOption" type="text/html">
     <option value="">全部</option>    
 {{#  layui.each(d.datas, function(index, item){ }}
     <option value="{{item.code}}">{{item.name}}</option>
     {{#  }); }}
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
	<script src="../js/common/stationSelector.js?v=180612" charset="gb2312"></script>
</aside>