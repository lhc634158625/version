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
<script src="../js/jquery/jquery.js"></script>
<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>

<script src="../js/jquery/jquery.js"></script>
<style>
#mainBody {
	position: fixed;
	right: 10px;
	bottom: 34px;
}

ul.layui-tab-title li:first-child i {
	display: none;
}

.layui-this {
	background: white;
}

#formDiv {
	position: fixed;
	border: 1px #ccc solid;
	bottom: 50px;
	margin-left: 10px;
	background: white;
	border-radius: 5px;
	width: 450px;
	bottom: 50px;
	display: none;
	z-index: 3;
}

.layui-input:-webkit-autofill {
	-webkit-box-shadow: 0 0 0px 1000px white inset;
}

.layui-form-label {
	width: 120px;
}

#formTop {
	width: 100%;
	height: 40px;
	background: #4472ca;
	border-radius: 5px;
	margin-bottom: 10px;
	line-height: 40px;
	font-size: 16px;
	color: white;
}

#formTop span:FIRST-CHILD {
	margin-left: 1em;
}

#formTop span:LAST-CHILD {
	float: right;
	font-size: 20px;
	margin-right: 26px;
	cursor: pointer;
}

#formTop img {
	width: 15px;
	height: 15px;
	margin-left: 15px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/fastReverseShiftMenu.jsp"%>
		<div id="mainBody">
			<div class="layui-tab" lay-filter="demo" lay-allowclose="true">
				<ul class="layui-tab-title" style="background: #92b4f4;">
					<li class="layui-this" lay-id="11">地图</li>
					<li lay-id="22">用户管理</li>
				</ul>
				<div class="layui-tab-content"
					style="border: 1px solid #ccc; border-top: none;">
					<div class="layui-tab-item layui-show">
						<div
							style="position: fixed; width: auto; height: 40px; z-index: 2; right: 30px; background: white;border-radius: 5px;padding: 5px;">
							<form class="layui-form" action="">
								<div class="layui-inline">
									<div class="layui-input-inline">
										<input type="checkbox" name="like1[write]" lay-skin="primary"
											title="一分钟 "> <input type="checkbox"
											name="like1[read]" lay-skin="primary" title="三分钟"> <input
											type="checkbox" name="like1[read]" lay-skin="primary"
											title="五分钟">
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline">
										<ul>
											<li style="position: relative;"><a onclick="showAll(this)">排班</a>
												<ul style="display: none;position: absolute;top: 30px;width: 100px;height: auto;background: white;">
													<li style="width: auto;height: 30px;border-bottom: solid 1px #ccc;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="有排班 ">
													</li>
													<li style="width: auto;height: 30px;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="无排班">
													</li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline">
										<ul>
											<li style="position: relative;"><a onclick="showAll(this)">勤务车辆</a>
												<ul style="display: none;position: absolute;top: 30px;width: 100px;height: auto;background: white;">
													<li style="width: auto;height: 30px;border-bottom: solid 1px #ccc;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="在线 ">
													</li>
													<li style="width: auto;height: 30px;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="离线">
													</li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline">
										<ul>
											<li style="position: relative;"><a onclick="showAll(this)">勤务人员</a>
												<ul style="display: none;position: absolute;top: 30px;width: 100px;height: auto;background: white;">
													<li style="width: auto;height: 30px;border-bottom: solid 1px #ccc;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="在线 ">
													</li>
													<li style="width: auto;height: 30px;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="离线 ">
													</li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline">
										<ul>
											<li style="position: relative;"><a onclick="showAll(this)">摄像头</a>
												<ul style="display: none;position: absolute;top: 30px;width: 100px;height: auto;background: white;text-align: center;">
													<li style="width: auto;height: 30px;border-bottom: solid 1px #ccc;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="高空枪机 ">
													</li>
													<li style="width: auto%;height: 30px;line-height: 30px;text-align: center;"><input type="checkbox" name="like1[write]"
																lay-skin="primary" title="模拟球机 ">
													</li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
								<div class="layui-inline">
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test1"
											placeholder="yyyy-MM-dd">
									</div>
									<label>-</label>
									<div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test2"
											placeholder="yyyy-MM-dd">
									</div>
									<button class="layui-btn layui-btn-primary layui-btn-sm">搜索</button>
									<button class="layui-btn layui-btn-primary layui-btn-sm">前一天</button>
									<button class="layui-btn layui-btn-primary layui-btn-sm">后一天</button>
									<button class="layui-btn layui-btn-primary layui-btn-sm">今天</button>
									<button class="layui-btn layui-btn-primary layui-btn-sm">本周</button>
									<button class="layui-btn layui-btn-primary layui-btn-sm">本月</button>
								</div>
							</form>
						</div>
						<div id="mapDiv"></div>
					</div>
					<div class="layui-tab-item">内容2</div>
				</div>
			</div>
			<div id="formDiv">
				<div id="formTop">
					<span>机场辖区</span><img src="../images/starlogo.png"><span
						onclick="closeMess()">X</span>
				</div>
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">编号</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">巡逻区域</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">区域以辐射范围</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">区域类型</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">X坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Y坐标</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">关联单位</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">代码</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电台值守组</label>
						<div class="layui-input-inline" style="width: 278px;">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-inline" style="width: 278px;">
							<textarea name="desc" placeholder="请输入内容" class="layui-textarea"
								style="width: 100%; resize: none;"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"></label>
						<div class="layui-input-inline" style="width: 278px;">
							<button class="layui-btn" lay-submit lay-filter="formChose"
								style="background: #4472ca;">选择坐标</button>
							<button class="layui-btn" lay-submit lay-filter="formSave"
								style="background: #4472ca;">保存信息</button>
							<button class="layui-btn" lay-submit lay-filter="formStop"
								style="background: #4472ca;">停用</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	layui
			.use(
					[ 'form', 'layedit', 'laydate' ],
					function() {
						var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
						//自定义颜色
						laydate.render({
							elem : '#test1',
							theme : '#4472ca'
						});//自定义颜色
						laydate.render({
							elem : '#test2',
							theme : '#4472ca'
						});
					});

	$(function() {
		var height = $(window).height();
		var width = $(window).width() - 300;
		var mainBody = document.getElementById("mainBody");
		var mapDiv = document.getElementById("mapDiv");
		var content = document.getElementsByClassName("layui-tab-content");
		mainBody.style.height = height * 0.85 + "px";
		mainBody.style.width = width + "px";
		for (var i = 0; i < content.length; i++) {
			content[i].style.height = (height * 0.8 - 30) + "px";
		}
		mapDiv.style.height = (height * 0.8 - 30) + "px";
		mapDiv.style.width = (width - 20) + "px";
	});

	function closeMess() {
		var formDiv = document.getElementById("formDiv");
		formDiv.style.display = "none";
	}

	//提取不重复的数据存入数组
	function isInArray(arr, value) {
		for (var i = 0; i < arr.length; i++) {
			if (value === arr[i]) {
				return true;
			}
		}
		return false;
	}
</script>
<script type="text/javascript">
	var map = PGISHelper.Init("mapDiv");
</script>
</html>
