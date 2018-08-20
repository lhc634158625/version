<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
<!--
.layui-nav-child dd a{
	min-width: 121px;
	width: auto;
}
.layui-nav .layui-nav-child dd:hover .ul_header{
	display: block;
	position: absolute;
	top: 0;
	left: 162px;
	background: white;
	box-shadow: 0 2px 4px rgba(0,0,0,12);
	border: 1px solid #d2d2d2;
	border-radius: 2px;
}

.layui-nav .layui-nav-child dd .ul_header{
	display: none;
}

.layui-nav .layui-nav-child dd .ul_header a:hover{
	background: #f0f0f0;
}
-->
</style>
<header class="main-header" style="height: 80px; width: 100%">

	<nav style="position: relative;top: 0">
		<!-- Navbar Right Menu -->
		<div class="layui-header" style="position: relative;" >
			<div class="layui-logo" style="height: 100%;position: absolute;">
				<img src="../images/logo1.png" style="height: 100%">
			</div>
			<ul class="layui-nav layui-col-md8 layui-col-md-offset4">
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 25%;height: 25%;" src="../images/qwts.png">&nbsp;勤务态势</a></a>
					<dl class="layui-nav-child">
						<dd>
							<a  href="<c:url value='/duty/policeForce.jsp'/>">警力布防</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/policeSituationSituation.jsp'/>">警情态势</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/alarmSituation.jsp'/>">接警情况</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/trafficCondition.jsp'/>">交通路况</a>
						</dd>
						<dd>
							<a href="<c:url value='/duty/colorWarn.jsp'/>">四色预警</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 21%;height: 23%;" src="../images/qwbs.png">&nbsp;勤务部署</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">日常勤务</a>
							<ul class="ul_header">
								<li><a href="<c:url value='/duty/policeStationScheduling.jsp'/>">派出所排班</a></li>
								<li><a href="<c:url value='/duty/fastReverseShift.jsp'/>">135快反圈排班</a></li>
								<li><a href="">重点防务区排班</a></li>
								<li><a href="">加密巡区排班</a></li>
								<li><a href="">案件回返</a></li>
							</ul>
						</dd>
						<dd>
							<a href="">加强性勤务</a>
							<ul class="ul_header">
								<li><a href="">节假日机关增援基层</a></li>
								<li><a href="">等级响应值班情况</a></li>
								<li><a href="">红色预警巡防部署</a></li>
							</ul>
						</dd>
						<dd>
							<a href="">特殊勤务</a>
							<ul class="ul_header">
								<li><a href="">综合武装设卡盘查</a></li>
								<li><a href="">围村围点</a></li>
								<li><a href="">自定义勤务</a></li>
							</ul>
						</dd>
						<dd>
							<a href="">站卡体系</a>
							<ul class="ul_header">
								<li><a href="">时际区际检查站</a></li>
								<li><a href="">围村围点</a></li>
								<li><a href="">治安岗点</a></li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 25%;height: 25%;" src="../images/qwjx.png">&nbsp;勤务绩效</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">勤务督导</a>
							<ul class="ul_header">
								<li><a href="">电台点名</a></li>
								<li><a href="">视频巡查</a></li>
								<li><a href="">GPS轨迹倒查</a></li>
								<li><a href="">盘查督导</a></li>
								<li><a href="">街面可防性警情倒查</a></li>
								<li><a href="">上下勤报备</a></li>
							</ul>
						</dd>
						<dd>
							<a href="">统计分析</a>
							<ul class="ul_header">
								<li><a href="">警力统计</a></li>
								<li><a href="">盘查量统计</a></li>
								<li><a href="">综合武装设卡盘查</a></li>
								<li><a href="">围村围点</a></li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 22%;height: 20%;" src="../images/qwxx.png">&nbsp;勤务信息</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">工作规范</a>
						</dd>
						<dd>
							<a href="">勤务指令</a>
						</dd>
						<dd>
							<a href="">警情通报</a>
						</dd>
						<dd>
							<a href="">治安摘报</a>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 25%;height: 25%;" src="../images/qwgl.png">&nbsp;勤务管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">警力部署</a>
						</dd>
						<dd>
							<a href="">设备管理</a>
						</dd>
						<dd>
							<a href="">巡逻必到点</a>
						</dd>
						<dd>
							<a href="">高峰站点</a>
						</dd>
						<dd>
							<a href="<c:url value='/home/outLogin'/>">签到登记</a>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="javascript:;"><img style="width: 22%;height: 22%;" src="../images/xtgl.png">&nbsp;系统管理</a>
					<dl class="layui-nav-child" style="float:left">
						<dd>
							<a href="<c:url value='/lhc/policeList.jsp'/>">警员列表</a>
						</dd>
						<dd>
							<a href="">组织管理</a>
						</dd>
						<dd>
							<a href="">用户列表</a>
						</dd>
						<dd>
							<a href="">角色权限</a>
						</dd>
						<dd>
							<a href="">系统参数</a>
						</dd>
						<dd>
							<a href="">系统日志</a>
						</dd>
						<dd>
							<a href="">指令模版</a>
						</dd>
						<dd>
							<a href="">消息模版</a>
						</dd>
						<dd>
							<a href="">卡口对应路段设置</a>
						</dd>
						<dd>
							<a href="">路线方案</a>
						</dd>
						<dd>
							<a href="">清空缓存</a>
						</dd>
						<dd>
							<a href="">单位视野</a>
						</dd>
					</dl>
				</li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a
					href="<c:url value=' '/>"><img style="width: 60%;height: 70%;" src="../images/message.png" class="layui-nav-img"></a></li>
				<li id="returnToLogin" class="layui-nav-item"><a
					href="<c:url value=''/>">退出</a></li>
				<li id="loginTo" class="layui-nav-item"><a>
						<img style="width: 25%;height: 25%;" src="../images/gly.png" class="layui-nav-img">
						<span id="loginUser">登录</span>
				 <!-- 	                <dl class="layui-nav-child"> --> <!-- 	                    <dd><a href="">基本资料</a></dd> -->
					<!-- 	                    <dd><a href="">安全设置</a></dd> --> <!-- 	                </dl> -->
				</a></li>
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
	</script>
	<script>
		var logint = document.getElementById('loginTo');
		logint.onclick=function(){
			if(sessionStorage.getItem("result") == null){
				top.window.location.href = "/duty/login.jsp";				
			}			
		}
		
		var rt = document.getElementById('returnToLogin');
		rt.onclick=function(){
			sessionStorage.removeItem("result");
		}
		function init(){
			var result = sessionStorage.getItem("result");
			if(result != null){
				var dataObj =eval("("+result+")");
				var loginName =  document.getElementById('loginUser');
				loginName.innerHTML = dataObj.name;
			}			
		}
		init();
	</script>
</header>