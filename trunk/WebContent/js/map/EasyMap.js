var mapZoom = new MapZoom(2, document.getElementById("zoombar"));
var mapObj;
var mapDraw;
var currentTool = "Pan";
var _policeId = 0;
var _stationId;
var _lastUpdateTime;
var _IsTrace = false;
var _operationType = "";
var _trafficInfos;
var _trafficType;
var _isTraffic = false;
var _traceLayerId = "TraceLayer";
var _isIntercept = false;
var _taskLevel = "";
var userlnglat = 1;
var _isTrafficViolate = false;
var heatmapInstance;
var _MapService ="http://teamwish.cn:8200/";;
function InitialMap() {
    mapObj = new Map("MapView", mapZoom);
    mapDraw = new MapDraw("TraceLayer", mapObj);

    mapObj.InitialMap();
    if (request("GetPos") != null) {
        $("#divPosInfo").show();
        SetTool("Pin");
        bSetMapSign = true;
        if (request("lng").length > 0) {
            PanTo(request("lng"), request("lat"));
            ZoomTo(4);
            setMapSign(request("lng"), request("lat"));

        }
    }

    /*heatmapInstance = h337.create({
        // only container is required, the rest will be defaults
        container: document.getElementById('ThemeView'),
        // onExtremaChange will be called whenever there's a new maximum or minimum
        onExtremaChange: function (data) {
            updateLegend(data);
        }
    });*/

    //ShowHeater();
    try {
        parent.OnMapReady();
    }
    catch (e) {
    }
}
function request(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result ? decodeURIComponent(result[2]) : null;
}
function ShowHeater(data) {

    var points = [];
    var max = 0;
    var width = 840;
    var height = 400;
    var len = 200;

    while (len--) {
        var val = Math.floor(Math.random() * 100);
        max = Math.max(max, val);
        var point = {
            x: Math.floor(Math.random() * width),
            y: Math.floor(Math.random() * height),
            value: val
        };
        points.push(point);
    }
    // heatmap data format
    var data = {
        max: max,
        data: points
    };
    // if you have a set of datapoints always use setData instead of addData
    // for data initialization
    heatmapInstance.setData(data);
}

var gradientCfg
function updateLegend(data) {

    // the onExtremaChange callback gives us min, max, and the gradientConfig
    // so we can update the legend
    document.querySelector('#min').innerHTML = data.min;
    document.querySelector('#max').innerHTML = data.max;
    // regenerate gradient image
    if (data.gradient != gradientCfg) {
        gradientCfg = data.gradient;
        var gradient = legendCtx.createLinearGradient(0, 0, 100, 1);
        for (var key in gradientCfg) {
            gradient.addColorStop(key, gradientCfg[key]);

            legendCtx.fillStyle = gradient;
            legendCtx.fillRect(0, 0, 100, 10);
            document.querySelector('#gradient').src = legendCanvas.toDataURL();
        }
    }
}
function SetMapSource(source) {

    if (source != null) {
        _MapService = source;
        mapObj.InitialMap();
    }
    else {
        if (_MapService != _DefaultService) {
            _MapService = _DefaultService
            mapObj.InitialMap();
        }
    }
}


