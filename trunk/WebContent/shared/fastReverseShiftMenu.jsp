<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
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
				<span id="show_span" style="line-height: 30px;">135</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<ul id="sType">
					<li><button class="layui-btn" style="background: #4472ca" onclick="shiftTypeClict(1);">1'</button></li>
					<li><button class="layui-btn" style="background: #4472ca" onclick="shiftTypeClict(3);">3'</button></li>
					<li><button class="layui-btn" style="background: #4472ca" onclick="shiftTypeClict(5);">5'</button></li>
				</ul>
				<ul id="stationType">
				</ul>
			</div>
		</div>
	</section>
	<script id="tmpStateOption" type="text/html">
     <option value="">全部</option>    
 {{#  layui.each(d.datas, function(index, item){ }}
     <option value="{{item.code}}">{{item.name}}</option>
     {{#  }); }}
     </script>
	<script src="../js/jquery.ztree.all-3.1.min.js"></script>
	<script src="../js/dateTime.js"></script>
	<script src="../js/common.js?v=180725" type="text/javascript"></script>
	<script src="../js/linq/linq.min.js"></script>
	<script src="../js/dictCache.js"></script>
	<script src="../js/IndexDB.js"></script>
	<script
		src="../js/common/stationSelector.js?v=180612&&multi=${param.multi}"
		charset="gb2312"></script>
	<script type="text/javascript">
	function shiftTypeClict(type) {
		var itemid = whole_pointInfoMap.get("135排班")+"-"+whole_pointInfoMap.get("辖区")+"-";
		var minutesType = 2;
		var title="";
		if(type==1){
			itemid += whole_pointInfoMap.get("1分钟");
			minutesType = 1;
			title="1分钟";
		}
		else if(type==3){
			itemid += whole_pointInfoMap.get("3分钟");
			title="3分钟";
		}
		else if(type==5){
			itemid += whole_pointInfoMap.get("5分钟");
			title="5分钟";
		}
		
		showTable(itemid,1,minutesType,title);
	}

</script>
</aside>