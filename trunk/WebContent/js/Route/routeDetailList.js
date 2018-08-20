function AfterInitial() {
    routeDetailList = new RouteDetailList();
    routeDetailList.Initial();
}
var routeDetailList
function RouteDetailList() {
    var _self = this;
    _self.orderField = 'Id'
    this.Initial = function () {
        if (RetrieveLocalData("routeDetailListFilter") != null) {
            _self.filter = RetrieveLocalData("routeDetailListFilter");
            _self.SetFilter();
        }
        _self.pageSize = 10;
        _self.pageIndex = RetrieveLocalData("routeDetailListPage");
        if (_self.pageIndex == null) _self.pageIndex = 0;
        _self.tableTmp = document.getElementById('tmpl').innerHTML;
        _self.InitData();
        _self.InitEvent();
    }
    this.InitData = function () {
        layui.use(['form', 'laypage', 'layer', 'laytpl', 'laydate'], function () {
            _self.laypage = layui.laypage
            , _self.layer = layui.layer
           , _self.laytpl = layui.laytpl
           , laydate = layui.laydate;
            laydate.render({
                elem: '#txtFromDt' //指定元素
            });
            laydate.render({
                elem: '#txtToDt' //指定元素
            });
            $("#btnSearch").click();
        });
    }
    this.SetFilter = function () {
        for (var i = 0; i < _self.filter.length; i++) {
            if (_self.filter[i].FieldName == "State") {
                $("#ddlState").val(_self.filter[i].Value)
            }
            if ((_self.filter[i].FieldName == "FromDt") && (_self.filter[i].Opt == ">=")) {
                $("#txtFromDt").val(_self.filter[i].Value)
            }
            if ((_self.filter[i].FieldName == "ToDt") && (_self.filter[i].Opt == "<=")) {
                $("#txtToDt").val(_self.filter[i].Value)
            }
        }
    }
    this.GetFilter = function () {
        _self.filter = new Array();
        condition = new Object();
        condition.FieldName = 'CompanyId';
        condition.Opt = '=';
        condition.Value = _LoginUser.CompanyId.toString();
        condition.FieldType = "string";
        _self.filter.push(condition);
        if ($("#txtFromDt").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'FromDt';
            condition.Opt = '>=';
            condition.Value = $("#txtFromDt").val();
            condition.FieldType = "string";
            _self.filter.push(condition);
        }
        if ($("#txtToDt").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'ToDt';
            condition.Opt = '<=';
            condition.Value = $("#txtToDt").val();
            condition.FieldType = "string";
            _self.filter.push(condition);
        }
        if ($("#ddlState").val() != "") {
            condition = new Object();
            condition.FieldName = 'State';
            condition.Opt = '=';
            condition.Value = $("#ddlState").val();
            condition.FieldType = "string";
            _self.filter.push(condition);
        }
    }
    this.InitEvent = function () {
        $("#btnSearch").click(function (e) {
            _self.GetFilter();
            var param = new Object();
            param.filter = _self.filter;
            param.tableName = "RouteDetail";
            PostData("GetRecordCount", param, function (result) {
                totalRecord = result.Data;
                _self.totalPage = Math.ceil(1.0 * totalRecord / _self.pageSize);
                if (JSON.stringify(RetrieveLocalData("routeDetailListFilter")) != JSON.stringify(_self.filter)) {
                    _self.pageIndex = 0;
                }
                SaveLocalData("routeDetailListFilter", _self.filter);
                _self.laypage.render({
                    elem: 'Page'
                   , count: totalRecord
                   , curr: _self.pageIndex + 1
                  , jump: function (obj, first) {
                      _self.pageIndex = obj.curr - 1;
                      SaveLocalData("routeDetailListPage", _self.pageIndex)
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
                if (rel == _self.orderField) {
                    _self.orderField = rel + " desc";
                }
                else {
                    _self.orderField = rel;
                }
                _self.RetrieveData();
            }
        });
        $("#chkAll").click(function (e) {
            var selects = $(".CheckItem");
            var isCheck = $(this).is(':checked');
            for (var i = 0; i < selects.length; i++) {
                selects[i].checked = isCheck;
            }
        });
        $("#btnNew").click(function (e) {
            ChangePage("routeDetail.html");
        });
    }
    this.Delete = function (id) {
        var param = new Object();
        param.id = id;
        param.userId = _LoginUser.Id;
        PostData("DeleteRouteDetail", param, function (result) {
            _self.RetrieveData();
        });
    }
    function Resize() {
    }
    var _routeDetails;
    var _routeDetail;
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = _self.pageSize;
        param.pageIndex = _self.pageIndex;
        param.orderField = _self.orderField;
        PostData("GetRouteDetail", param, function (result) {
            _routeDetails = result.Datas;
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('divContent').innerHTML = html;
            });
        });
    }
}

