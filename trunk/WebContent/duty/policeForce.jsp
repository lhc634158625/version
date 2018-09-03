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
<style type="text/css">
/*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
::-webkit-scrollbar {
	width: 16px;
	height: 16px;
	background-color: #F5F5F5;
}

/*定义滚动条轨道 内阴影+圆角*/
::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}

/*定义滑块 内阴影+圆角*/
::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #92b4f4;
}
</style>
</head>
<body class="layui-layout-body" onclick="showMessageMean(this)">
	<div class="layui-layout layui-layout-admin">


		<%@ include file="../shared/pageHeader1.jsp"%>
		<jsp:include page="../shared/policeForceMenu.jsp" flush="true">
			<jsp:param name="multi" value="1" />
		</jsp:include>
		<div id="mianBody">
			<div class="layui-row" style="margin-top: 20px; height: 60%;">
				<div class="layui-col-md3" style="float: right;z-index: 6;width: 400px;margin-right: 80px;">
					<div class="top">
						<ul class="top_2" id="top_2">
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m1" src="../images/m1.png" onmouseover="_show(1)"
								onmouseout="_hidden(1)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -120px; background: white; border-radius: 5px;">
									<li>
										<div
											style="width: 240px; height: auto; border: 1px solid #ccc; border-radius: 5px; background: white; padding: 10px; text-align: center;">
											<form class="layui-form" action=""
												style="width: 240px; height: auto; margin: 0 auto;">
												<div class="layui-form-item">
													<div class="layui-input-inline" style="width: 240px;">
														<input
															style="border: none; border-bottom: 1px #ccc solid; position: absolute;"
															type="text" name="search" maxlength="8"
															lay-verify="title" autocomplete="off" placeholder="搜索"
															class="layui-input">
														<button class="layui-btn layui-btn-primary"
															style="position: relative; float: right; border: none; border-bottom: 1px solid #ccc; width: 50px;">
															<img style="width: 40px; height: 40px;"
																src="../images/search.png">
														</button>
													</div>
												</div>
												<div class="layui-form-item" pane=""
													style="width: 225px; margin: 5px auto;">
													<div class="layui-input-inline" style="width: 225px;">
														<input type="checkbox" name="like1[write]"
															lay-skin="primary" title="警员"> <input
															type="checkbox" name="like1[write]" lay-skin="primary"
															title="车载"> <input type="checkbox"
															name="like1[write]" lay-skin="primary" title="警情">
													</div>
												</div>
												<div class="layui-form-item" pane=""
													style="height: 200px; overflow-y: scroll; overflow-x: hidden; background: #eee; border-radius: 5px; padding-left: 10px;">
													<div class="layui-input-inline"
														style="width: 200px; text-align: left;">
														<input style="float: left;" type="checkbox"
															name="like1[write]" lay-skin="primary" title="警员">
													</div>
													<div class="layui-input-inline"
														style="width: 200px; text-align: left;">
														<input style="float: left;" type="checkbox"
															name="like1[write]" lay-skin="primary" title="警员">
													</div>
													<div class="layui-input-inline"
														style="width: 200px; text-align: left;">
														<input style="float: left;" type="checkbox"
															name="like1[write]" lay-skin="primary" title="警员">
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m2" src="../images/m2.png" onmouseover="_show(2)"
								onmouseout="_hidden(2)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -165px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														视频设备</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="执勤人员">
																<ul style="width: auto;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 390px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="120接处警">
																			<ul style="width: 390px;">
																				<li>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="一警">
																					</div>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="二警">
																					</div>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="三警">
																					</div>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="社区">
																					</div>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="机动勤务">
																					</div>
																					<div class="layui-input-inline"
																						style="width: 120px; text-align: left;float: left;">
																						<input type="checkbox" name=""
																							lay-filter="" lay-skin="primary" title="交警">
																					</div>
																				</li>
																			</ul>
																		</div>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="135快反区">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="重点防务区">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="加密巡逻">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="站卡体系">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="社区联动">
																<ul style="width: auto;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="应急单位">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="救助单位">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="锁匠">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="自愿者">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="应急备勤">
																<ul style="width: auto;padding-left: 30px;">
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="应急屯兵">
																<ul style="width: auto;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="边防">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="海警">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="武警">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="消防">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="反恐处突">
																<ul style="width: auto;padding-left: 30px;">
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="封控圈">
																<ul style="width: auto;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="市际检查站">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 200px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="区际检查站">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 120px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="核心防务区">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="派驻所">
																<ul style="width: auto;padding-left: 30px;">
															</li>
														</ul>
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m3" src="../images/m3.png" onmouseover="_show(3)"
								onmouseout="_hidden(3)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -95px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														警用装备</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="巡逻车台">
																<ul style="width: 190px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="在线">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="离线">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="PDT">
																<ul style="width: 190px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="在线">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="离线">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="执法记录仪">
																<ul style="width: 190px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="在线">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="离线">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="警务通">
																<ul style="width: 190px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="在线">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 80px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="离线">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m4" src="../images/m4.png" onmouseover="_show(4)"
								onmouseout="_hidden(4)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -165px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														警用装备</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="必巡点">
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="武装巡逻">
																<ul style="width: 330px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 100px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="1分钟">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 100px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="3分钟">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 100px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="5分钟">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="盘查点">
																<ul style="width: 330px;padding-left: 30px;">
																	<li>
																		<div class="layui-input-inline"
																			style="width: 100px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="固定盘查">
																		</div>
																		<div class="layui-input-inline"
																			style="width: 100px; text-align: left;float: left;">
																			<input type="checkbox" name=""
																				lay-filter="" lay-skin="primary" title="固定盘查">
																		</div>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="围村围点">
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="长假排班">
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;border-bottom: 1px solid #ccc;padding-bottom: 5px">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="治安岗亭">
														</ul>
													</div>
													<div class="layui-input-inline"
														style="width: 100%; text-align: left; padding-left: 15px;">
														<ul>
															<li><input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="拦截圈">
														</ul>
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m5" src="../images/m5.png" onmouseover="_show(5)"
								onmouseout="_hidden(5)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -50px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														视频设备</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="高峰站点">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="alarmBox2" lay-skin="primary" title="卡口">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="高清球机">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="高清枪机">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="模拟球机">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="模拟枪机">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="alarmBox2" lay-skin="primary" title="高空枪机">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="涉爆视频">
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m6" src="../images/m6.png" onmouseover="_show(6)"
								onmouseout="_hidden(6)"></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m7" src="../images/m7.png" onmouseover="_show(7)"
								onmouseout="_hidden(7)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -50px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														最新警情</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="刑事案件">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="alarmBox2" lay-skin="primary" title="交通案件">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="治安案件">
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m8" src="../images/m8.png" onmouseover="_show(8)"
								onmouseout="_hidden(8)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -50px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														地图操作</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="DrawMap" lay-skin="primary" title="框选">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="alarmBox2" lay-skin="primary" title="清除">
													</div>
													<div class="layui-input-inline"
														style="width: 100px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name=""
															lay-filter="" lay-skin="primary" title="地图切换">
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
							<li class="top_2_li" onclick="showMessageMean(this)"><img
								id="m9" src="../images/m9.png" onmouseover="_show(9)"
								onmouseout="_hidden(9)">
								<ul
									style="display: none; position: absolute; top: 45px; right: -75px; background: white; border-radius: 5px;">
									<li>
										<div style="width: auto; height: auto;">
											<form class="layui-form" action="">
												<div class="layui-form-item" pane="">
													<div class="layui-inline"
														style="color: #666; border-bottom: 1px solid #ccc; height: 40px; line-height: 40px; text-align: center; width: 100%;">
														窗口操作</div>
													<div class="layui-input-inline" id="alarmBox1"
														style="width: 150px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name="alarmBox1"
															lay-filter="alarmBox1" lay-skin="primary" title="警情统计框"
															onclick="_open(1)">
													</div>
													<div class="layui-input-inline" id="alarmBox2"
														style="width: 150px; text-align: left; padding-left: 1em;">
														<input type="checkbox" name="alarmBox2"
															lay-filter="alarmBox2" lay-skin="primary" title="警情态势统计框"
															onclick="_open(2)">
													</div>
												</div>
											</form>
										</div>
									</li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="layui-row" style="height: 40%;">
				<div class="layui-col-md5" style="float: right;height: 100%;margin-right: 10px;">
					<div class="left_bottom" id="left_bottom" style="display: none;">
						<div class="left_bottom_1">
							<ul>
								<li>警情态势</li>
								<li>警力布防</li>
								<li>警情</li>
								<li>警力装备</li>
								<li onclick="_close(1)">x</li>
							</ul>
							<div>
								<table	class="layui-table">
									<thead>
										<tr>
											<td colspan="11">厦门公安局</td>
										</tr>
										<tr>
											<td>10:04:23</td>
											<td>派出所</td>
											<td>警务区</td>
											<td>警力</td>
											<td>在岗</td>
											<td>备勤</td>
											<td>单兵设备</td>
											<td>巡逻车</td>
											<td>24H接处警</td>
											<td>110</td>
											<td>自接</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>合计</td>
											<td>57</td>
											<td>102</td>
											<td>11</td>
											<td>11</td>
											<td>11</td>
											<td>11</td>
											<td>11</td>
											<td>11</td>
											<td>15</td>
											<td>5</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-col-md4" style="float: right;height: 100%;margin-right: 10px;">
					<div class="right_bottom" id="right_bottom" style="display: none;">
						<div class="right_bottom_1">
							<ul>
								<li>刑警警情</li>
								<li>两抢</li>
								<li>拎盗扒</li>
								<li>盗窃两车</li>
								<li>电信网络诈骗</li>
								<li onclick="_close(2)">x</li>
							</ul>
							<div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="mapDiv"></div>
		</div>
	</div>
