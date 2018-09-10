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
				<span id="show_span" style="line-height: 30px;">检查站</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<ul id="stationType">
					<li onclick="showAll(this)">市际检查站<img class="common_img"
						src="../images/starlogo.png" onclick="showTable()">
						<ul style="display: none; width: 100%; background: white;"
							onclick="cancelBubble()">
							<li
								style="width: 100%; height: auto; background: white; font-size: 14px;">
								<form class="layui-form"
									style="padding-bottom: 8px; width: 232px; margin-left: 20px; text-indent: 0px;">
									<div>序号:3</div>
									<div>
										名称:<input type="text" class="layui-text" value="市际封控圈">
									</div>
									<div>
										一级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="136"
											style="width: 20%;">人
									</div>
									<div>
										二级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="76" style="width: 20%;">人
									</div>
									<div>
										三级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="48" style="width: 20%;">人
									</div>
									<div>备注:</div>
									<textarea placeholder="进入厦门" class="layui-textarea"
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
										class="areaStyle_img" src="../images/diamond.png">厦门北高速检测站<img
										class="common_img" src="../images/starlogo.png"
										onclick="showTable()"></li>
									<li onclick="showMess()" class="areaStyle"><img
										class="areaStyle_img" src="../images/diamond.png">厦门西高速检测站<img
										class="common_img" src="../images/starlogo.png"
										onclick="showTable()"></li>
									<li onclick="showMess()" class="areaStyle"><img
										class="areaStyle_img" src="../images/diamond.png">东孚检测站<img
										class="common_img" src="../images/starlogo.png"
										onclick="showTable()"></li>
								</ul>
							</li>
						</ul></li>
					<li onclick="showAll(this)">市际检查站<img class="common_img"
						src="../images/starlogo.png" onclick="showTable()">
						<ul style="display: none; width: 100%; background: white;"
							onclick="cancelBubble()">
							<li
								style="width: 100%; height: auto; background: white; font-size: 14px;">
								<form class="layui-form"
									style="padding-bottom: 8px; width: 232px; margin-left: 20px; text-indent: 0px;">
									<div>序号:1</div>
									<div>
										名称:<input type="text" class="layui-text" value="市际封控圈">
									</div>
									<div>
										一级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="136"
											style="width: 20%;">人
									</div>
									<div>
										二级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="76" style="width: 20%;">人
									</div>
									<div>
										三级:<input type="checkbox" lay-skin="primary" title="启动"><input
											type="text" class="layui-text" value="48" style="width: 20%;">人
									</div>
									<div>备注:</div>
									<textarea placeholder="进入厦门" class="layui-textarea"
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
										class="areaStyle_img" src="../images/diamond.png">海沧大桥<img
										class="common_img" src="../images/starlogo.png"
										onclick="showTable()"></li>
									<li onclick="showMess()" class="areaStyle"><img
										class="areaStyle_img" src="../images/diamond.png">厦门大桥<img
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