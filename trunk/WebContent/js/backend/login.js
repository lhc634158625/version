if (self != top) {
    top.location = self.location;
}
function login() {

    if ($("#txtUserName").val() == "") {
        $("#lblError").html("请输入用户名");
        $(".alert").show();
        document.getElementById("txtUserName").focus();
        return;
    }
    if ($("#txtPassword").val() == "") {
        $("#lblError").html("密码不能为空！");
        $(".alert").show();
        document.getElementById("txtPassword").focus();
        return;
    }
  
    var param = new Object();
    param.nickName = $("#txtUserName").val();
    param.password = $("#txtPassword").val();
   
    PostData("sysService/checkUser", param,function (result) {     
        if (result.code== 0) {           
            window.localStorage.setItem("UserName", document.getElementById("txtUserName").value);
            localStorage.setItem("LoginUser", result.data);
            $(".alert").hide();
            self.location = "index.html";
        }
        else {
            $("#lblError").html(result.message);
            $(".alert").show();            
        }
    });
}
$(document).ready(function () {
    if (document.getElementById("txtUserName") != null) {
        document.getElementById("txtUserName").focus();
    }
    $("#txtUserName").val(window.localStorage.UserName);   
});
var _serviceUrl="http://localhost:8080/DutyService/rest/";
function PostData(method, data, callback) {   
    var datajson = JSON.stringify(data);
    $(".Mask").show();
    var url = _serviceUrl + method ;
    $.ajax({
        cache: false,
        type: "POST",
        async: true,     
        url: url,
        data: datajson, // JSON.stringify(obj),
        contentType: "application/json",
        dataType: "json",
        success: function (result) {           
            if (result.code != 0) {
                alert(result.message);
                return;
            }
            callback(result);
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
