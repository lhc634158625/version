function AfterInitial() {
    mapFrame = new MapFrame();
    mapFrame.Initial();
}
function Resize() {
   
}
var mapFrame
var mapFrm;
var infoFrm;
function MapFrame() {
   
    
    var reportFrm;    
    var traceFrm;
    var isDock = false;
    var HBody;
    var WBody;
    var _self = this;
    this.Initial = function () {       
        _self.InitData();
        _self.InitEvent();       
    }
    this.InitData = function () {
        mapFrm = document.getElementById("frmMap");
        infoFrm = document.getElementById("frmInfo");
        reportFrm = document.getElementById("frmReport");       
        traceFrm = document.getElementById("frmTrace");
        document.getElementById("frmMap").src = "/map/easymap.html"
        if(request("url")!=null)
        {
            infoFrm.src = decodeURIComponent(request("url"));        
            $("#InfoTitle").text(request("title"));
        }
        else
        {
            infoFrm.src = "/building/cameraInfolist.html";        
            $("#InfoTitle").text("摄像头管理");
        }
        $("#LeftInfoPanel").show();
        _self.Resize();        
        _condition = new Object();      
    }
    this.InitEvent = function () {
        /*--------------拖曳效果----------------
    *原理：标记拖曳状态dragging ,坐标位置iX, iY
    *         mousedown:fn(){dragging = true, 记录起始坐标位置，设置鼠标捕获}
    *         mouseover:fn(){判断如果dragging = true, 则当前坐标位置 - 记录起始坐标位置，绝对定位的元素获得差值}
    *         mouseup:fn(){dragging = false, 释放鼠标捕获，防止冒泡}
    */
        var dragging = false;
        var iX, iY;
        var dragObj;
        $(".Dragable").mousedown(function (e) {
            dragging = true;
            iX = e.clientX - this.offsetLeft;
            iY = e.clientY - this.offsetTop;
            this.setCapture && this.setCapture();
            dragObj = $(this)[0].id;
            return false;
        });
        $(".Dragable").mouseup(function (e) {
            dragging = false;

        });
        document.onmousemove = function (e) {
            if (dragging) {
                var e = e || window.event;
                var oX = e.clientX - iX;
                var oY = e.clientY - iY;
                $("#" + dragObj).css({ "left": oX + "px", "top": oY + "px" });
                return false;
            }
        };
        $(document).mouseup(function (e) {
            dragging = false;
            //$("#" + dragObj)[0].releaseCapture();
            // $("#divMessage")[0].releaseCapture();
            e.cancelBubble = true;
        })
        $("#txtKeyword").keyup(function (e) {
            var keyCode = e.keyCode;

            if (keyCode == 13) {
                $("#btnSearch").click();
            }
        });
        $("#btnSearch").click(function (e) {
            if ($("#txtKeyword").val().length < 1) {
                alert("请输入查询的关键字");
                return;
            }
            $("#SearchResult").css("left", ($(this).offset().left - 280) + "px");
            QueryData("SearchPioInfo/" + $("#txtKeyword").val(), function (objs) {
                var htmlStr = "<ul>";
                for (var i = 0, len = objs.length; i < len; i++) {
                    htmlStr += "<li onclick=\"LocatePosition('" + objs[i].Type + "'," + objs[i].Id + ",'" + objs[i].Name + "'," + objs[i].Longitude + "," + objs[i].Latitude + ",'" + objs[i].Source + "')\">" + objs[i].Type + ":" + objs[i].Name
                    if (objs[i].Content != null)
                        htmlStr += "<p>" + objs[i].Content + "</p>";
                    htmlStr += "</li>";
                }
                htmlStr += "</ul>";
                $("#SearchResult").html(htmlStr);

                $("#SearchResult").show();
            });
            e.stopPropagation();
        });

        $("#btnFloatClose").click(function (e) {
            $('#FloatPanel').hide();

        });
        $("#Tools").click(function (e) {
            $("#ToolItem").slideDown();
            e.stopPropagation();
        });
        $("#btnPrint").click(function (e) {
            window.print();
        });
        $("#btnManager").click(function (e) {
            self.location = "Manage/main.aspx";
        });
        $("#btnClearBuffer").click(function (e) {
            window.localStorage.clear();
        });
        $("#btnHideAll").click(function (e) {
            for (var i = 0; i < layers.length; i++) {
                var layer = layers[i];
                mapFrm.contentWindow.ShowLayer(layer.Id, false);
                if (layer != null) layer.visible = false;

            }
            FormatSum();
            $("#divChildType li").removeClass("Select");
            $("#divGrandson li").removeClass("Select");
        });

        $("#btnLight").click(function (e) {


            infoFrm.contentWindow.SwitchLamp();
        });
        $("#btnScreen").click(function (e) {
            $("#TopPanel").hide();
            $("#Left").hide();
            _self.Resize();
        });

      
        //右边菜单点击事件
        $("#RightTools li").on("click", function () {
            var id = $(this).attr("rel");
            if ($(this).hasClass("Select")) {
                $(this).removeClass("Select");

                $(this).addClass("gray");
                if ($(this).hasClass("Service")) {
                    SelectRegionService("Service_" + id, false);
                    return;
                }
                if (id == "Traffic") {//交通路况，关闭路况
                    mapFrm.contentWindow.SetNeedTraffic(-1);
                    $(this).addClass("gray");
                    $(this).removeClass("Select");
                    $("#divChildType li").hide();
                    return;
                }

            }
            else {
                $(this).removeClass("gray");
                if ($(this).hasClass("Service")) {
                    SelectRegionService("Service_" + id, true);
                    return;
                }
                if (id == "Traffic") { //交通路况，开启综合模式
                    mapFrm.contentWindow.SetNeedTraffic(0);
                    $(this).removeClass("gray");
                    $(this).addClass("Select");
                    $("#divChildType li").hide();
                    return;
                }



            }
        });
        //右边菜单鼠标滑动效果
        $("#RightTools li").hover(function () {
            var id = $(this).attr("rel");
            var offset = $(this).offset();
            // $(this).removeClass("gray");
            if ($("#divChildType li[parent='" + id + "']").length == 0) return;

            $("#divChildType li").hide();
            $("#divChildType li[parent='" + id + "']").show();

            $(this).addClass("active");
            var left = WBody - $("#divChildType li[parent='" + id + "']").length * 55 - 71;
            $("#divChildType").css({ "top": offset.top + "px", "left": left + "px" });
            $("#divChildType").show();
        },
        function () {
            // if (!$(this).hasClass("Select"))
            //      $(this).addClass("gray");
            $("#divChildType").hover(function () {
                $("#divChildType").show();
            }, function () {
                if ($("#divGrandson").is(':hidden')) {
                    $("#divChildType").hide();
                    return;
                }
                $("#divChildType").hide();
                $("#divGrandson").hide();
                $("#divGrandson").hover(function () {
                    $("#divChildType").show();
                    $("#divGrandson").show();
                }, function () {
                    $("#divChildType").hide();
                    $("#divGrandson").hide();
                });
            });
        });
        //右边子菜单点击事件
        $("#divChildType li").on("click", function () {
            var rel = $(this).attr("rel");
            var parent = $(this).attr("parent");
            var parentObj = $("[rel='" + parent + "']");
            var granson = $("li[parent='" + rel + "']");
            if ($(this).hasClass("Select")) {
                $(this).removeClass("Select");
                $(this).addClass("gray");
                if (parent == "Camera") {
                    SelectCamera($(this)[0].id, rel, false);
                }
                if (parent == "RegionService") {
                    SelectRegionService($(this)[0].id, rel, false);

                }

                if (parent == "Device") {
                    // SelectDevice(rel, false);
                    for (var i = 0; i < granson.length; i++) {
                        var ids = granson[i].attributes['rel'].value.split("_");
                        ShowDefaultLayer(ids[0], ids[1], false);
                    }
                }
                if (parent == "Staff")
                    SelectStaff($(this)[0].id, rel, false);
                if (parent == "Deploy") {
                    if (rel == "InterceptCirle")
                        mapFrm.contentWindow.IsShowIntercept(false);
                    else
                        SelectDeployPoint($(this)[0].id, rel, false);
                }
                if (parent == "Traffic") { //

                    mapFrm.contentWindow.SetNeedTraffic(-1);
                }
                if (parentObj.length > 0) {
                    if ($("[parent='" + parent + "'].Select").length == 0) {
                        parentObj.removeClass("Select");
                    }
                }

            } else {
                $(this).addClass("Select");
                $(this).removeClass("gray");
                if (parent == "Camera") {
                    SelectCamera($(this)[0].id, rel, true);

                }
                if (parent == "RegionService") {
                    SelectRegionService($(this)[0].id, rel, true);

                }
                if (parent == "Device") {
                    //SelectDevice(rel, true);
                    for (var i = 0; i < granson.length; i++) {
                        var ids = granson[i].attributes['rel'].value.split("_");
                        ShowDefaultLayer(ids[0], ids[1], true);
                    }
                }
                if (parent == "Staff")
                    SelectStaff($(this)[0].id, rel, true);
                if (parent == "Deploy") {
                    if (rel == "InterceptCirle")
                        mapFrm.contentWindow.IsShowIntercept(true);
                    else
                        SelectDeployPoint($(this)[0].id, rel, true);
                }
                if (parent == "Traffic") { //交通路况，开启综合模式
                    $("li[parent='Traffic']").removeClass("Select");
                    $("li[parent='Traffic']").addClass("gray");
                    $(this).addClass("Select");
                    $(this).removeClass("gray");
                    mapFrm.contentWindow.SetNeedTraffic(rel);
                }
                if (parentObj.length > 0) {
                    if ($("[parent='" + parent + "']").length > 0) {
                        if (!parentObj.hasClass("Select")) parentObj.addClass("Select");
                    }
                }
            }

        });
        //右边子菜单鼠标滑动事件    
        $("#divChildType li").hover(function () {
            $(this).removeClass("gray");
            var id = $(this).attr("rel");
            var offset = $(this).offset();

            $(this).removeClass("gray");

            if ($("#divGrandson li[parent='" + id + "']").length == 0) {
                $("#divGrandson").hide();
                return;
            }
            if ($(this).hasClass("Select"))
                $(this).removeClass("gray");
            window.status = id + "," + offset.top + "," + offset.left;
            $("#divGrandson li").hide();
            $("#divGrandson li[parent='" + id + "']").show();
            $(this).addClass("active");
            if (offset.top == 0) return;
            $("#divGrandson").css({ "top": (offset.top + 50) + "px", "left": offset.left + "px" });
            $("#divGrandson").show();

        }, function () {
            var id = $(this).attr("rel");
            if (!$(this).hasClass("Select"))
                $(this).addClass("gray");
            var offset = $(this).offset();
            if ($("#divGrandson li[parent='" + id + "']").length == 0) {
                // $("#divChildType").hide();

                return;
            }

            $("#divGrandson").hover(function () {
                $("#divGrandson").css({ "top": (offset.top + 50) + "px", "left": offset.left + "px" });
                $("#divGrandson").show();
                $("#divChildType").show();
            }, function () {
                $("#divGrandson").css({ "top": (offset.top + 50) + "px", "left": offset.left + "px" });
                $("#divGrandson").hide();
                $("#divChildType").hide();
            });
        });
        $("#divGrandson li").hover(function () {
            $(this).removeClass("gray");
        }, function () {
            if (!$(this).hasClass("Select"))
                $(this).addClass("gray");
        });
        $("#divGrandson li").click(function () {
            var rel = $(this).attr("rel");
            var ids = $(this)[0].id.split("_");
            var parent = $(this).attr("parent");
            var parentObj = $("[rel='" + parent + "']");
            if ($(this).hasClass("Select")) {

                $(this).removeClass("Select");
                $(this).addClass("gray");
                if (ids[1] == "Staff")
                    SelectStaff($(this)[0].id, rel, false);
                if (ids[1] == "Device")
                    SelectDevice(rel, false);
                if (ids[1] == "Deploy")
                    SelectDeployPoint($(this)[0].id, rel, false);
                if (parentObj.length > 0) {
                    if ($("[parent='" + parent + "'].Select").length == 0) {
                        parentObj.removeClass("Select");
                        parent = parentObj.attr("parent");
                        parentObj = $("[rel='" + parent + "']");
                        if ($("[parent='" + parent + "'].Select").length == 0) {
                            parentObj.removeClass("Select");
                        }
                    }
                }
            } else {
                $(this).addClass("Select");
                $(this).removeClass("gray");
                if (ids[1] == "Staff")
                    SelectStaff($(this)[0].id, rel, true);
                if (ids[1] == "Device")
                    SelectDevice(rel, true);
                if (ids[1] == "Deploy")
                    SelectDeployPoint($(this)[0].id, rel, true);
                if (parentObj.length > 0) {
                    if ($("[parent='" + parent + "']").length > 0) {
                        if (!parentObj.hasClass("Select")) {
                            parentObj.addClass("Select");
                            parent = parentObj.attr("parent");
                            parentObj = $("[rel='" + parent + "']");
                            if (!parentObj.hasClass("Select")) {
                                parentObj.addClass("Select");
                            }
                        }
                    }
                }
            }
        });
        //信息窗口事件    
        $("#btnInfoClose").click(function () {
            $("#LeftInfoPanel").hide();
            $("#divEdit").hide();
            _self.Resize();

        });
        //信息窗口事件    
        $("#divInfoTitle").dblclick(function () {
            if (!$(this).hasClass("Max")) {
                $("#RightPanel").hide();
                $(this).addClass("Max");
                $("#btnInfoClose").hide();
                $("#LeftInfoPanel").width(WBody - 70);
                $("#ControlLeftInfo").hide();
            }
            else {
                $(this).removeClass("Max");
                $("#btnInfoClose").show();
                $("#LeftInfoPanel").width(320);
                $("#RightPanel").show();
                $("#ControlLeftInfo").show();
            }
            _self.Resize();
        });
        $("#ControlLeftInfo").click(function (e) {
            if ($("#ControlLeftInfo").hasClass("Min")) {
                $('#LeftInfoPanel').show();

                $("#ControlLeftInfo").removeClass("Min")
                $("#ControlLeftInfo").addClass("Normal")
            }
            else {
                $('#LeftInfoPanel').hide();
                $("#ControlLeftInfo").addClass("Min")
                $("#ControlLeftInfo").removeClass("Normal")

            }
            _self.Resize();

        });
    }
    this.Resize=function() {
        HBody = document.documentElement.clientHeight;
        WBody = $("body").width()
        $("#FloatPanel").css({ "left": (WBody - $("#FloatPanel").width() - 10) + "px", "top": (HBody - $("#FloatPanel").height() - 70) + "px" });


        $("#RightPanel").height(HBody);

        $("#frmInfo").height(HBody - 25);
       
        $("#frmEdit").height(HBody - 25);

        var mapWidth;


        mapWidth = WBody;

        if (!$("#LeftInfoPanel").is(':hidden'))
            mapWidth -= $("#LeftInfoPanel").width();
        if (isDock)
            mapWidth -= $("#FloatPanel").width();


        $("#RightPanel").width(mapWidth-1);
        $("#frmMap").width(mapWidth-1);
        $("#frmMap").height(HBody);
        if (mapFrm.contentWindow.mapObj != null)
            mapFrm.contentWindow.mapObj.Resize();

        var offset = $("#RightPanel").offset();

        if (!$("#ControlLeftInfo").hasClass("Min"))
            offset.left = $("#LeftInfoPanel").width() - 13 + $("#LeftPanel").width();
        else
            offset.left = $("#LeftPanel").width();
        offset.top = (HBody - 70) / 2
        $("#ControlLeftInfo").offset(offset);
        // $("#RightTools").offset(offset);
        // $("#RightTools").height(HBody);
        $(".Mask").height(HBody);

    }
}


