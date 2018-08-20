function AfterInitial() {
    layui.use(['form',  'layer',  'upload'], function () {
        form = layui.form()      
        , layer = layui.layer     
        layui.upload({
            url: 'http://localhost:11612/DataHandler.ashx?CompanyId=' + _LoginUser.CompanyId //上传接口
                    , before: function (input) {
                        var formData = new FormData();
                        formData.append("FileData", $("#FileData")[0].files[0]);
                        formData.append("Name", name);
                        //返回的参数item，即为当前的input DOM对象
                        $.ajax({
                            url: 'http://localhost:11612/DataHandler.ashx?CompanyId=' + _LoginUser.CompanyId,
                            type: 'POST',
                            data: formData,
                            // 告诉jQuery不要去处理发送的数据
                            processData: false,
                            // 告诉jQuery不要去设置Content-Type请求头
                            contentType: false,
                            beforeSend: function () {
                                $("#divMask").show();
                            },
                            success: function (respStr) {
                                alert(res);

                            },
                            error: function (responseStr, err) {
                                alert(responseStr);
                            }
                        });
                    }
        , success: function (res) { //上传成功后的回调
            alert(res);
        }
        });
            $("#btnOk").click(function (e) {
                
        });
    });
   /* $("#btnOk").click(function (e) {
        if ($("#FileData")[0].files.length == 0) {
            alert("请选择文件");
            return;
        }
        var formData = new FormData();
        var name = $("#txtName").val();
        var _url = "/DataHandler.ashx?OwnerId=" + request("OwnerId") + "&OwnerType=" + request("OwnerType");
        //_url = "http://sr.esaling.cn/DataHandler.ashx?OwnerId=1081&OwnerType=UserInfo&Type=Image";
        //_url = "http://localhost:50328/DataHandler.ashx?OwnerId=1081&OwnerType=UserInfo&Type=Image";
        
        formData.append("FileData", $("#FileData")[0].files[0]);
        formData.append("Name", name);
        $.ajax({
            url: _url,
            type: 'POST',
            data: formData,
            // 告诉jQuery不要去处理发送的数据
            processData: false,
            // 告诉jQuery不要去设置Content-Type请求头
            contentType: false,
            beforeSend: function () {
                $("#divMask").show();
            },
            success: function (respStr) {
                if (respStr == "") return;
                var result = respStr;//JSON.parse(respStr);
                if (result.Code != 0)
                    alert(result.Message);
                if (result.Data.ContentType == "Image") {
                    document.getElementById("imgPreview").src = result.Data.AttachURL;
                }
                if (result.Data.ContentType == "Video") {
                    document.getElementById("imgPreview").src = result.Data.ThumbUrl;
                }
                $("#btnOk").hide();
                $("#divMask").hide();
                
                parent.afterUpload(result.Data);
                
            },
            error: function (responseStr,err) {
                alert(responseStr);
            }
        });
    });*/
   
}
/** 
* 从 file 域获取 本地图片 url 
*/
function getFileUrl(sourceId) {
    var url;
    if (navigator.userAgent.indexOf("MSIE") >= 1) { // IE 
        url = document.getElementById(sourceId).value;
    } else if (navigator.userAgent.indexOf("Firefox") > 0) { // Firefox 
        url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
    } else if (navigator.userAgent.indexOf("Chrome") > 0) { // Chrome 
        url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
    }
    return url;
}

/** 
* 将本地图片 显示到浏览器上 
*/
function preImg(sourceId, targetId) {
    var url = getFileUrl(sourceId);
    $("#btnOk").show();
    if (url.IsPicture) {
        var imgPre = document.getElementById(targetId);
        imgPre.src = url;
    }
}
String.prototype.IsPicture = function () {
    //判断是否是图片 - strFilter必须是小写列举
    var strFilter = ".jpeg|.gif|.jpg|.png|.bmp|.pic|"
    if (this.indexOf(".") > -1) {
        var p = this.lastIndexOf(".");
        //alert(p);
        //alert(this.length);
        var strPostfix = this.substring(p, this.length) + '|';
        strPostfix = strPostfix.toLowerCase();
        //alert(strPostfix);
        if (strFilter.indexOf(strPostfix) > -1) {
            //alert("True");
            return true;
        }
    }
    //alert('False');
    return false;
}
function Resize() {
    $(".Mask").height(_scrheight);
}
