function AfterInitial() {
    reportInfoList = new ReportInfoList();
    reportInfoList.Initial();
}
var reportInfoList
function ReportInfoList() {
    var _self = this;
    _self.orderField = 'FromRow,FromCol'
    this.Initial = function () {
        if (RetrieveLocalData("reportInfoListFilter") != null) {
            _self.filter = RetrieveLocalData("reportInfoListFilter");
            _self.SetFilter();
        }
        _self.pageSize = 1000;
        _self.pageIndex = RetrieveLocalData("reportInfoListPage");
        if (_self.pageIndex == null) _self.pageIndex = 0;

        _self.Type = request("type");
        $("blockquote").text(_self.Type);

        _self.InitData();
        _self.InitEvent();

    }
    this.InitData = function () {

        _self.dateTime = new DateTime();


        layui.use(['form', 'laypage', 'layer', 'laytpl', 'laydate', 'upload'], function () {
            _self.laypage = layui.laypage
            , _self.layer = layui.layer
           , _self.laytpl = layui.laytpl
            , _self.form = layui.form
           , laydate = layui.laydate
            , _self.upload = layui.upload;           
            _self.InitialMonth();
            var date = new Date();
            var lastMonth = _self.dateTime.FormatDate(_self.dateTime.AddDate(date, 'MONTH', -1), "yyyy-MM")
            $("#ddlMonth").val(lastMonth);
            _self.form.render();
            $("#btnSearch").click();
            
            _self.InitUpload();
            _self.form.on('select(timeType)', function (data) {
                    if ($("#ddlType").val() == "季报") {
                        _self.InitialSeason();
                    }
                    else
                        _self.InitialMonth();
            });
            _self.form.on('select(MonthType)', function (data) {
                _self.uploadIns.config.data = {
                    Month: $("#ddlMonth").val()
                }
            });
        });
    }
    this.InitUpload=function(){
        _self.uploadIns = _self.upload.render({
            elem: '#btnImport' //绑定元素
                  , accept: "file"
                 , data: { Month: $("#ddlMonth").val() }
             , url: _uploadUrl + 'OwnerType=Report&OwnerId=' + _LoginUser.CompanyId + "&ReportName=" + request("type") //+ "&Month=" + $("#ddlMonth").val()
            , done: function (res) {
                _self.layer.closeAll('loading'); //关闭loading
                if (res.Code != 0) {
                    _self.layer.alert(res.Message);
                    return;
                }
                _self.RetrieveData();
                //上传完毕回调
            }
             , error: function () {
                 _self.layer.closeAll('loading'); //关闭loading
                 //请求异常回调
             }
        });
    }
    this.SetFilter = function () {
        for (var i = 0; i < _self.filter.length; i++) {
            if (_self.filter[i].FieldName == "OwnerType") {
                $("#txtMonth").val(_self.filter[i].Value)
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

        condition = new Object();
        condition.FieldName = 'OwnerType';
        condition.Opt = '=';
        condition.Value = $("#txtMonth").val();
        condition.FieldType = "string";
        _self.filter.push(condition);


        condition = new Object();
        condition.FieldName = 'ReportName';
        condition.Opt = '=';
        condition.Value = _self.Type;
        condition.FieldType = "string";
        _self.filter.push(condition);

    }
    this.InitEvent = function () {
        $("#btnSearch").click(function (e) {
            _self.GetFilter();
            _self.RetrieveData();
        });
      
        $("#btnCreate").click(function (e) {
            var param = new Object();
            param.companyId = _LoginUser.CompanyId;
            param.ownerType = $("#ddlMonth").val();
            param.reportName = _self.Type;
            PostData("CreateReportInfo", param, function (result) {
                _self.layer.alert("生成成功！");
                _self.RetrieveData();
            });
        });
        $("#btnExport").click(function (e) {
            var param = new Object();
            param.ownerType = $("#txtMonth").val();
            param.companyId = _LoginUser.CompanyId;
            param.reportName = _self.Type;
            PostData("ExportReportInfo", param, function (result) {
                var url = _uploadUrl + "opt=DownLoadFile&AttachURL=" + encodeURIComponent(result.Data.FileUrl) + "&FileName=" + result.Data.FileName;
                window.open(url);
            });
        });
     
       
        //$(".field").change(function () {
        //    $(this).css("background-color", "#FFFFCC");
        //});
        //$(".field").change(function () {
     
        //});
    }
    this.InitialSeason = function () {
        var html = "";
        var date = new Date();
        var year = _self.dateTime.FormatDate(_self.dateTime.AddDate(date, 'MONTH', -1), "yyyy");
        for (var i = 1; i <= 4; i++) {
            html += "<option value='" + year + '年' + i + "季'>" + year + '年' + i + "季</option>";
        }
        $("#ddlMonth").html(html);
        _self.form.render();
    }
    this.InitialMonth = function () {
        var html = "";
        var date = new Date();
        var year = _self.dateTime.FormatDate(_self.dateTime.AddDate(date, 'MONTH', -1), "yyyy");
        for (var i = 1; i <= 9; i++) {
            html += "<option value='" + year + '-0' + i + "'>" + year + '年0' + i + "月</option>";
        }
        for (var i = 10; i <= 12; i++) {
            html += "<option value='" + year + '-' + i + "'>" + year + '年' + i + "月</option>";
        }
        $("#ddlMonth").html(html);
        _self.form.render();
    }
    function Resize() {
    }
    var _reportInfos;
    var _reportInfo;
    this.RetrieveData = function () {
        var param = new Object();
        param.ownerType = $("#ddlMonth").val();
        param.companyId = _LoginUser.CompanyId;
        param.reportName = _self.Type;
        PostData("GetReportInfo", param, function (result) {
            if (result.Datas.length == 0) {
                $("#divReportData").html("数据未生成");
                return;
            }
            var htmlStr = "<table class='InputTable'>";
            htmlStr += _self.FormatContent(result.Datas);
            htmlStr += "</table>";
            $("#divReportData").html(htmlStr);
        });
    }
    this.FormatContent = function (datas) {
        var tblHtml = "";
        var preFromRow = 0;

        datas.forEach(function (item, index, array) {
            if (item.FromRow != preFromRow)
                if (preFromRow == 0)
                    tblHtml += "<tr>";
                else
                    tblHtml += "</tr><tr>";
            tblHtml += "<td";
            if (item.FromRow != item.ToRow) {
                tblHtml += " rowspan='" + (item.ToRow - item.FromRow + 1) + "' ";
            }
            if (item.FromCol != item.ToCol) {
                tblHtml += " colspan='" + (item.ToCol - item.FromCol + 1) + "' ";
            }

            tblHtml += ">" + (item.Value == null ? "" : item.Value) + "</td>";


            preFromRow = item.FromRow;
        });

        tblHtml += "</tr>";
        return tblHtml;
    }
}