var _traceObj;
function ResetDefaultLayer() {
    var defaulLayer = ["ServiceRT", "ServiceTR", "MySubRegion", "ServiceTR", "DutyPoint"]
     for(var i=0;i<_outerLayers.length;i++){
         RemoveLayer(_outerLayers[i].name);
    }
    
}
function ChangeReportView() {
    if (!$("#ReportPanel").hasClass("Max")) {

        $("#ReportPanel").addClass("Max");

        $("#ReportPanel").height(400);
        reportFrm.contentWindow.SetHeight(400);
    }
    else {
        $("#ReportPanel").removeClass("Max");
        $("#ReportPanel").height(240);
        reportFrm.contentWindow.SetHeight(240);
    }
}
function CloseReportView() {
    $("#ReportPanel").slideUp();
}
var _condition;




//本页图层控制
var layers = [];
function GetLayerById(id) {
    for (var i = 0; i < layers.length; i++) {
        if(layers[i].Id==id)
        return layers[i];
    }
    for (var i = 0; i < layers.length; i++) {
        if (layers[i].Id == id)
            return layers[i];
    }
    return null;
}

function getSortFun(order, sortBy) {
    var ordAlpah = (order == 'asc') ? '>' : '<';
    var sortFun = new Function('a', 'b', 'return a.' + sortBy + ordAlpah + 'b.' + sortBy + '?1:-1');
    return sortFun;
}

