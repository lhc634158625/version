function AfterInitial() {
    layui.use(['form',  'layer',  'upload'], function () {
        form = layui.form()      
        , layer = layui.layer     
        layui.upload({
            url: 'http://localhost:11612/DataHandler.ashx?CompanyId=' + _LoginUser.CompanyId //�ϴ��ӿ�
                    , before: function (input) {
                        var formData = new FormData();
                        formData.append("FileData", $("#FileData")[0].files[0]);
                        formData.append("Name", name);
                        //���صĲ���item����Ϊ��ǰ��input DOM����
                        $.ajax({
                            url: 'http://localhost:11612/DataHandler.ashx?CompanyId=' + _LoginUser.CompanyId,
                            type: 'POST',
                            data: formData,
                            // ����jQuery��Ҫȥ�����͵�����
                            processData: false,
                            // ����jQuery��Ҫȥ����Content-Type����ͷ
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
        , success: function (res) { //�ϴ��ɹ���Ļص�
            alert(res);
        }
        });
            $("#btnOk").click(function (e) {
                
        });
    });
   /* $("#btnOk").click(function (e) {
        if ($("#FileData")[0].files.length == 0) {
            alert("��ѡ���ļ�");
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
            // ����jQuery��Ҫȥ�����͵�����
            processData: false,
            // ����jQuery��Ҫȥ����Content-Type����ͷ
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
* �� file ���ȡ ����ͼƬ url 
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
* ������ͼƬ ��ʾ��������� 
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
    //�ж��Ƿ���ͼƬ - strFilter������Сд�о�
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
