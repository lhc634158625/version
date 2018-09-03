var PGISHelper = {
    MapId: '',
    Map: null,
    Data: {},
    CurPixel: null,
    CurCoord: null,
    DragMode: '',
    Points: [],
    Lines: [],
    EditLinePoints: [],
    EditLinePointsLog: [],
    EditLine:{},
    CoordType: "",
    IsOnLinePoint: false,
    IsDrag: true,
    IsMouseDown: false,
    IsMouseUp: false,
    DelMarker: null,
    SelectdrawCircle:false,
    _Marker: null,
    _Feature: null,
    _Draw:null,
    ZIndex: 13,
    Scale: 1,
    Circle:null,
    Rect:null,
    Config: {
        IsShowMapControl: false,
        defaultlng: 118.1217384338379,
        defaultlat: 24.4822758436203,
        defaultzoom: 13,
        bakFnClick: undefined
    },
    Init: function (mapid) {
        PGISHelper.MapId = mapid;
        PGISHelper.Map = new EzMap(mapid);
        

        var point = new EzCoord(PGISHelper.Config.defaultlng, PGISHelper.Config.defaultlat);
        PGISHelper.Map.centerAndZoom(point, PGISHelper.Config.defaultzoom);
        
        //PGISHelper.Map.changeDragMode('drawCircle', drawCricleT);
        
        //PGISHelper.Map.changeDragMode('drawRect', drawRectT);
        
        
        if (PGISHelper.Config.IsShowMapControl) PGISHelper.Map.showMapControl();

        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_CLICK, function (evt) {
            PGISHelper.CurPixel = evt.pixel;
            PGISHelper.CurCoord = evt.coordinate;
            

            if (PGISHelper.Config.bakFnClick != undefined && typeof (PGISHelper.Config.bakFnClick) == "function") {
                PGISHelper.Config.bakFnClick(PGISHelper.CurCoord);
            }
            
            var marker = PGISHelper.Map.forEachFeatureAtPixel(PGISHelper.CurPixel,function(feature,layer){
            	if (feature instanceof EzMarker ||  feature instanceof Circle || feature instanceof Polygon|| feature instanceof Rectangle) {
    				return feature;
    			}
            });

            if (marker && marker.type == "place") {
                try {
                    LineListHelper.Logic.ShowPlaceInfo(marker.ID);
                } catch (e) {

                }
                return;
            }

            /*if (marker && marker.type == "milestones") {
                try {
                	ActivityListHelper.Logic.ShowMilestoneInfo(marker.ID);
                } catch (e) {

                }
                return;
            }*/
            
            if (marker && marker.type == "locations") {
            try {
            	ActivityListHelper.Logic.ShowPointInfo(marker.ID);
            } catch (e) {

            }
            return;
           }
            
            if (marker && marker.type == "location") {
                try {
                	ActivityListHelper.Logic.AddTaskPoint(marker.RWID,marker.XLID,marker.ID);
                } catch (e) {

                }
               } 
            if (marker) {
                if (marker && PGISHelper.IsOnLinePoint) {
                    PGISHelper.Map.removeOverlay(marker);
                }
                try {
                    SelectMark(marker);
                } catch (e) {

                }
                
            }
            getMapLGByClick(PGISHelper.CurCoord);
        }, PGISHelper.Map);
        
        
        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_MOUSEMOVE, function (evt) {
            PGISHelper.CurPixel = evt.pixel;
            PGISHelper.CurCoord = evt.coordinate; 

            var marker = PGISHelper.Map.forEachFeatureAtPixel(PGISHelper.CurPixel, function (feature, layer) {
                if (feature instanceof EzMarker) {
                    return feature;
                }
            });
            if (marker) {
                this.getViewport().style.cursor = 'pointer';
                marker.type = marker.type || "";
                              
                if (marker.type == "drawpoint" && PGISHelper.DragMode == 'editLine') {
                    PGISHelper.IsOnLinePoint = true;
                    //PGISHelper.ShowDelMarker(marker.getPoint());
                }
                else {
                    PGISHelper.IsOnLinePoint = false;
                }

                if (PGISHelper.IsOnLinePoint && PGISHelper.IsMouseDown) {
                    PGISHelper._Mark = marker;
                }

            } else {
                this.getViewport().style.cursor = '';
                //if (PGISHelper.IsMouseUp) PGISHelper.IsOnLinePoint = false;
                //PGISHelper.HideDelMarker();
            }
            if(PGISHelper.SelectdrawCircle!=null && PGISHelper.SelectdrawCircle){
            	PGISHelper.SelectdrawCircle =false;
            	PGISHelper.Map.changeDragMode('drawRect', drawRectT);
            }

        }, PGISHelper.Map);

        
        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_MOUSEDOWN, function (evt) {

            PGISHelper.IsMouseDown = true;
            PGISHelper.IsMouseUp = false;
            
        }, PGISHelper.Map);

        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_MOUSEUP, function (evt) {     
            if (PGISHelper._Mark != null && PGISHelper.IsOnLinePoint) {
                PGISHelper._Mark.setPoint(new EzCoord(evt.coordinate[0], evt.coordinate[1]));
                PGISHelper._Mark = null;
            }

            PGISHelper.IsMouseUp = true;
            PGISHelper.IsMouseDown = false;
            PGISHelper.IsDrag = false;

        }, PGISHelper.Map);
        
        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_ZOOMCHANGE, function (evt) {
            //PGISHelper.ZIndex = PGISHelper.Map.getZoom();            
            //if (PGISHelper.ZIndex > 13) {
            //    PGISHelper.Scale = 2;
            //}
            //else if (PGISHelper.ZIndex >10 && PGISHelper.ZIndex < 13) {
            //    PGISHelper.Scale = 1.5;
            //}
            //else
            //    PGISHelper.Scale = 1;
            //PGISHelper.Scale = 1;
        }, PGISHelper.Map);
        
        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_PAN, function (evt) {
            PGISHelper.IsDrag = true;
        }, PGISHelper.Map);

        PGISHelper.Map.addMapEventListener(Ez.Event.MAP_PANEND, function (evt) {
            
        }, PGISHelper.Map);


       

        var icon = new EzIcon({
            src: "js/act/images/close.gif",
            anchor: [0, 1.0],
            anchorXUnits: 'fraction',
            anchorYUnits: 'fraction',
            opacity: 1
        });
        
    	PGISHelper.DelMarker = new EzMarker(new EzCoord(116, 24), icon);
    	PGISHelper.Map.addOverlay(PGISHelper.DelMarker);
    	PGISHelper.DelMarker.type = "delpoint";
    	PGISHelper.DelMarker.hide();
    	
    	return PGISHelper;

    },
    ShowDelMarker: function (coord) {
        if (PGISHelper.DelMarker != null) {
            //PGISHelper.DelMarker.setPoint(coord);
            //PGISHelper.DelMarker.show();
        }
        else {

        }
    },
    HideDelMarker: function () {
        if (PGISHelper.DelMarker != null) {
            //PGISHelper.DelMarker.setPoint(new EzCoord(116, 24));
            //PGISHelper.DelMarker.show();
        }
    },
    RemoveMAp_ClICKListener: function (backfn) {
        PGISHelper.Config.bakFnClick = undefined;
    },
    StartEditLine: function (polyline, frontFn) {
        PGISHelper.DragMode = 'editLine';        
        PGISHelper.Map.changeDragMode('editGeometry', null, polyline, "on"); 
    },
    StopEditLine: function (polyline, bakFn) {
        PGISHelper.DragMode = '';
        PGISHelper.Map.changeDragMode('editGeometry', function (obj) {            
            if (bakFn != undefined && typeof (bakFn) == "function") {
                bakFn(polyline);
            }
        }, polyline, "off"); 
    },
    PanAndZoom: function (lng, lat, zoomIndex, offset, type) {
        var coord = new EzCoord(lng, lat);
        //带动画平移
        if (type != undefined && type != null) {
            var duration = 2000;
            PGISHelper.Map.animationTo(coord, type, {
                duration: duration
            });
        }
        //带缩放移图
        else if(zoomIndex != undefined && zoomIndex != null){
        	PGISHelper.Map.centerAndZoom(coord, zoomIndex);
        }else{
        	//水平移图
        	PGISHelper.Map.centerAtLatlng(coord);
        }
        	                   
        if(offset != undefined)
    	{
        	 var mbr = PGISHelper.Map.getBoundsLatLng();
        	   
        	 lng = lng -( Math.abs((mbr.maxX - mbr.minX)) * (offset / 2));
        	 coord = new EzCoord(lng, lat);
        	 PGISHelper.Map.centerAtLatlng(coord);
    	}
        
    },

    AddMark: function (obj) {
        var icon = new EzIcon({
            src: obj.iconUrl,
            anchor: [0.5, 1],
            anchorXUnits: 'fraction',
            anchorYUnits: 'fraction',
            opacity: 1
        });
        if (obj.lng == "" || obj.lng == 0)
        {
            obj.lng =0;
        }
        if (obj.lat == "" || obj.lat == 0) {
            obj.lat = 0;
        }
        var position = new EzCoord(obj.lng, obj.lat);

        var marker = new EzMarker(position, icon, obj.name);
        PGISHelper.Map.addOverlay(marker);
        marker.content = obj.content;
        marker.SX = obj.SX || 0;
        marker.uuid = obj.uuid || "-1";
        marker.lineid = obj.lineid || "-1";
        marker.ID=obj.ID;
        PGISHelper.Points.push(marker);
        return marker;
    },    
    RemoveMark: function (uuid) {
        var points = Enumerable.From(PGISHelper.Points).Where("x=>x.uuid =='" + uuid + "'").ToArray();
        for (var i = 0; i < points; i++) {
            PGISHelper.Map.removeOverlay(points);
        }
        
    },
    AddLine: function (points, color, width, line, markmodel, type) {
        var style_opts = {
            strokeColor: color,
            strokeWidth: width
        };
        type = type || "view";
        markmodel = markmodel || "startend";
        var polyline = new Polyline(points, style_opts);
        PGISHelper.Map.addOverlay(polyline);
        
        var uuid = (line != undefined) ? line.ID : getUUID();
        polyline.uuid = uuid;
        polyline.type = type;
        polyline.poinits = points;
        PGISHelper.AddLineMark(polyline, line, type, markmodel);

        PGISHelper.Lines = Enumerable.From(PGISHelper.Lines).Where("x=>x.uuid !='" + uuid + "'").ToArray();
        PGISHelper.Lines.push(polyline);
        return polyline;
    },
    AddLineMark: function (polyline, line, type, markmodel) {

        polyline = PGISHelper.ClearLineMark(polyline);

        var arrs = polyline.coordString.split(",");
        var index = 0;
        for (var i = 0; i < arrs.length; i = i + 2) {

            if (i == 0) {
                index++;
                var icon = new EzIcon({
                    src: rooturl + 'images/0_XLGH_MAP_QD.png',
                    anchorXUnits: 'fraction',
                    anchorYUnits: 'fraction',
                    opacity: 1
                });

                var position = new EzCoord(arrs[i], arrs[i + 1]);
                var title = new EzTitle("起点", {fontSize:14,fontColor:'#ff0000', anchor: [0.5, 1.2], texBaseline: 'top' });
                var marker = new EzMarker(position, icon, title);
                marker.uuid = getUUID();
                marker.type = type;
                marker.content = i;
                PGISHelper.Map.addOverlay(marker);
                marker.showTitle();
                polyline.markers.push(marker);
                continue;
            }

            if (i == arrs.length - 2) {
                index++;
                var icon = new EzIcon({
                    src: rooturl + 'images/0_XLGH_MAP_ZD.png',
                    anchorXUnits: 'fraction',
                    anchorYUnits: 'fraction',
                    opacity: 1
                });

                var position = new EzCoord(arrs[i], arrs[i + 1]);
                var title = new EzTitle("终点", {fontSize:14,fontColor:'#ff0000', anchor: [0.5, 1.2], texBaseline: 'top' });
                var marker = new EzMarker(position, icon, title);
                marker.uuid = getUUID();
                marker.type = type;
                PGISHelper.Map.addOverlay(marker);
                marker.showTitle();
                polyline.markers.push(marker);

                continue;
            }

            if (markmodel == "point" || markmodel == "all") {
                var query = Enumerable.From(line.Roads).Where("x=>x.QZXZ=='" + arrs[i] + "' && x.QZYZ =='" + arrs[i + 1] + "'").ToArray();
                if (line.IsArg == 1) {
                    query = Enumerable.From(line.Roads).Where("x=>x.lng=='" + arrs[i] + "' && x.lat =='" + arrs[i + 1] + "'").ToArray();
                }

                if (query.length > 0 && i != arrs.length - 4) {
                    index++;
                    var icon = new EzIcon({
                        src: rooturl + 'images/0_XLGH_MAP_TJD.png',
                        anchorXUnits: 'fraction',
                        anchorYUnits: 'fraction',
                        opacity: 1
                    });

                    var position = new EzCoord(arrs[i], arrs[i + 1]);
                    var name = (index) + " ";

                    var title = new EzTitle(name, { anchor: [0.5, 1.2], texBaseline: 'top' });
                    var marker = new EzMarker(position, icon, title);
                    marker.uuid = getUUID();
                    marker.type = type;
                    PGISHelper.Map.addOverlay(marker);
                    marker.showTitle();
                    polyline.markers.push(marker);
                }
                else if (markmodel == "all") {
                    var icon = new EzIcon({
                        src: rooturl + 'js/act/images/dd-via.png',
                        anchorXUnits: 'fraction',
                        anchorYUnits: 'fraction',
                        opacity: 1
                    });

                    var position = new EzCoord(arrs[i], arrs[i + 1]);
                    var marker = new EzMarker(position, icon, "点");
                    marker.uuid = getUUID();
                    marker.type = type;
                    PGISHelper.Map.addOverlay(marker);
                    polyline.markers.push(marker);
                }
            }
        }
    },
    ClearLineMark: function (polyline) {
        if (polyline.markers != null) {
            for (var i = 0; i < polyline.markers.length; i++) {
                PGISHelper.Map.removeOverlay(polyline.markers[i]);
            }
        }
        polyline.markers = [];
        return polyline;
    },
    RemoveLine: function (uuid) {
        var arrs = Enumerable.From(PGISHelper.Lines).Where("x=>x.uuid =='" + uuid + "'").ToArray();
        if (arrs.length > 0) {
            try {
                for (var i = 0; i < arrs.length; i++) {
                    PGISHelper.ClearLineMark(arrs[i]);
                    PGISHelper.Map.removeOverlay(arrs[i]);
                }                             
            } catch (e) {
    
            }

            PGISHelper.Lines = Enumerable.From(PGISHelper.Lines).Where("x=>x.uuid !='" + uuid + "'").ToArray();
        }
    },   
    AddPoint: function (lng, lat, name, content, icon, lineid, index, uuid) {

        icon == icon || '';
        lineid = lineid || ''
        uuid = uuid || getUUID();
        content = content || '';
        index = index || 0

        var obj = new Object();
        obj.lng = lng;
        obj.lat = lat;
        obj.iconUrl = rooturl + icon;
        obj.name = name;

        obj.content = content || '';
        obj.SX = index;
        obj.uuid = uuid;
        obj.lineid = lineid;
        var marker = PGISHelper.AddMark(obj);
    },
    RemoveLinePoint: function (lineid) {
        for (var i = 0; i < PGISHelper.Points.length; i++) {
            if (PGISHelper.Points[i].lineid == lineid) {
                PGISHelper.Map.removeOverlay(PGISHelper.Points[i]);
            }
        }
        PGISHelper.Points = Enumerable.From(PGISHelper.Points).Where("x=>x.lineid !='" + lineid + "'").ToArray();
    },
    ClearEditLinePoint: function () {
        if (PGISHelper.EditLinePoints.length > 0) {
            for (var i = 0; i < PGISHelper.EditLinePoints.length; i++) {
                if (PGISHelper.EditLinePoints[i].marker != null)
                    PGISHelper.Map.removeOverlay(PGISHelper.EditLinePoints[i].marker);
            }
            PGISHelper.Points = Enumerable.From(PGISHelper.Points).Where("x=>x.lineid !='-1'").ToArray();
        }

        PGISHelper.EditLinePoints = [];
    },
    AddEditLinePoint: function (linepoint, markObj) {
        if (markObj != undefined) {
            var marker = PGISHelper.AddMark(markObj);
            linepoint.marker = marker;
        }
        PGISHelper.EditLinePoints.splice(linepoint.SX, 0, linepoint);

        if (PGISHelper.EditLinePoints.length > 2) {
            for (var i = 1; i < PGISHelper.EditLinePoints.length - 1; i++) {
                PGISHelper.EditLinePoints[i].SX = i;
            }
        }
    },
    RemoveEditLinePoint: function (uuid) {
        var point = Enumerable.From(PGISHelper.EditLinePoints).Where("x=>x.ID =='" + uuid + "'").ToArray();
        if (point.length > 0) {
            if (point[0].marker != null)
                PGISHelper.Map.removeOverlay(point[0].marker);
        }
        PGISHelper.EditLinePoints = Enumerable.From(PGISHelper.EditLinePoints).Where("x=>x.ID !='" + uuid + "'").ToArray();

    },

    //
    AddLinePoint: function (index, lineId, name, content, uuid) {
        var obj = new Object();
        obj.lng = CurCoord[0];
        obj.lat = CurCoord[1];
        icon == icon || '';
        if (icon == 0) {
            obj.iconUrl = rooturl + icon;
            obj.name = name || "起点";
        }
        else if (index == 1000) {
            obj.iconUrl = rooturl + 'static/act/images/endpoint.png';
            obj.name = name || "终点";
        }
        else {
            obj.iconUrl = rooturl + 'static/act/images/middlepoint.png';
            obj.name = name || "途经点";
        }

        obj.content = content || '';
        obj.SX = index;
        obj.uuid = uuid || getUUID();
        obj.LineId = lineId || '';
        var marker = PGISHelper.AddMark(obj);

        var newRoadPoint = { SX: obj.SX, XLMC: name, QZXZ: obj.lng, QZYZ: obj.lat, uuid: obj.uuid, lineid: obj.LineId, point: marker };
        PGISHelper.AddLineRoadPoint(obj.SX, newRoad);
    },


    //

    DelLinePoint: function (uuid) {
        //RemoveMark(uuid);
        for (var i = 0; i < PGISHelper.EditLinePoints.length; i++) {
            if (PGISHelper.EditLinePoints[i].uuid == uuid) {
                PGISHelper.EditLinePoints.splice(i, 1);
                break;
            }
        }
    },


    AddLineRoadPoint: function (index, newRoadPoint) {
        if (index == 1000) {
            PGISHelper.EditLinePoints.push(newRoadPoint);
            return;
        }

        if (index == -1) {
            newRoadPoint.SX = 0;
            PGISHelper.EditLinePoints.push(newRoadPoint);
            return;
        }

        var _index = 0;
        var hasLast = 0;
        for (var i = 0; i < PGISHelper.EditLinePoints.length; i++) {

            if (PGISHelper.EditLinePoints[i].SX == 1000) {
                hasLast = 1;
            }
            else {

                PGISHelper.EditLinePoints[i].SX = i + _index;
                if (PGISHelper.EditLinePoints[i].SX == index) {
                    newRoadPoint.SX = parseInt(index) + 1;
                    _index = 1;
                }
            }
        }
        if (_index == 0) {
            if (PGISHelper.EditLinePoints == null || PGISHelper.EditLinePoints.length == 0)
                newRoadPoint.SX = 1;
            else if (hasLast == 1) newRoadPoint.SX = PGISHelper.EditLinePoints.length - 1;
        }
        PGISHelper.EditLinePoints.push(newRoadPoint);

    },
    RemoveEditLine: function () {
        var arrs = Enumerable.From(PGISHelper.Lines).Where("x=>x.uuid =='" + uuid + "'").ToArray();
        if (arrs.length == 1) {
            try {
                PGISHelper.ClearLineMark(arrs[0]);
                PGISHelper.Map.removeOverlay(arrs[0]);
            } catch (e) {

            }

            PGISHelper.Lines = Enumerable.From(PGISHelper.Lines).Where("x=>x.type !='edit'").ToArray();
        }
        return;
    },
    DrawEditLine: function (color, width) {
        var _coords = [];
        if (PGISHelper.EditLine.AllRoads == undefined || PGISHelper.EditLine.AllRoads.length == 0) return;

        for (var i = 0; i < PGISHelper.EditLine.AllRoads.length; i++) {
            if (PGISHelper.EditLine.AllRoads[i].QZXZ == "" || PGISHelper.EditLine.AllRoads[i].QZYZ == "")
                continue;
            var coord = new EzCoord(PGISHelper.EditLine.AllRoads[i].QZXZ, PGISHelper.EditLine.AllRoads[i].QZYZ);
            _coords.push(coord);
        }
        if (PGISHelper.EditLine.AllRoads.length > 0) {
            if (PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZXZ != undefined && PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZXZ != "" && PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZYZ != "")
            {
            	_coords.push(new EzCoord(PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZXZ, PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZYZ));
            }
        }
        if (_coords.length == 0) return;

        color = color || "#5298FF";
        width = width || 4;

        PGISHelper.AddLine(_coords, color, width, PGISHelper.EditLine, "point","edit");
        return;
    },    
    DrawEditLineByArg: function (color, width) {
        
        var stops = PGISHelper.GetStops();

        if (PGISHelper.HasStops() == 1 && stops.length > 1) {
            var _coords = [];
            var temp = stops.split(",");
            var coord = new EzCoord(temp[0], temp[1]);
            coord[2] = 0;
            coord[3] = 1;
            _coords.push(coord);

            coords = _coords;
            if (PGISHelper.EditLine.ID != undefined) PGISHelper.RemoveLine(PGISHelper.EditLine.ID);

            color = color || "#5298FF";
            width = width || 4;
            PGISHelper.EditLine.IsArg = 1;
            PGISHelper.AddLine(_coords, color, width, PGISHelper.EditLine, "point","edit");
        }
        else if (PGISHelper.HasStops() > 1 && stops.length > 1) {
          
            AjaxHelper.Getsolve(stops, function (data) {
                try {
                    var arrs = data.routes.features[0].geometry.paths[0];
                    var stops = Enumerable.From(data.stops.features).Select("x=>x.attributes.Cumul_Length").ToArray();
                    for (var i = 0; i < arrs.length; i++) {
                        arrs[i][3] = 0;
                    }

                    for (var i = 0; i < stops.length; i++) {
                        PGISHelper.EditLine.Roads[i].length = stops[i];
                        var _loaction = -1;
                        for (var j = 0; j < arrs.length; j++) {

                            var location = Math.abs(PGISHelper.EditLine.Roads[i].length - arrs[j][2]);
                            if (location == 0) {
                                PGISHelper.EditLine.Roads[i].arrsIndex = j;
                                PGISHelper.EditLine.Roads[i].lng = arrs[j][0];
                                PGISHelper.EditLine.Roads[i].lat = arrs[j][1];
                                break;
                            }
                            if (_loaction >= location || _loaction == -1) {
                                PGISHelper.EditLine.Roads[i].arrsIndex = j;
                                PGISHelper.EditLine.Roads[i].lng = arrs[j][0];
                                PGISHelper.EditLine.Roads[i].lat = arrs[j][1];
                                _loaction = location;
                            }
                        }

                        arrs[PGISHelper.EditLine.Roads[i].arrsIndex][3] = 1;
                    }

                    var _coords = [];
                    for (var i = 0; i < arrs.length; i++) {
                        var lnglat = [arrs[i][0], arrs[i][1]];
                        var coord = new EzCoord(lnglat[0], lnglat[1]);
                        coord[2] = arrs[2];
                        coord[3] = arrs[3];
                        _coords.push(coord);
                        //if (i == arrs.length - 1) {
                        //    endpoint = lnglat[0] + "," + lnglat[1];
                        //}
                    }
                    coords = _coords;
                    if (PGISHelper.EditLine.ID != undefined) PGISHelper.RemoveLine(PGISHelper.EditLine.ID);

                    color = color || "#5298FF";
                    width = width || 4;
                    PGISHelper.EditLine.IsArg = 1;
                    PGISHelper.AddLine(_coords, color, width, PGISHelper.EditLine, "point", "edit");
                   /* var line = PGISHelper.EditLine;
                    var _line = Enumerable.From(PGISHelper.Lines).Where("x=>x.uuid=='" + (line.ID == "" ? "-1" : line.ID) + "'").ToArray();
                    if (_line.length == 0) return;
                    _line = _line[0];
                    var oldlineStr = "";
                    for (var i = 0; i < PGISHelper.EditLine.AllRoads.length; i++) {
                        if (oldlineStr != "") oldlineStr += ",";
                        oldlineStr += PGISHelper.EditLine.AllRoads[i].QZXZ + "," + PGISHelper.EditLine.AllRoads[i].QZYZ;
                    }
                    if (PGISHelper.EditLine.AllRoads.length > 0) oldlineStr += "," + PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZXZ + "," + PGISHelper.EditLine.AllRoads[PGISHelper.EditLine.AllRoads.length - 1].ZZYZ;
                    var ischange = oldlineStr != _line.coordString;
                    if (PGISHelper.EditLine.ischange) {
                        ischange = true;
                    }
                
                    var roads = [];
                    
                    if (ischange) {
                        var newarrspoint = [];
                        var lineStr = _line.coordString.split(",");
                        for (var i = 0; i < lineStr.length; i = i + 2) {
                            newarrspoint.push([lineStr[i], lineStr[i + 1], 0, 0]);
                        }
                        _line.arrspoint = newarrspoint;
                        var _total = 0;
                        var _tmplnglat = "";
                        var _arrspoint = [];
                        for (var i = 0; i < _line.arrspoint.length; i++) {
                            if (_tmplnglat == (_line.arrspoint[i][0] + "," + _line.arrspoint[i][1])) {
                                continue;
                            }
                            if (i == 0) {
                                _total = 0;
                            }
                            else {
                                var curpoint = new EzCoord(_line.arrspoint[i][0], _line.arrspoint[i][1]);
                                var destpoint = new EzCoord(_line.arrspoint[i - 1][0], _line.arrspoint[i - 1][1]);
                                _total += curpoint.distanceTo(destpoint);
                            }
                            _line.arrspoint[i][2] = _total;
                            _tmplnglat = _line.arrspoint[i][0] + "," + _line.arrspoint[i][1];
                            _arrspoint.push(_line.arrspoint[i]);
                        }
                        _line.arrspoint = _arrspoint;
                        line.CD = _line.arrspoint[_line.arrspoint.length - 1][2];
                        $("#lblLineCD").val(( line.CD/1000).toFixed(2));
                        if($("#txtSD").val()!="" && $("#txtSD").val()!=null){
            				var sd=parseFloat($("#txtSD").val());
                        var totalSeconds=(((( line.CD/1000).toFixed(2)/sd)*3600).toFixed(0));
                        PGISHelper.EditLine.YJHS =dtFromat.SecondToTime(totalSeconds);
                        $("#lblLineYJHS").val(PGISHelper.EditLine.YJHS);}}*/
                } catch (e) {
                    console.log(e.toString());
                }
            });
        }
        else {

        }
    },
    GetStops: function () {
        PGISHelper.EditLine.Roads.sort(sortroads);
        var stopsStr = "";
        for (var i = 0; i < PGISHelper.EditLine.Roads.length; i++) {
            if (PGISHelper.EditLine.Roads[i].QZXZ == "" || PGISHelper.EditLine.Roads[i].QZYZ == "") continue;

            if (stopsStr != "") stopsStr += ";";

            stopsStr = stopsStr + PGISHelper.EditLine.Roads[i].QZXZ + "," + PGISHelper.EditLine.Roads[i].QZYZ;
        }

        return stopsStr;
    },
    HasStops: function () {
        PGISHelper.EditLine.Roads.sort(sortroads);
        var count = 0;
        for (var i = 0; i < PGISHelper.EditLine.Roads.length; i++) {
            if (PGISHelper.EditLine.Roads[i].QZXZ == "" || PGISHelper.EditLine.Roads[i].QZYZ == "") continue;
            
            count++;
        }

        return count;
    },
    GetNearestRoad: function(lng,  lat){
        var url = "Gis/NearestRoad.do?LNG=" + lng + "&LAT=" + lat + "&tm=" + new Date().getTime();

        var roadName = "";
        AjaxHelper.AjaxGet(url, function (data) {
            roadName = data.result[0].NAME;
        });
		return roadName;
    },
    AddControllerMark: function (arrs) {
        var iconurl = "";
        var markers = [];
        
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;

            if (arrs[i].ZT == 1) {
                iconurl = "images/0_ZYMAP_SEL_XHD.png";
            }
            else {
                iconurl = "images/0_ZYMAP_UNSEL_XHD.png";
                scale = 0.8;
            }
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);
            var name = (i +1) +"";
			var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon, title);
            marker.uuid = getUUID();
            marker.type = "controller";    
            marker.ID=arrs[i].ID;
            marker.values_.markerStyle.zIndex_="100";
            PGISHelper.Map.addOverlay(marker);
            marker.ZTTRUE = "images/0_ZYMAP_SEL_XHD.png";
            marker.ZTFALSE = "images/0_ZYMAP_UNSEL_XHD.png";
            marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    AddCamerasMark: function (arrs) {
        var iconurl = "";
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;

            if (arrs[i].ZT == 1) {
                iconurl = "images/0_MAP_SEL_SP.png";
            }
            else {
                iconurl = "images/0_MAP_UNSEL_SP.png";
            }
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);
            var name = (i +1) +"";
			var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon, title);
            marker.uuid = getUUID();
            marker.type = "camera";  
            marker.ID=arrs[i].ID;
            marker.values_.markerStyle.zIndex_="100";
            PGISHelper.Map.addOverlay(marker);
            marker.ZTTRUE = "images/0_MAP_SEL_SP.png";
            marker.ZTFALSE = "images/0_MAP_UNSEL_SP.png";
            marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    AddLocationsMark: function (arrs) {
        var iconurl = "";       
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;

            if (arrs[i].ZT == 1) {
                iconurl = "images/0_ZYMAP_SEL_GKD.png";
            }
            else {
                iconurl = "images/0_ZYMAP_UNSEL_GKD.png";
            }
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);
            var name = (i +1) +"";
			var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon, title);
            marker.uuid = getUUID();
            marker.ID=arrs[i].ID;
            marker.RWID=arrs[i].RWID;
            marker.XLID=arrs[i].XLID;
            marker.type = "location";  
            marker.values_.markerStyle.zIndex_="100";
            PGISHelper.Map.addOverlay(marker);
            marker.ZTTRUE = "images/0_ZYMAP_SEL_GKD.png";
            marker.ZTFALSE = "images/0_ZYMAP_UNSEL_GKD.png";
            marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    AddAllPointMark: function (arrs) {
        var iconurl = "";       
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;
            iconurl = "images/0_ZYMAP_UNSEL_GKD.png";
			if(arrs[i].TPMC){
				iconurl=arrs[i].TPMC;
			}
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);
           // var name = (i +1) +"";
			//var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon);
            marker.uuid = getUUID();
            marker.ID=arrs[i].ID;
            marker.type = "locations"; 
            marker.values_.markerStyle.zIndex_="10";
            PGISHelper.Map.addOverlay(marker);
            marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    AddMilestoneMark: function (arrs) {
        var iconurl = "images/0_ZYMAP_SEL_LCB.png";
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);		
			var name = (i +1) +"";
			var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon, title);  
            marker.uuid = getUUID();
            marker.ID=arrs[i].ID;
            marker.type = "milestone";   
            marker.values_.markerStyle.zIndex_="100";
            PGISHelper.Map.addOverlay(marker);
			marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    AddAllMilestoneMark: function (arrs) {
    	var iconurl = "";   
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;
            iconurl = "images/0_ZYMAP_UNSEL_LCB.png";
			if(arrs[i].TPMC){
				iconurl=arrs[i].TPMC;
			}
            var icon = new EzIcon({
                src: iconurl,
                anchorXUits:'fraction', 
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale:0.8,
                opacity:0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);		
			//var name = (arrs[i].MC) +"";
			//var title = new EzTitle(name, {anchor:[0.5,2.8], texBaseline:'top'});
            var marker = new EzMarker(position, icon);  
            marker.uuid = getUUID();
            marker.ID=arrs[i].ID;
            marker.type = "milestones"; 
            marker.values_.markerStyle.zIndex_="10";
            PGISHelper.Map.addOverlay(marker);
			marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
   
    AddPlaceMark: function (arrs) {
        var iconurl = "images/0_STA_SEL_CSD.png";
        var markers = [];
        for (var i = 0; i < arrs.length; i++) {
            if (arrs[i].JD == "" || arrs[i].WD == "") continue;

            var icon = new EzIcon({
                src: iconurl,
                anchorXUits: 'fraction',
                anchorYUits: 'fraction',
                anchor: [0.5, 1.0],
                scale: 0.8,
                opacity: 0.8
            });

            var position = new EzCoord(arrs[i].JD, arrs[i].WD);
            var name = "";
            var title = new EzTitle(name, { anchor: [0.5, 2.8], texBaseline: 'top' });
            var marker = new EzMarker(position, icon, title);
            marker.uuid = getUUID();
            marker.ID = arrs[i].ID;
            marker.type = "place";
            PGISHelper.Map.addOverlay(marker);
            marker.showTitle();
            markers.push(marker);
        }
        return markers;
    },
    
    ChangeDragMode: function(type, color){
		PGISHelper.Map.changeDragMode(type,function(feature){
			if(PGISHelper._Feature != null)
			{
				PGISHelper.Map.removeOverlay(PGISHelper._Feature)
			}
		    PGISHelper._Feature = feature;
			PGISHelper.Map.addOverlay(feature);
			
			if(color)
				feature.setStrokeColor(color);
			else 
			    feature.setStrokeColor("#0099FF");

		});
    },
    GetPointByMBR: function () {
        if (PGISHelper._Feature == null) return;

        if ($("#btnEditLineRoad").val() != "结束编辑") {
            if (PGISHelper._Feature != null) {
                if ($("#btnShowDrawRect").hasClass("active")) {
                    $("#btnShowDrawRect").removeClass("active");
                }
                PGISHelper.Map.removeOverlay(PGISHelper._Feature);
            }
            return;
        }

        $("#btnEditLineRoad").click();
        var line = Enumerable.From(PGISHelper.Lines).Where("x=>x.type=='edit'").ToArray();
        if (line.length > 0) {
            line = line[0];

            var coordarr = PGISHelper._Feature.coordString.split(",");
            var linecoordarr = line.coordString.split(",");
            var MBR = null;
            if (coordarr[0] < coordarr[2]) {
                MBR = new EzMBR(coordarr[0], coordarr[1], coordarr[2], coordarr[3]);
            }
            else {
                MBR = new EzMBR(coordarr[2], coordarr[3], coordarr[0], coordarr[1]);
            }
            var _linecoordStr = [];
            for (var i = 0; i < linecoordarr.length; i = i + 2) {
                var coord = new EzCoord(linecoordarr[i], linecoordarr[i + 1]);
                if (!MBR.containsPoint(coord)) {
                    _linecoordStr.push([linecoordarr[i], linecoordarr[i + 1]]);
                }
            }

            PGISHelper.RemoveLine(PGISHelper.EditLine.ID);

            if (PGISHelper._Feature != null) {
                if ($("#btnShowDrawRect").hasClass("active")) {
                    $("#btnShowDrawRect").removeClass("active");
                }
                PGISHelper.Map.removeOverlay(PGISHelper._Feature);
            }

            var color = PGISHelper.EditLine.YS || "#5298FF";
            var width = PGISHelper.EditLine.KD || 4;
            var _coords = [];
            for (var i = 0; i < _linecoordStr.length; i++) {
                var coord = new EzCoord(_linecoordStr[i][0], _linecoordStr[i][1]);
                _coords.push(coord);
            }
            if (_coords.length == 0) return;

            color = color || "#5298FF";
            width = width || 4;

            PGISHelper.AddLine(_coords, color, width, PGISHelper.EditLine, "point", "edit");
            //PGISHelper.Map.clearDragMode();
            //PGISHelper.Map.clearDragMode();
        }
        $("#btnEditLineRoad").click();
    }
}

function drawCricleT(drawObject) {
    var lay=drawObject;
    var radius = lay.getRadius();
    lay.setFillColor('rgb(0,0,200)');
    if(PGISHelper.Map.Circle!=null){
    	PGISHelper.Map.removeOverlay(PGISHelper.Map.Circle);
    }
    PGISHelper.Map.Circle=lay;
    PGISHelper.Map.addOverlay(lay);
}

function drawRectT(drawObject) {
    var lay=drawObject;
    var XY = drawObject.coordString;
    lay.setFillColor('rgb(0,0,100)');
    if(PGISHelper.Map.Rect!=null){
    	PGISHelper.Map.removeOverlay(PGISHelper.Map.Rect);
    }
    PGISHelper.Map.Rect=lay;
    PGISHelper.Map.addOverlay(lay);
    PGISHelper.SelectdrawCircle = true;
}

//选择坐标，地图点击事件
function getMapLGByClick(obj){
	if(typeof parent.getMapLGByClickFromOther =="function"){
		parent.getMapLGByClickFromOther(obj);
	}
}