function BeforeMapInitial() {
    ClearDraw();
}
function AfterMapInitial() {
    mapDraw.Draw();
    DrawIntercept();
    DrawTrafficViolate();
}
function DrawIntercept() {
    if (_isIntercept) {
        var mapView = document.getElementById("MapOther_3");
        mapView.innerHTML = "<img src='TrafficHandler.ashx?type=intercept&zoom=" + mapObj.Zoom() + "&centerx=" + mapObj.CenterX() + "&centery=" + mapObj.CenterY() + "&width=" + mapObj.ScreenWidth() + "&height=" + mapObj.ScreenHeight() + "&tasklevel=" + _taskLevel + "&interceptid=3' />";
        $("#MapOther_3").show();
        mapView = document.getElementById("MapOther_2");
        mapView.innerHTML = "<img src='TrafficHandler.ashx?type=intercept&zoom=" + mapObj.Zoom() + "&centerx=" + mapObj.CenterX() + "&centery=" + mapObj.CenterY() + "&width=" + mapObj.ScreenWidth() + "&height=" + mapObj.ScreenHeight() + "&tasklevel=" + _taskLevel + "&interceptid=2' />";

        mapView = document.getElementById("MapOther_1");
        mapView.innerHTML = "<img src='TrafficHandler.ashx?type=intercept&zoom=" + mapObj.Zoom() + "&centerx=" + mapObj.CenterX() + "&centery=" + mapObj.CenterY() + "&width=" + mapObj.ScreenWidth() + "&height=" + mapObj.ScreenHeight() + "&tasklevel=" + _taskLevel + "&interceptid=1' />";
        $("#MapOther_1").show();
        $("#MapOther_2").show();
        $("#MapOther_3").show();
    }
    else {
        $("#MapOther_1").hide();
        $("#MapOther_2").hide();
        $("#MapOther_3").hide();
    }
}
function ShowTrafficViolate() {
    _isTrafficViolate = true;
    DrawTrafficViolate();
}
function DrawTrafficViolate() {
    if (_isTrafficViolate) {
        var myDate = new Date();
        var mapView = document.getElementById("MapOther_1");
        mapView.innerHTML = "<img src='../images/loading.gif' style='magin:100px' />";
        var html = "<img src='TrafficHandler.ashx?type=trafficviolate&zoom=" + mapObj.Zoom() + "&centerx=" + mapObj.CenterX() + "&centery=" + mapObj.CenterY() + "&width=" + mapObj.ScreenWidth() + "&height=" + mapObj.ScreenHeight() + "&time=" + myDate.toLocaleTimeString() + "' />";
        mapView.innerHTML = html; // "<img src='TrafficHandler.ashx?type=trafficviolate&zoom=" + mapObj.Zoom() + "&centerx=" + mapObj.CenterX() + "&centery=" + mapObj.CenterY() + "&width=" + mapObj.ScreenWidth() + "&height=" + mapObj.ScreenHeight() + "' />";
    }
}
function IsShowIntercept(isShow) {
    _isIntercept = isShow;
    DrawIntercept();
}
function ShowIntercept(taskLevel, interceptId_Click) {
    _isIntercept = true;
    if (taskLevel != _taskLevel) {
        _taskLevel = taskLevel;
        DrawIntercept();
    }
    if (taskLevel == "临时") return;
    var objIds = [];
    if (interceptId_Click > 0) {
        objIds.push("MapOther_" + interceptId_Click);
    }
    else {
        objIds.push("MapOther_1");
        if (taskLevel == "一级" || taskLevel == "二级") {
            objIds.push("MapOther_2");
        }
        if (taskLevel == "一级") {
            objIds.push("MapOther_3");
        }
    }
    flashObject(objIds, false, 500);

}
function setObjects(cameraInfoObjects, guardObjects, regionServiceObjects) {

    mapDraw.CameraInfoObjects = cameraInfoObjects;
    mapDraw.GuardObjects = guardObjects;
    mapDraw.RegionServiceTrafficObjects = regionServiceObjects;
}
function setObject(objectsName, objects) {
    switch (objectsName) {
        case "CameraInfoObjects":
            mapDraw.CameraInfoObjects = objects;
            break;
        case "GuardObjects":
            mapDraw.GuardObjects = objects;
            break;
        case "RegionServiceTrafficObjects":
            mapDraw.RegionServiceTrafficObjects = objects;
            break;
        case "InterceptPointObjects":
            mapDraw.InterceptObjects = objects;
            break;
        case "RoutePlanDetailObjects":
            mapDraw.RoutePlanDetailObjects = objects;
            break;
        case "TaxiRegionObjects":
            mapDraw.TaxiRegionObjects = objects;
            break;
    }
}


function SetStationId(statoinId) {
    _stationId = statoinId;
}
function SetInfoObjecs(objs) {
    mapDraw.InfoObjects = objs;
    mapDraw.Draw();
    // setTimeout(setqtip, 2000);
}
function GetScreenInfo() {
    return { Longitude: mapObj.CenterX(), Latitude: mapObj.CenterY(), ZoomIndex: mapObj.ZoomIndex(), Zoom: mapObj.Zoom(), Width: mapObj.ScreenWidth(), Height: mapObj.ScreenHeight() };
}