GetRegionImage = function (type, isHalf) {
    try {
        if (type == "10") {//刑事警情
            if (isHalf) return "../images/icon/service/service1.gif"
            return "../images/icon/service/service1.png";
        }
        if (type == "50") { //交通警情
            if (isHalf) return "../images/icon/service/service6.gif"
            return "../images/icon/service/service6.png";
        }
        if (isHalf) return "../images/icon/service/service2.gif"
        return "../images/icon/service/service2.png";
    } catch (e) {
        if (isHalf) return "../images/icon/service/service2.gif"
        return "../images/icon/service/service2.png";
    }
}

function SelectRegionService(id, type, isSelected) {
    var layer = GetLayerById(id);


    if (isSelected) {
        if (layer == null) {
            var layer = GetLayerById(id);
            var now = new Date();
            var ids = id.split("_");
            var fromdt = FormatDate(AddDate(now, "MINUTE", -30), "yyyy-MM-dd HH:mm:SS");
       
            var param = new Object();
            param.stationId = _userInfo.StationId;
            param.serviceType = ids[2];
            param.lastDt = fromdt;
            param.lastId = 0;
            PostData("GetLastRegionService" ,param, function (objs) {
                for (var i = 0; i < objs.length; i++) {
                    objs[i].ImageUrl = GetRegionImage(ids[2], true);
                    objs[i].Content = GetAlertContent(objs[i]);
                    objs[i].Name = "警情信息";
                    objs[i].Title = objs[i].Name;
                    objs[i].StrId = "RegionService-" + i;
                }
                var layer = GetLayerById(id);
                if (layer == null) {
                    layer = new Object();
                    layer.Id = id;
                    layer.NickName = type;
                    layer.ImgUrl = GetRegionImage(ids[2], true);
                    layer.visible = true;
                    layer.Type = "RegionService";
                    layer.NeedRefresh = 1; //需要动态刷新 
                    layers.push(layer);
                }
                layer.MapLayers = objs;
                layer.UpdateDt = new Date();
                UpdateLayer(layer.Id, objs,true);
                FormatSum();
            });
        }
        else {
            mapFrm.contentWindow.ShowLayer(id, true);
            layer.visible = true;
        }
    }
    else {
        mapFrm.contentWindow.ShowLayer(id, false);

        if (layer != null) layer.visible = false;
    }
    FormatSum();
}
function RetrieveCamera(id, stations, pageIndex, typeName) {
    

    var param = new Object();
    var ids = id.split("_");
    param.deviceType = ids[2];
    param.stationId= _condition.RegioinIds;
    param.pageIndex=pageIndex;
    PostData("GetCamera", param, function (objs) {
        
        for (var i = 0; i < objs.length; i++) {
            objs[i].ImageUrl = GetCameraImage(ids[2]);
            objs[i].Longitude = objs[i].Lon;
            objs[i].Latitude = objs[i].Lat;
            objs[i].StrId = id + "-" + cameras.length+i;
            objs[i].Name = objs[i].ShortName == null ? "" : objs[i].ShortName;
        }
        cameras=cameras.concat(objs);
        if(objs.length==100)
        {
            _cameraPageIndex = _cameraPageIndex + 1;
            RetrieveCamear(id, stations, _cameraPageIndex, typeName);
            return;
        }
        SaveLocalData(id, cameras);
        var layer = new Object();
        layer.Id = id;
        layer.MapLayers = cameras;
        layer.Type = "Camera";
        layer.NickName = typeName;
        layer.ImgUrl = GetCameraImage(ids[2]);
        layer.NeedRefresh = 0; //需要动态刷新 
        layers.push(layer);
        layer.visible = true;
        UpdateLayer(id, cameras, true);
        FormatSum();
    });
}
var _cameraPageIndex = 0;
var cameras;
function SelectCamera(id, type, isSelected) {
    var layer = GetLayerById(id);
    if (isSelected) {
        if (layer == null) {
            // $(".Mask").show();
            var ids = id.split("_");
            $("#divMask").show();
            _cameraPageIndex = 0;
            cameras = RetrieveLocalData(id);
            if (cameras != null) {
                var layer = new Object();
                layer.Id = id;
                layer.MapLayers = cameras;
                layer.Type = "Camera";
                layer.NickName = type;
                layer.ImgUrl = GetCameraImage(ids[2]);
                layer.NeedRefresh = 0; //需要动态刷新 
                layers.push(layer);
                layer.visible = true;
                UpdateLayer(id, cameras, true);
                FormatSum();
                return;
            }
            cameras = new Array();
            RetrieveCamear(id, _condition.RegioinIds, _cameraPageIndex,type);           
            
        }
        else {
            mapFrm.contentWindow.ShowLayer(id, true);
            layer.visible = true;
        }
    }
    else {
        mapFrm.contentWindow.ShowLayer(id, false);
        if (layer != null) layer.visible = false;
    }
    FormatSum();
}

