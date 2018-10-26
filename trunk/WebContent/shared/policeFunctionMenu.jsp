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

#width_left {
	background: #ffffff;
	width: 275px;
	padding-right: 10px;
	margin-top: 40px;
}

#stationSelect .layui-input {
	border-bottom: 1px solid #cccccc;
	border-radius: 0 10px 10px 0;
}

#divTree::-webkit-scrollbar {
	display: none;
}

#left_mean_body {
	border: solid 1px #cccccc;
	border-radius: 0 10px 10px 0;
	height: auto;
	padding-bottom: 40px;
}

#sType {
	padding: 10px 0px 10px 20px;
	height: 20px;
}

#sType li {
	display: block;
	float: left;
	cursor: pointer;
	border-bottom: 1px solid #7fa7fe;
	color: #7fa7fe;
	margin-right: 37px;
}

#stationType {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
}

#stationType::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#stationType li {
	min-height: 40px;
	height: auto;
	line-height: 40px;
	font-size: 16px;
	padding-left: 20px;
	vertical-align: middle;
	line-height: 40px;
}

#stationType li img {
	width: 15px;
	height: 15px;
	float: right;
	margin-right: 20px;
	margin-top: 12px;
}

#stationType li:hover {
	background: #7fa7fe;
	cursor: pointer;
}

._level1 {
	background-color: #fff;
	border-radius: 5px;
	margin-top: 6px;
	border-bottom: 1px solid #ccc;
}

._level1 a {
	display: block;
	width: auto;
	height: 100%;
	padding-left: 80px;
}

._level2 {
	background-color: #ecf1f9;
	padding: 0px;
}

._level3 {
	padding: 0px;
	background-color: #ecf1f9;
}

#left_mean_body li {
	border-radius: 5px;
	border-top: 1px #ccc solid;
	line-height: 40px;
}

#left_mean_body i {
	position: absolute;
	left: 250px;
}

