var buyReport;
function AfterInitial() {
    buyReport = new BuyReport();
    buyReport.Initial();
}
function BuyReport() {
    var condition;
  
    var tableTmp;
    var _self = this;   
    var _selectIds;
    var myChart1, myChart2
    this.Initial = function () {      
        _self.tableTmp = document.getElementById('tmpl').innerHTML;
        _self.InitData();
        _self.InitEvent();       
    }
    this.InitData = function () {
        layui.use(['form','laypage', 'layer', 'laytpl','laydate'], function () {
            _self.laypage = layui.laypage
            ,_self.layer = layui.layer
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
    this.GetFilter = function () {
        filter = new Array();
        condition = new Object();
        condition.FieldName = 'CompanyId';
        condition.Opt = '=';
        condition.Value = _LoginUser.CompanyId;
        condition.FieldType = "string";
        filter.push(condition);
        if ($("#ddlState").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'State';
            condition.Opt = '=';
            condition.Value = $("#ddlState").val();
            condition.FieldType = "string";
            filter.push(condition);
        }
        if ($("#txtProviderName").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'Provider';
            condition.Opt = '=';
            condition.Value = $("#hfProviderId").val();
            condition.FieldType = "string";
            filter.push(condition);
        }
        if ($("#txtProductName").val().length > 0) {
            condition = new Object();
            condition.FieldName = 'ProductId';
            condition.Opt = '=';
            condition.Value = $("#hfProductId").val();
            condition.FieldType = "string";
            filter.push(condition);
        }
            if ($("#txtFromDt").val().length > 0) {
                condition = new Object();
                condition.FieldName = 'Created';
                condition.Opt = '>=';
                condition.Value = $("#txtFromDt").val();
                condition.FieldType = "string";
                filter.push(condition);
            }
            if ($("#txtToDt").val().length > 0) {
                condition = new Object();
                condition.FieldName = 'Created';
                condition.Opt = '<=';
                condition.Value = $("#txtToDt").val();
                condition.FieldType = "string";
                filter.push(condition);
            }
            if (($("#ddlType").val() != "")) {
                condition = new Object();
                condition.FieldName = 'BuyType';
                condition.Opt = '=';
                condition.Value = $("#ddlType").val();
                condition.FieldType = "string";
                filter.push(condition);
            }
            return filter;
    }
    this.InitEvent = function () {
        $("#btnSearch").click(function (e) {          

                var param = new Object();
                param.filter = _self.GetFilter();
                
               _self.RetrieveData();
                  
        });
        
        $("#btnExport").click(function (e) {
            var param = new Object();
            param.filter = filter;
            param.reportType = $("#ddlReportType").val();
            PostData("ExportBuyReport", param, function (result) {
               
                var url = "/DataHandler.ashx?opt=DownLoadFile&AttachURL=" + encodeURIComponent(result.Data.FileUrl) + "&FileName=" + result.Data.FileName;
                window.open(url);
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
        
        $("#txtProviderName").click(function (e) {
            var offset = $(this).offset();
            $("#divProvider").css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $("#divProvider").show();
            e.stopPropagation();
        });
        $("#txtProductName").click(function (e) {
            var offset = $(this).offset();
            var divProduct = "#divProduct"
            if ($("#ddlType").val() == "原料采购") divProduct = "#divMaterial"

            $(divProduct).css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $(divProduct).show();
            e.stopPropagation();
        });
        $("#txtTypeName").click(function (e) {
            var offset = $(this).offset();
            var divProduct = "#divProductType"
            if ($("#ddlType").val() == "原料采购") divProduct = "#divMaterialType"

            $(divProduct).css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $(divProduct).show();
            e.stopPropagation();
        });
        $("#ddlType").change(function (e) {
            $("#txtProductName").val("");
            $("#txtTypeName").val("");
        });
    }
   
    function Resize() {
    }
    var _userInfos;
    var _userInfo;
    this.RetrieveData = function () {
        var param = new Object();
        param.filter = filter;
        param.reportType = $("#ddlReportType").val();
        PostData("GetBuyReport", param, function (result) {
                     
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('divContent').innerHTML = html;
            });

            _self.myChart1 = echarts.init(document.getElementById('chart1'));
            _self.myChart2 = echarts.init(document.getElementById('chart2'));
            result.Datas.splice(result.Datas.length - 1);
            _self.DrawChart1(result.Datas);
            _self.DrawChart2(result.Datas);
      
        });
    }   
    this.DrawChart1 = function (datas) {
        var xdata = new Array();
        for (var i = 0; i < datas.length; i++) {
            xdata[i] = datas[i].Name;
            datas[i].name = datas[i].Name;
            datas[i].value = datas[i].Count;
        }
        var option1 = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: xdata
            },
            calculable: true,
            series: [
                {
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: datas
                }
            ]
        };
        _self.myChart1.setOption(option1);
    }
    this.DrawChart2 = function (datas) {
        var xdata = new Array();
        for (var i = 0; i < datas.length; i++) {
            xdata[i] = datas[i].Name;
            datas[i].name = datas[i].Name;
            datas[i].value = datas[i].Amount;
        }
        var option2 = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: xdata
            },
            calculable: true,
            series: [
                {
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: datas
                }
            ]
        };
        _self.myChart2.setOption(option2);
    }
}
function SelectDepartment(treeNode) {
    $("#txtDepartmentName").val( treeNode.Name);
    $("#hfDepartmentId").val(treeNode.Id);
    $("#divDepartment").hide();
}
function SelectProvider(treeNode) {
    $("#txtProviderName").val(treeNode.Name);
    $("#hfProviderId").val(treeNode.Id);
    $("#divProvider").hide();
}
function SelectProductType(treeNode) {
    $("#txtTypeName").val(treeNode.name);
    $("#txtTypeId").val(treeNode.id);
    $("#divProductType").hide();
}
function SelectMaterialType(treeNode) {
    $("#txtTypeName").val(treeNode.name);
    $("#txtTypeId").val(treeNode.id);
    $("#divMaterialType").hide();
}
function SelectProduct(treeNode) {
    $("#txtProductName").val(treeNode.Name);
    $("#hfProductId").val(treeNode.Id);
    $("#divProduct").hide();
}
function SelectMaterial(treeNode) {
    $("#txtProductName").val(treeNode.Name);
    $("#hfProductId").val(treeNode.Id);
    $("#divMaterial").hide();
}
