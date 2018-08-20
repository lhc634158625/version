//
//
//
var SrcHeight;
var _mapwidth = 256;
var _mapheight = 256;
var _scrwidth = document.body.clientWidth;

if (parent.minPagebodyHeight != null)
    SrcHeight = parent.minPagebodyHeight; // - 31;
else
    SrcHeight = document.documentElement.clientHeight;
var _scrheight = SrcHeight; 
var _xCount = Math.ceil(_scrwidth / _mapwidth);
var _yCount = Math.ceil(_scrheight / _mapheight);
$(window).resize(function () {
    if (parent.minPagebodyHeight != null)
        SrcHeight = parent.minPagebodyHeight; // - 31;
    else
        SrcHeight = document.documentElement.clientHeight;
    _scrwidth = document.body.clientWidth;
    _xCount = Math.ceil(_scrwidth / _mapwidth);
    _yCount = Math.ceil(_scrheight / _mapheight);
});
function Resize(width, height) {
    SrcHeight = height;
    _scrwidth = width;
    _xCount = Math.ceil(_scrwidth / _mapwidth);
    _yCount = Math.ceil(_scrheight / _mapheight);
}
function Map(layName, mapZoom) {
    var _layName = layName;
    var _layObj = document.getElementById(layName);
    var _mapLayerName = "_divMapLayer";
    var _mayLayer = document.getElementById(_mapLayerName);
    var _traceLayer = document.getElementById("TraceLayer");
    var _zoom = mapZoom.Zoom;
    this.PreZoom;
    var _centerX = 117.977574;
    var _centerY = 24.548974;
    var _prex, _prey;
    var _prelon, _prelat;
    //  SetSrcHeight();  //window.screen.availHeight - window.screenTop - 80;  // 1000; //  document.documentElement.clientHeight;
    
    var _maxLongitude = 118.511043;
    var _maxLatitude = 24.950827;
    var _minLongitude = 117.801482;
    var _minLatitude = 24.320000;
    var _deltaLon;
    var _deltaLat;
    var _curRadiu;
    var _maxZoom;
    var CircleObj;
    var RectObj;
    var _currentX, currentY;
    
    var _isDrag = false;
    var _isDraging = false;
    var _mapItems; //地图元素数组    
    var self = this;
    var _mapZoom = mapZoom;
    var _OperateLayer = document.getElementById("svg");
    this.Tool = "Pan";

    var bflag = (document.all) ? 0 : 1; //0=IE,1=FIREFOX
    var _movelefttop = "";
    var _initPostion = "";
    var bMousedown = false;
    var bDrag = false;
    var bDraging = false;
    this.NeedTraffic = -1;

    this.InitialMap = function () {
        //
        try {
            BeforeMapInitial();
        }
        catch (e) {

        }

        htmlContent = '<DIV id="_divMapLayer" style="position:absolute; left:0px; top:0px;  z-index:2;cursor:hand"></div>'; //width:256px; height:256px;
        // htmlContent = htmlContent + '';
        // _layObj.insertAdjacentHTML("BeforeEnd", htmlContent);
        // alert(_scrheight);
        _layObj.innerHTML = htmlContent;
        _mayLayer = document.getElementById(_mapLayerName);
        _mapItems = new Array();
        _traceLayer.style.left = "0px";
        _traceLayer.style.top = "0px";

        _deltaLat = _zoom * 180 / Math.PI / EARTH_RADIUS;
        _currentY = y;
        y = self.GetItemRow(_centerY);
        var centerY = _minLatitude + _deltaLat * y + _deltaLat / 2;
        self.PreZoom = 0;
        var k = 0;
        var x, y
        //_curRadiu = EARTH_RADIUS * Math.cos(this.Rad(_minLatitude));
        _deltaLon = _mapZoom.DeltaX; // _zoom * (180 / Math.PI / _curRadiu);
        x = self.GetItemCol(_centerX)
        _currentX = x;
        var centerX = _minLongitude + _deltaLon * x + _deltaLon / 2;

        _centerX = centerX;
        _centerY = centerY;
        // alert(_xCount + ";" + _yCount);
        for (var i = 0; i < _xCount; i++) {
            centerX = _minLongitude + (x + i) * _deltaLon + _deltaLon / 2;
            for (var j = 0; j < _yCount; j++) {

                centerY = _minLatitude + _deltaLat * (y - j) + _deltaLat / 2;
                _mapItems[k] = new MapItem(i, j, x + i, y - j, _zoom, centerX, centerY, self.NeedTraffic, _mayLayer);
                //_mapItems[k] = new MapItem(i, j, _centerX, _centerY, _zoom, _mayLayer);
                strHtml = _mapItems[k].RetrieveMap();

                // _mayLayer.insertAdjacentHTML("BeforeEnd", strHtml);
                k++;
            }
        }
        try {
            self.DrawCircle();
            self.DrawRect();
            AfterMapInitial();
            bRetrieveItem();
        }
        catch (e) {

        }
        //  alert(x + "," + y + "," + _centerX + "," + _centerY + "," + _zoom + "," + self.DeltaX());
    }
    // self.InitialMap(); //初始化地图

    if (bflag) {
        document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP);
    }
    //处理地图拖动开始
    this.eventmousedown = function (evt) {
        if (window.event.button == 2) return;
        bMousedown = true;
        if (evt == null) bflag = false;
        if (bflag) {//FIREFOX
            x = evt.pageX;
            y = evt.pageY;
            li_left = GetPosition(_mapLayerName, "left")
            li_top = GetPosition(_mapLayerName, "top")
            _prex = x;
            _prey = y;
            li_width = GetPosition(_mapLayerName, "width")
            li_height = GetPosition(_mapLayerName, "height")
            x = x - li_left
            y = y - li_top
            _prelon = self.MapX(x);
            _prelat = self.MapY(y);
            _isDrag = true;
            return false;
        } else {


            x = event.clientX;
            y = event.clientY;
            li_left = GetPosition(_mapLayerName, "left")
            li_top = GetPosition(_mapLayerName, "top")
            _prex = x;
            _prey = y;
            x = x - li_left
            y = y - li_top

            SetDebugInfo("x:" + x + "y:" + y + "left:" + li_left + "top:" + li_top);
        }
        _prelon = self.MapX(x);
        _prelat = self.MapY(y);
        _isDrag = true;
        _isDraging = false;

        _movelefttop = $("#" + _mapLayerName).css("left") + "," + $("#" + _mapLayerName).css("top");
    }

    this.eventmousemove = function (evt) {
        _mayLayer.style.cursor = 'pointer';
        // _mayLayer.style.cursor = 'hand';
        // window.status = bDrag + "," + bDraging;
        if (bMousedown) { if (bRetrieveItem()) { bDrag = true; bDraging = true; } };

        if (_isDrag) {
            if (bflag) {
                if ((self.Tool != "CircleSelector") && (self.Tool != "RectSelector")) {
                    newx = eval(evt.pageX - x);
                    newy = eval(evt.pageY - y);
                    if (!self.CheckView(-newx, -newy)) return false;
                    self.SetLayerPosition(newx, newy);
                    ResetMapItems();
                }
                else {
                    newx = eval(evt.pageX);
                    newy = eval(evt.pageY);
                    if (self.Tool == "CircleSelector") {
                        self.DrawCircle(_prex, _prey, Math.abs(newx - _prex));
                    }
                    if (self.Tool == "RectSelector") {
                        self.DrawRect(_prex, _prey, Math.abs(newx - _prex), Math.abs(newy - _prey));
                    }
                }

            } else {

                // SetDebugInfo("x:" + x + "<br/>y:" + y + "clientX:" + event.clientX + "clientY:" + event.clientY);
                newx = event.clientX - x + document.body.scrollLeft;
                newy = event.clientY - y + document.body.scrollTop;

                if ((self.Tool != "CircleSelector") && (self.Tool != "RectSelector")) {
                    if (!self.CheckView(-newx, -newy)) return false;
                    newx = event.clientX - x + document.body.scrollLeft;
                    newy = event.clientY - y + document.body.scrollTop;

                    self.SetLayerPosition(newx, newy);
                    ResetMapItems();
                }
                else {
                    if (self.Tool == "CircleSelector") {
                        newx = event.clientX + document.body.scrollLeft;
                        newy = event.clientY + document.body.scrollTop;
                        self.DrawCircle(_prex, _prey, Math.abs(newx - _prex));
                        CircleObj = new Object();
                        CircleObj.Longitude = self.MapX((_prex + newx) / 2);
                        CircleObj.Latitude = self.MapY((_prey + newy) / 2);
                        CircleObj.Radiu = self.Distance(self.MapX(_prex), CircleObj.Latitude, self.MapX(newx), CircleObj.Latitude) / 2;

                    }
                    if (self.Tool == "RectSelector") {
                        newx = event.clientX + document.body.scrollLeft;
                        newy = event.clientY + document.body.scrollTop;
                        self.DrawRect(_prex, _prey, Math.abs(newx - _prex), Math.abs(newy - _prey));
                        RectObj = new Object();
                        RectObj.Left = self.MapX(_prex);
                        RectObj.Top = self.MapY(_prey);
                        RectObj.Right = self.MapX(newx);
                        RectObj.Bottom = self.MapY(newy);
                    }
                }
                return false;
            }
            _isDraging = true;
        }
    }
    this.DrawRect = function (x, y, width, height) {
        if (x == null) {
            if (RectObj != null) {
                x = self.ScreenX(RectObj.Left);
                y = self.ScreenY(RectObj.Top);
                width = Math.abs(self.ScreenX(RectObj.Right) - x);
                height = Math.abs(self.ScreenY(RectObj.Bottom) - y);
            }
        }
        if (x == null) return;
        _OperateLayer.innerHTML = "";


        _OperateLayer.style.left = x + "px";
        _OperateLayer.style.top = y + "px";
        _OperateLayer.style.width = width + "px";
        _OperateLayer.style.height = height + "px";
        _OperateLayer.style.border = "1px solid Red";
        _OperateLayer.style.backgroundColor = "#7fcaff";
        _OperateLayer.style.display = "block";

    }
    this.DrawCircle = function (lon, lat, dist) {
        _OperateLayer.innerHTML = "";
        var x = lon;
        var y = lat;
        var radiu = dist
        if (x == null) {
            if (CircleObj != null) {
                x = self.ScreenX(CircleObj.Longitude);
                y = self.ScreenY(CircleObj.Latitude);

                radiu = self.ToScreenWidth(CircleObj.Radiu);
                x = x - radiu;
                y = y - radiu;
                radiu = radiu * 2;
            }
        }
        if (x == null) return;
        _OperateLayer.innerHTML = "<img src='../images/circle.gif' width=" + radiu + "  ondragstart='return false;'>";
        _OperateLayer.style.left = x + "px";
        _OperateLayer.style.top = y + "px";
        _OperateLayer.style.width = radiu + "px";
        _OperateLayer.style.height = radiu + "px";
        _OperateLayer.style.border = "0px";
        _OperateLayer.style.backgroundColor = "transparent";
        _OperateLayer.style.display = "block";
    }
    this.ToScreenWidth = function (width) {
        var x1 = _centerX + _mapZoom.DeltaX * width / _mapZoom.Zoom;
        x1 = self.ScreenX(x1);
        x = self.ScreenX(_centerX);
        return Math.abs(x - x1);
    }
    this.CheckView = function (left, top) {
        return true;
        var parameter = this.MapX(left);
        if (parameter < _minLongitude) return false;
        parameter = this.MapY(top);
        if (parameter > _maxLatitude) return false;
        parameter = this.MapX(left + _scrwidth);
        if (parameter > _maxLongitude) return false;
        parameter = this.MapY(top + _scrheight);
        if (parameter < _minLatitude) return false;
        if ((left == _prex) && (top == _prey)) return false;
        // alert(parameter);
        return true;
    }
    this.eventmouseup = function (evt) {
        if ((evt == null) || (evt == undefined)) bflag = false;
        if (typeof (restMapSign) != "undefined") {
            if (_movelefttop == "" || (_movelefttop == $("#" + _mapLayerName).css("left") + "," + $("#" + _mapLayerName).css("top"))) {
                if (bflag) {
                    mapx = evt.pageX - GetPosition(_mapLayerName, "left");
                    mapy = evt.pageY - GetPosition(_mapLayerName, "top");
                }
                else {
                    mapx = event.clientX + document.body.scrollLeft - GetPosition(_mapLayerName, "left");
                    mapy = event.clientY + document.body.scrollTop - GetPosition(_mapLayerName, "top");
                }

                restMapSign(mapx, mapy);
            }
        }

        if (self.Tool == "Pan") {
            if (_mayLayer.releaseCapture)
                _mayLayer.releaseCapture();
            else if (window.captureEvents)
                window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
            //   ResetMapItems();

        }
        {
            try {

                if (bflag) {
                    mapx = evt.pageX - GetPosition(_mapLayerName, "left");
                    mapy = evt.pageY - GetPosition(_mapLayerName, "top");
                }
                else {
                    mapx = event.clientX + document.body.scrollLeft - GetPosition(_mapLayerName, "left");
                    mapy = event.clientY + document.body.scrollTop - GetPosition(_mapLayerName, "top");
                }

                if ((self.Tool != "CircleSelector") && (self.Tool != "RectSelector")) {
                    if (!_isDraging)
                        AfterMapClick(mapx, mapy);
                    AfterMapPan();
                }
                else {

                    if (self.Tool == "CircleSelector") {
                        // self.Tool = "Pan";
                        // _OperateLayer.style.display = "none";

                        var centerx = (self.MapX(mapx) + _prelon) / 2;
                        var centery = (self.MapY(mapy) + _prelat) / 2;
                        AfterCircleSelect(centerx, centery, self.Distance(_prelon, _prelat, self.MapX(mapx), self.MapY(mapy)));
                    }
                    if (self.Tool == "RectSelector") {
                        //self.Tool = "Pan";
                        // _OperateLayer.style.display = "none";
                        AfterRectSelect(_prelon, _prelat, self.MapX(mapx), self.MapY(mapy));
                    }
                }
            }
            catch (e) {
                alert(e.message);

            }
        }

        if (bMousedown) {
            if (bRetrieveItem()) {
                var newtop = parseInt($("#" + _mapLayerName).css("top"));
                //if (newtop < 0) newtop = -newtop;
                var newLeft = parseInt($("#" + _mapLayerName).css("left"));
                //if (newLeft < 0) newLeft = -newLeft;

                _initPostion = newtop + "," + newLeft;
            }
        }

        _isDrag = false;
        _isDraging = false;
        bMousedown = false;
        bDrag = false;
        bDraging = false;
        //SetDebugInfo(_mayLayer.style.left + "<br/>" + _mayLayer.style.top);

    }
    this.eventmousewheel = function (e) {

        var evt = window.event || e;
        var delta = evt.detail ? -evt.detail / 3 : evt.wheelDelta / 120;

        if (delta >= 1) {
            _mapZoom.SetZoom(_mapZoom.ZoomIndex - 1);
            //alert(_mapZoom.Zoom);
            self.MapZoom(_mapZoom.Zoom);
        }
        else if (delta <= -1) {
            _mapZoom.SetZoom(_mapZoom.ZoomIndex + 1);
            self.MapZoom(_mapZoom.Zoom);
        }
    }

    this.eventdoubleclick = function (e) {
        // alert(this.Tool);
        //        if ((self.Tool == "Pan") || (self.Tool == "TrafficInfo")) {
        //            _mapZoom.SetZoom(_mapZoom.ZoomIndex - 1);
        //            self.MapZoom(_mapZoom.Zoom);

        //        }
        //        else {
        var evt = window.event || e;
        if (evt == null) bflag = false;
        try {
            if (bflag) {
                // alert(evt)
                mapx = evt.pageX - GetPosition(_mapLayerName, "left");
                mapy = evt.pageY - GetPosition(_mapLayerName, "top");
            }
            else {
                mapx = event.clientX + document.body.scrollLeft - GetPosition(_mapLayerName, "left");
                mapy = event.clientY + document.body.scrollTop - GetPosition(_mapLayerName, "top");
            }
            _mapZoom.SetZoom(_mapZoom.ZoomIndex - 1);
            //  self.MapZoom(_mapZoom.Zoom);
            //alert(mapx + ',' + mapy);
            // alert(mapx + "," + mapy);
            self.CenterAndZoom(self.MapX(mapx), self.MapY(mapy), _mapZoom.Zoom);
            AfterMapDblClick(mapx, mapy);
        }
        catch (e) {
            alert(e.Message);
        }
        //        }
    }
    this.eventcontext = function () {
        _mapZoom.SetZoom(_mapZoom.ZoomIndex + 1);
        self.MapZoom(_mapZoom.Zoom);
        return false;
    }
    //    if (bflag) {
    //        document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP | Event.MOUSEWHEEL | Event.DBLCLICKP);
    //        }
    //        document.onmousedown = self.eventmousedown;
    //        document.onmousemove = self.eventmousemove;
    //        document.onmouseup = self.eventmouseup;
    //        document.onmousewheel = self.eventmousewheel
    //        document.ondblclick = self.eventdoubleclick;
    //        document.oncontextmenu = self.eventcontext;

    if (bflag) {
        document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP | Event.MOUSEWHEEL | Event.DBLCLICK | Event.DOMMOUSESCROLL);
        document.addEventListener('DOMMouseScroll', self.eventmousewheel, false);
        // _layObj.addEventListener("DOMMouseScroll", self.eventmousewheel, false);
        //_layObj.dispatchEvent(event)
    }
    _layObj.onmousedown = self.eventmousedown;
    _layObj.onmousemove = self.eventmousemove;
    _layObj.onmouseup = self.eventmouseup;
    _layObj.onmousewheel = self.eventmousewheel
    _layObj.ondblclick = self.eventdoubleclick;
    //  document.onmouseup = self.eventmouseup;
    //  _layObj.oncontextmenu = self.eventcontext;


    //处理地图拖动---结束

    this.CenterAndZoom = function (longitude, latitude, zoom) {
        if ((longitude < 117) || (longitude > 119) || (latitude < 23) || (latitude > 25)) {
            alert("Center系统数据错误。经度:" + longitude + " 维度:" + latitude);
            //alert("系统数据错误");
            return;
        }
        if (_zoom == zoom) {
            self.PanTo(longitude, latitude);
            return;
        }
        _zoom = zoom;
        var deltaX = this.MapX(_scrwidth / 2 - _mapwidth / 2) - this.MapX(0);
        var deltaY = this.MapY(_scrheight / 2 - _mapheight / 2) - this.MapY(0);
        _centerX = longitude - deltaX
        _centerY = latitude - deltaY;
        self.PreZoom = _zoom;
        this.InitialMap();
        AfterMapZoom();
    }
    this.CheckPos = function (longitude, latitude) {
        if ((longitude < _minLatitude) || (longitude > _maxLongitude) || (latitude < _minLatitude) || (latitude > _maxLatitude)) {

            return false;
        }
        return true;
    }
    //根据方向移动地图
    this.Pan = function (directType) {
        var li_left = GetPosition(_mapLayerName, "left")
        var li_top = GetPosition(_mapLayerName, "top")

        if (directType == 1) // left
            li_left = li_left - _scrwidth / 2;
        if (directType == 2) // right
            li_left = li_left + _scrwidth / 2;
        if (directType == 3) // top
            li_top = li_top - _scrheight / 2;
        if (directType == 4) // bottom
            li_top = li_top + _scrheight / 2;
        this.SetLayerPosition(li_left, li_top);

        //            _mayLayer.style.left = li_left + "px";
        //            _mayLayer.style.top = li_top + "px";
        // alert(_mayLayer.style.top);
        ResetMapItems();
        var region = new Object();
        region.FromX = MapX(this.Left());
        region.FromY = MapY(this.Top());
        region.ToX = MapX(this.Right());
        region.ToY = MapX(this.Bottom());
        AfterMapPan(region);

    }
    this.SetTool = function (toolName) {
        this.Tool = toolName;
        if ((this.Tool != "CircleSelector") && (this.Tool != "RectSelector")) {
            _OperateLayer.style.display = "none";
        }
        if (this.Tool != "CircleSelector")
            CircleObj = null;
        if (this.Tool != "RectSelector")
            RectObj = null;
        //alert(this.Tool);
        //_OperateLayer.style.display = "none";
    }
    this.PanTo = function (longitude, latitude) {
        if (!this.CheckPos(longitude, latitude)) {
            alert("Pan系统数据错误。经度:" + longitude + " 维度:" + latitude);
            //alert("系统数据错误");
            return;
        }
        var left = this.ScreenX(longitude) - _scrwidth / 2;
        var top = this.ScreenY(latitude) - _scrheight / 2;
        //alert(left);
        this.SetLayerPosition(-left, -top);
        //        _mayLayer.style.left = -left + "px";
        //        _mayLayer.style.top = -top + "px";
        // alert(_mayLayer.style.top);
        ResetMapItems();
    }
    this.SetLayerPosition = function (x, y) {
        _traceLayer.style.left = x + "px";
        _traceLayer.style.top = y + "px";
        _mayLayer.style.left = x + "px";
        _mayLayer.style.top = y + "px";
       
    }

    this.MapZoom = function (izoom) {
        if (_zoom == parseInt(izoom)) return;
        if (izoom > _maxZoom) return;

        var longitude = this.MapX((this.Left() + this.Right()) / 2)
        var latitude = this.MapY((this.Top() + this.Bottom()) / 2)

        self.PreZoom = _zoom;
        _zoom = parseInt(izoom);
        var deltaX = this.MapX(_scrwidth / 2 - _mapwidth / 2) - this.MapX(0);
        var deltaY = this.MapY(_scrheight / 2 - _mapheight / 2) - this.MapY(0);
        _centerX = longitude - deltaX
        _centerY = latitude - deltaY;



        this.InitialMap();
        try {
            AfterMapZoom();
        }
        catch (e) {
        }
        if ($("#jqContextMenu").length > 0) {
            $("#jqContextMenu").hide();
        }
    }
    this.AllMap = function () {
        _mapZoom.SetZoom(9);
        _centerX = 117.577574; //117.877574;
        _centerY = 24.788974;
        self.PreZoom = _zoom;
        _zoom = parseInt(_mapZoom.Zoom);

        this.InitialMap();
        try {
            AfterMapZoom();
        }
        catch (e) {
        }
    }
    //document.body.onresize = mapObj.Resize();
    this.Resize = function () {
        var oldwidth = _scrwidth;
        var oldheight = _scrheight;
        if (document.body.clientWidth > 100) _scrwidth = document.body.clientWidth;
        if (document.documentElement.clientHeight > 100) _scrheight = document.documentElement.clientHeight;
        _xCount = Math.ceil(_scrwidth / _mapwidth);
        _yCount = Math.ceil(_scrheight / _mapheight);
        if ((_scrwidth != oldwidth) || (_scrheight != oldheight))
            self.InitialMap();
    }
    //获取对象位置，ao_object=对象Id, type='left,top,width,height'
    function GetPosition(objectId, type) {

        ls_temp = eval("document.getElementById('" + objectId + "').style." + type)
        ls_temp = ls_temp.substr(0, ls_temp.indexOf('px'))
        li_pos = parseInt(ls_temp)
        return li_pos
    }

    //根据当前地图层的位置，计算出需要在何处插入地图元素
    function ResetMapItems() {
        li_left = GetPosition(_mapLayerName, "left");
        li_top = GetPosition(_mapLayerName, "top");
        if (li_left < 0)
            deltaX = -Math.floor(li_left / _mapwidth);
        else
            deltaX = -Math.ceil(li_left / _mapwidth);
        if (li_top < 0)
            deltaY = -Math.floor(li_top / _mapheight);
        else
            deltaY = -Math.ceil(li_top / _mapheight);

        message = "deltaX:" + deltaX + "deltaY:" + deltaY;
        SetDebugInfo(message);
        RetrieveMaps(deltaX, deltaY);
    }
    //根据ResetMapItems计算结果，插入具体地图元素
    function RetrieveMaps(delatX, deltaY) {
        var k = _mapItems.length;
        var beginX, endX, beginY, endY;
        if (deltaX < 0)
            beginX = delatX;
        else
            beginX = delatX - 1;

        endX = _xCount + beginX;
        if (deltaY < 0)
            beginY = deltaY;
        else
            beginY = deltaY - 1;

        endY = beginY + _yCount;

        //alert(beginX + "," + endX + "," + beginY + "," + endY);
        var x, y;
        for (var i = beginX; i <= endX; i++) {
            x = self.MapX(i * _mapwidth + _mapwidth / 2);
            x = self.GetItemCol(x);
            centerX = _minLongitude + x * _deltaLon + _deltaLon / 2;
            for (var j = beginY; j <= endY; j++) {
                if (!CheckMapItems(i, j)) {
                    y = self.MapY(j * _mapheight + _mapheight / 2)
                    y = self.GetItemRow(y);

                    centerY = _minLatitude + _deltaLat * y + _deltaLat / 2;
                    _mapItems[k] = new MapItem(i, j, x, y, _zoom, centerX, centerY, self.NeedTraffic, _mayLayer);
                    // _mapItems[k] = new MapItem(i, j, x,y, _zoom,centerX,centerY, _mayLayer);
                    strHtml = _mapItems[k].RetrieveMap();
                    //alert("i:" + i + "j:" + j + ";" + strHtml);
                    // insertHtml("beforeend", _mayLayer, strHtml);
                    // _mayLayer.insertAdjacentHTML("BeforeEnd", strHtml);
                    k++;
                }
            }
        }
        try {
            self.DrawCircle();
            self.DrawRect();
            AfterMapPan();
        }
        catch (e) {
        }

        // alert(_mapItems.length);
    }
    this.RetrieveItemTraffic = function () {

        for (var i = 0; i < _mapItems.length; i++) {
            if (self.CheckItemPos(_mapItems[i].X, _mapItems[i].Y))
                _mapItems[i].RetrieveTraffic();
        }
    }
    this.CheckItemPos = function (x, y) {
        var left = x * _mapwidth + _mapwidth / 2;
        var top = y * _mapheight + _mapheight / 2;
        if (left < (this.Left())) return false;
        if (left > (this.Right())) return false;
        if (top < (this.Top())) return false;
        if (top > (this.Bottom())) return false;
        return true;
    }
    this.IsVisible = function (x, y) {
        var left = x ;
        var top = y;
        if (left < (this.Left())) return false;
        if (left > (this.Right())) return false;
        if (top < (this.Top())) return false;
        if (top > (this.Bottom())) return false;
        return true;
    }
    this.GetItemCol = function (centerX) {
        return Math.floor((centerX - _minLongitude) / self.DeltaX());

    }
    this.GetItemRow = function (centerY) {
        return Math.floor((centerY - _minLatitude) / self.DeltaY());

    }

    //根据单元标示，检查地图元素是否已经存在。
    function CheckMapItems(x, y) {
        for (var i = 0; i < _mapItems.length; i++) {
            if ((_mapItems[i].X == x) && (_mapItems[i].Y == y))
                return true;
        }
        return false;
    }
    this.Zoom = function () {
        return _zoom;
    }
    this.ZoomIndex = function () {
        return _mapZoom.ZoomIndex;
    }
    this.DeltaX = function () {
        return _deltaLon;
        // return Math.abs(self.MapX(0) - self.MapX(_mapwidth));
    }
    this.DeltaY = function () {
        return _deltaLat;
        //return Math.abs(self.MapY(0) - self.MapY(_mapheight));
    }
    this.CenterX = function () {
        return self.MapX((self.Left() + self.Right()) / 2);
    }
    this.CenterY = function () {
        return self.MapY((self.Top() + self.Bottom()) / 2);
    }

    this.ScreenWidth = function () {
        return _scrwidth;
    }
    this.ScreenHeight = function () {
        return _scrheight;
    }
    //把屏幕X轴信息转化为经度
    this.MapX = function (ax) {
        //alert(ax);
        var delta = 0.0005000;
        if (_mapZoom.ZoomIndex > 0)
            delta = 0.00120;
        var aret
        if (_mapwidth == 0) return 0
       // delta = 0.00128;
       // aret = (ax - _centerX - delta) * _mapwidth / (_zoom * 0.0000098799356166) + _mapwidth / 2;
        
        aret = (ax - _mapwidth / 2) * 0.0000098799356166 * _zoom / _mapwidth + _centerX + delta
        // alert(aret);
        return aret
    }
    //把屏幕Y轴信息转化为纬度
    this.MapY = function (ay) {
        var aret
        if (_mapwidth == 0) return 0
        aret = (_mapheight / 2 - ay) * 0.00000899322 * _zoom / _mapwidth + _centerY;//- 0.000207;
        return aret
    }
    //把经纬度转化为屏幕坐标
    this.ScreenX = function (ax) {
        var aret
        if (_zoom == 0) return 0
        //        var dist = self.Distance(_centerY, _centerX, _centerY, ax);

        //        aret = dist * _mapwidth /_zoom ;
        //        if (_centerX > ax)
        //            aret = _mapwidth / 2 - aret;
        //        else
        //            aret = _mapwidth / 2 + aret;
        //  var x = self.GetItemCol(ax);

        //var centerX = x * _deltaLon + _deltaLon / 2 + _minLongitude;
        // aret = _mapwidth * (ax - centerX - 0.001300) / _deltaLon + (x - _currentX) * _mapwidth + _mapwidth / 2;
        // aret = (ax - _centerX) * _mapwidth / _deltaLon + _mapwidth / 2;
        
        var delta = 0.0000700; //0.0005000;
        //if (_mapZoom.ZoomIndex > 0)
        //    delta = 0.00120;
        //delta = 0.00132;
        //if (_mapZoom.ZoomIndex == 0) {
        //    if (_MapService.indexOf("8085") > 0)
        //        delta = 0.0052;
        //    else
        //        delta = 0.00010;
        //}
        //if (_mapZoom.ZoomIndex == 1) delta = 0.00096;
        //if (_mapZoom.ZoomIndex == 2) delta = 0.00082; //0.00010;
        //if (_mapZoom.ZoomIndex == 3) delta = 0.00122; //0.00050;
        //if (_mapZoom.ZoomIndex == 4) delta = 0.00122;
        //if (_mapZoom.ZoomIndex == 5) delta = 0.00122;
        //if (_mapZoom.ZoomIndex == 6) delta = 0.00122;
        //delta = 0.00128;
        aret = (ax - _centerX - delta) * _mapwidth / (_zoom * 0.0000098799356166) + _mapwidth / 2;
        
        // aret = (ax - _centerX) * _mapwidth / (_zoom * 0.0000098725) + _mapwidth / 2
        return Math.round(aret)
    }
    //把经纬度转化为屏幕坐标
    this.ScreenY = function (ay) {
//                var aret
//                var dist = self.Distance(_centerY, _centerX,ay, _centerX);
//                aret = Math.round(_mapwidth * dist / _mapZoom);
        var aret
        if (_zoom == 0) return 0
        //
        aret = (_centerY - ay + 0.000207) * _mapwidth / (0.00000899322 * _zoom) + _mapheight / 2

        return Math.round(aret)
    }

    var EARTH_RADIUS = 6378137;
    this.Rad = function (d) {
        return d * Math.PI / 180.0;
    }

    this.Distance = function (lat1, lng1, lat2, lng2) {

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
    this.Top = function () {
        return -GetPosition(_mapLayerName, "top");
    }
    this.Left = function () {
        return -GetPosition(_mapLayerName, "left");
    }
    this.Bottom = function () {
        return -GetPosition(_mapLayerName, "top") + _scrheight;
    }

    this.Right = function () {
        return -GetPosition(_mapLayerName, "left") + _scrwidth;
    }

    this.bDrag = function () {
        return bDrag;
    }

    this.bDraging = function () {
        return bDraging;
    }

    function bRetrieveItem() {
        var strs = _initPostion.split(",");

        var bRetrieve = false;

        var newtop = parseInt($("#" + _mapLayerName).css("top"));
        //if (newtop < 0) newtop = -newtop;
        var newLeft = parseInt($("#" + _mapLayerName).css("left"));
        //if (newLeft < 0) newLeft = -newLeft;


        if (strs.length == 2) {
            var top0 = parseInt(strs[0]) - newtop;
            if (top0 < 0) top0 = -top0;
            var left0 = parseInt(strs[1]) - newLeft;
            if (left0 < 0) left0 = -left0;
            if (top0 > 50) {
                bRetrieve = true;
            }
            else if (left0 > 50) {
                bRetrieve = true;
            }
        }
        else {
            _initPostion = newtop + "," + newLeft;
        }
        return bRetrieve;
    }
}