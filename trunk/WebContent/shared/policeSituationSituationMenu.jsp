<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
<!--
ul li{
margin-top: 5px;
}
.first ul li{
list-style-image: url("../images/open.png");
}
.first{
list-style-image: none;
}
.first ul li a{
position: relative;
top: -4px;
color: white;
}
.menu_top{
	width: 100%;
	height: 5%;
	text-align: center;
	margin-top: 6%;
	margin:6%;
	color: white;
	border-bottom: #ccc 2px solid;
}
.button {
	position:absolute;
	left:40px; 
	top:220px;
    background-color: #33D1FF; /* Green */
    border: none;
    color: white;
    padding: 7px 30px;
    font-size: 10px;
    border-radius: 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
}
.common{
	color:white;
	line-height: 25px;
}
a{color:#ffffff}
a:hover{color:#01AAED} 


.color{
	color:#01AAED
}

-->
</style>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		
	    <div class="layui-side" style="background: #0f1b33">
	    
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <div class="menu_top">警情态势</div>
             
             <div id="filter">
             
		     <div id="案件类型">  
            <span class="common">案件类型：</span>  
            	<span class="common"><a href="#" onclick="aClick(event)">求助</a></span>  
       		 </div>
       		 
 			<div id="区域">
		     	<span class="common">区域：</span>  
            	<span class="common"><a href="#" onclick="aClick(event)">鼓浪屿</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">中华</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">滨海</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">梧村</a></span>
		     	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		     	<span class="common"><a href="#" onclick="aClick(event)">鼓浪屿</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">中华</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">滨海</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">梧村</a></span>
		     	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		     	<span class="common"><a href="#" onclick="aClick(event)">鼓浪屿</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">中华</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">滨海</a></span>
            	<span class="common"><a href="#" onclick="aClick(event)">梧村</a></span>
		     </div>
	        
	        <div id="时间">
		          <span class="common">时间：</span>
		          <span class="common"><a href="#" onclick="aClick(event)">今日</a></span>
            	  <span class="common"><a href="#" onclick="aClick(event)">昨天</a></span>
            	  <span class="common"><a href="#" onclick="aClick(event)">本周</a></span>
            	  <span class="common"><a href="#" onclick="aClick(event)">上周</a></span>
		     	  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		     	  <span class="common"><a href="#" onclick="aClick(event)">上月</a></span>
            	  <span class="common"><a href="#" onclick="aClick(event)">自定义</a></span>
		     </div>
		        <div class="button" id="btn" onclick="showtext();">开始查询</div>
		        
		        	<textarea id="text" style="width:190px; height:400px; line-height:20px;background:none; border:0px; boder-style:none; margin-top:50px;color:white" readOnly="true" >
		        	</textarea>
		         </div> 
		         </div>
	</section>
	<!-- /.sidebar -->
</aside>


<script src="../layui/layui.js"></script>
<script src="../js/mypgis.js"></script>
<script>

//a标签的单击事件，改变背景颜色  
function aClick(event)  
{         
    var tag = event.srcElement || event.target;//找到单击被点击的元素  
    var father = tag.parentNode;//找到最近的一个div标签  
    while(father.nodeName != "DIV")//如果tag的父级标签不是div标签则继续往上找  
    {  
        father = father.parentNode;  
    }  
    var fatherID = father.id;//找到tag标签最近一个父级div标签的id          
      
    //将fatherID该div对象下面的所有a标签，将各个a标签的className属性清空  
    for(var i = 0; i < document.getElementById(fatherID).getElementsByTagName("a").length;i++)  
    {  
        document.getElementById(fatherID).getElementsByTagName("a")[i].className = "";  
    }  
      
    //为事件源tag对象添加className样式  
    tag.className = 'color';   	
} 

function fe()  
{  
    var result = "";//记录返回的条件  
    var root = document.getElementById("filter").getElementsByTagName("a");//获取id为filter标签下面的所有a标签  
    for(var i = 0; i < root.length;i++)  
    {  
        if(root[i].className == 'color' )  
        {  
        	if(root[i].parentNode.parentNode.id=="案件类型")
        	{
        		result +="    类型: "+root[i].innerHTML+'\n';
        	}
        	if(root[i].parentNode.parentNode.id=="区域")
    		{
    			result +="    区域: "+root[i].innerHTML+'\n';
    		}
        	if(root[i].parentNode.parentNode.id=="时间")
    		{
    			result +="    时间: "+root[i].innerHTML;
    		}
        }  
    }  
    return result;  
} 
function showtext()
{
	document.getElementById("text").innerHTML=fe();
}
</script>

