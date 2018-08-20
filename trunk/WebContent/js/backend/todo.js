
var todo
//todo = new todo();
//todo.Initial();
var Todo = function () {
    var _self = this;
    this.Initial = function (index) {
        _self.tableTmp = document.getElementById('tmpTodo').innerHTML;
        _self.InitData();
        _self.InitEvent();
    }
   
    this.InitData = function () {
        layui.use(['laytpl',], function () {
            _self.laytpl = layui.laytpl
            _self.GetFilter();
            _self.RetrieveData();
        });       
    }
 
    this.InitEvent = function () {
       
        
    }
    this.GetFilter = function () {
        _self.filter = new Array();
        var condition = new Object();
        condition.FieldName = 'UserId';
        condition.Opt = '=';
        condition.Value = _LoginUser.Id;
        condition.FieldType = "string";
        _self.filter.push(condition);
    }
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = 6;
        param.pageIndex = 0;
        param.orderField = "Created desc";
        PostData("GetToDo", param, function (result) {
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('ulTodo').innerHTML = html;
            });
        });
    }
}
