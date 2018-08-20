
var message
//todo = new todo();
//todo.Initial();
var Message = function () {
    var _self = this;
    this.Initial = function (index) {
        _self.tableTmp = document.getElementById('tmpMessage').innerHTML;
        _self.InitData();
        _self.InitEvent();
    }
   
    this.InitData = function () {
        layui.use(['laytpl','layer'], function () {
            _self.laytpl = layui.laytpl
            , _self.layer = layui.layer
            _self.GetFilter();
            _self.RetrieveData();
        });       
    }
 
    this.InitEvent = function () {
       
        
    }
    this.ShowMessage = function (ind) {
        var messageInfo = _messageInfos[ind];
        _self.layer.open({
            content: messageInfo.Contents
          , btn: ['确定', '删除']
          , yes: function (index, layero) {
              var param = new Object();
              param.id = messageInfo.Id;
              PostData("ReadMessageInfo", param, function (result) {
                  _self.layer.close(index)
                  _self.RetrieveData();
              });
          }
          , btn2: function (index, layero) {
              var param = new Object();
              param.id = messageInfo.Id;
              PostData("DeleteMessageInfo", param, function (result) {
                  _self.layer.close(index)
                  _self.RetrieveData();
              });
          }
          , cancel: function () {
              //右上角关闭回调

              //return false 开启该代码可禁止点击该按钮关闭
          }
        });

    }
    this.GetFilter = function () {
      
        var condition = new Object();      
        _self.filter = new Array();
        condition = new Object();
        condition.FieldName = 'ReceiverId';
        condition.Opt = '=';
        condition.Value = _LoginUser.Id;
        condition.FieldType = "string";
        _self.filter.push(condition);
        condition = new Object();
        condition.FieldName = 'State';
        condition.Opt = '=';
        condition.Value = "新建";
        condition.FieldType = "string";
        _self.filter.push(condition);
       // _self.filter.push(condition);
    }
    var _messageInfos
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = 6;
        param.pageIndex = 0;
        param.orderField = "Created";
        PostData("GetMessageInfo", param, function (result) {
            _messageInfos = result.Datas;
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('ulMessage').innerHTML = html;               
            });

        });
    }
}
