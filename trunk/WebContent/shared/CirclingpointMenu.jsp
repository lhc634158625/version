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
				<span id="show_span" style="line-height: 30px;">围村围点</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<ul id="stationType">
					<li>巡逻特警支队<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>集美分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>思明分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>海沧分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>湖里分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>同安分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>翔安分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li>交通分局<img class="common_img" src="../images/starlogo.png"
						onclick="showTable()"></li>
					<li onclick="showAll(this)">机场分局<img class="common_img"
						src="../images/starlogo.png" onclick="showTable()">
						<ul style="display: none; width: 100%; background: white;"
							onclick="notReturn()">
							<li style="width: 100%; height: auto; background: white;">
								<div>分局(队伍驻地):</div>
								<form class="layui-form"
									style="padding-bottom: 8px; width: 232px; margin-left: 20px;">
									<textarea placeholder="请输入内容" class="layui-textarea"
										style="resize: none;"></textarea>
									<button class="layui-btn layui-btn-primary layui-btn-xs"
										style="width: 232px; margin-top: 5px;">保存信息</button>
								</form>
								<div>
									<button class="layui-btn layui-btn-primary">增加巡逻点</button>
									<button class="layui-btn layui-btn-primary"
										onclick="showAllBtn(this)">
										<img class="form_img" src="../images/checked.png">显示全部
									</button>
								</div>
								<ul>
									<li onclick="showMess()" class="areaStyle"><img
										class="areaStyle_img" src="../images/diamond.png">机场辖区<img
										class="common_img" src="../images/starlogo.png"
										onclick="showTable()"></li>
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
			var bro = $(obj).siblings();
			for (var i = 0; i < bro.length; i++) {
				bro[i].classList.remove("liL1");
			}
			var tag = $(obj).children();
			for (var i = 0; i < tag.length; i++) {
				if (tag[i].localName == "ul") {
					var display = tag[i].style.display;
					if (display == "block") {
						$(obj).removeClass("liL1");
						tag[i].style.display = "none";
					} else if (display == "none") {
						$(obj).addClass("liL1");
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

		function notReturn() {
			cancelBubble();
		}
	</script>
</aside>