function PanTo(longitude, latitude) { mapObj.PanTo(longitude, latitude); }
function ClearDraw() {
    if (mapDraw != null & typeof (mapDraw.Reset) == "function") {
        mapDraw.Reset();
    }
}
function ClearLine() {
    mapDraw.LineObjects = null;
    mapDraw.Draw();
}
function Draw() {
    mapDraw.Draw();
}
function AfterMapZoom() {
    // GetTrafficInfo();
    //mapDraw.TrafficInfoObjects = null;
    // mapDraw.Draw();

    mapDraw.Draw();
    try {
        parent.OnMapZoom(mapZoom.ZoomIndex);
    }
    catch (e) {
    }
}
function AfterMapPan(region) {
    try {
        DrawIntercept();
        parent.OnMapPan(region);

    }
    catch (e) {
    }
}
function ZoomTo(zoomIndex) {
    mapZoom.SetZoom(zoomIndex);
    mapObj.MapZoom(mapZoom.Zoom);
}
function ShowAlert(longitude, latitude, name, content) {

    themeObject = new Object();
    themeObject.Longitude = longitude;
    themeObject.Latitude = latitude;
    themeObject.Name = name;
    themeObject.Content = content;
    themeObject.Type = "Alert";
    mapDraw.ThemeObject = themeObject;
    PanTo(longitude, latitude);
    //          ReZoom(3, longitude, latitude);
    mapDraw.Draw();
}

function ShowTheme(longitude, latitude, name, content, dist) {

    themeObject = new Object();
    themeObject.Longitude = longitude;
    themeObject.Latitude = latitude;
    themeObject.Name = name;
    themeObject.Content = content;
    themeObject.Type = "Theme";
    mapDraw.PIOObject = themeObject;

    if (dist != null) {
        var obj = new Object();
        obj.Longitude = longitude;
        obj.Latitude = latitude;
        obj.Dist = dist;
        mapDraw.CircleObject = obj;
    }
    if (mapObj.ZoomIndex() > 3) {
        ReZoom(3, longitude, latitude);
    }
    else
        PanTo(longitude, latitude);
    mapDraw.Draw();
}
function DrawImage(obj) {
    mapDraw.ThemeObject = obj;

    if (mapZoom.ZoomIndex >= 2) {
        ReZoom(2, obj.Longitude, obj.Latitude);
    } else
        PanTo(obj.Longitude, obj.Latitude);
    mapDraw.Draw();
}
function ShowTraceLine(tracePos, needName) {
    if (needName)
        mapDraw.InfoObjects = tracePos;
    mapDraw.LineObjects = tracePos;
    mapDraw.Draw();
}

function SetStart_EndPostion(startStop, endStop) {
    mapDraw.StartPosition = startStop;
    mapDraw.EndPosition = endStop;
}

function ReZoom(zoomIndex, longitude, latitude) {
    if (zoomIndex < 0) {
        PanTo(longitude, latitude);
    }
    mapZoom.SetZoom(zoomIndex);
    mapObj.CenterAndZoom(longitude, latitude, mapZoom.Zoom);
}
function ClickCircleTool(obj) {

    $("#RectSelection").removeClass("ToolSelected");
    if ($("#CircleSelection").hasClass("ToolSelected")) {
        $("#CircleSelection").removeClass("ToolSelected");
        parent.ClearCircleSelect();
        SetTool('Pan');
    }
    else {
        $("#CircleSelection").addClass("ToolSelected");
        SetTool('CircleSelector');
    }
}
function ClickRectTool(obj) {

    $("#CircleSelection").removeClass("ToolSelected");
    if ($("#RectSelection").hasClass("ToolSelected")) {
        $("#RectSelection").removeClass("ToolSelected");
        parent.ClearRectSelect();
        SetTool('Pan');
    }
    else {
        $("#RectSelection").addClass("ToolSelected");
        SetTool('RectSelector');
    }
}
function ShowSelectTool(isShow) {
    if (isShow) {
        $("#RectSelection").show();
        $("#CircleSelection").show();
    }
    else {
        $("#RectSelection").hide();
        $("#CircleSelection").hide();
    }

}
function AfterCircleSelect(longitude, latitude, radium) {
    if (typeof (parent.AfterCircleSelect) != "undefined") {
        parent.AfterCircleSelect(longitude, latitude, radium);
    }
}
function AfterRectSelect(left, top, right, bottom) {
    if (typeof (parent.AfterRectSelect) != "undefined") {
        parent.AfterRectSelect(left, top, right, bottom);
    }
}
function SetTool(tool) {
    currentTool = tool;
    mapObj.SetTool(tool);
    if (tool == "Ruler") {
        mapDraw.ClearPin();
        mapDraw.ClearLinePoint();
        mapDraw.Reset();
    }
    if (tool == "Pin1") {
        mapDraw.ClearPin();
    }
}

