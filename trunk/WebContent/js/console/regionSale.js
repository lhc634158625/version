
var regionSale

var RegionSale = function () {
    var _self = this;
    this.Initial = function (index) {
        _self.option = "Count";
        _self.timeOption = "All";
        _self.InitData();
        _self.InitEvent();
    }
   
    this.InitData = function () {
        _self.dateTime=new DateTime();
        _self.myChart = echarts.init(document.getElementById('divRegionSaleChart'));
        var option = {
            
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: ["门禁", "视频", "车辆", "网络", "电梯", "显示屏", "电脑"],
                textStyle: {
                    color: '#fff'          // 图例文字颜色
                }
            },
            calculable: true,
            series: [
                {
                    type: 'pie',
                    radius: ['30%', '50%'],
                    data: [{ "name": "门禁", "value": 3345123.34 }, { "name": "车辆", "value": 34213.12 }, { "name": "网络", "value": 2457443.00 }, { "name": "电梯", "value": 3345317 }, { "name": "显示屏", "value": 6682353 }, { "name": "电脑", "value": 3675423.00 }]
                }
            ]
        };
        _self.myChart.hideLoading();
        _self.myChart.setOption(option); //先把可选项注入myChart中          
     //   _self.RetrieveData();

    } 
    this.InitEvent = function () {
        $("#bankChartTitle span").click(function (e) {
            _self.option = $(this).attr("rel");
            $("#claimChartTitle span").removeClass("selected");
            $(this).addClass("selected");
            _self.DrawChart();
        })
        $("#claimChatOption li").click(function (e) {
            _self.timeOption = $(this).attr("rel");
            $("#claimChatOption li").removeClass("selected");
            $(this).addClass("selected");
            _self.RetrieveData();
        })
    }
    this.GetFromDt = function () {
        var now=new Date();
        if( _self.timeOption == "Year"){
            return _self.dateTime.FormatDate(now, "yyyy-01-01")
        }
        if( _self.timeOption == "Month"){
            return _self.dateTime.FormatDate(now,"yyyy-MM-01")
        }
        if( _self.timeOption == "Week"){
            return _self.dateTime.FormatDate(_self.dateTime.WeekStartDate(now), "yyyy-MM-dd")
        }
        if( _self.timeOption == "Day"){
            return _self.dateTime.FormatDate(now, "yyyy-MM-dd")
        }
        return _self.dateTime.FormatDate(now, "yyyy-MM-dd");
    }
    var reportDatas;
    this.RetrieveData = function () {
        var filter = new Array();
        var condition = new Object();
        condition.FieldName = 'UserId';
        condition.Opt = '=';
        condition.Value = _LoginUser.Id;
        condition.FieldType = "string";
        filter.push(condition);
        if (_self.timeOption != "All") {
          
                condition = new Object();
                condition.FieldName = 'FromDt';
                condition.Opt = '>=';
                condition.Value = _self.GetFromDt();
                condition.FieldType = "string";
                filter.push(condition);
        }
        var param = new Object();
        param.filter = filter;
        param.reportType = "itemtype";
        PostData("GetClaimReport", param, function (result) {
            reportDatas = result.Datas
            _self.DrawChart();
        });
    }
    this.DrawChart = function () {
        var xdata = new Array();
        for (var i = 0; i < reportDatas.length; i++) {
            xdata[i] = reportDatas[i].Name;
            reportDatas[i].name = reportDatas[i].Name;
            if(_self.option=="Count")
                reportDatas[i].value = reportDatas[i].Count;
            else
                reportDatas[i].value = reportDatas[i].Amount;
        }
        var optionsAjax = _self.myChart.getOption();
        optionsAjax.legend.data = xdata;
        optionsAjax.series[0].data = reportDatas;
        //options.xAxis[0].data = result.category;  
        _self.myChart.hideLoading();
        _self.myChart.setOption(optionsAjax);
        //_self.myChart.setOption(option);
    }
}
