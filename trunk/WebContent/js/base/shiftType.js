var shiftTypePage
function AfterInitial() {
shiftTypePage = new ShiftType();
shiftTypePage.Initial();
}
function ShiftType() {
var _shiftType;
var _self = this;
this.Initial = function () {
     _self.detailTmp = document.getElementById('tmpDetail').innerHTML;
     _self.InitData();
     _self.InitEvent();       
 }
 this.InitData = function() { 
     _shiftType = new Object();
     $("#btnNew").hide();
     $("#btnSave").hide();
    $("#btnDelete").hide();
 }
this.InitEvent = function () {
     layui.use(['form','layer', 'laytpl'], function () {
        _self.form = layui.form
   , _self.laytpl = layui.laytpl
        , _self.layer = layui.layer
        //监听提交
       _self.form.on('submit(shiftType)', function (data) {
           var param = new Object();
            _self.AcceptText(data);           
          param.request = _shiftType;
          PostData("SaveShiftType", param, function (result) {
               _self.layer.msg("保存成功！");
              document.getElementById("frmShiftTypeSelector").contentWindow.RefreshData();
          });
          $("#btnSave").hide();
          $("#btnDelete").hide();
          $("#btnAdd").hide();
          return false;
      });            
  });
   $("#btnAdd").click(function (e) {
_self.EmptyData( _shiftType.id);
              $("#btnSave").show();
     });
     $("#btnDelete").click(function (e) {        
       if ((_shiftType == null) || (_shiftType.Type == "Company")) {
           _self.layer.alert("请先选择项");
           return false;
       }
        if (!confirm("亲，您确定要删除该项吗？")) return false;
         var param = new Object();
         param.id = _shiftType.id;
        PostData("DeleteShiftType", param, function (result) {
            _self.layer.alert("删除成功！");
            document.getElementById("frmShiftTypeSelector").contentWindow.RefreshData();
            return false;
         });
        return false;
     });
 }
   this.EmptyData = function (pId) {
          _shiftType = new Object();
        _shiftType.id = "";   
        _shiftType.name = "";   
        _shiftType.fromTime = "";   
        _shiftType.toTime = "";   
        _shiftType.memo = "";   
        _shiftType.type = "";   
        _shiftType.position = "";   
        _shiftType.pName = "";   
 _self.BindDetail();
  }
   this.AcceptText = function (data) {
        _shiftType.id = data.field.id;   
        _shiftType.name = data.field.name;   
        _shiftType.fromTime = data.field.fromTime;   
        _shiftType.toTime = data.field.toTime;   
        _shiftType.memo = data.field.memo;   
        _shiftType.type = data.field.type;   
        _shiftType.position = data.field.position;   
        _shiftType.pName = data.field.pName;   
  }
 this.BindDetailEvent = function () {
  }
 this.BindDetail = function () {
 _self.laytpl(_self.detailTmp).render(_shiftType, function (html) {
      document.getElementById('divEditInfo').innerHTML = html;
      _self.BindDetailEvent();
  });
   }
 this.SetData=function(shiftType) {     
     _shiftType = shiftType;
 _self.BindDetail();
   $("#btnAdd").show();
    $("#btnSave").show();       
    $("#btnDelete").show();
    if (shiftType.Type == "Company") {
         $("#btnDelete").hide();
         $("#btnSave").hide();
      }
 }  
}
function SelectShiftType(treeNode) {
   shiftTypePage.SetData(treeNode);    
}

