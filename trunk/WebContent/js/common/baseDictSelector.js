function AfterInitial() {
baseDictSelector = new BaseDictSelector();
baseDictSelector.Initial();
}
var baseDictSelector
function BaseDictSelector() {
var _self = this;
this.Initial = function () {
_self.InitData();
_self.InitEvent();
_self.initContextMenu();
_self.tableTmp = document.getElementById('tmpl').innerHTML;
}
this.InitData = function () {
   layui.use(['laypage', 'layer', 'laytpl'], function () {
      _self.laypage = layui.laypage
      , _self.layer = layui.layer
      , _self.laytpl = layui.laytpl   
   });
     GetTreeData();
 }
this.initContextMenu = function () {
     $("body").contextmenu(function (e) {
        $("#myMenu1").css({ "top": e.clientY + "px", "left": +e.clientX + "px" });
         $("#myMenu1").show();
        return false;
    });
 }
this.InitEvent = function () {
    $("#txtKeyword").keyup(function (e) {
      _self.RetrieveData();
  });
  $("#btnRefresh").click(function (e) {
      RefreshData();
      $('#myMenu1').hide();
    });
}
this.SelectItem = function (index) {
    parent.SelectBaseDict(_baseDicts[index]);
}
var _baseDicts;
this.RetrieveData = function () {
   var param = new Object();
   param.keyword = $("#txtKeyword").val();
    if (param.keyword.length == 0) {
        $("#divTree").show();
        $("#divList").hide();
         return;
    }
    else
   {
       $("#divTree").hide();
       $("#divList").show();
   }
   param.companyId = _LoginUser.CompanyId;
   PostData("GetBaseDictByKeyword", param, function (result) {
       _baseDicts = result.Datas;
       _self.laytpl(_self.tableTmp).render(result, function (html) {
           document.getElementById('divContent').innerHTML = html;
       });
    });
 }
 RefreshData = function () {
     SaveLocalData("BaseDictTree", null);
     GetTreeData();
 }
 GetTreeData = function () {
     $("#tree").html("");
     var oldData = RetrieveLocalData("BaseDictTree");
     if (oldData != null) {
         layui.use('tree', function () {
             layui.tree({
                 elem: '#tree'
                , nodes: oldData
             , click: function (node) {
                 parent.SelectBaseDict(node);
             }
             });
         });
         return;
     }
     var param = new Object();
     param.companyId = _LoginUser.CompanyId;
     PostData("GetBaseDictTree", param, function (result) {
         SaveLocalData("BaseDictTree", result.Datas);
         layui.use('tree', function () {
              layui.tree({
                 elem: '#tree'
                , nodes: result.Datas
             , click: function (node) {
                 parent.SelectBaseDict(node);
             }
             });
        });
     });
 }
}