function SelectStaff(id,type,isSeleted) {
    var layer = GetLayerById(id);
    if (isSeleted) {       
        if (layer == null) {
            GetStaffInfo(id, type);
        }
        else {
            mapFrm.contentWindow.ShowLayer(id, true);           
            layer.visible = true;
        }
    }
    else {
        mapFrm.contentWindow.ShowLayer(id, false);        
        if (layer != null) layer.visible = false;
        
    }
    FormatSum();
}
var staffColor = ["#ff0000", "#f8440d", "#0000ff", "#babc07", "#8104b5", "#0dcef8", "#01b5b3", "#878787"];

GetStaffInfo = function (id, type) {
    var ids = id.split('_');
    var param = new Object();
    param.stationId = _condition.RegioinIds;
    param.shiftType = ids[2];
    $("#divMask").show();
    QueryData("GetStaffs/" + encodeURI(_condition.RegioinIds) + "/" + ids[2], function (objs) {
        $("#divMask").hide();
        for (var i = 0; i < objs.length; i++) {
            objs[i].Id = objs[i].Id;
            objs[i].Title = objs[i].Name;
            if ($("#"+id).attr("mapicon") != null)
                objs[i].ImageUrl = $("#" + id).attr("mapicon");
            else
                objs[i].ImageUrl = GetRegionShiftImage(objs[i].ShiftType, objs[i].StateName);
            // objs[i].MidImage = "../Images/map/staff" + ids[1] + ".png";
            // objs[i].SmallImage = staffColor[parseInt(ids[1]) - 1];
            //objs[i].Content = FormatContent(objs[i]);
            // objs[i].Content = FormatStaffContent(objs[i]);
            objs[i].StrId = id + "-" + i;
            objs[i].NameDivStyle = "color:#032e76;";
            objs[i].Name = objs[i].Name == null ? "" : objs[i].Name;
            if (objs[i].StationName == null) objs[i].StationName = "";
            objs[i].StationName = TrimStation(objs[i].StationName);
        }
        var layer = GetLayerById(id);
        if (layer == null) {
            layer = new Object();
            layer.Id = id;
            layer.Type = "Staff";

            layer.NickName = type;
            if ($("#" + id).attr("mapicon") != null)
                layer.ImgUrl = $("#" + id).attr("mapicon");
            else
            layer.ImgUrl = GetRegionShiftImage(ids[2], "0");
            layer.visible = true;
            if (parseInt(ids[2]) <= 7) //勤务排班，需要动态刷新
                layer.NeedRefresh = 1;
            else
                layer.NeedRefresh = 0;
            layers.push(layer);
        }
        layer.UpdateDt = new Date();
        layer.MapLayers = objs;
        UpdateLayer(id, objs, true);
        if (!layer.visible)
            mapFrm.contentWindow.ShowLayer(id, false);

        FormatSum();
    });
}
var deviceColor = ["#038108", "#030381", "#", ""]
var _selectedDevice = "";
function GetDeviceName(type) {
    if (type == "1") return "'巡逻车台',"
    if (type == "2") return "'PDT',"
    if (type == "3") return "'群防设备',"
}
function SelectDevice(id, isSeleted) {
    var layer = GetLayerById(id);
    var ids = id.split('_');
    if (isSeleted) {
        if (layer == null) {
             _selectedDevice += ids[1]+",";
            // $(".Mask").show();
             GetDevice(id); 
        }
        else {
            mapFrm.contentWindow.ShowLayer(id, true);
            _selectedDevice.replace(ids[1]+",","");
            layer.visible = true;
            FormatSum();
        }
    }
    else {
        mapFrm.contentWindow.ShowLayer(id, false);
        if (layer != null) layer.visible = false;
        FormatSum();
    }
}
function GetDevice(id) {
    var ids = id.split('_');

    $("#divMask").show();
    QueryData("GetDeviceInfos/" + encodeURI(_condition.RegioinIds) + "/" + ids[1], function (objs) {
        $("#divMask").hide();
        for (var i = 0; i < objs.length; i++) {
            FormateDevice(objs[i],i,id);
        }
        var layer = GetLayerById(id);
        if (layer == null) {
            layer = new Object();
            layer.Id = id;
            layer.Type = "Device";
            layers.push(layer);
            layer.NeedRefresh = 1;
            layer.visible = true;
        }
        layer.UpdateDt = new Date();
        layer.MapLayers = objs;
        UpdateLayer(id, objs,true);
        FormatSum();
    });
}
FormateDevice = function (obj, i, id) {
    var ids = id.split('_');
    obj.Id = obj.Id;
    obj.Title = obj.Name + "<a onclick=\"parent.SetFollow('" + id + "'," + i + ")\" >[监控]</a><a onclick=\"parent.SetTrace('" + id + "'," + i + ")\">[轨迹]</a><a  onclick=\"parent.SetDispatch('" + id + "'," + i + ")\">[调度]</a>";
    obj.ImageUrl = GetDeviceImg(obj.Type, obj.State); //"../Images/map/device" + ids[1] + ".png";

    obj.StrId = id + "-" + i;
    obj.SmallImage = deviceColor[parseInt(ids[1]) - 1];
    //obj.Content = FormatContent(obj);
    obj.Content = FormatDeviceContent(obj);
    obj.Name = obj.Name == null ? "" : obj.Name;
    obj.NameDivStyle = "color:#032e76;";
    if (_currDevice != null) {
        if (_currDevice.Id == obj.Id)
            _currDevice.StrId = obj.StrId;
    }
    if (obj.StationName == null) obj.StationName = "";
    obj.StationName = TrimStation(obj.StationName);
}
SelectDeployPoint = function (id, type, isSeleted) {

    var layer = GetLayerById(id);
 
    if (isSeleted) {
        if (layer == null) {
          
            GetDeployPoint(id,type);
        }
        else {
            mapFrm.contentWindow.ShowLayer(id, true);
            
            layer.visible = true;
            FormatSum();
        }
    }
    else {
        mapFrm.contentWindow.ShowLayer(id, false);
        if (layer != null) layer.visible = false;
        FormatSum();
    }
}
function GetDeployImg(type) {
    if (type == '巡逻必到') return "/images/routepoint1.png";    
    if (type == '一分钟') return "/images/swat_1.png";
    if (type == '三分钟') return "/images/swat_2.png";
    if (type == '五分钟') return "/images/swat_3.png";
    if (type == '加密巡逻') return "/images/swat_4.png";
    if (type == '固定卡点') return "/images/fixcheck1.png";
    if (type == '临时卡点') return "/images/tempcheck1.png";
    if (type == '定点检查') return "/images/pointcheck1.png";
    if (type == '长假排班') return "/images/holidayduty1.png";
    if (type == '围村围楼') return "/images/surround1.png";
 
}
function GetDeployPoint(id, type) {
    var ids = id.split('_');
    $("#divMask").show();
    QueryData("GetPointInfo/" + _condition.RegioinIds + "/" + type, function (objs) {
        $("#divMask").hide();
        for (var i = 0; i < objs.length; i++) {
            objs[i].Id = objs[i].Id;
            objs[i].ImageUrl = GetDeployImg(type);
            objs[i].Title = objs[i].Name;
            objs[i].NameDivStyle = "color:#032e76;";
            objs[i].Content = objs[i].Memo == null ? null : objs[i].Memo;
            objs[i].StrId = id + "-" + i;
        }
        var layer = GetLayerById(id);
        if (layer == null) {
            layer = new Object();
            layer.Id = id;
            layer.NickName = type;
            layer.Type = "DeployPoint";
            layer.ImgUrl = GetDeployImg(type);
            layers.push(layer);
            layer.NeedRefresh = 0;
            layer.visible = true;
        }
        layer.UpdateDt = new Date();
        layer.MapLayers = objs;
        UpdateLayer(id, objs,true);
        FormatSum();
    });
}




