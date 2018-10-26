
var SelectorItem;
function stationSelectorItem() {
    var _self = this;
    var _allStations;
    var _ismulti = false;
    var _treeId="tree";
    var _stationId=1;
    var _stationGroupId=0;
    var _zTree;
    _self.pId=_LoginUser.stationId;

    this.Initial = function (multi,treeId,stationId,stationGroupId,pid) {
    	if(typeof multi!="undefined"){
        	_ismulti=multi;
        }
        if(typeof treeId!="undefined"){
        	_treeId=treeId;
        }
        if(typeof stationId!="undefined"){
        	_stationId=stationId;
        }
        if(typeof stationGroupId!="undefined"){
        	_stationGroupId=stationGroupId;
        }
        if(typeof pid!="undefined"){
        	_self.pId=pid;
        }
        _self.InitData(); 
    }
    this.InitData = function () {
        layui.use(['laypage', 'layer', 'laytpl'], function () {
            _self.laypage = layui.laypage
            , _self.layer = layui.layer
            , _self.laytpl = layui.laytpl
        });
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
                onExpand:onExpandforchangeWidth,
                onCollapse:onExpandforchangeWidth
            }
        };    
        if (_ismulti==true)
        {
            _self.setting = {
                check: {
                    enable: true,
                    nocheckInherit: false,
                    chkboxType: {"Y":"", "N":""}
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
        }
        var stationData=_stationId+"-"+_stationGroupId;
        RetrieveDBData(stationData, function (datas) {
            _allStations = datas;
            if (_allStations == null) {
                _allStations = new Array();              
                _self.RetrieveAllData();                  
                return;
            }
            _self.ShowData();
            _self.AddOption();
        });        
    }
    this.RetrieveAllData = function () {
        var param = new Object();
        param.stationId = _stationId;
        param.stationGroupId = _stationGroupId;
        PostData("sys/station/tree", param, function (result) {
            if (result.data.length > 0) {    
            	for(var i=0;i<result.data.length;i++)
        		{
            		result.data[i].pId=result.data[i].PId; 
            		if(result.data[i].id==_self.pId)
            			result.data[i].open=true;  
        		}
                _allStations = _allStations.concat(result.data);
                var stationData=_stationId+"-"+_stationGroupId;
                SaveDBData(stationData, _allStations);
            }
            _self.ShowData(); 
            _self.AddOption(); 
        });
    }
    function SelectStation(event, treeId, treeNode) {
    	if(typeof parent.changeStation=="function"){
    		parent.changeStation(treeNode);
    	}
    }
    function SelectStationById(id) {
        var _node = _zTree.getNodeByParam("id", id, null);
        if (_node != null) {
        	_zTree.selectNode(_node);
        	_zTree.expandNode(_node, true, true, true);
        }
    }
    function MultiSelectStation() {
    	var nodes = _zTree.getCheckedNodes(true);
    	if(typeof parent.changeStation=="function"){
    		parent.changeMultiStation(nodes);
    	}
        
//        var ids = "", names = "";
//        var checkNames = "";
//        for (var i = 0; i < nodes.length; i++) {
//            if (nodes[i].check_Child_State == 1)
//                continue;
//            ids += nodes[i].id + ",";
//            names += nodes[i].name + ",";
//            checkNames += "<li>" + nodes[i].name + "</li>";
//        }
//        if (ids.length > 0) {
//            ids = ids.substr(0, ids.length - 1)
//            names = names.substr(0, names.length - 1)
//        }
       // $("#ulSelectName").html(checkNames);
        // parent.SelectMultiStation(ids, names);
    }
    this.RefreshData = function () {
    	 var stationData=_stationId+"-"+_stationGroupId;
        SaveDBData(stationData, null);
        _self.pageIndex = 0;
        _allStations = new Array();
        _self.RetrieveAllData();
    }
    this.ShowData = function () {
       // var keyword = $("#txtKeyword").val().toUpperCase();
        _currDatas = _allStations;// Enumerable.From(_allStations).Where(function (x) { return x.code.indexOf(keyword) >= 0 || x.name.indexOf(keyword) >= 0 || x.pyCode.toUpperCase().indexOf(keyword) >= 0; }).OrderBy("x=>x.code").Take(10).ToArray();
        _self.ShowTree(_currDatas);
    }
    this.ShowTree = function (datas) { 
        $("#"+_treeId).html("");        
        _zTree = $.fn.zTree.init($("#"+_treeId), _self.setting, datas); 
        
    }   
    this.RefreshChecked=function(selectedIds) {
        var checkNames = "";
        var arrids = selectedIds.split(",");
        _zTree.checkAllNodes(false);
        for (var i = 0; i < arrids.length; i++) {
            var _node = _zTree.getNodeByParam("id", arrids[i], null);
            if (_node != null) {
            	_zTree.checkNode(_node, true, true);
                checkNames += "<li>" + _node.name + "</li>";
            }
        }
        $("#ulSelectName").html(checkNames);
    }
    this.openNode=function(treeId){    	
    	_zTree.selectNode(_zTree.getNodeByParam("id",treeId,null));
    	if(ismulti){    
    		_zTree.checkNode(_zTree.getNodeByParam("id",treeId,null), !_zTree.getNodeByParam("id",treeId,null).checked, true); 
    		_zTree.setting.callback.onCheck();
    	}
    	else{
    		_zTree.setting.callback.onClick(null, _zTree.setting.id, _zTree.getNodeByParam("id",treeId,null));	
    	}    	
    	onExpandforchangeWidth();
    }
    function onExpandforchangeWidth(){
    	if(typeof parent.onExpandforchangeWidth1=="function"){
    		parent.onExpandforchangeWidth1();
    	}
    }
 // 画警员搜索
    this.AddOption=function() {
    	if(typeof parent.AddOption=="function"){
    		parent.AddOption(_allStations);
    	}
 	}
    //默认打开某个节点
    this.openNodebyDefault=function(treeId){
    	_zTree.expandNode(zTree.getNodeByParam("id",treeId,null));
    }
}

