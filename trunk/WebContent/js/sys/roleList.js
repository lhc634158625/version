function AfterInitial() {
roleList = new RoleList();
roleList.Initial();
}
 var roleList ;
function RoleList() {
var tableTmp;
var _self = this;
_self.orderField = "id";
this.Initial = function () {
     if (RetrieveLocalData("roleListFilter") != null) {
         _self.filter = RetrieveLocalData("roleListFilter");
         _self.SetFilter();
     }
     _self.pageSize = 10;
     _self.pageIndex = RetrieveLocalData("roleListPage");
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
       param.tableName = "Role";
       PostData("baseService/getRecordCount", param, function (result) {
           totalRecord = result.Data;
          _self.totalPage = Math.ceil(1.0 * totalRecord / _self.pageSize);
         if (JSON.stringify(RetrieveLocalData("roleListFilter")) != JSON.stringify(_self.filter)) {
              _self.pageIndex = 0;
          }
           SaveLocalData("roleListFilter", _self.filter);
            _self.laypage.render({
               elem: 'Page'
               , count: totalRecord
              , curr: _self.pageIndex + 1
               , jump: function (obj, first) {
                   _self.pageIndex = obj.curr - 1;
                   SaveLocalData("roleListPage", _self.pageIndex)
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
       
        PostData("sys/role/save", _role, function (result) {
            _role = result.Data;
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
 var _roles;
 var _role;
 this.RetrieveData = function () {
     var param = new Object();
     param.conditions = _self.filter;
    param.pageSize = _self.pageSize;
     param.pageIndex = _self.pageIndex;
     param.orderField =  _self.orderField;
    PostData("sys/role/filter", param, function (result) {
          _roles = result.data;           
         _self.laytpl(_self.tableTmp).render(result, function (html) {
              document.getElementById('divContent').innerHTML = html;
          });
     });
  }
   this.EmptyData = function () {
          _role = new Object();
       
        _role.name = '';   
  }
   this.AcceptText = function () {
       
        _role.name = $("#txtName").val();   
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
 _self.laytpl(_self.detailTmp).render(_role, function (html) {
      document.getElementById('divEditInfo').innerHTML = html;
      _self.BindDetailEvent();
  });
   }
this.Delete=function(id) {
      if (!confirm("亲，您真的要删除该记录吗?")) return;
   
     PostData("sysService/deleteRole", id, function (result) {
         alert("删除记录成功!");
        _self.RetrieveData();
     });
}
 this.Edit = function (index) {
    $("#divMain").addClass("bd-content-wrap1");
    ShowPanel("#divEdit",480); 
    _role = _roles[index];
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
 roleList.SelectDict(node);
 $("#divDict").hide();
}
function CloseModule() {
    HidePanel("divEdit");
   $("#divMain").removeClass("bd-content-wrap1");
}

