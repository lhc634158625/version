var routeSet;
function AfterInitial() {
    routeSet = new RouteSet();
    routeSet.Initial();
}
function RouteSet() {
    var _routeSet;
    var _self = this;
    var form, layer, laytpl
    this.Initial = function () {
        _self.tableTmp = document.getElementById('tmpl').innerHTML;
        _self.InitData();
        _self.InitEvent();
    }
    this.InitData = function () {
        _routeSet = new Object();
        $("#btnDelete").hide();
        layui.use(['form', 'laydate', 'laytpl'], function () {
            _self.form = layui.form
            , _self.layer = layui.layer
            , _self.laytpl = layui.laytpl
            , laydate = layui.laydate;
            laydate.render({
                elem: '#txtFromTime' //指定元素
              , type: 'time'
            });
            laydate.render({
                elem: '#txtToTime' //指定元素
              , type: 'time'
            });
            if (request("Id") != null)
                _self.GetData();
            else
                _self.EmptyData();
            //监听提交
            _self.form.on('submit(routeSet)', function (data) {
                _routeSet.id = data.field.Id;
                _routeSet.companyId = data.field.CompanyId;
                _routeSet.name = data.field.Name;
                _routeSet.fromTime = data.field.FromTime;
                _routeSet.toTime = data.field.ToTime;
                _routeSet.contents = data.field.Contents;
                var param = new Object();
                param.request = _routeSet;
                PostData("SaveRouteSet", param, function (result) {
                    _routeSet = result.Data;
                    _self.layer.alert("保存信息成功!");
                });
                return false;
            });
        });
    }
    this.EmptyData = function () {
        _routeSet.id = NewGuid();
        _routeSet.companyId = '';
        _routeSet.name = '';
        _routeSet.fromTime = '';
        _routeSet.toTime = '';
        _routeSet.contents = '';
        _self.BindData();
    }
    this.BindData = function () {
        _self.laytpl(_self.tableTmp).render(_routeSet, function (html) {
            document.getElementById('divContent').innerHTML = html;
            document.getElementById("frmBuildingselect").src = "/common/deviceSelector.html?routeId=" + _routeSet.id;
            _self.form.render();
        });
    }
    this.InitEvent = function () {
        $("#btnReturn").click(function (e) {
            Return();
        });
        $("#btnDelete").click(function (e) {
            if (!confirm("亲，您确认要删除该记录吗？")) return;
            var param = new Object();
            param.id = _routeSet.Id;
            PostData("DeleteRouteSet", param, function (result) {
                _self.layer.alert("保存信息成功!");
                Return();
            });
        });
    }
    this.GetData = function () {
        var param = new Object();
        param.id = request("Id");
        PostData("GetRouteSetById", param, function (result) {
            _routeSet = result.Data;
            _self.BindData();
            $("#btnDelete").show();
        });
    }
}

