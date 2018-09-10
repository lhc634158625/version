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
				<span id="show_span" style="line-height: 30px;">治安岗点</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
			<form class="layui-form" >				
				<ul id="stationType">																							
					<li><input type="checkbox" lay-skin="primary" title="思明分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>
					<li><input type="checkbox" lay-skin="primary" title="湖里分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>
					<li><input type="checkbox" lay-skin="primary" title="海沧分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>
					<li><input type="checkbox" lay-skin="primary" title="同安分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>
					<li><input type="checkbox" lay-skin="primary" title="集美分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>
					<li><input type="checkbox" lay-skin="primary" title="翔安分局治安岗点"><img src="../images/starlogo.png" onclick="showTable()"></li>	
				</ul>
			</form>		
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