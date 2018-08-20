
var news
//todo = new todo();
//todo.Initial();
var News = function () {
    var _self = this;
    this.Initial = function (index) {
        _self.tableTmp = document.getElementById('tmpNews').innerHTML;
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
    this.ShowNews = function (index) {
        var news = _self.news[index];
        var htmlStr = "<div id='divNewsContent'><h1 style='text-align:center; font-size:16px;font-weight:bold;'>" + news.Title + "</h1>";
        htmlStr += "<p  style='text-align:right; margin-right:20px;font-weight:bold;'>发布时间：" + news.PublishDt + "</p>";
        htmlStr += "<p  style='padding:20px;'>" + news.Contents + "</p></div>";
        _self.layer.open({
            type: 1,
            area: ['800px', '500px']
            , content: htmlStr //这里content是一个普通的String
        });
    }
    this.GetFilter = function () {
        _self.filter = new Array();
        var condition = new Object();      
        condition.FieldName = 'CompanyId';
        condition.Opt = '=';
        condition.Value = _LoginUser.CompanyId;
        condition.FieldType = "string";
        _self.filter.push(condition);
        condition = new Object();
        condition.FieldName = 'State';
        condition.Opt = '=';
        condition.Value = "发布";
        condition.FieldType = "string";
        _self.filter.push(condition);
        condition = new Object();
        condition.FieldName = 'publishDt';
        condition.Opt = '>=';
        condition.Value = "dateadd(day,-isnull(staydays,0),getdate())";
        condition.FieldType = "number";
       // _self.filter.push(condition);
    }
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = 6;
        param.pageIndex = 0;
        param.orderField = "publishDt";
        PostData("GetNews", param, function (result) {
            _self.news = result.Datas;
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('ulNews').innerHTML = html;
               
            });

        });
    }
}
