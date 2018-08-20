function AfterInitial() {
	shiftTypeSelector = new ShiftTypeSelector();
	shiftTypeSelector.Initial();
}
var shiftTypeSelector
function ShiftTypeSelector() {
	var _self = this;
	this.Initial = function() {
		_self.InitData();
		_self.InitEvent();
		_self.initContextMenu();
	}
	this.InitData = function() {
		layui.use([ 'laypage', 'layer', 'laytpl' ], function() {
			_self.laypage = layui.laypage, _self.layer = layui.layer,
					_self.laytpl = layui.laytpl
		});
		GetTreeData();
	}
	this.initContextMenu = function() {
		$("body").contextmenu(function(e) {
			$("#myMenu1").css({
				"top" : e.clientY + "px",
				"left" : +e.clientX + "px"
			});
			$("#myMenu1").show();
			return false;
		});
	}
	this.InitEvent = function() {
		$("#btnRefresh").click(function(e) {
			RefreshData();
			$('#myMenu1').hide();
		});
	}
	RefreshData = function() {
		SaveLocalData("ShiftTypeTree", null);
		GetTreeData();
	}
	GetTreeData = function() {
		$("#tree").html("");
		var oldData = RetrieveLocalData("ShiftTypeTree");
		if (oldData != null) {
			layui.use('tree', function() {
				layui.tree({
					elem : '#tree',
					nodes : oldData,
					click : function(node) {
						parent.SelectShiftType(node);
					}
				});
			});
			return;
		}
		var param = new Object();
		param.companyId = _LoginUser.companyId;
		PostData("GetShiftTypeTree", param, function(result) {
			SaveLocalData("ShiftTypeTree", result.Datas);
			layui.use('tree', function() {
				layui.tree({
					elem : '#tree',
					nodes : result.Datas,
					click : function(node) {
						parent.SelectShiftType(node);
					}
				});
			});
		});
	}
}
