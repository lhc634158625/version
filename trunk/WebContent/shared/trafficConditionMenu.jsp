<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
<!--
ul li{
margin-top: 5px;
}
.first ul li{
list-style-image: url("../images/open.png");
}
.first{
list-style-image: none;
}
.first ul li a{
position: relative;
top: -4px;
color: white;
}
.menu_top{
	width: 100%;
	height: 3%;
	text-align: center;
	margin-top: 6%;
	color: white;
	border-bottom: #ccc 2px solid;
}
-->
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
	    <div class="layui-side" style="background: #0f1b33">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <div class="menu_top">警情态势</div>
            <ul class="layui-nav" style="background: #0f1b33;margin-top: 20px;"  lay-filter="test">
                <li class="first">厦门公安局
	                <ul class="layui-nav " style="background: #0f1b33"  lay-filter="test">
		                <li><a href="#">分局</a>
		                	<ul class="layui-nav "  style="background: #0f1b33" lay-filter="test">
				                <li><a href="#">思明分局</a></li>
				                <li><a href="#">海沧分局</a></li>
				                <li><a href="#">湖里分局</a></li>
				                <li><a href="#">集美分局</a></li>
				                <li><a href="#">同安分局</a></li>
				                <li><a href="#">翔安分局</a></li>
				                <li><a href="#">交通分局</a></li>
				                <li><a href="#">机场分局</a></li>
				                <li><a href="#">地铁分局</a></li>
			                </ul>
		                </li>
		                <li><a href="#">支队</a></li>
		                <li><a href="#">局属各单位</a></li>
		                <li><a href="#">现役部队</a></li>
		                <li><a href="#">未整理</a></li>
		                <li><a href="#">接处警临时单位</a></li>
		                <li><a href="#">无效单位</a></li>
		                <li><a href="#">行动组</a></li>
		            </ul>
                </li>
            </ul>
        </div>
	</section>
	<!-- /.sidebar -->
</aside>