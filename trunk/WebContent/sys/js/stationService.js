
/**
 * edit and save
 */
function saveStation(obj) {
    let pageFilter = new Object();
    load.PostData("sys/station/save", pageFilter, function (result) {
        if (result.message == "Success") {

        } else {

        }
        AfterInitial();
    });
}

function delStation(id) {
    let del_id = id;
    load.PostData("sys/station/delete", del_id, function (result) {
        if (result.message == "Success") {

        } else {

        }
        AfterInitial();
    });
}

function queryStationById(id) {
    let gete_id = id
    load.PostData("sys/station/get", gete_id, function (result) {
        if (result.message == "Success") {
            $("#pre_station").val(result.data.name);
        } else {
            layer.msg("无上级单位");
        }
    });
}


/**��ѡ�¼�����*/
function AfterInitial() {
    stationSelector = new StationSelector();
    stationSelector.Initial();
}
var stationSelector
function StationSelector() {
    var _self = this;
    var _allStations;
    var ismulti = false;
    _self.pId = _LoginUser.stationId;
    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
        _self.initContextMenu();
    }
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
                showIcon: true,

                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,//true
                showRenameBtn: showRenameBtn//true
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
                onCollapse: onExpandforchangeWidth,

                beforeDrag: beforeDrag,
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
                beforeRename: beforeRename,
                onRemove: onRemove,
                onRename: onRename,
                beforeDrag: beforeDrag,
                beforeDrop: beforeDrop
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
    this.GetFilter = function () {
        _self.filter = new Array();
        var condition = new Object();
        condition = new Object();
        condition.opt = "exists";
        condition.value = "(select id from dbo.GetChildIds(" + _self.pId + ",'1') a where a.id=station.id)";
        condition.fieldType = "string";
        _self.filter.push(condition);
    }
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
    function SelectStation(event, treeId, treeNode) {
        if (typeof parent.changeStation == "function") {
            parent.changeStation(treeNode);//在policeStationSchedulingMenu.jsp中
        }
    }
    //��ѡ�¼�����
    function TreeOnClick(event, treeId, treeNode) {
        console.log(treeNode);
        queryStationById(treeNode.pId);
        $("#title").html("更新");
        $("#post_data_btn").html("更新");
    }
    function SelectStationById(id) {
        var _node = zTree.getNodeByParam("id", id, null);
        if (_node != null) {
            zTree.selectNode(_node);
            zTree.expandNode(_node, true, true, true);
        }
    }
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
    RefreshData = function () {
        SaveDBData("StationTree", null);
        _self.pageIndex = 0;
        _allStations = new Array();
        _self.RetrieveAllData();
    }
    this.ShowData = function () {
        _currDatas = _allStations;
        _self.ShowTree(_currDatas);
    }

    /**��ѡ�¼�����*/
    this.ShowTree = function (datas) {
        $("#tree").html("");
        zTree = $.fn.zTree.init($("#tree"), _self.setting, datas);
        setCheck();
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

    //高级编辑
    function beforeEditName(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.selectNode(treeNode);
        setTimeout(function () {
            if (confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？")) {
                setTimeout(function () {
                    zTree.editName(treeNode);
                }, 0);
            }
        }, 0);
        return false;
    }
    function beforeRemove(treeId, treeNode) {

        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.selectNode(treeNode);
        console.log(treeNode.children);
        if (treeNode.children !== undefined) {
            layer.msg("无法删除,还有子节点");
            return false
        }
        return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
    }
    function onRemove(e, treeId, treeNode) {
        console.log("onRemove");
    }
    function beforeRename(treeId, treeNode, newName, isCancel) {
        if (newName.length == 0) {
            setTimeout(function () {
                var zTree = $.fn.zTree.getZTreeObj("tree");
                zTree.cancelEditName();
                alert("节点名称不能为空.");
            }, 0);
            return false;
        }
        return true;
    }
    function onRename(e, treeId, treeNode, isCancel) {
        console.log("onRename");
    }
    function showRemoveBtn(treeId, treeNode) {
        return treeNode;//!treeNode.isFirstNode;
    }
    function showRenameBtn(treeId, treeNode) {
        return !treeNode;//!treeNode.isLastNode;
    }

    var newCount = 1;
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);//add icon
        var btn = $("#addBtn_" + treeNode.tId);
        if (btn) btn.bind("click", function () {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            // zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, name: "new node" + (newCount++) });
            console.log(treeNode);
            $("#pre_station").val(treeNode.name);
            $("#title").html("新增");
            $("#post_data_btn").html("新增");
            return false;
        });
    };
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
    };
    function selectAll() {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.setting.edit.editNameSelectAll = $("#selectAll").attr("checked");
    }

    /**��ѡ�¼��*/
    function beforeDrag(treeId, treeNodes) {
        for (var i = 0, l = treeNodes.length; i < l; i++) {
            if (treeNodes[i].drag === false) {
                return false;
            }
        }
        return true;
    }
    function beforeDrop(treeId, treeNodes, targetNode, moveType) {
        console.log(targetNode);
        console.log(treeNodes);
        return targetNode ? targetNode.drop !== false : true;
    }

    function setCheck() {
        let zTree_obj = $.fn.zTree.getZTreeObj("tree");
        console.log("1111");
        zTree_obj.setting.edit.drag.isCopy = true;
        zTree_obj.setting.edit.drag.isMove = true;
        zTree_obj.setting.edit.drag.prev = true;
        zTree_obj.setting.edit.drag.inner = true;
        zTree_obj.setting.edit.drag.next = true;
    }

    // $(document).ready(function () {
    //     $.fn.zTree.init($("#tree"), setting, zNodes);
    //     setCheck();
    // });
}

