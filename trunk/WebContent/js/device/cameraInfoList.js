function AfterInitial() {
    cameraInfoList = new CameraInfoList();
    cameraInfoList.Initial();
}
var cameraInfoList;
function CameraInfoList() {
    var tableTmp;
    var _self = this;
    _self.orderField = "Id desc";
    this.Initial = function () {
        if (RetrieveLocalData("cameraInfoListFilter") != null) {
            _self.filter = RetrieveLocalData("cameraInfoListFilter");
            _self.SetFilter();
        }
        _self.pageSize = 10;
        _self.pageIndex = RetrieveLocalData("cameraInfoListPage");
        if (_self.pageIndex == null) _self.pageIndex = 0;
        _self.tableTmp = document.getElementById('tmpl').innerHTML;
        _self.detailTmp = document.getElementById('tmpDetail').innerHTML;
        _self.InitData();
        _self.InitEvent();
    }
    this.InitData = function () {
        layui.use(['laypage', 'layer', 'laytpl', 'form'], function () {
            _self.laypage = layui.laypage
            , _self.layer = layui.layer
            , _self.laytpl = layui.laytpl
            , _self.form = layui.form
            $("#btnSearch").click();
            $("#txtBuildNames").val('园区一层');
        });
    }
    this.SetFilter = function () {
        for (var i = 0; i < _self.filter.length; i++) {
            if (_self.filter[i].FieldName == "Name") {
                $("#txtKeyword").val(_self.filter[i].Value)
            }
        }
    }
    this.GetFilter = function () {
        _self.filter = new Array();
        condition = new Object();
        if ($("#txtKeyword").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'Name';
            condition.Opt = '包含';
            condition.Value = $("#txtKeyword").val();
            condition.FieldType = "string";
            _self.filter.push(condition);
        }
    }
    this.InitEvent = function () {
        $("#btnSearch").click(function (e) {
            _self.GetFilter();
            _self.RetrieveData();
        });
        $("#divHead th").click(function (e) {
            var rel = $(this).attr("sortfield");
            if (rel != null) {
                if (rel == orderField) {
                    orderField = rel + " desc";
                }
                else {
                    orderField = rel;
                }
                _self.RetrieveData();
            }
        });
        $("#btnNew").click(function (e) {
            _cameraInfo = new Object();
            $("#divMain").addClass("bd-content-wrap1");
            ShowPanel("#divEdit", 380);
            parent.ExpandInfo();
            _self.BindDetail();
        });

        $("#btnSave").click(function (e) {
            _self.AcceptText();
            var param = new Object();
            param.request = _cameraInfo;
            PostData("SaveCameraInfo", param, function (result) {
                _cameraInfo = result.Data;
                _self.layer.alert("保存成功！");
                _self.RetrieveData();
            });
        });
        $("#btnReturn").click(function (e) {

            HidePanel("#divEdit")
            $("#divMain").removeClass("bd-content-wrap1");
            parent.ShrinkInfo();
        });
        $("#txtBuildNames").click(function (e) {
            var offset = $(this).offset();
            $("#divBuilding").css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $("#divBuilding").show();
            e.stopPropagation();
        });

    }
    this.BindDetailEvent = function () {
        $("#txtBuildName").click(function (e) {
            var offset = $(this).offset();
            $("#divBuilding").css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $("#divBuilding").show();
            e.stopPropagation();
        });
        $("#txtManufacturer").click(function (e) {
            var offset = $(this).offset();
            _self.dictOwner = "Position";
            $("#divManufacturer").css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $("#divManufacturer").show();
            e.stopPropagation();
        });
        $(".baseDict").click(function (e) {
            _self.dictCode = $(this).attr("dictcode");
            _self.dictName = $(this).attr("showname");
            document.getElementById("frmDict").contentWindow.SetDict(_self.dictCode, _self.dictName);
            var offset = $(this).offset();
            $("#divDict").css({ "top": (offset.top) + "px", "left": +(offset.left) + "px" });
            $("#divDict").show();
            e.stopPropagation();
        });
    }
    this.AcceptText = function () {
        if ($("#txtAltitude").val().length > 0)
            _cameraInfo.altitude = $("#txtAltitude").val();
        _cameraInfo.name = $("#txtName").val();
        _cameraInfo.buildName = $("#txtBuildName").val();
        _cameraInfo.deviceType = $("#txtDeviceType").val();
        _cameraInfo.serverIP = $("#txtServerIP").val();
        _cameraInfo.channelIndex = $("#txtChannelIndex").val();
        _cameraInfo.manufacturer = $("#txtManufacturer").val();
        _cameraInfo.direction = $("#txtDirection").val();
        _cameraInfo.distance = $("#txtDistance").val();
        _cameraInfo.companyId = _LoginUser.companyId;
        _cameraInfo.buildId = $("#hfBuildId").val();
        if ($("#txtMatrixPort").val().length > 0)
            _cameraInfo.matrixPort = $("#txtMatrixPort").val();
    }
    this.BindDetail = function () {
        _self.laytpl(_self.detailTmp).render(_cameraInfo, function (html) {
            document.getElementById('divEditInfo').innerHTML = html;
            _self.BindDetailEvent();
        });
    }
    function Resize() {
    }
    var _cameraInfos;
    var _cameraInfo;
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = _self.pageSize;
        param.pageIndex = _self.pageIndex;
        param.orderField = _self.orderField;
        PostData("GetCameraInfo", param, function (result) {
            _cameraInfos = result.Datas;
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('divContent').innerHTML = html;
            });
            parent.UpdateLayer("Camera", _cameraInfos);
            // parent.
        });
    }
    this.Delete = function (id) {
        if (!confirm("亲，您真的要删除该记录吗?")) return;
        var request = new Object();
        request.id = id;
        PostData("DeleteCameraInfo", request, function (result) {
            layer.alert("删除记录成功!");
            _self.RetrieveData();
        });
    }
    this.Edit = function (index) {
        $("#divMain").addClass("bd-content-wrap1");
        ShowPanel("#divEdit", 380);
        parent.ExpandInfo();
        _cameraInfo = _cameraInfos[index];
        _self.BindDetail();

    }
    this.SetBuilding = function (treeNode) {
        _cameraInfo.buildName = treeNode.name;
        _cameraInfo.buildId = treeNode.id;
        _self.BindDetail();
    }
    this.SetManufacture = function (treeNode) {
        _cameraInfo.Manufacturer = treeNode.name;
        _self.BindDetail();
    }
    this.SetPosition = function (lng, lat) {
        if (_self.GetPos) {
            _cameraInfo.longitude = lng.toFixed(6);
            _cameraInfo.latitude = lat.toFixed(6);
            _self.BindDetail();
            _self.GetPos = false;
        }
    }
    this.SetDict = function (treeNode) {
        $("#txtManufacturer").val(treeNode.name);
        $("#hfManufacturerID").val(treeNode.id);
    }
    this.GetPosition = function () {
        _self.GetPos = true;
        parent.PickPos(_cameraInfo.longitude, _cameraInfo.latitude);
    }
    this.SelectDict = function (baseDict) {
        $("#txt" + _self.dictName).val(baseDict.code);
        if ($("#txt" + _self.dictName + "Name").length > 0) {
            $("#txt" + _self.dictName + "Name").val(baseDict.name);
            $("#txt" + _self.dictName + "Name").focus();
        } else {
            $("#txt" + _self.dictName).val(baseDict.name);
            $("#txt" + _self.dictName).focus();
        }
    }
}
function SelectBuilding(treeNode) {
    $("#txtBuildName").val(treeNode.name);
    $("#hfBuildId").val(treeNode.id);
    $("#txtBuildNames").val(treeNode.name);
    $("#hfBuildIds").val(treeNode.id);
    $("#divBuilding").hide();
}
function SelectDict(treeNode) {
    cameraInfoList.SetDict(treeNode);
    $("#divManufacturer").hide();
}
function AfterGetPosition(lng, lat) {
    cameraInfoList.SetPosition(lng, lat);
}
function SelectBaseDict(node) {
    if (node.children != null) return;
    cameraInfoList.SelectDict(node);
    $("#divDict").hide();
}