function RefreshLayer(force) {
    var now = new Date();
    var ids;
    for (var key in layers) {
        if ((layers[key].visible) && (layers[key].NeedRefresh == 1)) {
        
            if (force||(dateDiff(now, layers[key].UpdateDt) > 60)) {
                ids = layers[key].Id.split("_");
                if (ids[1] == "Staff")
                    GetStaffInfo(layers[key].Id, layers[key].NickName);
                if (ids[0] == "Device")
                    GetDevice(layers[key].Id);
                if (ids[1] == "Case")
                    GetRegionService(layers[key].Id);
            } 
        }        
    }
}
 
function GetGroupName(type) {
    if (type == "Camera") return "视频卡口";
    if (type == "Device") return "警用装备";
    if (type == "Service") return "接处警力";
}
function FormatSum() {

    var htmlStr = "<ul>"
    var cars = 0, persons = 0, counts = 0;
    var ids;
    var title
    var groupReports = {};
    var groupReport
   
    layers.sort(function (a, b) {
        if (a.Id > b.Id)
            return 1;
        return -1;        
    })
    var totalRC = 0;
    for (var i = 0; i < layers.length; i++) {
        if (!layers[i].visible) continue;
        ids = layers[i].Id.split("_");
        
        if (layers[i].NickName != null) {
            title = "<img src='" + layers[i].ImgUrl + "' style='float:left;'><div style='float:left;width:55px; overflow:hidden;'>" + layers[i].NickName+"</div>";
        } else
            title = $("#li_" + layers[i].Id).html().toLowerCase().replace("<br>", "")
        totalRC++;
        rc = layers[i].MapLayers.length;
        if (layers[i].MapLayers.length == 1) {
            if (layers[i].MapLayers[0].Type == "总数量")
                rc = layers[i].MapLayers[0].Id;
        }
        htmlStr += "<li><span>" + title + "</span><span style='width:25px'>" + rc + "</span></li>";
    }
    htmlStr += "</ul>";
    if (totalRC == 0) {
        $("#FloatPanel").hide();
        return;
    }
    $("#LegendContent").html(htmlStr);
    $("#FloatPanel").show();
    $("#LegendTitle").html("勤务力量(" + FormatDate(new Date(), "yyyy-MM-dd HH:mm") + ")");
}