</body>

<script src="../layui/layui.js"></script>
<script src="../js/pgis/mypgis.js"></script>
<script src="../js/pgis/EzMapAPI.js"></script>
<script src="../js/pgis/EzServerClient.min.js"></script>
<script>
	var map;

	$(function() {
		var mianBody = $(window).height() - 110;
		$("#mianBody").css("height", mianBody + "px");
		$("#mapDiv").css("height", mianBody + "px");
		map = PGISHelper.Init("mapDiv");
	});
	
	layui.use([ 'form', 'layedit', 'laydate','element' ],function() {
		var form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
		var $ = layui.jquery,element = layui.element; 
		form.on('checkbox(alarmBox2)', function() {
			var left_bottom = document.getElementById("left_bottom");
			var display = left_bottom.style.display;
			if(display=="none"){
				left_bottom.style.display="block";
			}else if(display=="block"){
				left_bottom.style.display="none";
			}
			return false;
		});
		form.on('checkbox(alarmBox1)', function() {
			var right_bottom = document.getElementById("right_bottom");
			var display = right_bottom.style.display;
			if(display=="none"){
				right_bottom.style.display="block";
			}else if(display=="block"){
				right_bottom.style.display="none";
			}
			return false;
		});
		form.on('checkbox(DrawMap)', function(data) {
			if(data.elem.checked){
				map.Map.changeDragMode('drawRect', drawRectT);
			}else{
				map.Map.clearDragMode();
			}
		});
	});
	function _show(n) {
		var a = document.getElementById("m" + n);
		var b = a.src = "../images/m" + n + n + ".png";
	}
	function _hidden(m) {
		var a = document.getElementById("m" + m);
		var b = a.src = "../images/m" + m + ".png";
	}

	function _close(k) {
		if (k == 2) {
			$("#alarmBox1").find('div.layui-unselect').click();
		} else if (k == 1) {
			$("#alarmBox2").find('div.layui-unselect').click();
		}
	}
