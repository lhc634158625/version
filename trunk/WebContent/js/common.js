window['layer'] && layer.config({
    extend: ['skin/osa/style.css'], //加载新皮肤
    skin: 'layer-ext-osa' //一旦设定，所有弹层风格都采用此主题。
});
$(function () {
    $(document).on("click", function () {
        if (!$("#divPopMenu").is(":hidden")) {
            $("#divPopMenu").slideUp();
        }

        //if (!$(".MovePanel").is(":hidden")) {
        $(".MovePanel").hide();
        //  }
    });
});
String.prototype.replaceAll = function (s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2);
}
var browser = {
    versions: function () {
        var u = navigator.userAgent, app = navigator.appVersion;
        return { //移动终端浏览器版本信息
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
            iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        };
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
}
/*
 判断浏览器名称和版本
 目前只能判断:ie/firefox/chrome/opera/safari
 2012年5月16日23:47:08
 浏览器内核名称:NV.name;
 浏览器内核版本:NV.version;
 浏览器外壳名称:NV.shell;
 */
var NV = {};
var UA = navigator.userAgent.toLowerCase();
try { NV.name = !-[1, ] ? 'ie' : (UA.indexOf("firefox") > 0) ? 'firefox' : (UA.indexOf("chrome") > 0) ? 'chrome' : window.opera ? 'opera' : window.openDatabase ? 'safari' : 'unkonw'; } catch (e) { };
try { NV.version = (NV.name == 'ie') ? UA.match(/msie ([\d.]+)/)[1] : (NV.name == 'firefox') ? UA.match(/firefox\/([\d.]+)/)[1] : (NV.name == 'chrome') ? UA.match(/chrome\/([\d.]+)/)[1] : (NV.name == 'opera') ? UA.match(/opera.([\d.]+)/)[1] : (NV.name == 'safari') ? UA.match(/version\/([\d.]+)/)[1] : '0'; } catch (e) { };
try { NV.shell = (UA.indexOf('360ee') > -1) ? '360极速浏览器' : (UA.indexOf('360se') > -1) ? '360安全浏览器' : (UA.indexOf('se') > -1) ? '搜狗浏览器' : (UA.indexOf('aoyou') > -1) ? '遨游浏览器' : (UA.indexOf('theworld') > -1) ? '世界之窗浏览器' : (UA.indexOf('worldchrome') > -1) ? '世界之窗极速浏览器' : (UA.indexOf('greenbrowser') > -1) ? '绿色浏览器' : (UA.indexOf('qqbrowser') > -1) ? 'QQ浏览器' : (UA.indexOf('baidu') > -1) ? '百度浏览器' : (UA.indexOf('360se') > -1) ? '' : '未知或无壳'; } catch (e) { }
/*
    给火狐添加event属性。
    */
if (NV.name == 'firefox') {
    var $E = function () { var c = $E.caller; while (c.caller) c = c.caller; return c.arguments[0] };
    __defineGetter__("event", $E);
}
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
function request(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result ? decodeURIComponent(result[2]) : null;
}
function stringToTime(string) {
    var f = string.split(' ', 2);
    var d = (f[0] ? f[0] : '').split('-', 3);
    var t = (f[1] ? f[1] : '').split(':', 3);
    return (new Date(
    parseInt(d[0], 10) || null,
    (parseInt(d[1], 10) || 1) - 1,
    parseInt(d[2], 10) || null,
    parseInt(t[0], 10) || null,
    parseInt(t[1], 10) || null,
    parseInt(t[2], 10) || null
    )).getTime();
}
//日期比较，返回第一个日期减第二日期秒数
function dateDiff(date1, date2) {
    var type1 = typeof date1, type2 = typeof date2;
    if (type1 == 'string')
        date1 = stringToTime(date1);
    else if (date1.getTime)
        date1 = date1.getTime();
    if (type2 == 'string')
        date2 = stringToTime(date2);
    else if (date2.getTime)
        date2 = date2.getTime();
    //alert((date1 - date2) / (1000*60*60));
    return (date1 - date2) / (1000);
}
// 替换字符串 
function Replace(str, from, to) {
    return str.split(from).join(to);
}
GetFullValue = function (v) {

    if (v > 9) return v.toString();
    return "0" + v;
}
function FormatDate(date, str) {
    if (date == null) return "";

    if ((typeof date) == 'string') {
        if (date.indexOf("Date") > 0) //处理json日期
            date = new Date(parseInt(date.replace("/Date(", "").replace(")/", "").split("+")[0]));
        else
            date = new Date(date);
    }
    // try {
    str = Replace(str, "yyyy", date.getFullYear());
    str = Replace(str, "MM", GetFullValue(date.getMonth() + 1));
    str = Replace(str, "dd", GetFullValue(date.getDate()));
    str = Replace(str, "HH", GetFullValue(date.getHours()));
    str = Replace(str, "mm", GetFullValue(date.getMinutes()));
    str = Replace(str, "SS", GetFullValue(date.getSeconds()));

    return str;
}
var _scrheight;
var _width;
var _LoginUser;
$(document).ready(function () {
    _scrheight = document.documentElement.scrollHeight;
    _width = $("body").width();
    $(window).resize();

    try {
        BeforeInitial();
    }
    catch (e) {
    }
    // AfterInitial();
    SetUserProfile();
});
$(window).resize(function () {
    $(".Mask").css({ "height": document.documentElement.clientHeight + "px", "line-height": document.documentElement.clientHeight + "px" });
    $('.page').height($(window).height() - 65);
    $('.tabPage').height($(window).height() - 145);
    try {
        Resize();
    }
    catch (e) {
    }
});
$(document).on("click", function () {
    if (!$("#divPopMenu").is(":hidden")) {
        $("#divPopMenu").slideUp();
    }
    if (!$(".MovePanel").is(":hidden")) {
        $(".MovePanel").hide();
    }
});
function HaveModule(id) {
    if (_LoginUser == null) return false;
    for (var i = 0; i < _LoginUser.moduleIds.length; i++) {
        if (_LoginUser.moduleIds[i] == id) {
            return true;
        }
    }
    return false;
}
function SetUserProfile() {
    var station = new Object();
    station.name = "XX公安局";
    _LoginUser = new Object();
    _LoginUser.name = "管理员";
    _LoginUser.nickName = "Admin";
    _LoginUser.id = 1;
    _LoginUser.token = "997e2752-7453-4b7a-b2f9-1bf1a1ac7d4c";
    _LoginUser.stationId = 1;
    _LoginUser.roleId = 1;
    _LoginUser.station = station;
    _LoginUser.moduleIds = [1];
    _uploadUrl = "http://localhost:29271/DataHandler.ashx?UserId=" + _LoginUser.id + "&Token=" + _LoginUser.token + "&";
    AfterInitial();
    return;
    if (window.localStorage.getItem("LoginUser") == null) {
        self.location = "/backend/login.html"
        return;
    }
    _LoginUser = JSON.parse(window.localStorage.getItem("LoginUser"));

    ///todo 增加活动或最后请求时间

    if (_LoginUser.loginDt == null) {
        self.location = "/backend/login.html"
        return;
    }
    var now = new Date();
    if (dateDiff(now, _LoginUser.loginDt) > 30 * 60) {
        self.location = "/backend/login.html"
        return;
    }
    _LoginUser.loginDt = FormatDate(now, "yyyy-MM-dd HH:mm:SS");
    localStorage.setItem("LoginUser", JSON.stringify(_LoginUser));
    _uploadUrl = "http://localhost:29271/DataHandler.ashx?UserId=" + _LoginUser.id + "&Token=" + _LoginUser.token + "&";
    AfterInitial();
}
function AddFavorite() {
    var pos = self.location.href.lastIndexOf("/");
    var url = self.location.href.substr(pos + 1).replace("?", "ASK");
    QueryData("AddUserModule/" + _userInfo.Id + "/" + url + "/" + document.title, function () {
        ShowTip("添加收藏夹成功！");
    });
}
function ChangePage(url, target) {
    if (url.indexOf("ReturnUrl") < 0) {
        if (url.indexOf("?") < 0)
            url = url + "?ReturnUrl=" + encodeURIComponent(self.location);
        else
            url = url + "&ReturnUrl=" + encodeURIComponent(self.location);
    }
    if (target == null)
        self.location = url;
    else
        target.location = url;
}
function Return() {
    if (request("ReturnUrl") != null)
        document.location = decodeURIComponent(request("ReturnUrl"));
    else
        document.location = "/backend/index.html";
}
var _serviceUrl = "http://218.85.92.186:8081/api/";
var _uploadUrl = "";
var _EMPTYGUID = "00000000-0000-0000-0000-000000000000";

function PostData(method, data, callback,basync) {
    var station = new Object();
    var result = sessionStorage.getItem("result");
    var dataObj;
	if(result != null){
		dataObj =eval("("+result+")");
	};		
    var datajson = JSON.stringify(data);
    //var token = window.localStorage.getItem("token");
    //$(".Mask").show();
    var url = _serviceUrl + method ;
    var basynctemp=true;
    if(typeof basync!="undefined"){
    	basynctemp=basync;
    }
    	
    $.ajax({
        cache: false,
        type: "POST",
        headers: {'token': dataObj.token,"userId":dataObj.id},
        async: basynctemp,
        url: url,
        data: datajson, // JSON.stringify(obj),
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            $(".Mask").hide();
            if (result.code != 0) {
                alert(result.message);
                return;
            }
            callback(result);
        },
        error: function (xhr) {
            $(".Mask").hide();
            if (xhr.status == 401) {
                top.window.location.href = "/duty/login.jsp";
            }
            else
                console.log(xhr.statusText);
            //alert(xhr.statusText);
        }
    });
}
function CheckUserByOwner(ownerId, companyId, callback) {
    var param = new Object();
    param.ownerId = ownerId;
    param.companyId = companyId;
    var datajson = JSON.stringify(param);
    $(".Mask").show();
    var url = _serviceUrl + "CheckUserByOwnerId";
    $.ajax({
        cache: false,
        type: "POST",
        async: false,
        url: url,
        data: datajson, // JSON.stringify(obj),
        contentType: "application/json",
        dataType: "json",
        success: function (dataItem) {
            $(".Mask").hide();
            callback(dataItem);
        },
        error: function (xhr) {
            $(".Mask").hide();
            if (xhr.status == 401) {
                top.window.location.href = "/backend/login.html?Logout=1";
            }
            else
                console.log(xhr.statusText);
            // alert(xhr.statusText);
        }
    });
}
function SaveLocalData(key, obj) {
    if (obj == null)
        window.localStorage.removeItem(_LoginUser.Id + "_" + key);
    else {
        if (_LoginUser.Id != null)
            window.localStorage.setItem(_LoginUser.Id + "_" + key, JSON.stringify(obj));
        else
            window.localStorage.setItem(key, JSON.stringify(obj));
    }

}
function RetrieveLocalData(key) {
    if ((window.localStorage.getItem(_LoginUser.id + "_" + key) == null) || (window.localStorage.getItem(_LoginUser.id + "_" + key).length == 0)) return null;
    return JSON.parse(window.localStorage.getItem(_LoginUser.id + "_" + key));

}
function SaveDBData(key, obj) {
    var indDB = new IndexDB();
    indDB.SaveData(key, obj);
    //if (obj == null) 
    //    window.localStorage.removeItem(_LoginUser.userCode + "_" + _LoginUser.orgCode + "_" + key);
    //else {
    //    if (_LoginUser!= null)
    //        window.localStorage.setItem(_LoginUser.userCode + "_" + _LoginUser.orgCode + "_" + key, JSON.stringify(obj));
    //    else
    //        window.localStorage.setItem( key, JSON.stringify(obj));
    //}

}
function RetrieveDBData(key, callback) {
    var indDB = new IndexDB();
    return indDB.GetData(key, callback);
    //if ((window.localStorage.getItem(_LoginUser.userCode + "_" + _LoginUser.orgCode + "_" + key) == null) || (window.localStorage.getItem(_LoginUser.userCode + "_" + _LoginUser.orgCode + "_" + key).length == 0)) return null;
    //return JSON.parse(window.localStorage.getItem(_LoginUser.userCode + "_" + key));

}
function AddSystemLog(moduleName, operation, result) {
    var param = new Object();
    var request = new Object();
    request.ModuleName = moduleName;
    request.Operation = operation;
    request.CompanyId = _LoginUser.companyId;
    request.Operater = _LoginUser.name;
    request.OperaterId = _LoginUser.id;
    request.Result = result;
    param.request = request;
    PostData("SaveSystemLog", param, function (result) {

    });
}
function preview(oper) {
    if (oper < 10) {
        pagesetup_null();
        bdhtml = window.document.body.innerHTML; //获取当前页的html代码  
        sprnstr = "<!--startprint" + oper + "-->"; //设置打印开始区域  
        eprnstr = "<!--endprint" + oper + "-->"; //设置打印结束区域  
        prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 18); //从开始代码向后取html  
        prnhtmlprnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr)); //从结束代码向前取html  
        window.document.body.innerHTML = prnhtml;
        window.print();
        window.document.body.innerHTML = bdhtml;
    } else {
        window.print();
    }
    // $("div#divContent").printArea();  
}
function pagesetup_null() {
    try {
        var RegWsh = new ActiveXObject("WScript.Shell")
        hkey_key = "header"
        RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
        hkey_key = "footer"
        RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
    } catch (e) { }
}
ShowPanel = function (id, leftwidth) {
    $(id).css("width", 0);
    $(id).show();
    $(id).css("z-index", 3);
    $(id).animate({
        width: leftwidth + 'px',
        opacity: 1
    }, 500);
},
HidePanel = function (id) {
    $(id).animate({
        width: '0',
        opacity: 1
    }, 500);
    $(id).hide();
}
NewGuid = function () {
    return 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}
Distance = function (lat1, lng1, lat2, lng2) {
    var R = 6378137.0;
    var dis = 0;
    if (lat1 == lat2 && lng1 == lng2)
        dis = 0;
    else {
        var cos = Math.sin(2 * Math.PI * lat1 / 360) * Math.sin(2 * Math.PI * lat2 / 360) + Math.cos(2 * Math.PI * lat1 / 360) * Math.cos(2 * Math.PI * lat2 / 360) * Math.cos(2 * Math.PI * (lng1 - lng2) / 360);
        var acos = Math.acos(cos);
        dis = R * acos;
    }
    return Math.round(dis);
}

window.alert = function (msg) {
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;
        //触发事件
        layer.alert(msg, { area: ['500px', '300px'] });
    });
}