SetCondition = function (condition) {

    //if ((_condition.Name == condition.Name) && (_condition.CaseTypeId == condition.CaseTypeId) && (_condition.RegioinIds == condition.RegioinIds) && (_condition.FromDt == condition.FromDt) && (_condition.ToDt == condition.ToDt)) return;
    _condition = condition;
   // var ids;
   // for (var key in layers) {
  //      ids = key.split("_");
        RefreshLayer(true);
        //if ((ids[0] != "Staff") || (ids[0] != "Device")) continue;
        //GetStaffInfo(key);
   // }
}
//显示报表图层
ShowReport = function (data, condition) {
    if (frmReport.src.toLowerCase().indexOf("/policeshow/chart.html") < 0) {
        frmReport.src = "/policeshow/chart.html";
        setTimeout(function () {
            ShowReport(data, condition);
        }, 1000);
    }
    frmReport.contentWindow.SetData(data, condition);
    $("#ReportPanel").show();
    $("#ReportPanel").addClass("Max");

    $("#ReportPanel").height(HBody - 77);
    reportFrm.contentWindow.SetHeight(HBody - 77);
}

/******地图相关操作**************/
var _mapZoom;
var _mapRegion;
var _outerLayers = new Array();
//显示图层元素窗口信息
ShowLayerInfoWindow = function (layerId, index) {
    mapFrm.contentWindow.ShowLayerInfoWindow(layerId, index);
}
SelectLayerObject = function (strId) {
    mapFrm.contentWindow.SelectLayerObject(strId);
}
function RemoveLayer(id) {
    var index;
    for (var i = 0; i < _outerLayers.length; i++) {
        if (_outerLayers.name == id) {
            index = i;
            _layers[i].objs = null;
            _layers.splice(i, 1);
        }
    }
    mapFrm.contentWindow.RemoveLayer(id);
}
//显示图层
function ShowLayer(layerName,isShow) {
    mapFrm.contentWindow.ShowLayer(layerName, isShow);
}
//根据名称获取图层
function GetLayerByName(name) {

    for (var i = 0; i < _outerLayers.length; i++) {
        if (_outerLayers[i].name == name) return _outerLayers[i];
    }
    return null;
}
//添加图层
//isInner表示是否是内部图层，内部图层有统计
function AddLayer(id, objs, isInner) {
    if (!isInner) {
        var layer = new Object();
        layer.name = id;
        layer.visible = true;
        layer.objs = objs;
        _outerLayers.push(layer);
    }
    mapFrm.contentWindow.AddLayer(id, objs);
}
//更新图层
function UpdateLayer(id, objs,isInner) {

    if (!isInner) {
        var layer = GetLayerByName(id);
        if (layer == null)        
            AddLayer(id, objs, isInner)
        else {
            layer.objs = objs;
            mapFrm.contentWindow.UpdateLayer(id, objs);
        }
    }
    else
        mapFrm.contentWindow.UpdateLayer(id, objs);
}
//追加图层对象
function AppendLayer(id, objs, isInner) {
    if (!isInner) {
        var layer = GetLayerByName(id);
        if (layer == null)
            AddLayer(id, objs, isInner)
        else {
            layer.objs = layer.objs.concat(objs);
            mapFrm.contentWindow.AppendLayer(id, objs);
        }
    }
    else
        mapFrm.contentWindow.AppendLayer(id, objs);    
    
}
//地图圈选后通知info窗口
AfterCircleSelect = function (longitude, latitude, radium) {
    try {
        infoFrm.contentWindow.CircleSelect(longitude, latitude, radium);
    }
    catch (e) {
    }
    

}
//取消圈选后通知info窗口
ClearCircleSelect = function () {
    try {
        infoFrm.contentWindow.ClearCircleSelect();
    }
    catch (e) {
    }
    
}
//框选后通知info窗口
AfterRectSelect = function (left, top, right, bottom) {
    try {
        infoFrm.contentWindow.RectSelect(left, top, right, bottom);
    }
    catch (e) {
    }
    
}
//取消框选后通知info窗口
ClearRectSelect = function () {
    try {
        infoFrm.contentWindow.ClearRectSelect();
    }
    catch (e) {
    }   
}
//地图缩放后通知info窗口
//zoomIndex为当前的缩放等级
OnMapZoom = function (zoomIndex) {
    _mapZoom = zoomIndex;

    try {
        infoFrm.contentWindow.OnMapZoom(zoomIndex);
    }
    catch (e) {
    }
}
//地图移动后通知info窗口
//region为当期视野
OnMapPan = function (region) {
    _mapRegion = region;
    try {
        infoFrm.contentWindow.OnMapPan(region);
    }
    catch (e) {
    }
}
//获取位置后通知info窗口
function AfterGetPosition(lng, lat) {
    try {
        infoFrm.contentWindow.AfterGetPosition(lng,lat);
    }
    catch (e) {
    }
    
}
function PickPos(lng, lat) {
    mapFrm.contentWindow.PickPos(lng,lat);
}
//设置地图工具
function SetMapTool(tool) {
    mapFrm.contentWindow.SetTool(tool);
}
//移动到特定位置和缩放等级
//缩放等级不填则直接移动到特定位置
function ZoomTo(lng, lat, zoomIndex) {
    mapFrm.contentWindow.ReZoom(zoomIndex,lng,lat);
}
//点图加载完毕
function OnMapReady() {
    
    if (_userInfo.Station.Zoom > 0) {
        ZoomTo(_userInfo.Station.CenterX,_userInfo.Station.CenterY,_userInfo.Station.Zoom)
    }
}
var pioObj;
//点击查询结果后，选择具体信息的后续操作
function LocatePosition(layId, id, name, lng, lat,source) {
    if (lng < 100 && lat < 10)
    {
        alert("经纬度值错误");
        return;
    }
    if (source == "Device") {
        var param = new Object();
        param.id = id;        
        $("#divMask").show();
        PostData("GetDeviceById", param, function (obj) {
            $("#divMask").hide();
            pioObj = obj;
            obj.Title = obj.Name + "<a onclick=\"parent.ShowFollow()\" >[监控]</a><a onclick=\"parent.ShowTrace()\">[轨迹]</a><a  onclick=\"parent.DispatchDeviveById('" + id + "')\">[调度]</a>";
            obj.ImageUrl = GetDeviceImg(obj.Type, obj.State);
            obj.Content = FormatDeviceContent(obj);
            obj.Name = obj.Name == null ? "" : obj.Name;
            if (obj.StationName == null) obj.StationName = "";
            obj.StationName = TrimStation(obj.StationName);
            mapFrm.contentWindow.DrawImage(obj);
            return;
        });
    }
    if (source == "Staff") {
        var param = new Object();
        param.id = id;
        $("#divMask").show();
        PostData("GetStaffById", param, function (obj) {
            $("#divMask").hide();
            pioObj = obj;
            obj.ImageUrl = GetRegionShiftImage(obj.ShiftType, obj.StateName);         
            obj.Name = obj.Name == null ? "" : obj.Name;
            if (obj.StationName == null) obj.StationName = "";
            obj.StationName = TrimStation(obj.StationName);
            mapFrm.contentWindow.DrawImage(obj);
            return;
        });
    }
    if(source!="Device"&&source!="Staff")
    mapFrm.contentWindow.ShowTheme(lng, lat, name, null);
}
//移动轨迹回访到具体位置
function MoveTrack(index, lng, lat) {
    mapFrm.contentWindow.MoveTrack(index);
}
//暂停轨迹回访
function PauseTrace() {
    mapFrm.contentWindow.PauseTrace()
}
//停止回放
function StopTrace() {
    mapFrm.contentWindow.StopTrace()
}
//清除轨迹
function ClearTraceInfo() {
    
    mapFrm.contentWindow.ClearTraceInfo()
}
//添加轨迹点
function AddTrace(objs) {
    mapFrm.contentWindow.AddTrace(objs);
}
//更新点信息
function UpdateMark(mark) {
    if (mark.Id == _currDevice.Id) {
        mark.StrId = _currDevice.StrId;
    }
    mapFrm.contentWindow.UpdateMark(mark);
}
//开始轨迹回放
function StartTrace(speed, imgUrl) {
    mapFrm.contentWindow.StartTrace(speed, imgUrl);
}
var videos = new Array();
//地图选中market对象
SelectedItem = function (objIndex, layerName) {
    if (layerName == _condition.Name) {
        infoFrm.contentWindow.SelectedItem(objIndex);
        return;
    }
    var htmlStr
    if (layerName.substr(3, 6) == "Camera") {
        var layer = GetLayerById(layerName);
        var camera = layer.MapLayers[objIndex];
        ShowVideo(camera.GISID);       
    }
}
//播放视频
ShowVideo = function (gisId) {
    self.location = "vshow:" + gisId;
}