</script>
<script>
	function showMessageMean(obj) {
		var sub1 = $("#top_2").children();
		for (var i = 0; i < sub1.length; i++) {
			var img = sub1[i].firstChild;
			if (img.localName == "img") {
				var num = img.id.replace("m", "");
				img.src = "../images/m" + num + ".png";
				img.setAttribute("onmouseover", "_show(" + num + ")");
				img.setAttribute("onmouseout", "_hidden(" + num + ")");
			}
			var ul = sub1[i].lastChild;
			if (ul.localName == "ul") {
				ul.style.display = "none";
			}
		}
		var sub2 = $(obj).children();
		for (var i = 0; i < sub2.length; i++) {
			if (sub2[i].localName == "img") {
				var num = sub2[i].id.replace("m", "");
				sub2[i].src = "../images/m" + num + num + ".png";
				sub2[i].removeAttribute("onmouseover");
				sub2[i].removeAttribute("onmouseout");
			}
			if (sub2[i].localName == "ul") {
				sub2[i].style.display = "block";
			}
		}
		cancelBubble();
	}

	// 阻止外层onclick发生
	function cancelBubble(e) {
		var evt = e ? e : window.event;
		if (evt.stopPropagation) { //W3C 
			evt.stopPropagation();
		} else { //IE      
			evt.cancelBubble = true;
		}
	}
</script>
</html>
