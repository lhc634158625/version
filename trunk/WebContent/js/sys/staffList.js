function AfterInitial() {
staffList = new StaffList();
staffList.Initial();
}
 var staffList ;
function StaffList() {
var tableTmp;
var _self = this;
_self.orderField = "created desc";
this.Initial = function () {
     if (RetrieveLocalData("staffListFilter") != null) {
         _self.filter = RetrieveLocalData("staffListFilter");
         _self.SetFilter();
     }
     _self.pageSize = 10;
     _self.pageIndex = RetrieveLocalData("staffListPage");
     if (_self.pageIndex==null) _self.pageIndex = 0;
     _self.tableTmp = document.getElementById('tmpl').innerHTML;
     _self.detailTmp = document.getElementById('tmpDetail').innerHTML;
     _self.InitData();
     _self.InitEvent();
 }
 this.InitData = function () {
     layui.use(['laypage', 'layer', 'laytpl'], function () {
         _self.laypage = layui.laypage
         ,_self.layer = layui.layer
         , _self.laytpl = layui.laytpl
         $("#btnSearch").click();
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
        var param = new Object();
        param.conditions =  _self.filter;
       param.tableName = "Staff";
       PostData("baseService/getRecordCount", param, function (result) {
           totalRecord = result.Data;
          _self.totalPage = Math.ceil(1.0 * totalRecord / _self.pageSize);
         if (JSON.stringify(RetrieveLocalData("staffListFilter")) != JSON.stringify(_self.filter)) {
              _self.pageIndex = 0;
          }
           SaveLocalData("staffListFilter", _self.filter);
            _self.laypage.render({
               elem: 'Page'
               , count: totalRecord
              , curr: _self.pageIndex + 1
               , jump: function (obj, first) {
                   _self.pageIndex = obj.curr - 1;
                   SaveLocalData("staffListPage", _self.pageIndex)
                   _self.RetrieveData();
                    //首次不执行
                    if (!first) {
                       //do something
                   }
               }
            });
        });
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
_self.EmptyData()
          $("#divMain").addClass("bd-content-wrap1");
          ShowPanel("#divEdit", 480);
_self.BindDetail()
    });
    $("#btnSave").click(function (e) {
            _self.AcceptText();           
        param.request = _staff;
        PostData("sysService/saveStaff", _staff, function (result) {
            _staff = result.data;
            _self.layer.alert("保存成功！");
            _self.RetrieveData();           
       });
    });
    $("#btnReturn").click(function (e) {
        HidePanel("#divEdit")
        $("#divMain").removeClass("bd-content-wrap1");
     });
 }
 function Resize() {
 }
 var _staffs;
 var _staff;
 this.RetrieveData = function () {
     var param = new Object();
     param.conditions = _self.filter;
    param.pageSize = _self.pageSize;
     param.pageIndex = _self.pageIndex;
     param.orderField =  _self.orderField;
    PostData("sys/staff/filter", param, function (result) {
          _staffs = result.data;           
         _self.laytpl(_self.tableTmp).render(result, function (html) {
              document.getElementById('divContent').innerHTML = html;
          });
     });
  }
   this.EmptyData = function () {
          _staff = new Object();
        _staff.id = '';   
        _staff.name = '';   
        _staff.gender = '';   
        _staff.state = '';   
        _staff.longitude = '';   
        _staff.latitude = '';   
        _staff.stationId = '';   
        _staff.telephone = '';   
        _staff.position = '';   
        _staff.shiftType = '';   
        _staff.regionId = '';   
        _staff.code = '';   
        _staff.pyCode = '';   
        _staff.address = '';   
        _staff.timeType = '';   
        _staff.serviceId = '';   
        _staff.lastPosTime = '';   
        _staff.isDel = '';   
        _staff.idCode = '';   
        _staff.leaderPost = '';   
        _staff.nonLeaderPost = '';   
        _staff.posType = '';   
        _staff.shiftState = '';   
        _staff.updateDt = '';   
        _staff.shiftInfos = '';   
  }
   this.AcceptText = function () {
        _staff.id = $("#txtId").val();   
        _staff.name = $("#txtName").val();   
        _staff.gender = $("#txtGender").val();   
        _staff.state = $("#txtState").val();   
        _staff.longitude = $("#txtLongitude").val();   
        _staff.latitude = $("#txtLatitude").val();   
        _staff.stationId = $("#txtStationId").val();   
        _staff.telephone = $("#txtTelephone").val();   
        _staff.position = $("#txtPosition").val();   
        _staff.shiftType = $("#txtShiftType").val();   
        _staff.regionId = $("#txtRegionId").val();   
        _staff.code = $("#txtCode").val();   
        _staff.pyCode = $("#txtPyCode").val();   
        _staff.address = $("#txtAddress").val();   
        _staff.timeType = $("#txtTimeType").val();   
        _staff.serviceId = $("#txtServiceId").val();   
        _staff.lastPosTime = $("#txtLastPosTime").val();   
        _staff.isDel = $("#txtIsDel").val();   
        _staff.idCode = $("#txtIdCode").val();   
        _staff.leaderPost = $("#txtLeaderPost").val();   
        _staff.nonLeaderPost = $("#txtNonLeaderPost").val();   
        _staff.posType = $("#txtPosType").val();   
        _staff.shiftState = $("#txtShiftState").val();   
        _staff.updateDt = $("#txtUpdateDt").val();   
        _staff.shiftInfos = $("#txtShiftInfos").val();   
  }
 this.BindDetailEvent = function () {
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
 this.BindDetail = function () {
 _self.laytpl(_self.detailTmp).render(_staff, function (html) {
      document.getElementById('divEditInfo').innerHTML = html;
      _self.BindDetailEvent();
  });
   }
this.Delete=function(id) {
      if (!confirm("亲，您真的要删除该记录吗?")) return;
      var request = new Object();
     request.id = id;
     PostData("sysService/deleteStaff", request, function (result) {
         alert("删除记录成功!");
        _self.RetrieveData();
     });
}
 this.Edit = function (index) {
    $("#divMain").addClass("bd-content-wrap1");
    ShowPanel("#divEdit",480); 
    _staff = _staffs[index];
 _self.BindDetail();
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
function SelectBaseDict(node) {
  if (node.children != null) return;
 staffList.SelectDict(node);
 $("#divDict").hide();
}
function CloseModule() {
    HidePanel("divEdit");
   $("#divMain").removeClass("bd-content-wrap1");
}