/******通用功能操作**************/
//获取当前选中设备类型
GetDeviceTypes = function () {
    if (_selectedDevice.length > 0) return _selectedDevice.substr(0, _selectedDevice.length - 1);
    return "0";
}
MoveObject = function (source, x, y) {
    var offset = $("#" + source).offset();
    var oX = offset.left + x;
    var oY = offset.top + y;
    $("#" + source).css({ "left": oX + "px", "top": oY + "px" });
}
//选择缺省子项
ShowDefaultLayer = function (type, index, isShow) {
    var id = "li_" + type + "_" + index;
    var rel = $("#"+id).attr("rel");
    var parent = $("#" + id).attr("parent");
    if (!isShow) {
        $("#" + id).removeClass("Select");
        $("#" + id).addClass("gray");
        if (parent == "Camera") {
            SelectCamera(id, rel, false);
            return;
        }
        if ((parent == "Car")||(parent == "Personal")||(parent == "Group")) {
            SelectDevice(rel, false);
            return;
        }
        if ((parent == "Process") || (parent == "Social") || (parent == "Intercept")) {
            SelectStaff(id,rel, false);
            return;
        }        
    } else {
        $("#" + id).addClass("Select");
        $("#" + id).removeClass("gray");
        if (parent == "Camera") {
            SelectCamera(id, rel, true);            
        }
        if ((parent == "Car") || (parent == "Personal") || (parent == "Group")) {
            SelectDevice(rel, true);           
        }
        if ((parent == "Process") || (parent == "Social") || (parent == "Intercept")) {
            SelectStaff(id, rel, true);           
        }  
        
    }

}
var _currDevice;//当前设备
//隐藏轨迹窗口图层
HideTrace=function()
{
$("#divTrace").hide();
}
//地图打开轨迹操作
SetTrace = function (layname, objIndex) {
    //
    var device;
    if (layname == "PoliceShow") {
        var layer = GetLayerByName(layname);
        device = layer.objs[objIndex];
    }
    else {
        var layer = GetLayerById(layname);
        if (layer == null)
        {
            layer = GetLayerByName(layname);
            device = layer.objs[objIndex];
        }
        else
        device = layer.MapLayers[objIndex];
          
    }   
    ShowTrace(device);
  
}
//警力查询打开跟踪操作
ShowTrace = function (obj) {
    if(obj==null) obj=pioObj;
    traceFrm.contentWindow.SetDevice(obj, "Trace");
    _currDevice=obj;
    $("#divTrace").show();
}
//地图打开跟踪操作
SetFollow = function (layname, objIndex) {
    var device;
    //traceFrm.contentWindow.SelectDev(devCode, devName);
    if (layname == "PoliceShow") {
        var layer = GetLayerByName(layname);
        device = layer.objs[objIndex];
    }
    else {
        var layer = GetLayerById(layname);
        if (layer == null) {
            layer = GetLayerByName(layname);
            device = layer.objs[objIndex];
        }
        else
            device = layer.MapLayers[objIndex];
    }
    ShowFollow(device);
}
ShowFollow=function(obj)
{
    if(obj==null) obj=pioObj;
    _currDevice = obj;
    traceFrm.contentWindow.SetDevice(obj, "Follow");
    $("#divTrace").show();
}
ShowCarVideo = function (videoId) {
    // var videoIds = _currDevice.VideoIds;
    
    self.location = "vshow:carVideo#" + videoId;
   // document.getElementById("frmCarVideo").contentWindow.CancelVideoMonitor(_currDevice.Code);
       
}