function AddPin(longitude, latitude) {
    mapObj.PanTo(longitude, latitude);
    mapDraw.AddPin(longitude, latitude);
    mapDraw.Draw();
}
function PickPos(longitude, latitude) {
    if (longitude != null & latitude != null) {
        mapObj.PanTo(longitude, latitude);
        mapDraw.AddPin(longitude, latitude);
        mapDraw.Draw();
    }
    SetTool("Pin");
}
function AfterMapClick(mapx, mapy) {
    var lng = mapObj.MapX(mapx);
    var lat = mapObj.MapY(mapy);
    if (currentTool == "Ruler") {
        mapDraw.AddPin(mapObj.MapX(mapx), mapObj.MapY(mapy));
        mapDraw.AddLinePoint(mapObj.MapX(mapx), mapObj.MapY(mapy));
        mapDraw.Draw();
    }
    if (currentTool == "Pin") {
        setMapSign(lng, lat);        
        try {
            parent.AfterGetPosition(lng, lat);
        }
        catch (e) { }       
    }
    if (currentTool == "Pin1") {
        mapDraw.AddPin(mapObj.MapX(mapx), mapObj.MapY(mapy));
        mapDraw.Draw();
        SetTool("Pan");        
    }
    if (currentTool == "Pan") {
        // SetTool("Pan");
        try {
            parent.AfterGetPosition(mapObj.MapX(mapx), mapObj.MapY(mapy));
        }
        catch (e) { }
    }
    if (currentTool == "Pin2") {

        mapDraw.AddPin(mapObj.MapX(mapx), mapObj.MapY(mapy));
        mapDraw.Draw();
        SetTool("Pan");
        try {
            parent.AfterGetPosition(mapObj.MapX(mapx), mapObj.MapY(mapy));
        }
        catch (e) { }
    }
    mapDraw.HideInfoWindow();
}

function AfterMapDblClick(mapx, mapy) {
    if (currentTool == "Ruler") {
        alert(mapDraw.Distance() + "米");
        SetTool("Pan");
    }
    //alert(mapx + "," + mapy + "," + mapObj.MapX(mapx) + "," + mapObj.MapY(mapy));
}
function AddTrace(objs) {
    mapDraw.AddTrace(objs);
}

function StartTrace(speed, imgUrl) {
    mapDraw.StartTrace(speed, imgUrl);
}
function TraceInfos(times) {
    mapDraw.TraceInfos(times);
}

function PauseTrace() {
    mapDraw.PauseTrace();
}

function StopTrace() {
    mapDraw.StopTrace();
}
function MoveTrack(index) {
    mapDraw.MoveTrack(index);
}
function ClearTrafficInfo() {
    mapDraw.ThemeObject = null;;
    //mapDraw.TrafficInfoObjects = null;
    mapDraw.Reset();
}
function ClearTraceInfo() {
    mapDraw.ClearTrace();
}

function SetNeedTraffic(isNeed) {
    if (mapObj.NeedTraffic != isNeed) {
        mapObj.NeedTraffic = isNeed;
        mapObj.InitialMap();
    }
}

