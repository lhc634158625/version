<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
<!-- Left side column. contains the logo and sidebar -->
<style>
#pointMess {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
	padding-bottom: 10px;
}

#pointMess::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#pointMess li {
	min-height: 24px;
	height: auto;
	line-height: 24px;
	font-size: 14px;
	padding-left: 20px;
	vertical-align: middle;
}

#pointMess li a {
	display: block;
	width: 100%;
	height: 100%;
	word-break: keep-all; /* 不换行 */
	white-space: nowrap; /* 不换行 */
	overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
	text-overflow: ellipsis;
	/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
}

#pointMess li:hover {
	background: #7fa7fe;
	cursor: pointer;
}

#taskMess {
	margin-top: 16px;
	max-height: 600px;
	overflow-y: scroll;
	padding-bottom: 10px;
}

#taskMess::-webkit-scrollbar {
	width: 0;
	height: 0;
}

#fontSize tr:hover {
	cursor: pointer;
}

#fontSize tr td {
	font-size: 12px;
}
</style>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<div id="width_left" class="layui-side">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<div
				style="color: #000; border-radius: 0 10px 10px 0; border: 1px #cccccc solid; margin: 19px 0 2px 0; height: 4%;"
				class="menu_top">
				<span id="show_span" style="line-height: 30px;">节假日机关增援基层</span> <input
					id="show_hid" onclick="showAndHidMean()" type="button"
					style="width: 30px; height: 30px; border: none; border-radius: 0 10px 10px 0; float: right; background-image: url(../images/sh.png);"></input>
			</div>
			<div id="left_mean_body">
				<div style="display: block; text-align: center; margin-top: 10px;">
					<button class="layui-btn" style="background: #4472ca"
						onclick="changeUl(1)">点位</button>
					<button class="layui-btn" style="background: #4472ca"
						onclick="changeUl(2)">任务</button>
				</div>
				<ul id="pointMess" style="display: block;">
					<li onclick="showMessByPoint()"><a>市局_中山路口</a></li>
					<li onclick="showMessByPoint()"><a title='市局_华侨博物馆路口（成功大道口）'>市局_华侨博物馆路口（成功大道口）</a></li>
					<li onclick="showMessByPoint()"><a>市局_钟鼓隧道口前斑马线</a></li>
					<li onclick="showMessByPoint()"><a>市局_南普陀寺门前小广场</a></li>
					<li onclick="showMessByPoint()"><a>市局_厦大南校门</a></li>
					<li onclick="showMessByPoint()"><a>市局_厦大西校门</a></li>
					<li onclick="showMessByPoint()"><a>市局_思明南路南普陀寺门前斑马线</a></li>
					<li onclick="showMessByPoint()"><a>市局_思明南路演武路三叉路口</a></li>
				</ul>

				<div id="taskMess" style="display: none;">
					<form class="layui-form">
						<div class="layui-inline" style="margin-top: 5px;">
							<label class="layui-form-label" style="width: 30px;">名称</label>
							<div class="layui-input-inline">
								<input type="text" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-inline" style="margin-top: 5px;">
							<label class="layui-form-label" style="width: 30px;">时间</label>
							<div class="layui-input-inline" style="width: 100px;">
								<input type="text" id="date1" lay-verify="date1"
									placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
							</div>
							<label>-</label>
							<div class="layui-input-inline"
								style="width: 100px; margin-top: 5px;">
								<input type="text" id="date2" lay-verify="date2"
									placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div
							style="display: block; text-align: center; margin-top: 5px;">
							<button class="layui-btn layui-btn-primary" lay-submit
								lay-filter="_search">搜索</button>
							<button class="layui-btn layui-btn-primary" lay-submit
								lay-filter="_new">新建</button>
						</div>
					</form>
					<table class="layui-table">
						<thead>
							<tr>
								<th>名称</th>
								<th>起始时间</th>
								<th>截至时间</th>
							</tr>
						</thead>
						<tbody id="fontSize">
							<tr onclick="showMessByTask()">
								<td>抗战胜利日</td>
								<td>2015-09-03</td>
								<td>2015-09-05</td>
							</tr>
							<tr>
								<td>劳动节</td>
								<td>2015-05-01</td>
								<td>2015-05-03</td>
							</tr>
						</tbody>
					</table>
				</div>
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

		function showMessByPoint() {
			var pointDiv = document.getElementById("pointDiv");
			pointDiv.style.display = "block";
		}
		
		function showMessByTask() {
			var taskDiv = document.getElementById("taskDiv");
			taskDiv.style.display = "block";
		}


		function changeUl(obj) {
			var pointMess = document.getElementById("pointMess");
			var taskMess = document.getElementById("taskMess");
			if (obj == 1) {
				taskMess.style.display = "none";
				pointMess.style.display = "block";
			} else if (obj == 2) {
				pointMess.style.display = "none";
				taskMess.style.display = "block";
			}
		}
	</script>
</aside>