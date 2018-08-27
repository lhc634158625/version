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
				<span id="show_span" style="line-height: 30px;">135</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<ul id="sType">
					<li><button class="layui-btn" style="background: #4472ca">1'</button></li>
					<li><button class="layui-btn" style="background: #4472ca">3'</button></li>
					<li><button class="layui-btn" style="background: #4472ca">5'</button></li>
				</ul>
				<ul id="stationType">
					<li><a>巡逻特警支队</a><img src="../images/starlogo.png"></li>
					<li><a>集美分局</a><img src="../images/starlogo.png"></li>
					<li><a>思明分局</a><img src="../images/starlogo.png"></li>
					<li><a>海沧分局</a><img src="../images/starlogo.png"></li>
					<li><a>湖里分局</a><img src="../images/starlogo.png"></li>
					<li><a>同安分局</a><img src="../images/starlogo.png"></li>
					<li><a>翔安分局</a><img src="../images/starlogo.png"></li>
					<li><a>交通分局</a><img src="../images/starlogo.png"></li>
					<li><a onclick="showAll(this)">机场分局</a><img
						src="../images/starlogo.png">
						<ul style="display: none;">
							<li
								style="width: 100%; height: auto; background: white; padding-left: 0;">
								<form class="layui-form"
									style="padding-bottom: 8px; width: 232px;">
									<div>分局(队伍驻地):</div>
									<textarea placeholder="请输入内容" class="layui-textarea"
										style="resize: none;"></textarea>
									<button class="layui-btn layui-btn-primary layui-btn-xs"
										style="width: 232px; margin-top: 5px;">保存信息</button>
								</form>
								<button class="layui-btn layui-btn-primary">增加巡逻点</button>
								<button class="layui-btn layui-btn-primary"
									onclick="showAllBtn(this)">
									<img src="../images/checked.png"
										style="float: left; margin-right: 0;">显示全部
								</button>
								<ul>
									<li style="width: 100%; background: white; padding-left: 0;"><img
										style="float: left; margin-right: 0;"
										src="../images/diamond.png"><a onclick="showMess()">机场辖区</a><img
										src="../images/starlogo.png"></li>
								</ul>
							</li>
						</ul></li>
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
	<script>
		function showAll(obj) {
			var tag = $(obj).parent().children();
			for (var i = 0; i < tag.length; i++) {
				if (tag[i].localName == "ul") {
					var display = tag[i].style.display;
					if (display == "block") {
						tag[i].style.display = "none";
					} else if (display == "none") {
						tag[i].style.display = "block";
					}
				}
			}
		}

		function showAllBtn(obj) {
			var src = $(obj).children().attr("src");
			if (src == "../images/checked.png") {
				$(obj).children().attr("src", "../images/unchecked.png");
			} else if (src == "../images/unchecked.png") {
				$(obj).children().attr("src", "../images/checked.png");
			}
		}

		function showMess() {
			var formDiv = document.getElementById("formDiv");
			formDiv.style.display = "block";
		}
	</script>
</aside>