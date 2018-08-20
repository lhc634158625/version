<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html">
<html>
<head>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=9">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>登录</title>
<script src="../js/jquery/jquery.js"></script>
<link rel="stylesheet" href="../css/login.css">

</head>
<body>
	<div class="loginbody">
		<form action="" method="post" id="myForm">
			<div class="texts">
				<input type="text" id="account" class="form-control"
					placeholder="请输入用户名" /> <img alt="" src="../images/account.png">
			</div>
			<div class="texts" style="margin-top: 5%;">
				<input type="password" id="password"
					class="form-control" placeholder="请输入密码"> <img alt=""
					src="../images/password.png">
			</div>
			<div style="margin-top: 5%;">
				<input type="button"
					value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录"
					onclick="login()" class="loginbtn">
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	function login() {
		var request={}
		request.nickName=document.getElementById("account").value;
		request.password=document.getElementById("password").value;
		PostData("sys/user/login",request,function(result){
			userInfo=result.data;
			alert(result.data.nickName);
		});
	}
	document.onkeydown = function(event) {
		e = event ? event : (window.event ? window.event : null);
		if (e.keyCode == 13) {
			//执行的方法 
			login();
		}
	}
	var _serviceUrl="http://218.85.92.186:8081/api/";
	function PostData(method, data, callback) {   
	    var datajson = JSON.stringify(data);
	    $(".Mask").show();
	    var url = _serviceUrl + method ;
	    $.ajax({
	        cache: false,
	        type: "POST",
	        async: true,
	        headers: {'token': 'abcd1234',"userId":"1"},
	        url: url,
	        data: datajson, // JSON.stringify(obj),
	        contentType: "application/json",
	        dataType: "json",
	        success: function (result) {
	        	if(window.sessionStorage){	
	        		sessionStorage.setItem("result",JSON.stringify(result.data));
	        		//var text = sessionStorage.getItem("result");
	        		//var dataObj =eval("("+text+")");
	        		//alert(dataObj);
	        		}else{
	        		alert('This browser does NOT support localStorage');
	        		}
	            if (result.code != 0) {
	                alert(result.message);
	                return;
	            }
	            window.location.href = "${pageContext.request.contextPath}/duty/policeForce.jsp";
	        },
	        error: function (xhr) {
	            $(".Mask").hide();
	            /* if (xhr.status == 401) {
	                top.window.location.href = "/backend/login.html?Logout=1";
	            }
	            else
	                console.log(xhr.statusText); */
	            //alert(xhr.statusText);
	        }
	    });
	}
</script>
<script src="<c:url value='/layui/layui.js'/>"></script>
</html>