function AfterInitial() {
    stationSelector = new StationSelector();
    //执行
    stationSelector.Initial();
}
var stationSelector
function StationSelector() {
    var _self = this;
    var _allStations;
    var ismulti = false;
    _self.pId = _LoginUser.stationId;

    //初始化
    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
        _self.initContextMenu();
    }

    //初始化数据
    this.InitData = function () {
        layui.use(['laypage', 'layer', 'laytpl'], function () {
            _self.laypage = layui.laypage
                , _self.layer = layui.layer
                , _self.laytpl = layui.laytpl
        });
        if (request("pId") != null)
            _self.pId = request("pId");
        _self.setting = {
            view: {
                dblClickExpand: false,
                selectedMulti: false,
                showIcon: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: SelectStation,
                onClick: TreeOnClick,
                onExpand: onExpandforchangeWidth,
                onCollapse: onExpandforchangeWidth
            }
        };
        //if (request("multi") == "1")  
        if (_self.getParam("multi")) {
            ismulti = true;
            _self.setting = {
                check: {
                    enable: true,
                    nocheckInherit: false
                },
                view: {
                    dblClickExpand: false,
                    selectedMulti: false,
                    showIcon: true
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onCheck: MultiSelectStation
                }
            };
            $("#divSelectedNames").show();
        }

        //取回数据库数据
        RetrieveDBData("AllStation", function (datas) {
            _allStations = datas;
            _self.pageIndex = 0;
            if (_allStations == null) {
                _allStations = new Array();
                _self.RetrieveAllData();
                return;
            }
            _self.ShowData();
            _self.AddOption();
        });
    }

    //json传输格式
    this.GetFilter = function () {
        _self.filter = new Array();
        var condition = new Object();
        condition = new Object();
        condition.opt = "exists";
        condition.value = "(select id from dbo.GetChildIds(" + _self.pId + ",'1') a where a.id=station.id)";
        condition.fieldType = "string";
        _self.filter.push(condition);
    }

    //取回所有数据
    this.RetrieveAllData = function () {
        _self.GetFilter();
        var param = new Object();
        param.stationId = 1;
        param.stationGroupId = 0;
        PostData("sys/station/tree", param, function (result) {
            if (result.data.length > 0) {
                for (var i = 0; i < result.data.length; i++) {
                    result.data[i].pId = result.data[i].PId;
                    if (result.data[i].id == _self.pId)
                        result.data[i].open = true;
                }

                _allStations = _allStations.concat(result.data);
                SaveDBData("AllStation", _allStations);
                _self.ShowData();
                _self.AddOption();
            }
        });
    }
    this.initContextMenu = function () {
        $("body").contextmenu(function (e) {
            $("#myMenu1").css({ "top": e.clientY + "px", "left": +e.clientX + "px" });
            $("#myMenu1").show();
            return false;
        });
    }
    this.InitEvent = function () {
        $("#btnRefresh").click(function (e) {
            RefreshData();
            $('#myMenu1').hide();
        });
    }
    //选择单位
    function SelectStation(event, treeId, treeNode) {
        if (typeof parent.changeStation == "function") {
            parent.changeStation(treeNode);
        }
    }

    //根据id选择单位
    function SelectStationById(id) {
        var _node = zTree.getNodeByParam("id", id, null);
        if (_node != null) {
            zTree.selectNode(_node);
            zTree.expandNode(_node, true, true, true);
        }
    }

    //批量选择单位
    function MultiSelectStation() {
        var nodes = zTree.getCheckedNodes(true);
        var ids = "", names = "";
        var checkNames = "";
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].check_Child_State == 1)
                continue;
            ids += nodes[i].id + ",";
            names += nodes[i].name + ",";
            checkNames += "<li>" + nodes[i].name + "</li>";
        }
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1)
            names = names.substr(0, names.length - 1)
        }
        $("#ulSelectName").html(checkNames);
        // parent.SelectMultiStation(ids, names);
    }

    //刷新数据
    RefreshData = function () {
        SaveDBData("StationTree", null);
        _self.pageIndex = 0;
        _allStations = new Array();
        _self.RetrieveAllData();
    }

    //展示数据
    this.ShowData = function () {
        // var keyword = $("#txtKeyword").val().toUpperCase();
        _currDatas = _allStations;// Enumerable.From(_allStations).Where(function (x) { return x.code.indexOf(keyword) >= 0 || x.name.indexOf(keyword) >= 0 || x.pyCode.toUpperCase().indexOf(keyword) >= 0; }).OrderBy("x=>x.code").Take(10).ToArray();
        console.log(_currDatas);
        var indDB = new IndexDB();
        indDB.SaveData("treeData", _currDatas);
        _self.ShowTree(_currDatas);
    }

    //展示树
    this.ShowTree = function (datas) {
        $("#tree").html("");
        //树对象
        zTree = $.fn.zTree.init($("#tree"), _self.setting, datas);
        if (request("selectedIds") != null)
            _self.RefreshChecked(request("selectedIds"));
        if (request("default") != null) {
            var nodes = zTree.getNodes();
            if (nodes.length > 0) {
                if (typeof parent.SelectStation == "function") {
                    parent.SelectStation(nodes[0]);
                }
            }
        }
        _self.openNodebyDefault(123); //默认展开分局
    }

    //检查刷新
    this.RefreshChecked = function (selectedIds) {
        var checkNames = "";
        var arrids = selectedIds.split(",");
        zTree.checkAllNodes(false);
        for (var i = 0; i < arrids.length; i++) {
            var _node = zTree.getNodeByParam("id", arrids[i], null);
            if (_node != null) {
                zTree.checkNode(_node, true, true);
                checkNames += "<li>" + _node.name + "</li>";
            }
        }
        $("#ulSelectName").html(checkNames);
    }

    //打开节点
    this.openNode = function (treeId) {
        zTree.selectNode(zTree.getNodeByParam("id", treeId, null));
        if (ismulti) {
            zTree.checkNode(zTree.getNodeByParam("id", treeId, null), !zTree.getNodeByParam("id", treeId, null).checked, true);
            zTree.setting.callback.onCheck();
        }
        else {
            zTree.setting.callback.onClick(null, zTree.setting.id, zTree.getNodeByParam("id", treeId, null));
        }

        onExpandforchangeWidth();
    }
    function onExpandforchangeWidth() {
        if (typeof parent.onExpandforchangeWidth1 == "function") {
            parent.onExpandforchangeWidth1();
        }
    }

    //点击节点
    function TreeOnClick(event, treeId, treeNode) {
        //判断
        // console.log(treeNode);
        console.log(treeNode.id + ", " + treeNode.name);
        // let arr = treeNode.tId.split("_");
        //输入框中的值
        $("#station_select_ztree").val(treeNode.name);
        //发送给服务器的值
        // $("#station_select_ztree").attr("stationId",parseInt(arr[1])).id
        sessionStorage.setItem("stationId", treeNode.id);
    };


    // 画警员搜索
    this.AddOption = function () {
        if (typeof parent.AddOption == "function") {
            parent.AddOption(_allStations);
        }
    }

    //获取引用参数
    this.getParam = function (param) {
        var js = document.getElementsByTagName("script");
        for (var i = 0; i < js.length; i++) {
            if (js[i].src.indexOf("stationSelector.js") >= 0) {
                var arraytemp = new Array();
                arraytemp = js[i].src.split('?');
                arraytemp = arraytemp[1].split('&');
                for (var j = 0; j < arraytemp.length; j++) {
                    var temp = arraytemp[j].split('=');
                    if (temp[0] == param && temp[1] == "1") {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    //默认打开某个节点
    this.openNodebyDefault = function (treeId) {
        zTree.expandNode(zTree.getNodeByParam("id", treeId, null));
    }
}

