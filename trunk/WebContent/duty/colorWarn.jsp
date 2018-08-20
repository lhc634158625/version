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
<link rel="stylesheet" href="../js/pgis/EzServerClient.min.css">
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/colorWarn.css">
<script src="../js/jquery/jquery.js"></script>
</head>
<body class="layui-layout-body" onLoad="onLoad()">
	<div class="layui-layout layui-layout-admin">


		<%@ include file="../shared/pageHeader.jsp"%>
		<%@ include file="../shared/colorWarnMenu.jsp"%>

		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div>
				<div class="layui-row layui-col-space1">
					<div id="mianBody">
						<div class="layui-fluid"
							style="height: 30px; padding-top: 12px; padding-bottom: 12px; background-color: #f2f2f2; z-index: 2;">
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
							<div class="layui-col-md1" style="left: 1%; margin-top: 2%;"></div>
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
					</div>

					<div id="mapDiv"></div>
				</div>
			</div>
			<%@ include file="../shared/pageFooter.jsp"%>
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
