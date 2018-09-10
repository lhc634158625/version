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
<link rel="stylesheet" href="../css/trafficCondition.css">
<script src="../js/jquery/jquery.js"></script>
</head>
<body class="layui-layout-body" onLoad="onLoad()">
	<div class="layui-layout layui-layout-admin">


		<%@ include file="../shared/pageHeader1.jsp"%>
		<jsp:include page="../shared/policeForceMenu.jsp" flush="true">
			<jsp:param name="multi" value="1" />
		</jsp:include>

		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div>
				<div class="layui-row layui-col-space1">
					<div id="mianBody">
						<div class="layui-fluid"
							style="height: 30px; padding-top: 12px; padding-bottom: 12px; background-color: #f2f2f2; z-index: 2;">
							<div class="layui-col-md1" style="top: 1%;">
								<i class="layui-icon" style="font-size: 15px; color: #ff4d00;">&#xe617;</i>
								堵塞 0.5km/h
							</div>
							<div class="layui-col-md1" style="top: 1%; left: -2%;">
								<i class="layui-icon" style="font-size: 15px; color: #FFB800;">&#xe617;</i>
								拥堵 6-15km/h
							</div>
							<div class="layui-col-md1" style="top: 1%; left: -3.5%;">
								<i class="layui-icon" style="font-size: 15px; color: #50c878;">&#xe617;</i>
								缓慢 16-30km/h
							</div>
							<div class="layui-col-md1" style="top: 1%; left: -4.5%;">
								<i class="layui-icon" style="font-size: 15px; color: #16982b;">&#xe617;</i>
								畅通 31km/h
							</div>
							<div class="layui-col-md1" style="top: 1%; left: -6.5%;">
								<i class="layui-icon" style="font-size: 15px; color: #c2c2c2;">&#xe617;</i>
								无
							</div>
							<div class="layui-col-md2" style="top: 1%; left: -10%;">
								路况时间 18-07-26 03:34</div>
							<div class="layui-col-md2" style="top: 1%; left: -17%;">
								刷新时间 18-07-26 03:50</div>

						</div>
						
						<div class="layui-row" style="display: none;">
							<div class="layui-col-md5" style="left: 1%; margin-top: 2%;"></div>
							<div class="layui-col-md3" style="margin-top: 2%;"></div>
							<div class="layui-col-md3" style="margin-top: 0%; right: 1%">
								<div class="right_bottom" id="right_bottom">
									<div class="right_bottom_1">
										<img alt="" src="../images/close.png" onclick="_close(2)">
									</div>
									<div class="right_bottom_2">
										<img alt="" src="../images/ooo.png">
									</div>
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
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.8&key=dcd6434328f0d0deab0be97b7f209f5b"></script> 
<script src="../layui/layui.js"></script>
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
	var district, map = new AMap.Map('mapDiv', {
		resizeEnable: true,	
   		center:[118.1217384338379,24.4822758436203],
   		zoom:11,
   		zooms:[11,20]
 	});
	addXiaMen();
    function addXiaMen() {
        //加载行政区划插件
        AMap.service('AMap.DistrictSearch', function() {
            var opts = {
                subdistrict: 0,   //返回下一级行政区
                extensions: 'all',  //返回行政区边界坐标组等具体信息
                level: 'city'  //查询行政级别为 市
            };
            //实例化DistrictSearch
            district = new AMap.DistrictSearch(opts);
            district.setLevel('district');
            //行政区查询
            district.search('厦门市', function(status, result) {
                var bounds = result.districtList[0].boundaries;
                var polygons = [];
                if (bounds) {
                    for (var i = 0, l = bounds.length; i < l; i++) {
                        //生成行政区划polygon
                        var polygon = new AMap.Polygon({
                            map: map,
                            strokeWeight: 1,
                            path: bounds[i],                            
                            fillOpacity: 0,
                            fillColor: '#CCF3FF',
                            strokeColor: '#B72927',
                            strokeWeight: 5,
                            strokeStyle: "dashed"//
                        });
                        polygons.push(polygon);
                    }
                    map.setFitView();//地图自适应
                }
            });
        });
    }
    //实时路况图层
    var trafficLayer = new AMap.TileLayer.Traffic({
        zIndex: 10
    });
    trafficLayer.setMap(map);
    trafficLayer.show();
	//var map = PGISHelper.Init("mapDiv");
</script>
</html>