function AfterRetrieveTraffic(trafficInfos) {
    //alert(trafficInfos);
    // alert("traffics"+trafficInfos.length);
    if (trafficInfos != null) {
        mapDraw.TrafficInfoObjects = trafficInfos;
    }
    _isTraffic = true;
    if (_isTraffic)
        mapDraw.Draw();
}
function UpdateTraffic(traffic) {
    mapDraw.UpdateTrafficInfo(traffic);
}
function SetCamera(cameraInfos) {
    // alert("cameraInfos" + cameraInfos.length);
    mapDraw.CameraInfoObjects = cameraInfos;
    if (_isTraffic)
        mapDraw.Draw();
    //mapDraw.Draw();
}
function AfterTraceEnd() {
    try {
        parent.AfterTraceEnd();
    }
    catch (e) { }
}
function test() {
    alert('hello');
}

function UpdateMark(mark) {
    mapDraw.UpdateMark(mark);
}
function ShowInfoWindow(pio) {


    mapObj.PanTo(pio.Longitude, pio.Latitude);
    var x = mapObj.ScreenX(pio.Longitude);
    var y = mapObj.ScreenY(pio.Latitude);
    mapDraw.ShowInfoWindow(x, y, 0, 0, pio.Content);
}
// 显示调试信息
function SetDebugInfo(message) {
    // $("#divDebugInfo").html(message);
}

//根据QueryString参数名称获取值
function getQueryStringByName(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
    if (result == null || result.length < 1) {
        return "";
    }
    return result[1];
}

//右键
function initContextMenu() {
    $('div.contextMenu').contextMenu('myMenu1', {

        onShowMenu: function (e, menu) {

            if ($(e.target).attr('id') == 'svg') {
                SetContextMenu('svg');
            }
            else if ($(e.target).attr('id') == 'map') {
                SetContextMenu('map');
            }
            else {
                SetContextMenu('staff');
            }

            return menu;

        },
        shadow: false

    });

}

$(document).ready(function () {


    InitialMap();

    //            var drawObj = new SVGDraw("id2", "TraceLayer");
    //           
    //            drawObj.line(100, 100, 500, 200, "#0000ff", 2);
    //            drawObj.line(500, 200, 200, 100, "#0000ff", 2);
});

function setMapSign(lng, lat) {
    clearSetMapSign();

    if (lng == "" || lat == "") return;

    if (bSetMapSign) {

        var left = parseInt($("#" + _traceLayerId).css("left"));
        var top = parseInt($("#" + _traceLayerId).css("top"));

        var x = mapObj.ScreenX(lng); //  - 10 - left;
        var y = mapObj.ScreenY(lat); //  - 30 - top;

        var strHtml = '<div id="divMapSign"  style="position:absolute;left:' + (x - 10) + 'px;' + 'top:' + (y - 32) + 'px; z-index:100;"  >';
        strHtml += '<img src="/images/map/mapsign.png"  ondragstart="return false;"  style="height:30px"/>';
        strHtml += '</div>';
        $("#" + _traceLayerId).append(strHtml);

    }
}

function restMapSign(mapx, mapy) {
    if (bSetMapSign) {

        setMapSign(mapObj.MapX(mapx), mapObj.MapY(mapy));
        if (parent.FrmContent == null)
            parent.saveMapSign(mapObj.MapX(mapx), mapObj.MapY(mapy));
        else
            parent.FrmContent.contentWindow.saveMapSign(mapObj.MapX(mapx), mapObj.MapY(mapy));
    }
}

function clearSetMapSign() {
    if ($("#divMapSign").length > 0) $("#divMapSign").remove();
}

var bSetMapSign = false;

function changeMapSource() {
    if ($("#mapRightTop_txt").html() == "&nbsp;地图") {
        $("#mapRightTop_txt").html("&nbsp;卫星");
        $("#mapRightTop_pic").css("background-image", "url('../Images/map/map_2.jpg')");
        _MapService = _MapService.replace("8089", "8085");
    }
    else {
        $("#mapRightTop_txt").html("&nbsp;地图");
        $("#mapRightTop_pic").css("background-image", "url('../Images/map/map_1.jpg')");
        _MapService = _MapService.replace("8085", "8089");
    }
    //alert(_MapService);
    mapObj.InitialMap(); // InitialMap();
}