//扩大编辑图层
ExpandInfo = function () {
    $("#LeftInfoPanel").width(900);
    $("#frmInfo").width(900);
    mapFrame.Resize();
}
//缩小编辑图层
ShrinkInfo = function () {
    $("#LeftInfoPanel").width(400);
    $("#frmInfo").width(400);
    mapFrame.Resize();
}
LoadCarVideo=function(curMobile, carNo, paramList){
    document.getElementById("frmCarVideo").contentWindow.LoadVideo(curMobile, carNo, paramList, 0x01); //0x01表示视频监控链路

}
SetCarVideoTime = function (timeInterval) {
    document.getElementById("frmCarVideo").contentWindow.SetTimeService(timeInterval);
}
//地图打开调度操作
SetDispatch = function (layname, objIndex) {
    //traceFrm.contentWindow.SelectDev(devCode, devName);
    if (layname == "PoliceShow") {
        var layer = GetLayerByName(layname);
        var obj = layer.objs[objIndex];
        _currDevice = obj;
        ShowDialog("/PoliceShow/Dispatch.html?type=2&staffIds=" + obj.Id);
    }
    else {
        var layer = GetLayerById(layname);
        var obj = layer.MapLayers[objIndex];
        ShowDialog("/PoliceShow/Dispatch.html?type=1&deviceIds=" + obj.Id);
    }
}
//地图打开调度操作
DispatchDeviveById = function (id) {
   
    ShowDialog("/PoliceShow/Dispatch.html?type=1&deviceIds=" + id);
   
}
SetReportStation = function (stationId) {
    reportFrm.contentWindow.SetStationId(stationId);
}
function Alert() {
    alert("hello");
}

ShowDialog = function (url, width, height) {
    if (width == null) {
        width = 800;
        height = 600;
    }
    TINY.box.show({ iframe: url, width: width, height: height, fixed: false })
}