.active_color {
	background-color: #92b4f4;
}
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div
				style="color: #000; border-radius: 0 10px 10px 0; border: 1px #cccccc solid; margin: 19px 0 2px 0; height: 4%;"
				class="menu_top">
				<span id="show_span" style="line-height: 30px;">菜单</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<div class="layui-collapse _level1" lay-accordion="">
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">勤务态势</h2>
						<div class="layui-colla-content _level3">
							<ul>
								<li style="border: none;"><a
									href="<c:url value='/duty/policeForce.jsp'/>"
									onclick="showNameLeftLeft(this)">警力部署</a></li>
								<li><a
									href="<c:url value='/duty/policeSituationSituation.jsp'/>"
									onclick="showNameLeft(this)">警情态势</a></li>
								<li><a href="<c:url value='/duty/alarmSituation.jsp'/>"
									onclick="showNameLeft(this)">接警情况</a></li>
								<li><a href="<c:url value='/duty/trafficCondition.jsp'/>"
									onclick="showNameLeft(this)">交通路况</a></li>
								<li><a href="<c:url value='/duty/colorWarn.jsp'/>"
									onclick="showNameLeft(this)">四色预警</a></li>
							</ul>
						</div>
					</div>
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">勤务部署</h2>
						<div class="layui-colla-content _level2">
							<div class="layui-collapse" lay-accordion=""
								style="border: none;">
								<div class="layui-colla-item">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">日常勤务</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a
												href="<c:url value='/duty/policeStationScheduling.jsp'/>"
												onclick="showNameLeft(this)">派出所排班</a></li>
											<li><a
												href="<c:url value='/duty/fastReverseShift.jsp'/>"
												onclick="showNameLeft(this)">135快饭圈排班</a></li>
											<li><a href="<c:url value='/duty/keyDefenseArea.jsp'/>"
												onclick="showNameLeft(this)">重点防务区排班</a></li>
											<li><a
												href="<c:url value='/duty/encryptPatrolArea.jsp'/>"
												onclick="showNameLeft(this)">加密巡区排班</a></li>
											<li><a href="<c:url value='/duty/caseCallback.jsp'/>"
												onclick="showNameLeft(this)">案件回访</a></li>
										</ul>
									</div>
								</div>
								<div class="layui-colla-item">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">加强性勤务</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a
												href="<c:url value='/duty/holidaySupport.jsp'/>"
												onclick="showNameLeft(this)">节假日机关增援基层</a></li>
											<li><a
												href="<c:url value='/duty/gradeResponseDuty.jsp'/>"
												onclick="showNameLeft(this)">等级响应值班情况</a></li>
											<li><a>红色预警巡防部署</a></li>
										</ul>
									</div>
								</div>
								<div class="layui-colla-item">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">特殊勤务</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a
												href="<c:url value='/duty/armedCheck.jsp'/>">综合武装设卡盘点</a></li>
											<li><a>围村围点</a></li>
											<li><a>自定义勤务</a></li>
										</ul>
									</div>
								</div>
								<div class="layui-colla-item">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">站卡体系</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a>市际区际检查站</a></li>
											<li><a>治安岗点</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">勤务绩效</h2>
						<div class="layui-colla-content _level2">
							<div class="layui-collapse" lay-accordion="">
								<div class="layui-colla-item ">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">警务督导</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a>电台点名</a></li>
											<li><a>视频巡查</a></li>
											<li><a>GPS轨迹倒查</a></li>
											<li><a>盘查督导</a></li>
											<li><a>街面可防性警情倒查</a></li>
											<li><a>上下勤报备</a></li>
										</ul>
									</div>
								</div>
								<div class="layui-colla-item _level1">
									<h2 class="layui-colla-title _level2"
										style="padding-left: 50px;">统计分析</h2>
									<div class="layui-colla-content _level3">
										<ul class="">
											<li style="border: none;"><a>警力统计</a></li>
											<li><a>盘查量统计</a></li>
											<li><a>综合武装设卡盘查</a></li>
											<li><a>围村围点</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">勤务信息</h2>
						<div class="layui-colla-content _level3">
							<ul>
								<li style="border: none;"><a>工作规范</a></li>
								<li><a>勤务指令</a></li>
								<li><a>警情通报</a></li>
								<li><a>治安摘报</a></li>
							</ul>
						</div>
					</div>
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">勤务管理</h2>
						<div class="layui-colla-content _level3">
							<ul>
								<li style="border: none;"><a
									href="<c:url value='/duty/policeStationScheduling.jsp'/>"
									onclick="showNameLeft(this)">警力部署</a></li>
								<li><a>设备管理</a></li>
								<li><a>巡逻必到点</a></li>
								<li><a>高峰站点</a></li>
								<li><a>签到登记</a></li>
							</ul>
						</div>
					</div>
					<div class="layui-colla-item _level1">
						<h2 class="layui-colla-title _level1">系统管理</h2>
						<div class="layui-colla-content _level3">
							<ul>
								<li style="border: none;"><a>角色权限</a></li>
								<li><a>系统参数</a></li>
								<li><a>系统日志</a></li>
								<li><a>指令模板</a></li>
								<li><a>消息模板</a></li>
								<li><a>卡口对应路段设置</a></li>
								<li><a>路线方案</a></li>
								<li><a>清空缓存</a></li>
								<li><a>单位视野</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
</aside>
<script src="../js/jquery.ztree.all-3.1.min.js"></script>
<script src="../js/dateTime.js"></script>
<script src="../js/common.js?v=180725" type="text/javascript"></script>
<script src="../js/linq/linq.min.js"></script>
<script src="../js/dictCache.js"></script>
<script src="../js/IndexDB.js"></script>
<script src="../js/common/stationSelector.js?v=180612" charset="gb2312"></script>
<script>
	function showNameLeft(obj) {
		sessionStorage.removeItem("titleAdd");
		var a = $(obj).parents();
		var html = ' > ' + $(obj).text();
		for (var i = 0; i < a.length; i++) {
			if (a[i].className.indexOf("layui-colla-item") != -1) {
				html = ' > ' + a[i].innerText.split("\n")[0] + html;
			}
			if (a[i].className.indexOf("layui-collapse _level1") != -1) {
				break;
			}
		}
		if (html != '' && html != null) {
			html = html.substring(3);
		}
		sessionStorage.setItem("titleAdd", html);
	}
</script>