var _gFlashTime = 5;
var _gInterval;
var _gFlashObjectIds;
var _gFlash_IsParent = false;
var _gJquerySelector;
function flashObject(objIds, isParent, intervalTime, jquerySelector) {
    if (objIds == null || objIds.length < 1)
        return;
    if (_gInterval != null) {
        window.clearInterval(_gInterval);
        showObject(_gFlashObjectIds, _gFlash_IsParent, true);
        _gInterval = null;
        //return;
    }
    if (intervalTime == null)
        intervalTime = 500;
    _gFlashTime = 5;
    _gFlashObjectIds = objIds;
    if (isParent != null)
        _gFlash_IsParent = isParent;
    _gJquerySelector = jquerySelector;

    _gInterval = window.setInterval(flashObject_execute, intervalTime);
}
function flashObject_execute() {
    if (_gFlashTime > 0) {
        _gFlashTime = _gFlashTime - 1;
        //alert(_flashTimes);
        if (_gFlashTime % 2 == 0) {
            showObject(_gFlashObjectIds, _gFlash_IsParent, false);
            if (_gJquerySelector != null) showObjectBySelector(_gJquerySelector, false);
        }
        else {
            showObject(_gFlashObjectIds, _gFlash_IsParent, true);
            if (_gJquerySelector != null) showObjectBySelector(_gJquerySelector, true);
        }
    } else {//剩余时间小于或等于0的时候，就停止间隔函数
        window.clearInterval(_gInterval);
        //这里可以添加倒计时时间为0后需要执行的事件
        showObject(_gFlashObjectIds, _gFlash_IsParent, true);
        if (_gJquerySelector != null) showObjectBySelector(_gJquerySelector, true);
        _gInterval = null;
    }
}

function showObject(objIds, isParent, isShow) {
    for (var l = 0; l < objIds.length; l++) {
        if (isParent) {
            isShow ? $("#" + objIds[l]).parent().show() : $("#" + objIds[l]).parent().hide();
        }
        else {
            isShow ? $("#" + objIds[l]).show() : $("#" + objIds[l]).hide();

        }
    }
}

function showObjectBySelector(selector, isShow) {
    isShow ? $(selector).show() : $(selector).hide();
}

function ClearTheme() {
    mapDraw.ThemeObject = null;
    mapDraw.CircleObject = null;
    mapDraw.Draw();
}
function AddLayer(name, objs) {
    mapDraw.AddLayer(name, objs);
}
function UpdateLayer(name, objs) {
    mapDraw.UpdateLayer(name, objs);
}
function AppendLayer(name, objs) {
    mapDraw.AppendLayer(name, objs);
}
function RemoveLayer(name) {
    mapDraw.RemoveLayerByName(name);
}
function ResetLayer() {
    mapDraw.ResetLayer();
}
function ShowLayer(name, isShow) {
    mapDraw.ShowLayer(name, isShow)
}
function ShowLayerName(isShow) {
    mapDraw.ShowLayerName(isShow)
}
function ShowLayerInfoWindow(name, index) {
    mapDraw.ShowLayerInfoWindow(name, index)
}
function SelectLayerObject(strId) {
    mapDraw.SelectObject(strId)
}
function clickObject(objId, isParent) {
    if (isParent) {
        $("#" + objId).click();
    }
    else {
        $("#" + objId).parent().click();
    }
}
function showPopContent(objId, isParent) {
    if ($("#divInfoWindow").is(":visible")) {
        clickObject(objId, isParent);
    }
}

var dragobj = null;
var iX, iY;
function onDrag(obj) {
    var e = window.event;
    dragobj = obj;
    iX = e.clientX - obj.offsetLeft;
    iY = e.clientY - obj.offsetTop;
    obj.setCapture && obj.setCapture();
}
$(function () {
    document.onmousemove = function (e) {
        if (dragobj != null) {
            var e = e || window.event;
            var oX = e.clientX - iX;
            var oY = e.clientY - iY;
            $("#" + dragobj.id).css({ "left": oX + "px", "top": oY + "px" });
            return false;
        }
    };
    $(document).mouseup(function (e) {
        if (dragobj) {
            //$("#" + dragobj.id)[0].releaseCapture(); 
            //  dragobj.releaseCapture(); 
            if (typeof (dragobj.releaseCapture) != "undefined") dragobj.releaseCapture();
            dragobj = null;
            // e.cancelBubble = true;
        } else
            e.cancelBubble = false;
        //$("#divMenu").slideUp();

    })
});