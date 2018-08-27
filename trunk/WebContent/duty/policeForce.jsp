<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>


<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>警力布防</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/policeForce.css">
<link rel="stylesheet" href="../js/pgis/EzServerClient.min.css">
<script src="../js/jquery/jquery.js"></script>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">


		<%@ include file="../shared/pageHeader.jsp"%>
		<%@ include file="../shared/policeForceMenu.jsp"%>

		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div>
				<div class="layui-row layui-col-space1">
					<div id="mianBody">
						<div class="layui-fluid"
							style="height: 30px; padding-top: 12px; padding-bottom: 12px; background-color: #f2f2f2; z-index: 2;">
							<div style="float: right;">
								<button class="layui-btn layui-btn-primary layui-btn-sm"
									onclick="_open(1)">浮框1</button>
								<button class="layui-btn layui-btn-primary layui-btn-sm"
									onclick="_open(2)">浮框2</button>
							</div>
						</div>
						<div class="layui-row">
							<div class="layui-col-md3" style="left: 1%; margin-top: 1%;">
								<div class="left_top">
									<ul class="left_top_2">
										<li id="li1"><img src="../images/m1.png"
											onmouseover="_show(1)" onmouseout="_hidden(1)"></li>
										<li id="li2"><img src="../images/m2.png"
											onmouseover="_show(2)" onmouseout="_hidden(2)"></li>
										<li id="li3"><img src="../images/m3.png"
											onmouseover="_show(3)" onmouseout="_hidden(3)"></li>
										<li id="li4"><img src="../images/m4.png"
											onmouseover="_show(4)" onmouseout="_hidden(4)"></li>
										<li id="li5"><img src="../images/m5.png"
											onmouseover="_show(5)" onmouseout="_hidden(5)"></li>
										<li id="li6"><img src="../images/m6.png"
											onmouseover="_show(6)" onmouseout="_hidden(6)"></li>
										<li id="li7"><img src="../images/m7.png"
											onmouseover="_show(7)" onmouseout="_hidden(7)"></li>
										<li id="li8"><img src="../images/m8.png"
											onmouseover="_show(8)" onmouseout="_hidden(8)"></li>
									</ul>
								</div>
							</div>
							<div class="layui-col-md2"
								style="float: right; right: 2%; margin-top: 1%;">
								<form class="right_top" action="#">
									<div class="right_top_1">
										<img alt="" src="../images/search.png" onclick="submit()">
									</div>
									<input class="right_top_2" style="color: white;"
										placeholder="请输入警员号、设备号等">
								</form>
							</div>
						</div>
						<div class="layui-row">
							<div class="layui-col-md1" style="left: 1%; margin-top: 2%;">
								<div class="left">
									<div class="left_1 ">
										<ul class="left_1_1">
											<li><span>警力态势</span></li>
										</ul>
									</div>
									<div class="left_2">
										<ul class="left_2_2">
											<li><span>警力态势</span>
												<ul class="left_2_2_1">
													<li><span>一警</span></li>
													<li><span>二警</span></li>
													<li><span>三警</span></li>
												</ul></li>
											<li><span>社区</span></li>
											<li><span>机动警务</span></li>
											<li><span>交警</span></li>
											<li><span>135快反区</span></li>
											<li><span>重点防务区</span></li>
											<li><span>加密巡逻</span></li>
											<li><span>站卡体系</span></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="layui-col-md3" style="float: right; margin-top: 5%;">
								<div class="right">
									<ul>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/jl.png"></a></li>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/zb.png"></a></li>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/sp.png"></a></li>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/lk.png"></a></li>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/jq.png"></a></li>
										<li onmouseover="_elongation(this)"
											onmouseout="_origina(this)"><a href="#"><img
												src="../images/bs.png"></a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="layui-row">
							<div class="layui-col-md4" style="left: 1%; margin-top: 1%;">
								<div class="left_bottom" id="left_bottom">
									<div class="left_bottom_1">
										<img alt="" src="../images/close.png" onclick="_close(1)">
									</div>
									<div class="left_bottom_2">
										<table class="layui-table">
											<thead>
												<tr>
													<td>头一</td>
													<td>头二</td>
													<td>头三</td>
													<td>头四</td>
													<td>头五</td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="layui-col-md4" style="margin-top: 1%;"></div>
							<div class="layui-col-md4" style="margin-top: 1%; right: 1%">
								<div class="right_bottom" id="right_bottom">
									<div class="right_bottom_1">
										<img alt="" src="../images/close.png" onclick="_close(2)">
									</div>
									<div class="right_bottom_2">
										<div class="layui-tab" lay-allowclose="true">
											<ul class="layui-tab-title">
												<li class="layui-this">选项一</li>
												<li>选项二</li>
												<li>选项三</li>
												<li>选项四</li>
											</ul>
											<div class="layui-tab-content" style="height: 78%;">
												<div class="layui-tab-item layui-show">1</div>
												<div class="layui-tab-item">2</div>
												<div class="layui-tab-item">3</div>
												<div class="layui-tab-item">4</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div id="mapDiv"></div>
				</div>
			</div>
		</div>
	</div>
</body>

<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>
<script>
	function _show(n) {
		var a = document.getElementById("li" + n);
		var b = document.getElementById("li" + n).firstElementChild;
		var c = b.src = "../images/m" + n + n + ".png";
		$("#li" + n).addClass("left_top_3");
	}
	function _hidden(m) {
		$("#li" + m).removeClass("left_top_3");
		var a = document.getElementById("li" + m);
		var b = document.getElementById("li" + m).firstElementChild;
		var c = b.src = "../images/m" + m + ".png";
	}
	function _close(k) {
		if (k == 1) {
			document.getElementById("left_bottom").style.display = "none";
		} else if (k == 2) {
			document.getElementById("right_bottom").style.display = "none";
		}
	}

	function _open(k) {
		if (k == 1) {
			document.getElementById("left_bottom").style.display = "block";
		} else if (k == 2) {
			document.getElementById("right_bottom").style.display = "block";
		}
	}
	function _elongation(obj) {
		$(obj).css("left", "0");
		$(obj).addClass("elongation");
	}
	function _origina(obj) {
		$(obj).removeClass("elongation");
		$(obj).css("left", "10px");
	}
	var mianBody = $(window).height();
	$("#mianBody").css("min-height", mianBody * 0.82);
	$("#mianBody").css("height", "auto");
	$("#mapDiv").css("min-height", mianBody);
	$("#mapDiv").css("height", "auto");
</script>
<script type="text/javascript">
	var map = PGISHelper.Init("mapDiv");
</script>
</html>
