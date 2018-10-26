<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>案件回访</title>
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
#right_top{
	padding:10px 0 18px 0;
	height:30px;
	width:100%;
}
#right_top ul li{
	border:1px solid #ccc;
	width:114px; 
	height:30px;
	float:left;
	line-height: 30px;
    text-align: center;
    margin-left:20px;
}
#right_top a{
	line-height:30px;
	margin-left: 30px;
    color: #334ba1;
}
#right_all_one ul  li{
	padding-bottom:4px;
}
.layui-form-label{
	width:80px;
}
.layui-form-item{
	margin-bottom:10px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="../shared/pageHeader1.jsp"%>
		<%@ include file="../shared/policeFunctionMenu.jsp"%>
		<div id="mainBody">
			<div class="layui-tab" lay-filter="demo" lay-allowclose="true">
				<ul class="layui-tab-title" style="background: #92b4f4;">
					<li class="layui-this" lay-id="11">案件回访</li>
				</ul>
				<div class="layui-tab-content"style="border: 1px solid #ccc; border-top: none;">
					<div class="layui-tab-item layui-show" >
						<div id="body_main_right">
							<div id="right_top">
								<ul>
									<li onclick="changeList('buttom_caseList')" >案件列表</li>
									<li onclick="changeList('buttom_backList')" >回访列表</li>
									<li >回访信息</li>
								</ul>
								<a>工作规范</a>
								<a>使用帮助</a>
							</div>
							<div id="buttom_caseList">						
								<div id="right_all_caseList_one" style="height:auto;width:100%;">
								<form class="layui-form" action="" lay-filter="example">
									<div class="layui-form-item">
	  									<label class="layui-form-label">警情号：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	<label class="layui-form-label">案件类别：</label>
									    <div class="layui-input-inline">
									        <select name="modules1" lay-verify="required" lay-search="">
									          <option value="">请选择案件类别</option>
									          <option value="1">layer</option>
									          <option value="2">form</option>								         
									        </select>
									    </div>
									    <label class="layui-form-label">生成时间：</label>
									    <div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test1"
											placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label" style="width: 10px; padding-left: 0;">-</label>
										<div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="test2"
												placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label">有无回访：</label>
										<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">请选择有无回访</option>
									          <option value="1">有回访</option>
									          <option value="2">无回访</option>								         
									        </select>
									    </div>
									</div>	
									<div class="layui-form-item">
										<label class="layui-form-label">单位：</label>
								   		<div class="layui-input-inline">
								      		<input id="showTree1" onclick="showTreemMean(this,this.id)" type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	<label class="layui-form-label">报警人：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	 <label class="layui-form-label">报警时间：</label>
									    <div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test3"
											placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label" style="width: 10px; padding-left: 0;">-</label>
										<div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="test4"
												placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label">电话：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
									</div>	
									<div class="layui-form-item">
										<label class="layui-form-label">报警地址：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>	
										<label class="layui-form-label">作案手法：</label>
								   		<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value=""></option>
									          <option value="1">A</option>
									          <option value="2">B</option>								         
									        </select>
									    </div>
									    <label class="layui-form-label">原始复选框</label>
									    <div class="layui-input-inline" style="width:360px;">
									      <input type="checkbox" name="like1[write]" lay-skin="primary" title="一类盗窃" checked="">
									      <input type="checkbox" name="like1[read]" lay-skin="primary" title="二类盗窃" checked="">
									      <input type="checkbox" name="like1[write]" lay-skin="primary" title="咋骗" checked="">
									      <input type="checkbox" name="like1[read]" lay-skin="primary" title="其他" >
									    </div>
									    <div class="layui-input-inline" style="width:210px;">
									      <button class="layui-btn layui-btn-primary layui-btn-xs">查询</button>
									      <button class="layui-btn layui-btn-primary layui-btn-xs">清空</button>
										</div>	
									</div>	
									<div class="layui-form-item">
										<div class="layui-input-inline" style="width: 65%; padding-left: 60px;">
											<ul>
												<li><span style="color:#fe0000">请在回访前先学习回访规范，避免无效工作</span></li>
												<li><span style="color:#73b9ea">请注意，列表显示案件已调整为回访工作规范要求第1、2、3、类案件,都必须回访,更改报警时间即可查询历史案件进行回访。</span></li>
												<li><span style="color:#73b9ea">业务咨询、申诉：指挥中心派出所工作指导处2262503</span></li>
											</ul>
										</div>
										 <button class="layui-btn layui-btn-primary layui-btn-xs">查询所有警情</button>								
									</div>																		
								</form>								
								</div>
								<div id="right_all_caseList_two">
									<table class="layui-hide" id="demo"></table>
								</div>
							</div>
							<div id="buttom_backList" style="display:none;">
								<div id="right_all_backList_one" style="height:213px;width:100%;">
								<form class="layui-form" action="" lay-filter="example">
									<div class="layui-form-item">
	  									<label class="layui-form-label">警情号：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	<label class="layui-form-label">案件类别：</label>
									    <div class="layui-input-inline">
									        <select name="modules1" lay-verify="required" lay-search="">
									          <option value="">请选择案件类别</option>
									          <option value="1">layer</option>
									          <option value="2">form</option>								         
									        </select>
									    </div>
									    <label class="layui-form-label">报警时间：</label>
									    <div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test5"
											placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label" style="width: 10px; padding-left: 0;">-</label>
										<div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="test6"
												placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label">回访方式：</label>
										<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">选择全部</option>
									          <option value="1">上门回访</option>
									          <option value="2">电话回访</option>
									          <option value="3">短信回访</option>
									          <option value="4">信函回访</option>
									          <option value="5">邮件回访</option>
									          <option value="6">未上门回访</option>								         
									        </select>
									    </div>
									</div>	
									<div class="layui-form-item">
										<label class="layui-form-label">单位：</label>
								   		<div class="layui-input-inline">
								      		<input id="showTree" onclick="showTreemMean(this,this.id)" type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	<label class="layui-form-label">回访民警：</label>
								   		<div class="layui-input-inline">
								      		<input type="text" name="username" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
								    	</div>
								    	 <label class="layui-form-label">回访时间：</label>
									    <div class="layui-input-inline" style="width: 120px;">
										<input type="text" class="layui-input" id="test7"
											placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label" style="width: 10px; padding-left: 0;">-</label>
										<div class="layui-input-inline" style="width: 120px;">
											<input type="text" class="layui-input" id="test8"
												placeholder="yyyy-MM-dd">
										</div>
										<label class="layui-form-label">有无图片：</label>
										<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">选择全部</option>
									          <option value="1">有图片</option>
									          <option value="2">无图片</option>								         
									        </select>
									    </div>
									</div>	
									<div class="layui-form-item">
										<label class="layui-form-label">抽查结果：</label>
										<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">选择全部</option>
									          <option value="1">有抽查，全部</option>
									          <option value="2">有回访</option>
									          <option value="1">未回访</option>
									          <option value="2">非事主不明情况</option>
									          <option value="1">联系不上事主</option>
									          <option value="2">无抽查</option>								         
									        </select>
									    </div>	
										<label class="layui-form-label">作案手法：</label>
								   		<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value=""></option>
									          <option value="1">A</option>
									          <option value="2">B</option>								         
									        </select>
									    </div>
									    <label class="layui-form-label">原始复选框</label>
									    <div class="layui-input-inline" style="width:360px;">
									      <input type="checkbox" name="like1[write]" lay-skin="primary" title="一类盗窃" checked="">
									      <input type="checkbox" name="like1[read]" lay-skin="primary" title="二类盗窃" checked="">
									      <input type="checkbox" name="like1[write]" lay-skin="primary" title="咋骗" checked="">
									      <input type="checkbox" name="like1[read]" lay-skin="primary" title="其他" >
									    </div>
									    <div class="layui-input-inline" style="width:210px;">
									      <button class="layui-btn layui-btn-primary layui-btn-xs">查询</button>
									      <button class="layui-btn layui-btn-primary layui-btn-xs">清空</button>
										</div>	
									</div>	
									<div class="layui-form-item">
											<label class="layui-form-label">回访来源：</label>
								   		<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">选择全部</option>
									          <option value="1">网页</option>
									          <option value="2">移动终端</option>								         
									        </select>
									    </div>
									    <label class="layui-form-label">回访时差：</label>
								   		<div class="layui-input-inline">
									        <select name="modules2" lay-verify="required" lay-search="">
									          <option value="">选择全部</option>
									          <option value="1">单位发生变化</option>
									          <option value="2">未按时回访</option>
									          <option value="3">1天</option>
									          <option value="4">2天</option>								         
									        </select>
									    </div>
										 <button class="layui-btn layui-btn-primary layui-btn-xs">导出结果</button>								
									</div>																		
								</form>								
								</div>
								<div id="right_all_backList_two">
									<table class="layui-hide" id="demo_backlist"></table>
								</div>
							</div>
							<div id="buttom_backMessage"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="textTree" style="position: absolute; overflow:auto;border:solid 1px #ccc; background-color:#fff; height:200px;">
		<ul id="tree" class="ztree"></ul>
	</div>	
	</div>
</body>
<script>
layui.use('table', function(){
	  var table = layui.table;
	  //展示已知数据
	  table.render({
	    elem: '#demo'
	    ,cols: [[ //标题栏
	      {field: 'csum', title: '回访次数',  sort: true}
	      ,{field: 'gsum', title: '抽查次数' }
	      ,{field: 'id', title: '报警号' }
	      ,{field: 'time', title: '报警时间'}
	      ,{field: 'type', title: '案件类别'}
	      ,{field: 'people', title: '报警人'}
	      ,{field: 'callphnoe', title: '报警电话',sort: true}
	      ,{field: 'selephnoe', title: '联系电话',sort: true}
	      ,{field: 'tel', title: '报警地址'}
	      ,{field: 'dw', title: '单位'}
	      ,{field: 'creattime', title: '生成时间', sort: true}
	    ]]
	    ,data: [{
	      "csum": "10"
	      ,"gsum": "11"
	      ,"id": "35222519995455221"
	      ,"time": "2018/08/28 15:22"
	      ,"type": "盗窃"
	      ,"people": "小王"
	      ,"callphnoe": "12345678911"
	      ,"selephnoe": "12345678911"
	      ,"tel": "福建省厦门市思明区XXX"
	      ,"dw": "XXXX派出所"
	      ,"creattime": "2018/08/28 15:22"
	    },
	    {
		      "csum": "10"
		      ,"gsum": "11"
		      ,"id": "35222519995455221"
		      ,"time": "2018/08/28 15:22"
		      ,"type": "盗窃"
		      ,"people": "小王"
		      ,"callphnoe": "12345678911"
		      ,"selephnoe": "12345678911"
		      ,"tel": "福建省厦门市思明区XXX"
		      ,"dw": "XXXX派出所"
		      ,"creattime": "2018/08/28 15:22"
		    },
		    {
			      "csum": "10"
			      ,"gsum": "11"
			      ,"id": "35222519995455221"
			      ,"time": "2018/08/28 15:22"
			      ,"type": "盗窃"
			      ,"people": "小王"
			      ,"callphnoe": "12345678911"
			      ,"selephnoe": "12345678911"
			      ,"tel": "福建省厦门市思明区XXX"
			      ,"dw": "XXXX派出所"
			      ,"creattime": "2018/08/28 15:22"
			    },
			    {
				      "csum": "10"
				      ,"gsum": "11"
				      ,"id": "35222519995455221"
				      ,"time": "2018/08/28 15:22"
				      ,"type": "盗窃"
				      ,"people": "小王"
				      ,"callphnoe": "12345678911"
				      ,"selephnoe": "12345678911"
				      ,"tel": "福建省厦门市思明区XXX"
				      ,"dw": "XXXX派出所"
				      ,"creattime": "2018/08/28 15:22"
				    },
				    {
					      "csum": "10"
					      ,"gsum": "11"
					      ,"id": "35222519995455221"
					      ,"time": "2018/08/28 15:22"
					      ,"type": "盗窃"
					      ,"people": "小王"
					      ,"callphnoe": "12345678911"
					      ,"selephnoe": "12345678911"
					      ,"tel": "福建省厦门市思明区XXX"
					      ,"dw": "XXXX派出所"
					      ,"creattime": "2018/08/28 15:22"
					    },
					    {
						      "csum": "10"
						      ,"gsum": "11"
						      ,"id": "35222519995455221"
						      ,"time": "2018/08/28 15:22"
						      ,"type": "盗窃"
						      ,"people": "小王"
						      ,"callphnoe": "12345678911"
						      ,"selephnoe": "12345678911"
						      ,"tel": "福建省厦门市思明区XXX"
						      ,"dw": "XXXX派出所"
						      ,"creattime": "2018/08/28 15:22"
						    },
						    {
							      "csum": "10"
							      ,"gsum": "11"
							      ,"id": "35222519995455221"
							      ,"time": "2018/08/28 15:22"
							      ,"type": "盗窃"
							      ,"people": "小王"
							      ,"callphnoe": "12345678911"
							      ,"selephnoe": "12345678911"
							      ,"tel": "福建省厦门市思明区XXX"
							      ,"dw": "XXXX派出所"
							      ,"creattime": "2018/08/28 15:22"
							    },
							    {
								      "csum": "10"
								      ,"gsum": "11"
								      ,"id": "35222519995455221"
								      ,"time": "2018/08/28 15:22"
								      ,"type": "盗窃"
								      ,"people": "小王"
								      ,"callphnoe": "12345678911"
								      ,"selephnoe": "12345678911"
								      ,"tel": "福建省厦门市思明区XXX"
								      ,"dw": "XXXX派出所"
								      ,"creattime": "2018/08/28 15:22"
								    },
								    {
									      "csum": "10"
									      ,"gsum": "11"
									      ,"id": "35222519995455221"
									      ,"time": "2018/08/28 15:22"
									      ,"type": "盗窃"
									      ,"people": "小王"
									      ,"callphnoe": "12345678911"
									      ,"selephnoe": "12345678911"
									      ,"tel": "福建省厦门市思明区XXX"
									      ,"dw": "XXXX派出所"
									      ,"creattime": "2018/08/28 15:22"
									    },
									    {
										      "csum": "10"
										      ,"gsum": "11"
										      ,"id": "35222519995455221"
										      ,"time": "2018/08/28 15:22"
										      ,"type": "盗窃"
										      ,"people": "小王"
										      ,"callphnoe": "12345678911"
										      ,"selephnoe": "12345678911"
										      ,"tel": "福建省厦门市思明区XXX"
										      ,"dw": "XXXX派出所"
										      ,"creattime": "2018/08/28 15:22"
										    },
										    {
											      "csum": "10"
											      ,"gsum": "11"
											      ,"id": "35222519995455221"
											      ,"time": "2018/08/28 15:22"
											      ,"type": "盗窃"
											      ,"people": "小王"
											      ,"callphnoe": "12345678911"
											      ,"selephnoe": "12345678911"
											      ,"tel": "福建省厦门市思明区XXX"
											      ,"dw": "XXXX派出所"
											      ,"creattime": "2018/08/28 15:22"
											    },
											    {
												      "csum": "10"
												      ,"gsum": "11"
												      ,"id": "35222519995455221"
												      ,"time": "2018/08/28 15:22"
												      ,"type": "盗窃"
												      ,"people": "小王"
												      ,"callphnoe": "12345678911"
												      ,"selephnoe": "12345678911"
												      ,"tel": "福建省厦门市思明区XXX"
												      ,"dw": "XXXX派出所"
												      ,"creattime": "2018/08/28 15:22"
												    },
												    {
													      "csum": "10"
													      ,"gsum": "11"
													      ,"id": "35222519995455221"
													      ,"time": "2018/08/28 15:22"
													      ,"type": "盗窃"
													      ,"people": "小王"
													      ,"callphnoe": "12345678911"
													      ,"selephnoe": "12345678911"
													      ,"tel": "福建省厦门市思明区XXX"
													      ,"dw": "XXXX派出所"
													      ,"creattime": "2018/08/28 15:22"
													    },
													    {
														      "csum": "10"
														      ,"gsum": "11"
														      ,"id": "35222519995455221"
														      ,"time": "2018/08/28 15:22"
														      ,"type": "盗窃"
														      ,"people": "小王"
														      ,"callphnoe": "12345678911"
														      ,"selephnoe": "12345678911"
														      ,"tel": "福建省厦门市思明区XXX"
														      ,"dw": "XXXX派出所"
														      ,"creattime": "2018/08/28 15:22"
														    },
														    {
															      "csum": "10"
															      ,"gsum": "11"
															      ,"id": "35222519995455221"
															      ,"time": "2018/08/28 15:22"
															      ,"type": "盗窃"
															      ,"people": "小王"
															      ,"callphnoe": "12345678911"
															      ,"selephnoe": "12345678911"
															      ,"tel": "福建省厦门市思明区XXX"
															      ,"dw": "XXXX派出所"
															      ,"creattime": "2018/08/28 15:22"
															    },
															    {
																      "csum": "10"
																      ,"gsum": "11"
																      ,"id": "35222519995455221"
																      ,"time": "2018/08/28 15:22"
																      ,"type": "盗窃"
																      ,"people": "小王"
																      ,"callphnoe": "12345678911"
																      ,"selephnoe": "12345678911"
																      ,"tel": "福建省厦门市思明区XXX"
																      ,"dw": "XXXX派出所"
																      ,"creattime": "2018/08/28 15:22"
																    },
																    ]
	    //,skin: 'line' //表格风格
	    ,even: true
	    ,page: true //是否显示分页
	    //,limits: [5, 7, 10]
	    ,limit: 10 //每页默认显示的数量
	  });
	  ChangeTableHeight();
	});
</script>
<script type="text/javascript">
	layui
			.use(
					[ 'form', 'layedit', 'laydate' ],
					function() {
						var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
						//自定义颜色
						laydate.render({
							elem : '#test1',
							theme : '#4472ca',
							type: 'datetime',
							format: 'yyyy/MM/dd HH:mm'
						});//自定义颜色
						laydate.render({
							elem : '#test2',
							theme : '#4472ca',
							type: 'datetime'
						});
						//自定义颜色
						laydate.render({
							elem : '#test3',
							theme : '#4472ca',
							type: 'datetime'
						});//自定义颜色
						laydate.render({
							elem : '#test4',
							theme : '#4472ca',
							type: 'datetime'
						});
						//自定义颜色
						laydate.render({
							elem : '#test5',
							theme : '#4472ca',
							type: 'datetime'
						});//自定义颜色
						laydate.render({
							elem : '#test6',
							theme : '#4472ca',
							type: 'datetime'
						});
						//自定义颜色
						laydate.render({
							elem : '#test7',
							theme : '#4472ca',
							type: 'datetime'
						});//自定义颜色
						laydate.render({
							elem : '#test8',
							theme : '#4472ca',
							type: 'datetime'
						});
					});

	$(function() {
		var height = $(window).height();
		var width = $(window).width() - 300;
		var mainBody = document.getElementById("mainBody");
		var content = document.getElementsByClassName("layui-tab-content");
		mainBody.style.height = height * 0.85 + "px";
		mainBody.style.width = width + "px";
		for (var i = 0; i < content.length; i++) {
			content[i].style.height = (height * 0.8 - 30) + "px";
		}
	});	
</script>
<script>
//改变列表显示内容
function changeList(id_value){
	//buttom_backList,
	var objcaselist = document.getElementById('buttom_caseList');
	objcaselist.style.display="none";
	var objbacklist = document.getElementById('buttom_backList');
	objbacklist.style.display="none";
	var obj = document.getElementById(id_value);
	obj.style.display ="block";
	
}
</script>
<script>
function showTreemMean(obj,Id){
	var cityObj = $("#" + Id);
    var cityOffset = $("#" + Id).offset();
    var leftv = cityOffset.left;
    var topv = cityOffset.top;
    var oh = cityObj.outerHeight();
   $('#textTree').css({ left: leftv + "px", top: topv + oh + "px" }).slideDown("fast");;
   $("body").bind("mousedown", onBodyDown);
   gTargetId = Id;
}
function onBodyDown(event) {
	 var str = event.target.id.substring(0,4);
	 if(str =="tree"&&!(event.target.id.indexOf("span")>-1)){
		return;
	 }else{
	    hideMenu();
	 } 
   }

function hideMenu() {
	 $('#textTree').fadeOut("fast");
      $("body").unbind("mousedown", onBodyDown);
  }

function changeStation(treeNode){
	 var selectv = document.getElementById('showTree');
	 selectv.value=treeNode.name;
}
</script>
<script>
//调整内容表格的最大高度
function ChangeTableHeight(){
	var h= document.documentElement.clientHeight || document.body.clientHeight;	 
	var bdr = document.getElementById('mainBody');
	var bdrh = bdr.offsetTop;
	var htwo = document.getElementById('right_all_caseList_two');
	var ht = htwo.offsetTop;
	var tb=document.getElementsByClassName("layui-table-main");
	if(tb!=null){	
		for(var i=0;i<tb.length;i++){				
			if(tb[i].offsetTop!=0 && h!=(tb[i].offsetHeight+tb[i].offsetTop+30)){
				var offset=h-bdrh-ht-140;
				if(offset>0){
					tb[i].style.height=offset+'px';						
				}		
			}	
		}
	}
}
</script>
</html>
