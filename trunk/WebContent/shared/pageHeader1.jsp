<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.layui-nav-child dd a {
	min-width: 121px;
	width: auto;
}

.layui-nav .layui-nav-child dd:hover .ul_header {
	display: block;
	position: absolute;
	top: 0;
	left: 162px;
	background: white;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 12);
	border: 1px solid #d2d2d2;
	border-radius: 2px;
}

.layui-nav .layui-nav-child dd .ul_header {
	display: none;
}

.layui-nav .layui-nav-child dd .ul_header a:hover {
	background: #f0f0f0;
}

#layui-header {
	position: relative;
	height: 110px;
	width: 100%;
	background-color: white;
	background-image: url('../images/logo2.png');
	background-size: 100% 110px;
	background-repeat: no-repeat;
}

#titleAdd {
	position: absolute;
	bottom: 25px;
	left: 10%;
}

.layui-nav-child {
	padding: 0
}
</style>
<header class="main-header" style="height: 110px; width: 100%">

	<nav style="position: relative; top: 0; height: 110px; width: 100%;">
		<!-- Navbar Right Menu -->
		<div class="layui-header" id="layui-header">
			<div id="titleAdd"></div>
			<ul class="layui-nav layui-col-md8 layui-col-md-offset4"
				style="background-color: transparent;">
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 25%; height: 25%;" src="../images/qwts.png">&nbsp;勤务态势</a></a>
					<dl class="layui-nav-child">
						<dd>
							<a href="<c:url value='/duty/policeForce.jsp'/>"
								onclick="showName(this)">警力布防</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/policeSituationSituation.jsp'/>"
								onclick="showName(this)">警情态势</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/alarmSituation.jsp'/>"
								onclick="showName(this)">接警情况</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/trafficCondition.jsp'/>"
								onclick="showName(this)">交通路况</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/colorWarn.jsp'/>"
								onclick="showName(this)">四色预警</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 21%; height: 23%;" src="../images/qwbs.png">&nbsp;勤务部署</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:;" onclick="showName(this)">日常勤务</a>
							<ul class="ul_header">
								<li><a
									href="<c:url value='/duty/policeStationScheduling.jsp'/>"
									onclick="showName(this)">派出所排班</a></li>
								<li><a href="<c:url value='/duty/fastReverseShift.jsp'/>"
									onclick="showName(this)">135快反圈排班</a></li>
								<li><a href="<c:url value='/duty/keyDefenseArea.jsp'/>"
									onclick="showName(this)">重点防务区排班</a></li>
								<li><a href="<c:url value='/duty/encryptPatrolArea.jsp'/>"
									onclick="showName(this)">加密巡区排班</a></li>
								<li><a href="<c:url value='/duty/caseCallback.jsp'/>"
									onclick="showName(this)">案件回访</a></li>
							</ul>
						</dd>
						<dd>
							<a href="javascript:;" onclick="showName(this)">加强性勤务</a>
							<ul class="ul_header">
								<li><a href="" onclick="showName(this)">节假日机关增援基层</a></li>
								<li><a href="" onclick="showName(this)">等级响应值班情况</a></li>
								<li><a href="" onclick="showName(this)">红色预警巡防部署</a></li>
							</ul>
						</dd>
						<dd>
							<a href="javascript:;" onclick="showName(this)">特殊勤务</a>
							<ul class="ul_header">
								<li><a href="" onclick="showName(this)">综合武装设卡盘查</a></li>
								<li><a href="" onclick="showName(this)">围村围点</a></li>
								<li><a href="">自定义勤务</a></li>
							</ul>
						</dd>
						<dd>
							<a href="javascript:;" onclick="showName(this)">站卡体系</a>
							<ul class="ul_header">
								<li><a href="" onclick="showName(this)">时际区际检查站</a></li>
								<li><a href="" onclick="showName(this)">围村围点</a></li>
								<li><a href="" onclick="showName(this)">治安岗点</a></li>
							</ul>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 25%; height: 25%;" src="../images/qwjx.png">&nbsp;勤务绩效</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:;" onclick="showName(this)">勤务督导</a>
							<ul class="ul_header">
								<li><a href="" onclick="showName(this)">电台点名</a></li>
								<li><a href="" onclick="showName(this)">视频巡查</a></li>
								<li><a href="" onclick="showName(this)">GPS轨迹倒查</a></li>
								<li><a href="" onclick="showName(this)">盘查督导</a></li>
								<li><a href="" onclick="showName(this)">街面可防性警情倒查</a></li>
								<li><a href="" onclick="showName(this)">上下勤报备</a></li>
							</ul>
						</dd>
						<dd>
							<a href="javascript:;" onclick="showName(this)">统计分析</a>
							<ul class="ul_header">
								<li><a href="" onclick="showName(this)">警力统计</a></li>
								<li><a href="" onclick="showName(this)">盘查量统计</a></li>
								<li><a href="" onclick="showName(this)">综合武装设卡盘查</a></li>
								<li><a href="" onclick="showName(this)">围村围点</a></li>
							</ul>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 22%; height: 20%;" src="../images/qwxx.png">&nbsp;勤务信息</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="" onclick="showName(this)">工作规范</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">勤务指令</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">警情通报</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">治安摘报</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 25%; height: 25%;" src="../images/qwgl.png">&nbsp;勤务管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="<c:url value='/duty/policeStationScheduling.jsp'/>"
								onclick="showName(this)">警力部署</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">设备管理</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">巡逻必到点</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">高峰站点</a>
						</dd>
						<dd>
							<a href="<c:url value='/home/outLogin'/>"
								onclick="showName(this)">签到登记</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img
						style="width: 22%; height: 22%;" src="../images/xtgl.png">&nbsp;系统管理</a>
					<dl class="layui-nav-child" style="float: left">
						<dd>
							<a href="<c:url value='/lhc/policeList.jsp'/>" onclick="showName(this)">警员列表</a>
						</dd>
						<dd>
							<a href="<c:url value='/lhc/stationManage.jsp'/>" onclick="showName(this)">组织管理</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">用户列表</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">角色权限</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">系统参数</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">系统日志</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">指令模版</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">消息模版</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">卡口对应路段设置</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">路线方案</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">清空缓存</a>
						</dd>
						<dd>
							<a href="" onclick="showName(this)">单位视野</a>
						</dd>
					</dl></li>
			</ul>
			<ul class="layui-nav layui-layout-right"
				style="background-color: transparent;">
				<li id="loginTo" class="layui-nav-item"><a> <img
						style="width: 25%; height: 25%;" src="../images/gly.png"
						class="layui-nav-img"> <span id="loginUser">登录</span>
				</a></li>
				<li id="returnToLogin" class="layui-nav-item"><a
					onclick='OnClickeExit();'>退出</a></li>
			</ul>
		</div>
	</nav>
	<script src="../layui/layui.js"></script>
	<script>
		layui.use('element', function() {
			var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

			//监听导航点击
			element.on('nav(demo)', function(elem) {
				//console.log(elem)
				layer.msg(elem.text());
			});
		});

		$(function() {
			// 拼接导航栏
			$("#titleAdd").empty();
			var titleAdd = sessionStorage.getItem("titleAdd");
			if (titleAdd == null || titleAdd == "") {
				titleAdd = '勤务态势   > 警力布防';
			}
			$("#titleAdd").append(titleAdd);

		});
	</script>
	<script>
		var logint = document.getElementById('loginTo');
		logint.onclick = function() {
			if (sessionStorage.getItem("result") == null) {
				top.window.location.href = "/duty/login.jsp";
			}
		}

		var rt = document.getElementById('returnToLogin');
		rt.onclick = function() {
			sessionStorage.removeItem("result");
		}
		function init() {
			var result = sessionStorage.getItem("result");
			if (result != null) {
				var dataObj = eval("(" + result + ")");
				var loginName = document.getElementById('loginUser');
				loginName.innerHTML = dataObj.name;
			}
		}
		init();
		function OnClickeExit() {
			var request = {};
			PostDataExit("sys/user/logout", request, function(result) {
				sessionStorage.removeItem("result");
				top.window.location.href = "/duty/login.jsp";
			});
		}
		function PostDataExit(method, data, callback) {
			var result = sessionStorage.getItem("result");
			var dataObj;
			if (result != null) {
				dataObj = eval("(" + result + ")");
			}
			;
			var datajson = JSON.stringify(data);
			var token = window.localStorage.getItem("token");
			var url = "http://218.85.92.186:8081/api/" + method;
			$.ajax({
				cache : false,
				type : "POST",
				headers : {
					'token' : dataObj.token,
					"userId" : dataObj.id
				},
				async : true,
				url : url,
				data : datajson, // JSON.stringify(obj),
				contentType : "application/json",
				dataType : "json",
				success : function(result) {
					callback(result);
				},
				error : function(xhr) {
					alert("系统退出出错！");
					return;
				}
			});
		}

		function showName(obj) {
			sessionStorage.removeItem("titleAdd");
			var a = $(obj).parents();
			var html = '';
			for (var i = a.length - 1; i >= 0; i--) {
				var b = a[i].firstElementChild;
				if (b.localName == "a") {
					html += ' > ' + b.innerText;
				}
			}
			if (html != '' && html != null) {
				html = html.substring(3);
			}
			sessionStorage.setItem("titleAdd", html);
		}
	</script>
</header>