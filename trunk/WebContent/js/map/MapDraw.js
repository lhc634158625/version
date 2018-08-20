function MapDraw(traceLayer, mapObj) {
    var _layers = new Array();
    var _linelayers = new Array();
    var _isShowLayerName = false;

    var _mapObj = mapObj;
    var _zoom = mapObj.ZoomIndex();
    var _gtimer;
    var _flashTime = 0;
    var _traceTime;
    var _traceIndex;
    var _flashId;
    var _traceObjects;
    var _stopTrace = false;
    var _pauseTrace = false;
    var _selectId = 0;
    this.InfoObjects;
    this.ThemeObject;
    this.PoliceObjects;
    this.PoliceId = 0;
    this.DeviceObjects;
    this.DeviceId = 0;
    this.RegionServiceObjects;
    this.LineObjects = new Array();
    this.OtherLineObjects = new Array();
    this.PinObjects = new Array();
    this.TrafficInfoObjects;
    this.CircleObject;
    this.RegionObjects;
    this.PIOObject;
    this.StartPosition;
    this.EndPosition;
    var self = this;
    var trafficType = 3;
    var _traceLayer = document.getElementById(traceLayer);
    var drawobj = new jsGraphics(traceLayer);
   
    drawobj.setColor("#7997df");
    drawobj.setStroke(4);
    this.CameraInfoObjects;
    this.RegionServiceTrafficObjects;
    this.GuardObjects;
    this.IsShowEdgeId = 0;
    this.PeakObjects; //高峰站点
    this.PeakStaffObjects; //高峰站点
    this.InterceptObjects; //拦截点
    this.RoutePlanDetailObjects;
    this.TaxiRegionObjects; //出租车聚集预警重点区域

    this.Distance = function () {
        if (this.PinObjects.length == 0) return;

        var distance = 0;
        //lat1,  lng1,  lat2,  lng2
        for (var i = 0; i < this.PinObjects.length - 1; i++) {
            distance += _mapObj.Distance(this.PinObjects[i].Latitude, this.PinObjects[i].Longitude, this.PinObjects[i + 1].Latitude, this.PinObjects[i + 1].Longitude);
        }
        return Math.round(distance);
    }

    this.Reset = function () {
        drawobj.clear();
        _traceLayer = document.getElementById(traceLayer);
        _traceLayer.innerHTML = "";

    }

    this.Draw = function () {
        this.Reset();
        if (_mapObj.PreZoom == _mapObj.Zoom()) return;
        _zoom = mapObj.ZoomIndex();
        ///转换坐标
        for (var i = 0; i < this.PinObjects.length; i++) {
            this.PinObjects[i].x = _mapObj.ScreenX(this.PinObjects[i].Longitude);
            this.PinObjects[i].y = _mapObj.ScreenY(this.PinObjects[i].Latitude);
        }


        if (this.PoliceObjects != null) {
            for (var i = 0; i < this.PoliceObjects.length; i++) {
                this.PoliceObjects[i].x = _mapObj.ScreenX(this.PoliceObjects[i].Longitude);
                this.PoliceObjects[i].y = _mapObj.ScreenY(this.PoliceObjects[i].Latitude);
            }
        }

        if (this.DeviceObjects != null) {
            for (var i = 0; i < this.DeviceObjects.length; i++) {
                this.DeviceObjects[i].x = _mapObj.ScreenX(this.DeviceObjects[i].Longitude);
                this.DeviceObjects[i].y = _mapObj.ScreenY(this.DeviceObjects[i].Latitude);
            }
        }

        if (this.RegionServiceObjects != null) {
            for (var i = 0; i < this.RegionServiceObjects.length; i++) {
                this.RegionServiceObjects[i].x = _mapObj.ScreenX(this.RegionServiceObjects[i].Longitude);
                this.RegionServiceObjects[i].y = _mapObj.ScreenY(this.RegionServiceObjects[i].Latitude);
            }
        }

        if (this.RegionObjects != null) {
            for (var i = 0; i < this.PoliceObjects.length; i++) {
                this.PoliceObjects[i].x = _mapObj.ScreenX(this.PoliceObjects[i].Longitude);
                this.PoliceObjects[i].y = _mapObj.ScreenY(this.PoliceObjects[i].Latitude);
            }
        }

        if (this.OtherLineObjects != null) {
            for (var i = 0; i < this.OtherLineObjects.length; i++) {
                this.OtherLineObjects[i].x = _mapObj.ScreenX(this.OtherLineObjects[i].Longitude);
                this.OtherLineObjects[i].y = _mapObj.ScreenY(this.OtherLineObjects[i].Latitude);
            }
        }
        if (this.TrafficInfoObjects != null) {
            //alert(this.TrafficInfoObjects.length);
            for (var i = 0; i < this.TrafficInfoObjects.length; i++) {
                this.TrafficInfoObjects[i].fromx = _mapObj.ScreenX(this.TrafficInfoObjects[i].FromX);
                this.TrafficInfoObjects[i].fromy = _mapObj.ScreenY(this.TrafficInfoObjects[i].FromY);
                this.TrafficInfoObjects[i].tox = _mapObj.ScreenX(this.TrafficInfoObjects[i].ToX);
                this.TrafficInfoObjects[i].toy = _mapObj.ScreenY(this.TrafficInfoObjects[i].ToY);
            }
        }

        if (this.CameraInfoObjects != null) {
            //alert(this.CameraInfoObjects.length);
            for (var i = 0; i < this.CameraInfoObjects.length; i++) {
                this.CameraInfoObjects[i].x = _mapObj.ScreenX(this.CameraInfoObjects[i].Lon);
                this.CameraInfoObjects[i].y = _mapObj.ScreenY(this.CameraInfoObjects[i].Lat);
            }
        }

        if (this.RegionServiceTrafficObjects != null) {
            for (var i = 0; i < this.RegionServiceTrafficObjects.length; i++) {
                this.RegionServiceTrafficObjects[i].x = _mapObj.ScreenX(this.RegionServiceTrafficObjects[i].Longitude);
                this.RegionServiceTrafficObjects[i].y = _mapObj.ScreenY(this.RegionServiceTrafficObjects[i].Latitude);
            }
        }

        if (this.GuardObjects != null) {
            //alert(this.GuardObjects.length);
            for (var i = 0; i < this.GuardObjects.length; i++) {
                this.GuardObjects[i].x = _mapObj.ScreenX(this.GuardObjects[i].CenterX);
                this.GuardObjects[i].y = _mapObj.ScreenY(this.GuardObjects[i].CenterY);
            }
        }

        if (this.ThemeObject != null) {
            this.ThemeObject.x = _mapObj.ScreenX(this.ThemeObject.Longitude);
            this.ThemeObject.y = _mapObj.ScreenY(this.ThemeObject.Latitude);
           
        }
        if (this.PIOObject != null) {
            this.PIOObject.x = _mapObj.ScreenX(this.PIOObject.Longitude);
            this.PIOObject.y = _mapObj.ScreenY(this.PIOObject.Latitude);

        }
        if (this.StartPosition != null) {
            this.StartPosition.x = _mapObj.ScreenX(this.StartPosition.Longitude);
            this.StartPosition.y = _mapObj.ScreenY(this.StartPosition.Latitude);
        }

        if (this.EndPosition != null) {
            this.EndPosition.x = _mapObj.ScreenX(this.EndPosition.Longitude);
            this.EndPosition.y = _mapObj.ScreenY(this.EndPosition.Latitude);
        }

        if (this.CircleObject != null) {
            this.CircleObject.x = _mapObj.ScreenX(this.CircleObject.Longitude);
            this.CircleObject.y = _mapObj.ScreenX(this.CircleObject.Latitude);
            this.CircleObject.Radiu = _mapObj.ToScreenWidth(this.CircleObject.Dist);

        }

        if (this.PeakObjects != null) {
            for (var i = 0; i < this.PeakObjects.length; i++) {
                this.PeakObjects[i].x = _mapObj.ScreenX(this.PeakObjects[i].Longitude);
                this.PeakObjects[i].y = _mapObj.ScreenY(this.PeakObjects[i].Latitude);
            }
        }

        if (this.PeakStaffObjects != null) {
            for (var i = 0; i < this.PeakStaffObjects.length; i++) {
                if (this.PeakStaffObjects[i].StaffLongitude == 0 || (this.PeakStaffObjects[i].StaffDevCodeState == "0")) {
                    this.PeakStaffObjects[i].x = _mapObj.ScreenX(this.PeakStaffObjects[i].Longitude);
                    this.PeakStaffObjects[i].y = _mapObj.ScreenY(this.PeakStaffObjects[i].Latitude);
                }
                else {
                    this.PeakStaffObjects[i].x = _mapObj.ScreenX(this.PeakStaffObjects[i].StaffLongitude);
                    this.PeakStaffObjects[i].y = _mapObj.ScreenY(this.PeakStaffObjects[i].StaffLatitude);
                }
            }
        }

        if (this.InterceptObjects != null) {
            for (var i = 0; i < this.InterceptObjects.length; i++) {
                this.InterceptObjects[i].x = _mapObj.ScreenX(this.InterceptObjects[i].CenterX);
                this.InterceptObjects[i].y = _mapObj.ScreenY(this.InterceptObjects[i].CenterY);
            }
        }

        if (this.RoutePlanDetailObjects != null) {
            for (var i = 0; i < this.RoutePlanDetailObjects.length; i++) {
                this.RoutePlanDetailObjects[i].x = _mapObj.ScreenX(this.RoutePlanDetailObjects[i].FromX);
                this.RoutePlanDetailObjects[i].y = _mapObj.ScreenY(this.RoutePlanDetailObjects[i].FromY);
                //this.RoutePlanDetailObjects[i].Content = this.RoutePlanDetailObjects[i].RoadName;
                this.RoutePlanDetailObjects[i].Type = this.RoutePlanDetailObjects[i].Count_Arrange > 0 ? 1 : 2; // Math.ceil(Math.random() * 2);
                this.RoutePlanDetailObjects[i].Name = this.RoutePlanDetailObjects[i].RoadName;
            }
        }

        if (this.TaxiRegionObjects != null) {
            for (var i = 0; i < this.TaxiRegionObjects.length; i++) {
                this.TaxiRegionObjects[i].x = _mapObj.ScreenX(this.TaxiRegionObjects[i].Longitude);
                this.TaxiRegionObjects[i].y = _mapObj.ScreenY(this.TaxiRegionObjects[i].Latitude);
            }
        }

        //画出
        {
            this.DrawLayer();
            this.DrawLineLayers();
            this.DrawPin();
            this.DrawInfos();
            this.DrawTheme();
           // this.DrawTrafficInfo();
            this.DrawStartPosition();
            this.DrawEndPosition();
            this.DrawPoliceInfos();
            this.DrawDeviceInfos();
            this.DrawRegionServiceInfos();
            this.DrawPIO();
            this.DrawLines();
            this.DrawOtherLines();
            this.DrawCameraInfos();
            this.DrawRegionServiceTraffics();
            this.DrawGuardObjects();
            this.DrawCircle();
            this.DrawPeakObjects();
            this.DrawInterceptObjects();
            this.DrawRoutePlanDetailObjects();
            this.DrawTaxiRegionObjects();
        }
    }
    this.FlashImage = function (id, type) {
        _gtimer = window.setInterval(self.BeginFlash, 500);
        _flashTime = 0;
        _flashId = "img_" + type + "_" + id;
    }
    this.BeginFlash = function () {
        var obj = document.getElementById(_flashId);
        if (obj == null) return;
        if (_flashTime >= 5) {
            window.clearInterval(_gtimer);
            obj.style.display = "block";
            return;
        }
        if (obj.style.display == "block")
            obj.style.display = "none"
        else
            obj.style.display = "block"
    }
    
    this.ResetLineLayer = function () {
        _layers = new Array();
        this.Draw();
    }
    this.AddLineLayer = function (name, objs) {

        var layer = new Object();
        layer.name = name;
        layer.visible = true;
        layer.objs = objs;
        _linelayers[_linelayers.length] = layer;
        this.DrawLineLayer(layer);
        //  var reg1 = new RegExp('"', "g");

    }
    this.DrawLineLayer = function (layer) {
        var svgDraw = new SVGDraw(layer.name, traceLayer);
        if (layer.objs == null) return;
        if (layer.objs.length == 0) return;
        layer.svgDraw = svgDraw;
        var strElement = "";
        var maxSpeed;
        for (var i = 0; i < layer.objs.length; i++) {
            if (layer.objs[i].Color == null)
                layer.objs[i].Color = "#ff0000";

            drawobj.setColor(layer.objs[i].Color);
            layer.objs[i].fromx = _mapObj.ScreenX(layer.objs[i].FromX);
            layer.objs[i].fromy = _mapObj.ScreenY(layer.objs[i].FromY);
            layer.objs[i].tox = _mapObj.ScreenX(layer.objs[i].ToX);
            layer.objs[i].toy = _mapObj.ScreenY(layer.objs[i].ToY);
            
            drawobj.svgDraw(layer.objs[i].fromx,
                    layer.objs[i].fromy,
                    layer.objs[i].tox,
                    layer.objs[i].toy, layer.objs[i].Color, 2);
        }
    }
    this.DrawLineLayers = function () {
        for (var i = 0; i < _linelayers.length; i++) {
            var svgDraw = new SVGDraw(layer.name, traceLayer);
            var layer = _linelayers[i];
            if (layer.objs == null) return;
            if (layer.objs.length == 0) return;
            layer.svrDraw = svgDraw;
            var strElement = "";
            var maxSpeed;
            for (var i = 0; i < layer.objs.length; i++) {
                if (layer.objs[i].Color == null)
                    layer.objs[i].Color = "#ff0000";

                drawobj.setColor(layer.objs[i].Color);
                layer.objs[i].fromx = _mapObj.ScreenX(layer.objs[i].FromX);
                layer.objs[i].fromy = _mapObj.ScreenY(layer.objs[i].FromY);
                layer.objs[i].tox = _mapObj.ScreenX(layer.objs[i].ToX);
                layer.objs[i].toy = _mapObj.ScreenY(layer.objs[i].ToY);
                drawobj.svgDraw(layer.objs[i].fromx,
                    layer.objs[i].fromy,
                    layer.objs[i].tox,
                    layer.objs[i].toy, layer.objs[i].Color, 2);
            }
        }
        
    }
    this.GetLineLayerByName = function (name) {
        for (var i = 0; i < _layers.length; i++) {
            if (_layers[i].name == name) return _layers[i];
        }
        return null;
    }
    this.ShowLineLayer = function (name, isShow) {
        var layer = GetLineLayerByName(name);
        //   if (layer.visible==isShow) return;
        layer.visible = isShow;
        layer.svgDraw.showLayer(name, isShow);

    }

    this.AddLayer = function (name, objs) {

        var layer = new Object();
        layer.name = name;
        layer.visible = true;
        layer.objs = objs;
        _layers[_layers.length] = layer;


        this.DrawLayerInfo(layer);
        //  var reg1 = new RegExp('"', "g");

    }
    this.ResetLayer = function () {
        _linelayers = new Array();
        this.Draw();
    }
    


    this.AppendLayer = function (name, objs) {

        var layer = GetLayerByName(name);
        if (layer == null) {
            this.AddLayer(name, objs);
            return;
        }
        layer.objs = layer.objs.concat(objs);


        this.DrawAppendLayer(layer,objs);
        //  var reg1 = new RegExp('"', "g");

    }

    this.DrawAppendLayer = function (layer, objs) {
        if (objs == null) return;
        var strHtml = "";
        var display = "";
        var layerIndex = GetLayerIndexByName(layer.name);
        var reg = new RegExp("'", "g");
        if (!layer.visible) display = " display:none;"
        for (var i = 0; i < objs.length; i++) {

            if (objs[i].Name != null) alt = objs[i].Name;

            if ((objs[i].longitude == null) || (objs[i].longitude < 100)) continue;
            objs[i].x = _mapObj.ScreenX(objs[i].longitude);
            objs[i].y = _mapObj.ScreenY(objs[i].latitude);


            if ((objs[i].MidImage != null) && (_zoom >= 6) && (_zoom <= 6)) {
                strHtml += '<div id="_Mark_' + layerIndex + '_' + objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (objs[i].x - 8) + 'px; top:' + (objs[i].y - 8) + 'px; min-width:20px;' + display + '" >';
                strHtml += '<img class="ImgLayer' + layer.name + '" src="' + objs[i].MidImage + '"  title="' + objs[i].Name + '" id="img_InfoObject_' + objs[i].StrId + '" style="max-height:12px;max-width:12px;" ondragstart="return false;" />';
            }
            else if ((objs[i].SmallImage != null) && (_zoom >= 7)) {
                strHtml += '<div id="_Mark_' + layerIndex + '_' + objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (objs[i].x - 8) + 'px; top:' + (objs[i].y - 8) + 'px; min-width:20px;' + display + '" >';
                strHtml += '<span class="ImgLayer' + layer.name + '" style="color:' + objs[i].SmallImage + ';"  id="img_InfoObject_' + objs[i].StrId + '" >●</span>';
            }
            else {
                var maxHeight = 36;
                if (_zoom > 6) maxHeight = 16;
                if (_zoom > 7) maxHeight = 12;
                strHtml += '<div id="_Mark_' + layerIndex + '_' + objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (objs[i].x - 8) + 'px; top:' + (objs[i].y - 8) + 'px; min-width:20px;' + display + '">';
                strHtml += '<img class="ImgLayer' + layer.name + '" src="' + objs[i].ImageUrl + '" style="max-height:'+maxHeight+'px;" title="' + objs[i].Name + '" id="img_InfoObject_' + objs[i].StrId + '" ondragstart="return false;" />';
            }

            if ((layer.objs[i].NameDivStyle != null) && (_zoom < 6))
                strHtml += '<div class="mapTitle" style=" margin-left:-10px;' + objs[i].NameDivStyle + '">' + objs[i].Name + '</div>';
            strHtml += '</div>';
        }
        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        $(".InforWindow").click(function (e) {
            var ids = this.id.split("_");
            var i = -1;
            var layerIndex = "";

            if (ids.length >= 4) {
                i = parseInt(ids[4]);
                layerIndex = parseInt(ids[2]);
            }
            var layer = _layers[layerIndex];
            if (i >= 0) {
                mapDraw.SelectObject(layer.objs[i].StrId);
                if (layer.objs[i].Content != null)
                    mapDraw.ShowInfoWindow1(layer.objs[i].x, layer.objs[i].y, (layer.objs[i].InfoContentWidth == null ? "0" : layer.objs[i].InfoContentWidth), 160, layer.objs[i].Content, layer.objs[i].Title);
                try { parent.SelectedItem(i, layer.name); }
                catch (e) { alert(e.message); }
            }
        });
    }
    this.DrawLayerInfo = function (layer) {
        if (layer.objs == null) return;
        var strHtml = "";
        var layerIndex = GetLayerIndexByName(layer.name);
        var reg = new RegExp("'", "g");
        var display = "";
        for (var i = 0; i < layer.objs.length; i++) {
            display = "";
            if (!layer.visible) display = " display:none;"
            if (layer.objs[i].Name != null) alt = layer.objs[i].Name;
            //if (layer.objs[i].Title != null) alt = layer.objs[i].Title;
            if ((layer.objs[i].longitude == null) || (layer.objs[i].longitude < 100)) continue;
            layer.objs[i].x = _mapObj.ScreenX(layer.objs[i].longitude);
            layer.objs[i].y = _mapObj.ScreenY(layer.objs[i].latitude);

            if ((layer.objs[i].MidImage != null) && (_zoom >= 6) && (_zoom <= 6)) {
                strHtml += '<div id="_Mark_' + layerIndex + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;' + display + '" >';
                strHtml += '<img class="ImgLayer' + layer.name + '" src="' + layer.objs[i].MidImage + '" title="' + layer.objs[i].Name + '" style="max-height:12px; max-width:12px;" id="img_InfoObject_' + layer.objs[i].StrId + '" ondragstart="return false;" />';
            }
            else if ((layer.objs[i].SmallImage != null) && (_zoom >= 7)) {
                strHtml += '<div id="_Mark_' + layerIndex + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;' + display + '" >';
                strHtml += '<span class="ImgLayer' + layer.name + '" style="color:' + layer.objs[i].SmallImage + ';"  id="img_InfoObject_' + layer.objs[i].StrId + '" >●</span>';
            }
            else {
                var maxHeight = 36;
                if (_zoom > 6) maxHeight = 16;
                if (_zoom > 7) maxHeight = 12;                
                strHtml += '<div id="_Mark_' + layerIndex + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;' + display + '">';
                strHtml += '<img class="ImgLayer' + layer.name + '" src="' + layer.objs[i].ImageUrl + '" style="max-height:'+maxHeight+'px;" title="' + layer.objs[i].Name + '" id="img_InfoObject_' + layer.objs[i].StrId + '" ondragstart="return false;" />';
            }

            if ((layer.objs[i].NameDivStyle != null) && (_zoom < 6))
                strHtml += '<div class="mapTitle" style="margin-left:-10px;' + layer.objs[i].NameDivStyle + '">' + layer.objs[i].Name + '</div>';
            strHtml += '</div>';
        }
        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        $(".InforWindow").click(function (e) {
            var ids = this.id.split("_");
            var i = -1;
            var layerIndex = "";

            if (ids.length >= 4) {
                i = parseInt(ids[4]);
                layerIndex = parseInt(ids[2]);
            }
            var layer = _layers[layerIndex];
            if (i >= 0) {
                mapDraw.SelectObject(layer.objs[i].StrId);
                if (layer.objs[i].Content != null)
                    mapDraw.ShowInfoWindow1(layer.objs[i].x, layer.objs[i].y, (layer.objs[i].InfoContentWidth == null ? "0" : layer.objs[i].InfoContentWidth), 160, layer.objs[i].Content, layer.objs[i].Title);
                try { parent.SelectedItem(i, layer.name); }
                catch (e) { alert(e.message); }
            }
        });
    }
    this.UpdateLayer = function (name, objs) {
        var layer = GetLayerByName(name);
        if (layer == null) {
            this.AddLayer(name, objs);
            return;
        }
        layer.objs = objs;
        $(".MapLayer" + name).remove();
        this.DrawLayerInfo(layer);

    }
    function GetLayerIndexByName(name) {

        for (var i = 0; i < _layers.length; i++) {
            if (_layers[i].name == name) return i;
        }
        return null;
    }
    function GetLayerByName(name) {

        for (var i = 0; i < _layers.length; i++) {
            if (_layers[i].name == name) return _layers[i];
        }
        return null;
    }
    this.RemoveLayerByName = function (name) {
        var index;
        for (var i = 0; i < _layers.length; i++) {
            if (_layers[i].name == name) {
                index = i;
                _layers[i].objs = null;
                _layers.splice(i, 1);
            }
        }
        $(".MapLayer" + name).remove();

        return null;
    }
    this.ShowLayer = function (name, isShow) {
    //var layer=GetLayerByName(name);
     //   if (layer.visible==isShow) return;

        if (isShow)
            $(".MapLayer" + name).show();
        else
            $(".MapLayer" + name).hide();
        //$(".ImgLayer" + name).attr("src", "../Images/map/c_01_b.gif");
        if (GetLayerByName(name) != null) GetLayerByName(name).visible = isShow;
    }
    this.ShowLayerName = function (isShow) {
        _isShowLayerName = isShow;
        if (isShow)
            $(".LayerName").show();
        else
            $(".LayerName").hide()

    }
    this.DrawLayer = function () {
        var strHtml = "";
        var reg = new RegExp("'", "g");

        for (var j = 0; j < _layers.length; j++) {
            var layer = _layers[j];
            if (layer.objs == null) continue;
            if (layer.visible == null) continue;
            for (var i = 0; i < layer.objs.length; i++) {
                if ((layer.objs[i].longitude == null) || (layer.objs[i].longitude < 100)) continue;
                if (layer.objs[i].Name != null) alt = layer.objs[i].Name;
                
                layer.objs[i].x = _mapObj.ScreenX(layer.objs[i].longitude);
                layer.objs[i].y = _mapObj.ScreenY(layer.objs[i].latitude);
               
                if ((layer.objs[i].MidImage != null) && (_zoom >= 6) && (_zoom <= 6)) {
                    strHtml += '<div id="_Mark_' + j + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;" >';
                    strHtml += '<img class="ImgLayer' + layer.name + '" src="' + layer.objs[i].MidImage + '" style="max-height:12px;max-width:12px;" title="' + layer.objs[i].Name + '" id="img_InfoObject_' + layer.objs[i].StrId + '" ondragstart="return false;"/>';
                }
                else if ((layer.objs[i].SmallImage != null) && (_zoom >= 7)) {
                    strHtml += '<div id="_Mark_' + j + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;" >';
                    strHtml += '<span class="ImgLayer' + layer.name + '" style="color:' + layer.objs[i].SmallImage + '; font-size:10px;"  id="img_InfoObject_' + layer.objs[i].StrId + '" ondragstart="return false;" >●</span>';                
                }
                else {
                 var maxHeight = 36;
                if (_zoom > 6) maxHeight = 16;
                if (_zoom > 7) maxHeight = 12;     
                    strHtml += '<div id="_Mark_' + j + '_' + layer.objs[i].Id + '_' + i + '" class="InforWindow MapLayer' + layer.name + '" style="white-space:nowrap;left:' + (layer.objs[i].x - 8) + 'px; top:' + (layer.objs[i].y - 8) + 'px; min-width:20px;" >';
                    strHtml += '<img class="ImgLayer' + layer.name + '" src="' + layer.objs[i].ImageUrl + '" style="max-height:'+maxHeight+'px;" title="' + layer.objs[i].Name + '" id="img_InfoObject_' + layer.objs[i].StrId + '" ondragstart="return false;" />';
                }
                if ((layer.objs[i].NameDivStyle != null)&&(_zoom <6))
                    strHtml += '<div class="mapTitle" style="margin-left:-10px;' + layer.objs[i].NameDivStyle + '">' + layer.objs[i].Name + '</div>';
                //strHtml += '<div class="mapTitle" style="color:#ff0000;">hello</div>';
                strHtml += '</div>';
            }
        }
        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        this.ShowLayerName(_isShowLayerName);
        for (var j = 0; j < _layers.length; j++) {
            this.ShowLayer(_layers[j].name, _layers[j].visible);
        }
        $(".InforWindow").click(function (e) {
            var ids = this.id.split("_");
            var i = -1;
            var layerIndex = "";

            if (ids.length >= 4) {
                i = parseInt(ids[4]);
                layerIndex = parseInt(ids[2]);
            }

            var layer = _layers[layerIndex];
            if (i >= 0) {
                mapDraw.SelectObject(layer.objs[i].StrId);
                if (layer.objs[i].Content != null)
                    mapDraw.ShowInfoWindow1(layer.objs[i].x, layer.objs[i].y, (layer.objs[i].InfoContentWidth == null ? "0" : layer.objs[i].InfoContentWidth), 160, layer.objs[i].Content, layer.objs[i].Title);
                try { parent.SelectedItem(i, layer.name); }
                catch (e) { alert(e.message); }
            }
        });
    }
    this.ShowLayerInfoWindow = function (layerName, i) {
        var layer = GetLayerByName(layerName);
        if (layer == null) return;      
        mapDraw.ShowInfoWindow1(layer.objs[i].x, layer.objs[i].y, (layer.objs[i].InfoContentWidth == null ? "0" : layer.objs[i].InfoContentWidth), 160, layer.objs[i].Content, layer.objs[i].Title);
        mapObj.PanTo(layer.objs[i].Longitude, layer.objs[i].Latitude);
        this.SelectObject(layer.objs[i].StrId);
    }
    this.SelectObject = function (id) {
        var ids = id.split("-");
        if (ids.length > 1) {

            var layer = GetLayerByName(ids[0]);
            if (layer == null) return;
            if (layer.objs[ids[1]] == null) return;
            if (!mapObj.IsVisible(layer.objs[ids[1]].x, layer.objs[ids[1]].y))
                mapObj.PanTo(layer.objs[ids[1]].longitude, layer.objs[ids[1]].latitude);
        }
        if (_selectId != 0)
            $("#img_InfoObject_" + _selectId).removeClass("ObjectSelect");
        $("#img_InfoObject_" + id).addClass("ObjectSelect");

        this.FlashImage("InfoObject", id);
        _selectId = id;
    }
    this.UpdateMark = function (obj)
    {
        var ids = obj.StrId.split("-");
        if (ids.length > 1) {

            var layer = GetLayerByName(ids[0]);
            if (layer == null) return;
            if (layer.objs[ids[1]] == null) return;
            var layerIndex = GetLayerIndexByName(layer.name);
            layer.objs[ids[1]].longitude=obj.longitude;
            layer.objs[ids[1]].latitude = obj.latitude;
            layer.objs[ids[1]].x = _mapObj.ScreenX(layer.objs[ids[1]].longitude);
            layer.objs[ids[1]].y = _mapObj.ScreenY(layer.objs[ids[1]].latitude);
       l
            if (!mapObj.IsVisible(layer.objs[ids[1]].x, layer.objs[ids[1]].y))
                mapObj.PanTo(layer.objs[ids[1]].longitude, layer.objs[ids[1]].latitude);
            $("#_Mark_"+layerIndex+"_"+ layer.objs[ids[1]].Id+"_"+ids[1]).css({left:(layer.objs[ids[1]].x -8)+"px",top:(layer.objs[ids[1]].y -8)+"px"});        
           
        }
        if (_selectId != 0)
            $("#img_InfoObject_" + _selectId).removeClass("ObjectSelect");
        $("#img_InfoObject_" + obj.StrId).addClass("ObjectSelect");
        this.FlashImage("InfoObject", obj.StrId);
        _selectId = obj.StrId;
    }
   
    this.DrawLines = function () {
        if (this.LineObjects == null) return;
        if (this.LineObjects.length < 2) return;
        var offset = $("#TraceLayer").offset();
        this.LineObjects[0].x = _mapObj.ScreenX(this.LineObjects[0].Longitude);
        this.LineObjects[0].y = _mapObj.ScreenY(this.LineObjects[0].Latitude);
        var color = "#0000ff";
        /*
        var drawObj1 = new SVGDraw("id2", "TraceLayer");
        var draw = SVG('TraceLayer');        
        var strElement = "";
        var maxSpeed;
        var minX = this.LineObjects[0].x, minY = this.LineObjects[0].y, maxX = this.LineObjects[0].x, maxY = this.LineObjects[0].y;
        var posStr = this.LineObjects[0].x + "," + this.LineObjects[0].y;
        for (var i = 0; i < this.LineObjects.length - 1; i++) {

            this.LineObjects[i + 1].x = _mapObj.ScreenX(this.LineObjects[i + 1].Longitude);
            this.LineObjects[i + 1].y = _mapObj.ScreenY(this.LineObjects[i + 1].Latitude);
            if (this.LineObjects[i].ServiceId > 0)
                this.LineObjects[i].color = "#ff0000";
            else
                this.LineObjects[i].color = "#0000ff";

        }

        drawObj1.drawLine(this.LineObjects, 1);
        */
       
        drawobj.setStroke(4);
        for (var i = 0; i < this.LineObjects.length - 1; i++) {
            // if(!this.CheckPos(this.LineObjects[i].x, this.LineObjects[i].y)) continue;
            //  if(!this.CheckPos(this.LineObjects[i+1].x, this.LineObjects[i+1].y)) continue;
            trimLine = this.Trim(this.LineObjects[i].x, this.LineObjects[i].y, this.LineObjects[i + 1].x, this.LineObjects[i + 1].y);
            if (trimLine == null) continue;
            if (this.LineObjects[i].ServiceId > 0)
                drawobj.setColor("#ff0000");
            else
                drawobj.setColor("#ff0000");

            //  alert(trimLine.x1 + "," + trimLine.y1 + "," + trimLine.x2 + "," + trimLine.y2);
            drawobj.drawLine(trimLine.x1, trimLine.y1, trimLine.x2, trimLine.y2)
        }

        drawobj.paint();
        
    }
    this.DrawOtherLines = function () {
        if (this.OtherLineObjects == null) return;
        if (this.OtherLineObjects.length < 2) return;
        // alert(this.LineObjects.length);
        drawobj.setColor("#ae0391");
        drawobj.setStroke(4);
        for (var i = 0; i < this.OtherLineObjects.length - 1; i++) {
            // if(!this.CheckPos(this.LineObjects[i].x, this.LineObjects[i].y)) continue;
            //  if(!this.CheckPos(this.LineObjects[i+1].x, this.LineObjects[i+1].y)) continue;
            trimLine = this.Trim(this.OtherLineObjects[i].x, this.OtherLineObjects[i].y, this.OtherLineObjects[i + 1].x, this.OtherLineObjects[i + 1].y);
            if (trimLine == null) continue;
            //  alert(trimLine.x1 + "," + trimLine.y1 + "," + trimLine.x2 + "," + trimLine.y2);
            drawobj.drawLine(trimLine.x1, trimLine.y1, trimLine.x2, trimLine.y2)
        }

        drawobj.paint();
    }
    this.Trim = function (x1, y1, x2, y2) {
        return { "x1": x1, "y1": y1, "x2": x2, "y2": y2 };
        if (this.CheckPos(x1, y1) && this.CheckPos(x2, y2)) return { "x1": x1, "y1": y1, "x2": x2, "y2": y2 };
        // if ((!this.CheckPos(x1, y1)) && (!this.CheckPos(x2, y2))) return null;
        if (x1 == x2) //same x
        {
            if ((x1 >= mapObj.Left) && (x1 <= mapObj.Right)) //in window
            {
                if (y1 <= mapObj.Top) y1 = mapObj.Top;
                if (y1 >= mapObj.Bottom) y1 = mapObj.Bottom;
                if (y2 <= mapObj.Top) y2 = mapObj.Top;
                if (y2 >= mapObj.Bottom) y2 = mapObj.Bottom;
                return { "x1": x1, "y1": y1, "x2": x2, "y2": y2 };
            }
            else
                return null;
        }
        var p1, p2, p3, p4;

        var delta = (y2 - y1) / (x2 - x1);
        if (delta == 0)//same in y
        {
            if ((y1 >= mapObj.Top) && (y1 <= mapObj.Bottom)) //in window
            {
                if (x1 <= mapObj.Left) x1 = mapObj.Left;
                if (x1 >= mapObj.Right) x1 = mapObj.Right;
                if (x2 <= mapObj.Left) x2 = mapObj.Left;
                if (x2 >= mapObj.Right) x2 = mapObj.Right;
                return { "x1": x1, "y1": y1, "x2": x2, "y2": y2 };
            }
            else
                return null;
        }

        lefty = delta * (mapObj.Left - x1) + y1;
        if ((lefty >= mapObj.Top) && (lefty <= mapObj.Bottom) && ((x1 < mapObj.Left) || (x2 < mapObj.Left))) {
            p1 = new Object();
            p1.x = mapObj.Left;
            p1.y = lefty;
        }
        righty = delta * (mapObj.Right - x1) + y1;
        if ((righty >= mapObj.Top) && (righty <= mapObj.Bottom) && ((x1 > mapObj.Right) || (x2 > mapObj.Right))) {
            p2 = new Object();
            p2.x = mapObj.Right;
            p2.y = righty;
        }
        topx = (mapObj.Top - y1) / delta + x1;
        if ((topx >= mapObj.Left) && (topx <= mapObj.Right) && ((y1 < mapObj.Top) || (y2 < mapObj.Top))) {
            p3 = new Object();
            p3.y = mapObj.Top;
            p3.x = topx;
        }
        bottomx = (mapObj.Bottom - y1) / delta + x1;
        if ((bottomx >= mapObj.Left) && (bottomx <= mapObj.Right) && ((y1 > mapObj.Bottom) || (y2 > mapObj.Bottom))) {
            p4 = new Object();
            p4.y = mapObj.Bottom;
            p4.x = bottomx;
        }
        if (p1 == null) p1 == p2;
        if (p1 == null) p1 = p3;
        if (p1 == null) p1 = p4;

        if (p2 == null) p2 = p3;
        if (p2 == null) p2 = p4;

        if ((p1 != null) && (p2 != null) && (p1 != p2)) return { "x1": p1.x, "y1": p1.y, "x2": p2.x, "y2": p2.y };
        if ((p1 != null) && (p2 != null) && (p1 == p2)) {
            if (this.CheckPos(x1, y1)) {
                p2 = new Object();
                p2.x = x1;
                p2.y = y1;
            }
            if (this.CheckPos(x2, y2)) {
                p2 = new Object();
                p2.x = x2;
                p2.y = y2;
            }
            return { "x1": p1.x, "y1": p1.y, "x2": p2.x, "y2": p2.y };
        }
        return null;
    }
    this.CheckPos = function (x, y) {
        var mapWidth = mapObj.Right - mapObj.Left;
        var mapHeight = mapObj.Bottom - mapObj.Top;
        if (x < (mapObj.Left)) return false;
        if (x > (mapObj.Right)) return false;
        if (y < (mapObj.Top)) return false;
        if (y > (mapObj.Bottom)) return false;
        return true;
    }
    this.AddLinePoint = function (x, y) {
        var lineObject = new Object();
        lineObject.Longitude = x;
        lineObject.Latitude = y;
        if (this.LineObjects == null) this.LineObjects = new Array();
        this.LineObjects[this.LineObjects.length] = lineObject;
    }

    this.ClearLinePoint = function () {
        this.LineObjects = new Array();
    }

    // 显示起始点
    this.DrawStartPosition = function () {
        if (this.StartPosition == null) return;

        var strHtml = '<div class="DivFrom" style="left:' + (this.StartPosition.x - 14) + 'px; top:' + (this.StartPosition.y - 32) + 'px;"></div>';

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    // 显示终止点
    this.DrawEndPosition = function () {
        if (this.EndPosition == null) return;

        var strHtml = '<div class="DivTo" style="left:' + (this.EndPosition.x - 14) + 'px; top:' + (this.EndPosition.y - 32) + 'px;"></div>';

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    // 显示信息点
    this.DrawPin = function () {
        if (this.PinObjects.length == 0) return;

        var strHtml = "";
        for (var i = 0; i < this.PinObjects.length; i++) {
            strHtml += '<div class="Pin" style="left:' + (this.PinObjects[i].x - 12) + 'px; top:' + (this.PinObjects[i].y - 38) + 'px">' + String.fromCharCode(65 + i) + '</div>';
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }
    //显示圆圈
    this.DrawCircle = function () {
        if (this.CircleObject == null) return
        var strHtml = "";
        for (var i = 0; i < this.PinObjects.length; i++) {
            strHtml += '<div  style="left:' + (this.CircleObject.x + this.CircleObject.Radiu) + 'px; top:' + (this.CircleObject.y - this.CircleObject.Radiu) + 'px"><img src="../images/circle.gif" width=' + this.CircleObject.Radiu * 2 + '></div>';
        }
        alert(strHtml);
        this.InsertHtml("afterbegin", _traceLayer, strHtml);

    }
    this.AddPin = function (x, y) {
        var pinObject = new Object();
        pinObject.Longitude = x;
        pinObject.Latitude = y;
        this.PinObjects[this.PinObjects.length] = pinObject;
    }

    this.ClearPin = function (x, y) {
        this.PinObjects = null;
        this.PinObjects = new Array();
    }

    // 显示信息点
    this.DrawInfos = function () {
        if (this.InfoObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var alt;
        for (var i = 0; i < this.InfoObjects.length; i++) {
            // if (!this.CheckPos(this.InfoObjects[i].x, this.InfoObjects[i].y)) continue;
            alt = "";
            this.InfoObjects[i].x = _mapObj.ScreenX(this.InfoObjects[i].Longitude);
            this.InfoObjects[i].y = _mapObj.ScreenY(this.InfoObjects[i].Latitude);
            if (this.InfoObjects[i].Name != null) alt = this.InfoObjects[i].Name;
            if (this.InfoObjects[i].Title != null) alt = this.InfoObjects[i].Title;
            strHtml += '<div class="InforWindow" style="white-space:nowrap;left:' + (this.InfoObjects[i].x - 8) + 'px; top:' + (this.InfoObjects[i].y - 8) + 'px; min-width:20px;" ';
            /*
            if (this.InfoObjects[i].Content == null)
            strHtml += 'onmouseover="mapDraw.ShowText(' + (this.InfoObjects[i].x - 7) + ', ' + (this.InfoObjects[i].y - 20) + ', \'' + alt + '\')" '
            + ' onmouseout="mapDraw.HideText()">';
            else*/
            strHtml += '>';

            if (this.InfoObjects[i].ImageUrl == null)
                strHtml += '<img src="../images/stop.gif" title="' + alt + '"';
            else {
                if (this.InfoObjects[i].Id == null) {
                    strHtml += '<img src="' + this.InfoObjects[i].ImageUrl + '" title="' + alt + '"';
                }
                else {
                    strHtml += '<img src="' + this.InfoObjects[i].ImageUrl + '" title="' + alt + '" id="img_InfoObject_' + this.InfoObjects[i].Id + '"';
                }
            }
            if (this.InfoObjects[i].AutoResize) {
                var imgWH = this.InfoObjects[i].ImageWidth;
                if (_mapObj.ZoomIndex() < 6) {
                }
                else {
                    imgWH = imgWH / ((_mapObj.ZoomIndex() - 4) * 0.5);
                }

                if (this.InfoObjects[i].ImageWidth != null) {
                    strHtml += ' width="' + imgWH + '"';
                }
            }
            if (this.InfoObjects[i].Content != null) {
                if (this.InfoObjects[i].Name == null) {
                    strHtml += ' onclick=" mapDraw.ShowInfoWindow(' + this.InfoObjects[i].x + ',' + this.InfoObjects[i].y + ',200,160,\'' + this.InfoObjects[i].Content.replace(reg, "\\'") + '\',true);GetSerivceMemo(' + this.InfoObjects[i].Id + ');try{parent.SelectedItem(' + this.InfoObjects[i].Id + ',' + this.InfoObjects[i].Longitude + ',' + this.InfoObjects[i].Latitude + ',\'' + this.InfoObjects[i].Name + '\');} catch(e){ alert(e.message);}" /></div>';
                }
                else {
                    if (this.InfoObjects[i].Isqtip == null || this.InfoObjects[i].Isqtip == false) {
                        strHtml += ' onclick=" mapDraw.ShowInfoWindow(' + this.InfoObjects[i].x + ',' + this.InfoObjects[i].y + ',200,160,\'' + this.InfoObjects[i].Content.replace(reg, "\\'") + '\',true);GetSerivceMemo(' + this.InfoObjects[i].Id + ');try{parent.SelectedItem(' + this.InfoObjects[i].Id + ',' + this.InfoObjects[i].Longitude + ',' + this.InfoObjects[i].Latitude + ',\'' + this.InfoObjects[i].Name + '\');} catch(e){ alert(e.message);}" />';
                    }
                    else {
                        strHtml += ' onclick=" try{parent.SelectedItem(\'' + this.InfoObjects[i].Id + '\',' + this.InfoObjects[i].Longitude + ',' + this.InfoObjects[i].Latitude + ',\'' + this.InfoObjects[i].Name + '\',\'' + this.InfoObjects[i].ObjectType + '\');} catch(e){ alert(e.message);}" />';
                    }
                    if (this.InfoObjects[i].NameDivStyle == null) {
                        strHtml += this.InfoObjects[i].Name;
                    }
                    else {
                        if (this.InfoObjects[i].NameMaxZoomIndex == null) {
                            strHtml += '<div class="mapTitle" style="' + this.InfoObjects[i].NameDivStyle + '">' + this.InfoObjects[i].Name + '</div>';
                        }
                        else {
                            if (_mapObj.ZoomIndex() <= this.InfoObjects[i].NameMaxZoomIndex) {
                                strHtml += '<div class="mapTitle" style="' + this.InfoObjects[i].NameDivStyle + '">' + this.InfoObjects[i].Name + '</div>';
                            }
                        }
                    }
                    strHtml += '</div>';
                }
            } else {
                strHtml += ' onclick=" try{parent.SelectedItem(' + this.InfoObjects[i].Id + ',' + this.InfoObjects[i].Longitude + ',' + this.InfoObjects[i].Latitude + ',\'' + this.InfoObjects[i].Name + '\',\'' + this.InfoObjects[i].ObjectType + '\');} catch(e){ alert(e.message);}" />' + (this.InfoObjects[i].Name == null ? "" : this.InfoObjects[i].Name) + '</div>';
            }
            if (this.InfoObjects[i].Type == "指挥点") {
                strHtml += '<div style="position:absolute;left:' + (this.InfoObjects[i].x - 8) + 'px; top:' + (this.InfoObjects[i].y - 40) + 'px"><img src="../images/map/flag.png" ></div><div style="position:absolute;left:' + (this.InfoObjects[i].x + 2) + 'px; top:' + (this.InfoObjects[i].y - 36) + 'px">' + this.InfoObjects[i].Orders + '</div></div>';
            }
            if (this.InfoObjects[i].Type == "总部点") {
                strHtml += '<div style="position:absolute;left:' + (this.InfoObjects[i].x - 8) + 'px; top:' + (this.InfoObjects[i].y - 60) + 'px;z-index:5;"><img src="../images/map/headflag.png" ></div><div style="position:absolute;left:' + (this.InfoObjects[i].x + 2) + 'px; top:' + (this.InfoObjects[i].y - 36) + 'px">' + this.InfoObjects[i].Orders + '</div></div>';
            }
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);

    }

    var traceShowCount = 1;
    this.AddTrace = function (objs) {
        this.LineObjects = objs;
        this.InfoObjects = objs;
        this.DrawLines();
        this.DrawInfos();
        Draw();
    }
    var traceSpee=0
    var traceTimer
    var currIndex;   
    var posCount;
    var currCount;
    var timer = 10;
    var _speed;
    this.StartTrace = function (speed, imgUrl) {
        if (this.LineObjects == null) return;
        if (this.LineObjects.length < 0) return;
        _stopTrace = false;
        _pauseTrace = false;
        this.ThemeObject = new Object();
        this.ThemeObject.Longitude = this.LineObjects[0].Longitude;
        this.ThemeObject.Latitude = this.LineObjects[0].Latitude;
        this.ThemeObject.ImageUrl = imgUrl;
        this.ThemeObject.x = _mapObj.ScreenX(this.ThemeObject.Longitude);
        this.ThemeObject.y = _mapObj.ScreenY(this.ThemeObject.Latitude);
        currIndex = 0;
        if (this.LineObjects.length < 1) {
            this.DrawTheme();
            return;
        }
        this.ThemeObject.Angle = this.GetDegree(this.LineObjects[currIndex], this.LineObjects[currIndex + 1]);
        this.DrawTheme();
        _speed = speed;
        this.MoveNext();
    }
    this.MoveTrack = function (index) {
        this.PauseTrace();
        currIndex = index;
        this.PauseTrace();
    }
    this.MoveNext = function () {
        if (currIndex >= (self.LineObjects.length - 1)) return;
        if (_pauseTrace) return;
        if (_stopTrace) return;
        var step = _speed / (1000 / timer)
        posCount = Math.round(mapObj.Distance(self.LineObjects[currIndex].Longitude, self.LineObjects[currIndex].Latitude, self.LineObjects[currIndex + 1].Longitude, self.LineObjects[currIndex + 1].Latitude) / step);
        if (posCount < 1) {
            currIndex++;
            this.MoveNext();
            return;
        }
        currCount = 0;
        traceTimer = setInterval(function () {
            currCount++;
            if (currCount >= posCount) {
                clearInterval(traceTimer);
                currIndex++;
                self.MoveNext();
                return;
            }

            // self.ThemeObject.x = currPos.x;
            //  self.ThemeObject.y = currPos.y;

            self.ThemeObject.Longitude = self.NextPos(self.LineObjects[currIndex].Longitude, self.LineObjects[currIndex + 1].Longitude, posCount, currCount);
            self.ThemeObject.Latitude = self.NextPos(self.LineObjects[currIndex].Latitude, self.LineObjects[currIndex + 1].Latitude, posCount, currCount);
            var offset = $("#TraceLayer").offset();
            self.ThemeObject.x = _mapObj.ScreenX(self.ThemeObject.Longitude) + offset.left;
            self.ThemeObject.y = _mapObj.ScreenY(self.ThemeObject.Latitude) + offset.top;
            if (!mapObj.IsVisible(self.ThemeObject.x, self.ThemeObject.y)) {
                mapObj.PanTo(self.ThemeObject.Longitude, self.ThemeObject.Latitude);
                self.ThemeObject.x = _mapObj.ScreenX(self.ThemeObject.Longitude) + offset.left;
                self.ThemeObject.y = _mapObj.ScreenY(self.ThemeObject.Latitude) + offset.top;
            }
            if (currIndex < (self.LineObjects.length - 1))
                self.ThemeObject.Angle = self.GetDegree(self.LineObjects[currIndex], self.LineObjects[currIndex + 1]);
            self.ThemeObject.Content = self.LineObjects[currIndex].PosDesc;
            self.UpdateTheme();
        }, timer);
    }
    this.NextPos = function (first,last,totalCount,currIndex) {
        return first+currIndex * (last - first) / totalCount;
    }
    this.GetDegree=function(curPos,targetPos){
    var deg = 0;
            //start!
          

            if(targetPos.x != curPos.x){
                    var tan = (targetPos.y - curPos.y)/(targetPos.x - curPos.x),
                    atan  = Math.atan(tan);
                    deg = atan*360/(2*Math.PI);
                    //degree  correction;
                    if(targetPos.x < curPos.x){
                        deg = -deg + 90 + 90;

                    } else {
                        deg = -deg;
                    }
                    return -deg;                   

            }else {
                    var disy = targetPos.y- curPos.y ;
                    var bias = 0;
                    if(disy > 0)
                        bias=-1
                    else
                        bias = 1
                    return -bias * 90;  
            }
    }
    this.StopTrace = function () {
        _stopTrace = true;
        clearInterval(traceTimer);
        currIndex = 0;
    }
    this.PauseTrace = function () {
        if (_pauseTrace) {
            _pauseTrace = false;
            this.MoveNext();
        }
        else {
            _pauseTrace = true;
           // clearInterval(traceTimer);
        }
    }
    this.ClearTrace = function () {
        this.Reset();
        this.LineObjects = null;
        this.InfoObjects = null;
        this.ThemeInfo = null;
        this.ThemeObject = null;
        this.Draw();
    }
    // 显示警员信息点
    this.DrawPoliceInfos = function () {
        if (this.PoliceObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var policeObject = null;
        for (var i = 0; i < this.PoliceObjects.length; i++) {
            // if (!this.CheckPos(this.InfoObjects[i].x, this.InfoObjects[i].y)) continue;
            if (this.PoliceObjects[i].Id == this.PoliceId)
                policeObject = this.PoliceObjects[i];

            strHtml += '<div class="InforWindow contextMenu" style="left:' + this.PoliceObjects[i].x + 'px; top:' + this.PoliceObjects[i].y + 'px"';
            strHtml += ' onmouseover="curPoliceId=' + this.PoliceObjects[i].Id + ';mapDraw.ShowInfoWindow(' + (this.PoliceObjects[i].x + 8) + ',' + (this.PoliceObjects[i].y + 8) + ',200,180,\'' + this.PoliceObjects[i].Content.replace(reg, "\\'") + '\');GetSerivceMemo(' + this.PoliceObjects[i].LastService + ');"';
            // strHtml += ' onmouseout="/*mapDraw.HideInfoWindow()*/">';
            strHtml += '/>';
            if (mapObj.ZoomIndex() <= 6) {
                strHtml += '<div style="color: Green; font-weight: bold; text-align: center; ">' + this.PoliceObjects[i].Region + '</div>';
            }
            strHtml += '<img id=img_police_"' + this.PoliceObjects[i].Id + '" src="' + this.GetPoliceImage(this.PoliceObjects[i]) + '"  onclick=" try{parent.SelectedItem(' + this.PoliceObjects[i].Id + ',' + this.PoliceObjects[i].Longitude + ',' + this.PoliceObjects[i].Latitude + ',\'' + this.PoliceObjects[i].Name + '\');} catch(e){ alert(e.message);}" />'
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        if (policeObject != null)
            this.ShowInfoWindow(policeObject.x + 8, policeObject.y + 8, 200, 160, policeObject.Content);
        // alert(strHtml);  
        // this.PoliceObjects = null
        //右键
        initContextMenu();
    }

    this.GetPoliceImage = function (policeObject) {
        var imgsrc = "../images/map/shift" + policeObject.ShiftId;
        // if (policeObject.State == "接警")
        imgsrc += "_1.gif";
        //        else
        //            imgsrc += "_2.gif";
        if (mapObj.ZoomIndex() > 6) {
            // if (policeObject.IsOverTime)
            //     return "../images/map/small.gif";
            if ((policeObject.StateId == 0) || (policeObject.StateId == 5))
                imgsrc = "../images/map/small_0.gif";
            if ((policeObject.StateId == 1) || (policeObject.StateId == 2))
                imgsrc = "../images/map/small_1.gif";
            if ((policeObject.StateId == 3))
                imgsrc = "../images/map/small_2.gif";
            if ((policeObject.StateId == 4))
                imgsrc = "../images/map/small_3.gif";
            if ((policeObject.StateId == 6))
                imgsrc = "../images/map/small_4.gif";
        }
        else {
            //            if (policeObject.IsOverTime) return "../images/map/shift" + policeObject.ShiftId + ".gif"
            if (policeObject.StateId == 0);
            imgsrc = "../images/map/shift" + policeObject.ShiftId + "_0.gif";
            if ((policeObject.StateId == 1) || (policeObject.StateId == 2))
                imgsrc = "../images/map/shift" + policeObject.ShiftId + "_1.gif";
            if ((policeObject.StateId == 3))
                imgsrc = "../images/map/shift" + policeObject.ShiftId + "_2.gif";
            if ((policeObject.StateId == 4))
                imgsrc = "../images/map/shift" + policeObject.ShiftId + "_3.gif";
            if ((policeObject.StateId == 5))
                imgsrc = "../images/map/shift" + policeObject.ShiftId + "_4.gif";
        }
        return imgsrc;
    }

    // 显示设备信息点
    this.DrawDeviceInfos = function () {
        if (this.DeviceObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var deviceObject = null;
        for (var i = 0; i < this.DeviceObjects.length; i++) {
            // if (!this.CheckPos(this.InfoObjects[i].x, this.InfoObjects[i].y)) continue;
            if (this.DeviceObjects[i].Id == this.DeviceId)
                deviceObject = this.DeviceObjects[i];
            if (this.DeviceObjects[i].Content == null) this.DeviceObjects[i].Content = "";
            strHtml += '<div class="InforWindow contextMenu" style="left:' + this.DeviceObjects[i].x + 'px; top:' + this.DeviceObjects[i].y + 'px"';
            strHtml += ' onmouseover="curPoliceId=\'' + this.DeviceObjects[i].Code + ',devcode\';mapDraw.ShowInfoWindow(' + (this.DeviceObjects[i].x + 8) + ',' + (this.DeviceObjects[i].y + 8) + ',200,180,\'' + this.DeviceObjects[i].Content.replace(reg, "\\'") + '\');GetSerivceMemo(' + this.DeviceObjects[i].LastStaffWorkLogId + ');"';
            strHtml += ' onclick="mapDraw.ShowInfoWindow(' + (this.DeviceObjects[i].x + 8) + ',' + (this.DeviceObjects[i].y + 8) + ',200,180,\'' + this.DeviceObjects[i].Content.replace(reg, "\\'") + '\', true);GetSerivceMemo(' + this.DeviceObjects[i].LastStaffWorkLogId + ');"';
            // strHtml += ' onmouseout="/*mapDraw.HideInfoWindow()*/">';
            strHtml += '/>';

            strHtml += GetTitleByZoom(this.DeviceObjects[i].StationName, this.DeviceObjects[i].RegionName, this.DeviceObjects[i].Name, 4, 2, this.DeviceObjects[i]);

            strHtml += '<img id="img_device_' + this.DeviceObjects[i].Id + '" src="' + this.GetDeiveImage(this.DeviceObjects[i]) + '" ' + ((this.DeviceObjects[i].LastGPSInfo != null) ? ' onclick=" try{parent.SelectedItem(' + this.DeviceObjects[i].Id + ',' + this.DeviceObjects[i].LastGPSInfo.Longitude + ',' + this.DeviceObjects[i].LastGPSInfo.Latitude + ',\'' + this.DeviceObjects[i].Name + '\');} catch(e){ alert(e.message);}"' : '') + ' />';
            strHtml += '</div>';
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        //if (deviceObject != null)
        //    this.ShowInfoWindow(deviceObject.x + 8, deviceObject.y + 8, 200, 160, deviceObject.Content);
        // alert(strHtml);  

        //右键
        initContextMenu();
    }

    this.GetDeiveImage = function (contentObj) {
        var strTraceImg = "_0";
        var type = 4;
        if (contentObj.Type == "单兵电台(单模)" || contentObj.Type == "PDT") {
            type = 9;
        }
        var imgsrc = "../images/map/shift" + type;
        imgsrc += "_0.png";


        if (contentObj.State == "离线")
            imgsrc = "../images/map/shift" + type + "_5" + strTraceImg + ".png";
        else if (contentObj.IsOverTime)
            imgsrc = "../images/map/shift" + type + "_0" + strTraceImg + ".png";
        else if (contentObj.NeedProcess == true)
            imgsrc = "../images/map/shift" + type + "_1" + strTraceImg + ".png";
        else
            imgsrc = "../images/map/shift" + type + "_0" + strTraceImg + ".png";

        return imgsrc;
    }
    function GetTitleByZoom(station, region, name, type, state, item) {
        if (station == null) station = "";
        if (region == null) region = "";
        var title = "", typeClass = "";

        if (mapObj.ZoomIndex() > 6) return "";

        station = station.replace("厦门市公安局", "").replace("派出所", "").replace("边防", "");
        if (name == null) name = "";
        name = name.replace("闽D", "").replace("警", "");

        var color = "";
        if (item != null) {
            if (item.NeedProcess == true)
                color = "red";
            else {
                color = "green";
            }
        }


        if (type == 1) {

        }
        else if (type == 2) {
            if (region != "") {
                title = region + "_" + name;
            }
            else {
                title = station + "_" + name;
            }
        }
        else if (type == 3) {

        }
        else if (type == 4) {
            if (region != "") {
                title = region + "_" + name;
            }
            else {
                title = station + "_" + name;
            }
        }


        if (title == "") return "";

        if (color == "") {
            title = '<div  class="mapTitle ' + type + '">' + title + '</div>';
        }
        else {
            title = '<div style="color:' + color + '" class="mapTitle ' + type + '">' + title + '</div>';
        }

        return title;
    }

    // 显示警情信息点
    this.DrawRegionServiceInfos = function () {
        if (this.RegionServiceObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var regionServiceObject = null;
        for (var i = 0; i < this.RegionServiceObjects.length; i++) {
            // if (this.RegionServiceObjects[i].Id == this.PoliceId)
            //     regionServiceObject = this.DeviceObjects[i];

            var x = _mapObj.ScreenX(this.RegionServiceObjects[i].Longitude);
            var y = _mapObj.ScreenY(this.RegionServiceObjects[i].Latitude);

            strHtml += '<div class="InforWindow contextMenu" style="left:' + x + 'px; top:' + y + 'px"';
            strHtml += ' onmouseover="mapDraw.ShowInfoWindow(' + (x + 8) + ',' + (y + 8) + ',200,180,\'' + this.RegionServiceObjects[i].AlertContent.replace(reg, "\\'") + '\');GetSerivceMemo(' + this.RegionServiceObjects[i].Id + ');"';
            //strHtml += ' onmouseout="/*mapDraw.HideInfoWindow()*/">';
            strHtml += '/>';
            strHtml += '<img src="../images/map/alertpoint.gif" /></div>';
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        if (regionServiceObject != null)
            this.ShowInfoWindow(deviceObject.x + 8, deviceObject.y + 8, 200, 160, deviceObject.Content);
        // alert(strHtml);  

        //右键
        initContextMenu();
    }

    // 显示监控信息点
    this.DrawCameraInfos = function () {
        if (this.CameraInfoObjects == null)
            return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var cameraObject = null;
        var regionName = "";
        var peakSite = "";
        var cameraTitle = "";
        var imgWH = 20;
        if (_mapObj.ZoomIndex() < 6) {
        }
        else {
            imgWH = imgWH / ((_mapObj.ZoomIndex() - 4) * 0.5);
        }
        for (var i = 0; i < this.CameraInfoObjects.length; i++) {
            //            if (this.CameraInfoObjects[i].Id == this.PoliceId)
            //                deviceObject = this.CameraInfoObjects[i];

            regionName = this.CameraInfoObjects[i].CommunityName + " " + this.CameraInfoObjects[i].RegionName;
            regionName = (regionName.replace("边防", "")).replace("派出所", "");
            peakSite = ((this.CameraInfoObjects[i].PeakSite == null || this.CameraInfoObjects[i].PeakSite == "NULL") ? " " : this.CameraInfoObjects[i].PeakSite);
            if (peakSite != " ")
                peakSite = peakSite + "类";
            cameraTitle = this.CameraInfoObjects[i].ChannelName + " (" + regionName + " " + peakSite + ")";

            strHtml += '<div class="InforWindow contextMenu" style="left:' + this.CameraInfoObjects[i].x + 'px; top:' + (this.CameraInfoObjects[i].y - imgWH) + 'px"';
            strHtml += ' onmouseover="curPoliceId=' + this.CameraInfoObjects[i].Id + ';mapDraw.ShowInfoWindow(' + (this.CameraInfoObjects[i].x + 8) + ',' + (this.CameraInfoObjects[i].y + 8) + ',200,180,\'' + this.CameraInfoObjects[i].Content.replace(reg, "\\'") + '\');"';
            strHtml += '/>';

            strHtml += '<img height="' + imgWH + '" src="' + this.GetCameraImage(this.CameraInfoObjects[i]) + '"  onclick=" try{mapDraw.ShowInfoWindow(' + (this.CameraInfoObjects[i].x + 8) + ',' + (this.CameraInfoObjects[i].y + 8) + ',200,180,\'' + this.CameraInfoObjects[i].Content.replace(reg, "\\'") + '\');parent.showCamera(\'' + this.CameraInfoObjects[i].ServerIP + '\',' + this.CameraInfoObjects[i].ChannelIndex + ',\'' + cameraTitle + '\',\'' + this.CameraInfoObjects[i].GISID + '\');} catch(e){ alert(e.message);}" />'
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
        if (cameraObject != null)
            this.ShowInfoWindow(cameraObject.x + 8, policeObject.y + 8, 200, 160, cameraObject.Content);
        // alert(strHtml);  

    }

    this.GetCameraImage = function (cameraObject) {
        var imgsrc = "../images/map/camera_" + cameraObject.DeviceType + ".gif";
        return imgsrc;
    }

    this.DrawRegionServiceTraffics = function () {
        //alert(this.RegionServiceTrafficObjects);
        if (this.RegionServiceTrafficObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var regionServiceObject = null;
        for (var i = 0; i < this.RegionServiceTrafficObjects.length; i++) {

            var x = _mapObj.ScreenX(this.RegionServiceTrafficObjects[i].Longitude);
            var y = _mapObj.ScreenY(this.RegionServiceTrafficObjects[i].Latitude);

            strHtml += '<div class="InforWindow contextMenu" style="left:' + x + 'px; top:' + y + 'px"';
            strHtml += ' onmouseover="mapDraw.ShowInfoWindow(' + (x + 8) + ',' + (y + 8) + ',200,180,\'' + this.RegionServiceTrafficObjects[i].AlertContent.replace(reg, "\\'") + '\');GetSerivceMemo(' + this.RegionServiceTrafficObjects[i].Id + ');"';
            strHtml += ' onclick="mapDraw.ShowInfoWindow(' + (x + 8) + ',' + (y + 8) + ',200,180,\'' + this.RegionServiceTrafficObjects[i].AlertContent.replace(reg, "\\'") + '\', true);GetSerivceMemo(' + this.RegionServiceTrafficObjects[i].Id + ');"';
            strHtml += '/>';
            strHtml += '<img src="' + this.GetRegionServiceTrafficImage(this.RegionServiceTrafficObjects[i]) + '" /></div>';
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    this.GetRegionServiceTrafficImage = function (regionServiceTrafficObject) {
        var imgsrc = "../images/map/alarm1.gif";
        if (regionServiceTrafficObject.TypeName == "交通事故") {
            imgsrc = "../images/map/alarm1.gif";
        }
        else if (regionServiceTrafficObject.TypeName == "交通违法") {
            imgsrc = "../images/map/alarm3.gif";
        }
        else {
            imgsrc = "../images/map/alarm2.gif";
        }
        return imgsrc;
    }

    // 显示警卫信息点
    this.DrawGuardObjects = function () {
        if (this.GuardObjects == null)
            return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var cameraObject = null;
        var regionName = "";
        var peakSite = "";
        var cameraTitle = "";
        for (var i = 0; i < this.GuardObjects.length; i++) {
            strHtml += '<div class="InforWindow contextMenu" style="left:' + this.GuardObjects[i].x + 'px; top:' + this.GuardObjects[i].y + 'px"';
            strHtml += ' onmouseover="curPoliceId=' + this.GuardObjects[i].Id + ';mapDraw.ShowInfoWindow(' + (this.GuardObjects[i].x + 8) + ',' + (this.GuardObjects[i].y + 8) + ',200,180,\'' + this.GuardObjects[i].GuardContent.replace(reg, "\\'") + '\');"';
            strHtml += '/>';

            strHtml += '<img src="../images/map/shift5_0.png"  onclick=" try{parent.showCamera(\'\');} catch(e){ alert(e.message);}" />'
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    // 显示高峰站点
    this.DrawPeakObjects = function () {
        if (this.PeakObjects == null) return;

        if (_mapObj.ZoomIndex() < 4) {
            this.DrawPeakStaffObjects();
            //return;
        }
        var reg = new RegExp("'", "g");
        var strHtml = "";

        var imgWH = 40;

        if (_mapObj.ZoomIndex() < 6) {
        }
        else {
            imgWH = imgWH / ((_mapObj.ZoomIndex() - 4) * 0.5);

        }
        for (var i = 0; i < this.PeakObjects.length; i++) {
            if (this.PeakObjects[i].Name == null || this.PeakObjects[i].Name == "") this.PeakObjects[i].Name = "未命名";

            strHtml += '<div class="InforWindow contextMenu" style="text-align: left; left:' + this.PeakObjects[i].x + 'px; top:' + (this.PeakObjects[i].y - imgWH - (_mapObj.ZoomIndex() < 6 ? 20 : 0)) + 'px">';

            if (_mapObj.ZoomIndex() < 6)
                strHtml += '<div class="mapTitle ">' + this.PeakObjects[i].Name.replace("高峰站点_", "").replace("高峰站点", "") + '</div>';

            strHtml += '<img height="' + imgWH + 'px" class="img_PeakObject_' + this.PeakObjects[i].Id + '" id="img_PeakObject_' + this.PeakObjects[i].Id + '" src="' + this.GetPeakSiteImage(this.PeakObjects[i]) + '"';
            strHtml += ' onclick=" try{mapDraw.ShowPeakSiteInfoWin(this,' + i + ');';
            strHtml += ' parent.FrmContent.contentWindow.selectPeakSite(' + this.PeakObjects[i].Id + ',\'' + (this.PeakObjects[i].GISID == "" ? 0 : this.PeakObjects[i].GISID) + '\', this);} catch(e){ alert(e.message);}" />';


            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    this.GetPeakSiteImage = function (peakSiteObject) {
        var imgsrc = "../images/map/small_0.gif";
        if (peakSiteObject.TimeState == "到点") {
            if (peakSiteObject.GISID == null || peakSiteObject.GISID == "") {
                imgsrc = "../images/map/peak1_1.png";
            }
            else {
                imgsrc = "../images/map/peak2_1.png";
            }
        }
        else {
            if (peakSiteObject.GISID == null || peakSiteObject.GISID == "") {
                imgsrc = "../images/map/peak1_0.png";
            }
            else {
                imgsrc = "../images/map/peak2_0.png";
            }
        }
        return imgsrc;
    }

    this.ShowPeakSiteInfoWin = function (obj, objIndex) {

        mapDraw.HideInfoWindow();

        if (mapDraw.PeakObjects == null) return;
        var contentObj = mapDraw.PeakObjects[objIndex];
        if (contentObj == null) return;

        OnFocusImg("img_PeakObject_" + contentObj.Id);
        var x = $(obj).parent().position();

        var strHtml = '<div id="divInfoWindow" name="divInfoWindow" class="DivInfoWindow contextMenu" style="left:' + (x.left - 130) + 'px;' + 'top:' + (x.top - 180) + 'px;">';
        strHtml += '<img style="border:0px;"  src="../images/LeftMenuTop_bg.gif" width="300px" onclick="mapDraw.HideInfoWindow();" />';
        strHtml += '<div  class="MessageFrame" style="height:144px;"><div class="MessageContent" style="height:144px;z-index:10">';

        strHtml += mapDraw.GetPeakSiteContent(contentObj);

        strHtml += '</div></div><img src="../images/messageBottom.gif" width="300px"/></div>';


        this.InsertHtml("afterbegin", _traceLayer, strHtml);


    }

    this.GetPeakSiteContent = function (contentObj) {
        var content = '<table class="InfoListTable100">';
        content += '<tr><td width="60">单位:</td><td >' + contentObj.StationName + '</td></tr>';
        var peakSiteType = contentObj.Flags == null ? "" : contentObj.Flags;
        if (peakSiteType == "1" || peakSiteType == "2") peakSiteType = "&nbsp;&nbsp;" + peakSiteType + "类";
        content += '<tr style="background-color:#f0f0f0"><td width="60">名称:</td><td >' + contentObj.Name + peakSiteType + '</td></tr>';
        //content += '<tr style="background-color:#f0f0f0"><td width="60">名称:</td><td >' + contentObj.Name + '</td></tr>';
        content += '<tr ><td>摄像头:</td><td><a herf="javascrpt:void(0);" style="cursor:pointer; color:Blue;" onclick="parent.FrmContent.contentWindow.showCameraByGISID(\'' + contentObj.GISID + '\');">' + contentObj.GISIDName + '</a></td> </tr>';
        content += '<tr style="background-color:#f0f0f0"><td width="60">排班:</td><td >' + contentObj.ArrangeStr + '</td></tr>';
        content += '<tr ><td>人员:</td><td>' + contentObj.StaffName + '</td> </tr>';

        content += "</table>";

        return content;
    }

    // 显示高峰站点人员
    this.DrawPeakStaffObjects = function () {

        if (this.PeakStaffObjects == null) return;

        var reg = new RegExp("'", "g");
        var strHtml = "";

        var imgWH = 40;

        for (var i = 0; i < this.PeakStaffObjects.length; i++) {
            if (this.PeakStaffObjects[i].Name == null || this.PeakStaffObjects[i].Name == "") this.PeakStaffObjects[i].Name = "未命名";

            if (this.PeakStaffObjects[i].StaffDevCodeState == "0" || this.PeakStaffObjects[i].StaffLongitude == 0) {

                strHtml += '<div id="div_PeakObject_' + this.PeakStaffObjects[i].Id + "_" + this.PeakStaffObjects[i].StaffId + '" class="InforWindow contextMenu  imgreset" ref="' + this.PeakStaffObjects[i].Id + '" height=' + imgWH + ' style="text-align: left; left:' + this.PeakStaffObjects[i].x + 'px; top:' + (this.PeakStaffObjects[i].y - imgWH) + 'px">';

                strHtml += '<div class="mapTitle ">' + this.PeakStaffObjects[i].StaffName + '</div>';

                strHtml += '<img  height="' + imgWH + 'px" class="img_PeakObject_' + this.PeakStaffObjects[i].Id + '" id="img_PeakObject_' + this.PeakStaffObjects[i].Id + "_" + this.PeakStaffObjects[i].StaffId + '" src="' + this.GetPeakSiteStaffImage(this.PeakStaffObjects[i]) + '"';
                strHtml += ' onclick=" try{mapDraw.ShowPeakSiteStaffInfoWin(this,' + i + ');';

                strHtml += '} catch(e){ alert(e.message);}" />';


                strHtml += '</div>';
            }
            else {
                strHtml += '<div class="InforWindow contextMenu" style="text-align: left; left:' + this.PeakStaffObjects[i].x + 'px; top:' + (this.PeakStaffObjects[i].y - imgWH) + 'px">';

                strHtml += '<div class="mapTitle ">' + this.PeakStaffObjects[i].StaffName + '</div>';

                strHtml += '<img  height="' + imgWH + 'px" class="img_PeakObject_' + this.PeakStaffObjects[i].Id + '" id="img_PeakObject_' + this.PeakStaffObjects[i].Id + "_" + this.PeakStaffObjects[i].StaffId + '" src="' + this.GetPeakSiteStaffImage(this.PeakStaffObjects[i]) + '"';
                strHtml += ' onclick=" try{mapDraw.ShowPeakSiteStaffInfoWin(this,' + i + ');';


                strHtml += '} catch(e){ alert(e.message);}" />';

                strHtml += '</div>';
            }
        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);

        ResetImage("imgreset");
    }

    this.GetPeakSiteStaffImage = function (peakSiteObject) {
        var imgsrc = "../images/map/small_0.gif";
        if (peakSiteObject.StaffDevcodeState == "1") {
            imgsrc = "../images/map/peak3_0.png";
        }
        else {
            imgsrc = "../images/map/peak3_1.png";
        }
        return imgsrc;
    }

    this.ShowPeakSiteStaffInfoWin = function (obj, objIndex) {

        mapDraw.HideInfoWindow();

        if (mapDraw.PeakStaffObjects == null) return;
        var contentObj = mapDraw.PeakStaffObjects[objIndex];
        if (contentObj == null) return;
        //img_PeakObject_
        //OnFocusImg("img_PeakObject_" + contentObj.Id + "_" + contentObj.StaffId);       

        OnFocusImg("img_PeakObject_" + contentObj.Id);
        var x = $(obj).parent().position();

        var strHtml = '<div id="divInfoWindow" name="divInfoWindow" class="DivInfoWindow contextMenu" style="left:' + (x.left - 130) + 'px;' + 'top:' + (x.top - 180) + 'px;">';
        strHtml += '<img style="border:0px;"  src="../images/LeftMenuTop_bg.gif" width="300px" onclick="mapDraw.HideInfoWindow();" />';
        strHtml += '<div  class="MessageFrame" style="height:144px;"><div class="MessageContent" style="height:144px;z-index:10">';

        strHtml += mapDraw.GetPeakSiteStaffContent(contentObj);

        strHtml += '</div></div><img src="../images/messageBottom.gif" width="300px"/></div>';


        this.InsertHtml("afterbegin", _traceLayer, strHtml);


    }

    this.GetPeakSiteStaffContent = function (contentObj) {
        var content = '<table class="InfoListTable100">';
        content += '<tr><td width="60">单位:</td><td colspan="3">' + contentObj.StationName + '</td></tr>';
        content += '<tr style="background-color:#f0f0f0"><td width="60">高峰名称:</td><td  colspan="3">' + contentObj.Name + '</td></tr>';
        content += '<tr ><td>摄像头:</td><td colspan="3"><a herf="javascrpt:void(0);" style="cursor:pointer; color:Blue;" onclick="parent.FrmContent.contentWindow.showCameraByGISID(\'' + contentObj.GISID + '\');">' + contentObj.GISIDName + '</a></td> </tr>';

        content += '<tr style="background-color:#f0f0f0"><td width="60" >排班:</td><td colspan="3">' + contentObj.ArrangeStr + '</td></tr>';
        content += '<tr><td width="60">人员:</td><td >' + contentObj.StaffName + '</td><td>警号:</td><td >' + contentObj.StaffCode + '</td></tr>';
        content += '<tr style="background-color:#f0f0f0"><td width="60">设备:</td><td  colspan="3">' + contentObj.StaffDevCode + '(' + (contentObj.StaffDevCodeState == "0" ? "离线" : "在线") + ')</td></tr>';
        content += '<tr ><td width="60">最后时间:</td><td colspan="3">' + contentObj.strLastPosTime + '</td></tr>';
        content += '<tr style="background-color:#f0f0f0"><td width="60">最后位置:</td><td colspan="3">' + contentObj.strAddress + '</td></tr>';
        content += '<tr ><td>到岗:</td><td colspan="3">' + (contentObj.State == null ? "未到岗" : contentObj.State) + '</td> </tr>';


        content += "</table>";

        return content;
    }

    // 显示拦截点
    this.DrawInterceptObjects = function () {
        //alert(this.InterceptObjects);
        if (this.InterceptObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var imgWH = 30;
        if (_mapObj.ZoomIndex() < 6) {
        }
        else {
            imgWH = imgWH / ((_mapObj.ZoomIndex() - 4) * 0.5);
        }
        for (var i = 0; i < this.InterceptObjects.length; i++) {
            if (this.InterceptObjects[i].Name == null || this.InterceptObjects[i].Name == "")
                this.InterceptObjects[i].Name = "未命名";
            x = this.InterceptObjects[i].x - (120 + imgWH) / 2;
            y = this.InterceptObjects[i].y - imgWH / 2;
            strHtml += '<div class="InforWindow contextMenu" style="cursor:pointer;text-align: center; left:' + x + 'px; top:' + y + 'px"';
            //strHtml += ' onmouseover="mapDraw.ShowInfoWindow1(' + (x + 60) + ',' + (y + 8) + ',200,180,\'' + this.InterceptObjects[i].Content.replace(reg, "\\'") + '\',\'' + this.InterceptObjects[i].Title + '\');"';
            strHtml += ' onclick="mapDraw.ShowInfoWindow1(' + (x + 60) + ',' + (y + 8) + ',300,180,\'' + this.InterceptObjects[i].Content.replace(reg, "\\'") + '\',\'' + this.InterceptObjects[i].Title + '\');"';
            strHtml += '>';
            strHtml += '<img height="' + imgWH + '" id="img_InterceptPointObject_' + this.InterceptObjects[i].Id + '" src="' + this.GetInterceptPointImage(this.InterceptObjects[i]) + '"  onclick="try{parent.FrmContent.contentWindow.selectInterceptPoint('
                + this.InterceptObjects[i].Id
                + ', this);} catch(e){ alert(e.message);}" />'
            //strHtml += '<div style="width:120px;cursor:pointer;">' + this.InterceptObjects[i].Name + '</div>';
            strHtml += '<div class="mapTitle" style="color:#003300;">' + this.InterceptObjects[i].Name + '</div>';
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    this.GetInterceptPointImage = function (interceptPointObject) {
        return "../images/map/interceptpoint_" + interceptPointObject.Type + "_" + interceptPointObject.InterceptId + ".png";
        var imgsrc = "../images/map/interceptpoint_0.png";
        if (interceptPointObject.Type == 0) {
            imgsrc = "../images/map/interceptpoint_0_" + interceptPointObject.InterceptId + ".png";
        }
        else
            imgsrc = "../images/map/interceptpoint_1_" + interceptPointObject.InterceptId + ".png";
        return imgsrc;
    }
    this.DrawRoutePlanDetailObjects = function () {
        //alert(this.InterceptObjects);
        if (this.RoutePlanDetailObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var imgWH = 24;
        if (_mapObj.ZoomIndex() < 6) {
        }
        else {
            imgWH = imgWH / ((_mapObj.ZoomIndex() - 4) * 0.5);
        }
        for (var i = 0; i < this.RoutePlanDetailObjects.length; i++) {
            if (this.RoutePlanDetailObjects[i].Name == null || this.RoutePlanDetailObjects[i].Name == "")
                this.RoutePlanDetailObjects[i].Name = "未命名";
            x = this.RoutePlanDetailObjects[i].x - imgWH / 2;
            y = this.RoutePlanDetailObjects[i].y - imgWH / 2;
            strHtml += '<div class="InforWindow contextMenu" style="cursor:pointer;text-align: center; left:' + x + 'px; top:' + y + 'px"';
            strHtml += ' onmouseover="mapDraw.ShowInfoWindow(' + (x + 8) + ',' + (y + 8) + ',200,180,\'' + this.RoutePlanDetailObjects[i].Content.replace(reg, "\\'") + '\');"';
            strHtml += ' onclick="mapDraw.ShowInfoWindow(' + (x + 8) + ',' + (y + 8) + ',200,180,\'' + this.RoutePlanDetailObjects[i].Content.replace(reg, "\\'") + '\', true);"';
            strHtml += '>';
            strHtml += '<img height="' + imgWH + '" id="img_RoutePlanDetailObject_' + this.RoutePlanDetailObjects[i].Id + '" src="' + this.GetRoutePlanDetailImage(this.RoutePlanDetailObjects[i]) + '"  onclick="try{parent.FrmContent.contentWindow.selectRoutePlanDetail('
                + this.RoutePlanDetailObjects[i].Id
                + ', this);} catch(e){ alert(e.message);}" />';
            //strHtml += '<img id="img_InterceptPointObject_' + this.InterceptObjects[i].Id + '" src="' + this.GetInterceptPointImage(this.InterceptObjects[i]) + '"  onclick="alert(123);'
            //    + '" />'
            //strHtml += '<div style="width:120px;cursor:pointer;">' + this.RoutePlanDetailObjects[i].Name + '</div>';
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    this.GetRoutePlanDetailImage = function (routePlanDetailObject) {
        return "../images/map/" + routePlanDetailObject.ImageUrl;
    }
    this.DrawTaxiRegionObjects = function () {
        //alert(this.InterceptObjects);
        if (this.TaxiRegionObjects == null) return;
        var reg = new RegExp("'", "g");
        var strHtml = "";
        var imgWH = 16;
        for (var i = 0; i < this.TaxiRegionObjects.length; i++) {
            if (this.TaxiRegionObjects[i].Name == null || this.TaxiRegionObjects[i].Name == "")
                this.TaxiRegionObjects[i].Name = "未命名";
            x = this.TaxiRegionObjects[i].x - imgWH / 2;
            y = this.TaxiRegionObjects[i].y - imgWH / 2;
            strHtml += '<div class="InforWindow contextMenu" style="cursor:pointer;text-align: center; left:' + x + 'px; top:' + y + 'px"';
            strHtml += '>';
            strHtml += '<img height="' + imgWH + '" id="img_TaxiRegionObject_' + this.TaxiRegionObjects[i].Id + '" src="' + this.GetTaxiRegionImage(this.TaxiRegionObjects[i]) + '" alt="" title="'
                + this.TaxiRegionObjects[i].Name
                + '" />';
            strHtml += '</div>';

        }

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }

    this.GetTaxiRegionImage = function (TaxiRegionObject) {
        return "../images/map/重点区域.png";
    }
    this.CheckPos = function (x, y) {
        if (this.StartPosition != null)
            if ((this.StartPosition.x == x) && (this.StartPosition.y == y)) return false;
        if (this.DrawEndPosition != null)
            if ((this.DrawEndPosition.x == x) && (this.DrawEndPosition.y == y)) return false;
        return true
    }
    this.ShowText = function (x, y, name) {
        var strHtml = '<span id="divTextInfo" name="divTextInfo" class="DivTextInfo" style="left:' + x + 'px;' + 'top:' + y + 'px;width:' + name.length * 14 + 'px;">' +
                          name + '</span>';

        this.InsertHtml("afterbegin", _traceLayer, strHtml);
    }
    this.HideText = function () {
        this.ClearImage("divTextInfo");
    }
    //显示信息点
    this.DrawTheme = function () {
        if (this.ThemeObject == null) return;
        if ($("#divThemePic").length > 0) {
            this.UpdateTheme();
            return;
        }
        var imgSrc;
        if (this.ThemeObject.ImageUrl != null) {
            imgSrc = this.ThemeObject.ImageUrl;
        }
        else {
            if (this.ThemeObject.Type == "Park")
                imgSrc = "../images/park.gif"
            else
                if (this.ThemeObject.Type == "alert")
                    imgSrc = "../images/alertpoint.gif"
                else
                    imgSrc = "../images/themepoint.gif";
        }

        // this.DrawImage(ls_filename, li_x - 8, li_y - 8, 16, 16, this.ThemeObject.Name, this.ThemeObject.Content)

        var strHtml = '<div name="themepic" id="divThemePic" class="themepic" style="left:' + (this.ThemeObject.x - 8) + 'px; top:' + (this.ThemeObject.y - 8) + 'px; " >' +
			              '<img  id="imgThemePic" src="' + imgSrc + '" alt="' + (this.ThemeObject.Name == null ? '' : this.ThemeObject.Name) + '"';
        if (this.ThemeObject.Angle != null) {
            strHtml += ' style="-moz-transform:rotate(' + this.ThemeObject.Angle + 'deg); -webkit-transform:rotate(' + this.ThemeObject.Angle + 'deg); height:36px;"';
        }
        else {
            strHtml += ' style="height:36px;"';
        }
        var reg = new RegExp("'", "g");
        var imgWH = 16;
        var x = this.ThemeObject.x - imgWH / 2;
        var y = this.ThemeObject.y - imgWH / 2;
        //if (this.ThemeObject.Content != null) {
        //    strHtml += ' onclick=" mapDraw.ShowInfoWindow(' + x + ',' + y + ',200,160,\'' + this.ThemeObject.Content.replace(reg, "\\',true") + '\')"';
        //}

        strHtml += ' />' + (this.ThemeObject.Name == null ? '' : this.ThemeObject.Name) + '</div>';

        this.InsertHtml("afterbegin", _traceLayer, strHtml);

        if (this.ThemeObject.Content != null) {
            this.ShowInfoWindow1(x, y, (this.ThemeObject.InfoContentWidth == null ? "0" : this.ThemeObject.InfoContentWidth), 160, this.ThemeObject.Content, this.ThemeObject.Title);
            $("#divThemePic").click(function (e) {
                mapDraw.ShowInfoWindow1(x, y, (mapDraw.ThemeObject.InfoContentWidth == null ? "0" : mapDraw.ThemeObject.InfoContentWidth), 160, mapDraw.ThemeObject.Content, mapDraw.ThemeObject.Title);
            });
        }
    }
    this.UpdateTheme = function () {

        if (this.ThemeObject == null) return;
        if (this.ThemeObject.Angle != null) {
            $("#imgThemePic").css({ "-moz-transform": "rotate(" + this.ThemeObject.Angle + "deg)", "-moz-transform": "rotate(" + this.ThemeObject.Angle + "deg)" });
        }

        // $("#movepin").animate({ left: this.ThemeObject.x + "px", top: this.ThemeObject.y + "px" }, 50);
        var offset = $("#divThemePic").offset();
        if (offset == null) return;
        offset.left = this.ThemeObject.x - 8;
        offset.top = this.ThemeObject.y - 8;
        $("#divThemePic").offset(offset);
        if (this.ThemeObject.Angle != null) {
            var img = document.getElementById("imgThemePic");

            img.style.transform = "rotate(" + this.ThemeObject.Angle + "deg)";
            // img.src = canvas.toDataURL("image/png");
            //$("#imgThemePic").css({"-moz-transform":"rotate("+this.ThemeObject.Angle+"deg)","-moz-transform":"rotate("+this.ThemeObject.Angle+"deg)"});
        }
        if ((this.ThemeObject.Content == null)||(this.ThemeObject.Content.length==0)) {
            this.HideInfoWindow();
        }
        else {
            var offset = $("#TraceLayer").offset();
            self.ThemeObject.x = self.ThemeObject.x - offset.left;
            self.ThemeObject.y = self.ThemeObject.y - offset.top - 16;
            this.ShowInfoWindow1(this.ThemeObject.x, this.ThemeObject.y, 200, 160, this.ThemeObject.Content, "信息展示");
            
        }
    }
    //显示信息点
    this.DrawPIO = function () {
        if (this.PIOObject == null) return; 
        this.ClearImage("themepic")
        ls_filename = "../images/themepoint.gif"
        this.DrawImage(ls_filename, this.PIOObject.x - 8, this.PIOObject.y - 8, 16, 16, this.PIOObject.Name,null)
    }
    //显示信息点
    this.ShowTheme = function (asname, al_long, al_lat, content) {
        li_x = al_long
        li_y = al_lat
        this.ClearImage("themepic")
        ls_filename = "../images/themepoint.gif"
        this.DrawImage(ls_filename, li_x - 8, li_y - 8, 16, 16, asname, content)
    }
    //显示信息点
    this.ShowAlert = function (asname, al_long, al_lat, content) {
        li_x = al_long
        li_y = al_lat
        this.ClearImage("themepic")
        ls_filename = "../images/alertpoint.gif"
        this.DrawImage(ls_filename, li_x - 8, li_y - 8, 16, 16, asname, content)
    }
    //显示信息点
    this.ShowPark = function (asname, al_long, al_lat, content) {
        li_x = al_long
        li_y = al_lat
        this.ClearImage("themepic")
        ls_filename = "../images/park.gif"
        this.DrawImage(ls_filename, li_x - 8, li_y - 8, 16, 16, asname, content)
    }
    this.DrawImage = function (imgSrc, x, y, w, h, a, content) {
        var strHtml = '<div name="themepic" id="ThemePic" class="themepic" style="left:' + x + 'px; top:' + y + 'px; height:' + h + 'px" >' +
			              '<img src="' + imgSrc + '" alt="' + a + '"';
        var reg = new RegExp("'", "g");
        if (content != null) {
            strHtml += ' onclick=" mapDraw.ShowInfoWindow(' + x + ',' + y + ',200,160,\'' + content.replace(reg, "\\',true") + '\')"';
        }

        strHtml += ' />' + a + '</div>';

        this.InsertHtml("afterbegin", _traceLayer, strHtml);

        if (content != null)
            this.ShowInfoWindow(x, y, 200, 160, content, true);
    }

    this.HideInfoWindow = function () {
       // this.ClearImage("divInfoWindow");
        //this.ClearImage("divInfoShadow");
        $("#divInfoWindow").hide();
        ClearFocusImg();
    }

    this.ShowInfoWindow = function (x, y, w, h, content, isForcedShow) {

        if (isForcedShow == null || isForcedShow == false) {
            var chkStaffInfo = $(window.parent.document).find("#chkStaffInfo").attr("checked");
            var cbxShowPopInfo = $(window.parent.document).find("#cbxShowPopInfo").attr("checked");
            if (!chkStaffInfo & !cbxShowPopInfo) return;
        }

        this.HideInfoWindow();

        if (mapObj.Tool != "Pan") return;
        var strHtml = '<div id="divInfoWindow" name="divInfoWindow" class="DivInfoWindow contextMenu" style="left:' + (x - 150) + 'px;' + 'top:' + (y - 233) + 'px;">' +
			              '<img src="../images/LeftMenuTop_bg.gif" width="300px" onclick="mapDraw.HideInfoWindow();" />' +
                          '<div  class="MessageFrame" style="height:184px;"><div class="MessageContent" style="height:184px;z-index:10">' + content + '</div></div>' +
                          '<img src="../images/messageBottom.gif" width="300px"/>' +
                      '</div>';
        //<div id="divInfoShadow"  class="MessageShadow contextMenu" style="position:absolute;left:' + (x - 150) + 'px;' + 'top:' + (y - 114) + 'px;height:124px;z-index:1"></div>

        this.InsertHtml("afterbegin", _traceLayer, strHtml);

    }
    this.ShowInfoWindow1 = function (x, y, w, h, content, title) {

        this.HideInfoWindow();
       
        if (mapObj.Tool != "Pan") return;
        if ($("#divInfoWindow").length==0) {
            var strHtml = '<div onmousedown="onDrag(this)" id="divInfoWindow" name="divInfoWindow" class="DivInfoWindow1 contextMenu" style="left:' + (x - 150) + 'px;' + 'top:' + (y - 240) + 'px;'
                + ((w == null || w == 0) ? '' : 'width:' + w + 'px; ')
                + '">'
                + '<div class="InfoWindowTitle"><span style="width:85%; float:left;" id="lblInforWindowTitle">' + title + '</span> <img src="../images/closebox.png" style="float:right; margin-right:10px; height: 12px;margin-top:10px;"  onclick="mapDraw.HideInfoWindow();" /></div><div style="clear:both;"></div>'
                + '<div class="divInfoContent" id="divInfoContent">' + content + '</div>' +
            //   '<div class="divInfoContent">addfd</div>' +      
                      '<div class="divInfoContentBottom"></div></div>';
            //<div id="divInfoShadow"  class="MessageShadow contextMenu" style="position:absolute;left:' + (x - 150) + 'px;' + 'top:' + (y - 114) + 'px;height:124px;z-index:1"></div>

            this.InsertHtml("afterbegin", _traceLayer, strHtml);
        }
        else {

           
            $("#lblInforWindowTitle").html(title);
            $("#divInfoContent").html(content);
            if( w> 0)
                $("#divInfoWindow").width(w);

        }
        var height = $("#divInfoWindow").height();
        $("#divInfoWindow").css({ "left": (x - 150) + "px", "top": (y - height-8) + "px" });
       // 
       // var offset = $("#divInfoWindow").offset();
       // offset.top = 240 + offset.top - height - 12;
       // $("#divInfoWindow").offset(offset);
        $("#divInfoWindow").show();
    }
    this.ClearImage = function (asname) {
        var elm, elmp

        for (var i = 0; i < _traceLayer.childNodes.length; i++) {
            elm = _traceLayer.childNodes[i];

            try {
                if (elm.getAttribute("id") == asname)
                    _traceLayer.removeChild(elm)
            }
            catch (e) { }
        }
    }

    ///插入信息到对应层，支持Firefox+IE
    //where 插入位置
    //el 层对象
    //html html内容
    this.InsertHtml = function (where, el, html) {
        where = where.toLowerCase();

        if (el.insertAdjacentHTML) {
            switch (where) {
                case "beforebegin":
                    el.insertAdjacentHTML('BeforeBegin', html);
                    return el.previousSibling;
                case "afterbegin":
                    el.insertAdjacentHTML('AfterBegin', html);
                    return el.firstChild;
                case "beforeend":
                    el.insertAdjacentHTML('BeforeEnd', html);
                    return el.lastChild;
                case "afterend":
                    el.insertAdjacentHTML('AfterEnd', html);
                    return el.nextSibling;
            }
            throw 'Illegal insertion point -> "' + where + '"';
        }

        var range = el.ownerDocument.createRange();
        var frag;

        switch (where) {
            case "beforebegin":
                range.setStartBefore(el);
                frag = range.createContextualFragment(html);
                el.parentNode.insertBefore(frag, el);
                return el.previousSibling;
            case "afterbegin":
                if (el.firstChild) {
                    range.setStartBefore(el.firstChild);
                    frag = range.createContextualFragment(html);
                    el.insertBefore(frag, el.firstChild);
                    return el.firstChild;
                }
                else {
                    el.innerHTML = html;
                    return el.firstChild;
                }
            case "beforeend":
                if (el.lastChild) {
                    range.setStartAfter(el.lastChild);
                    frag = range.createContextualFragment(html);
                    el.appendChild(frag);
                    return el.lastChild;
                }
                else {
                    el.innerHTML = html;
                    return el.lastChild;
                }
            case "afterend":
                range.setStartAfter(el);
                frag = range.createContextualFragment(html);
                el.parentNode.insertBefore(frag, el.nextSibling);
                return el.nextSibling;
        }
        throw 'Illegal insertion point -> "' + where + '"';
    }
}
var curpeakId = "";
var OnFocusImg = function (Id) {



    $("." + Id).each(function () {
        if ($(this).hasClass("curOnClickImg")) return;
        $(this).addClass("curOnClickImg");
        $(this).height($(this).height() * 1.3);
        $(this).parent().css("z-index", 1000);
        $(this).parent().attr("oldzindex", $(this).css("z-index"));
        $(this).addClass("curOnClickImg");
        $(this).attr("src", $(this).attr("src").replace(".png", "_1.png"));
    });
}

var ClearFocusImg = function () {
    $(".curOnClickImg").each(function (i) {
        if ($(this).attr("id") == curpeakId) return;
        $(this).removeClass("curOnClickImg");
        var old = $(this).parent().attr("oldzindex");
        $(this).parent().css("z-index", old);
        $(this).height($(this).height() / 1.3);
        $(this).attr("src", $(this).attr("src").replace("_1.png", ".png"));
    });
}

var ResetImage = function (val) {
    var bb = [];

    $("." + val).each(function (i) {
        bb.push({ "peaksite": $(this).attr("ref"), "Id": $(this).attr("id"), "height": $(this).attr("height") });

        //if (typeof (bb[$(this).attr("ref")]) == "undefined") bb[$(this).attr("ref")] = "";

        //bb[$(this).attr("ref")] += $(this).attr("id") + ",";
        //if (aa.indexOf($(this).attr("ref") + ",") == -1) aa += $(this).attr("ref") + ",";
    });

    bb.sort(function (a, b) { return a.peaksite - b.peaksite });
    var a = "", ia = 1, height = 0;
    for (var i = 0; i < bb.length; i++) {
        var x = $("#" + bb[i].Id).position();
        if (a == bb[i].peaksite) {
            ia += 1;
        }
        else {
            ia = 1;
            a = bb[i].peaksite;
        }
        height = parseInt(bb[i].height);
        if (ia == 1) {
            $("#" + bb[i].Id).css({ "left": (x.left - height), "top": (x.top - height) });
        }
        else if (ia == 2) {
            $("#" + bb[i].Id).css({ "left": (x.left + height), "top": (x.top - height) });
        }
        else if (ia == 3) {
            $("#" + bb[i].Id).css({ "left": (x.left - height), "top": (x.top + height) });
        }
        else if (ia == 4) {
            $("#" + bb[i].Id).css({ "left": (x.left + height), "top": (x.top + height) });
        }
        else {
            $("#" + bb[i].Id).css({ "left": (x.left + ((ia - 3) * height)), "top": (x.top + height) });
        }
    }
}