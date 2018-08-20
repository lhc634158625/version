
var proTypeRadar

var ProTypeRadar = function () {
    var _self = this;
    this.Initial = function (index) {
        _self.option = "Count";
        _self.timeOption = "All";
        _self.InitData();
        _self.InitEvent();
    }
   
    this.InitData = function () {
        _self.dateTime=new DateTime();
        _self.myChart = echarts.init(document.getElementById('divProTypeRadarChart'));
        option = {
           
            tooltip: {},
            legend: {
                data: ['可用数', '总数'],
                x: 'right',
                textStyle: {
            color: '#fff'          // 图例文字颜色
        }
            },
            radar: {
                itemStyle: {
                    normal: {
                         color: "#ffffff",
                        label: {
                            show: false
                        },
                        lineStyle: {
                            width: 2,
                            type: 'solid'
                        }
                    },
                    emphasis: {
                        color: "#ff0000",
                        label: {
                            show: false
                        }
                    }
                },
                splitArea: {
                    show: false
                },

                // shape: 'circle',
                name: {
                    textStyle: {
                        color: '#fff',
                        backgroundColor: '#999',
                        borderRadius: 3,
                        padding: [3, 5]
                    }
                },
                indicator: [
                   { name: '摄像头', max: 6500 },
                   { name: '门禁', max: 16000 },
                   { name: '路由', max: 30000 },
                   { name: '电梯', max: 38000 },
                   { name: '停车场', max: 52000 },
                   { name: '显示器', max: 25000 },
                { name: '照明', max: 52000 },
                   { name: '消防', max: 25000 }
                ]
            },
            series: [{
                name: '可用 vs 总数',
                type: 'radar',
              
                // areaStyle: {normal: {}},
                data: [
                    {
                        value: [5000, 14000, 28000, 35000, 50000, 21000, 40000, 23000],
                        itemStyle: {
                            normal: {
                                color: '#B3E4A1'
                            }
                        },
                        areaStyle: {
                            normal: {
                                opacity: 0.1
                            }
                        },
                        name: '总数'
                    },
                     {
                         value: [4300, 10000, 28000, 31000, 42000, 19000, 20000],
                         itemStyle: {
                             normal: {
                                 color: 'rgb(238, 197, 102)'
                             }
                         },
                         areaStyle: {
                             normal: {
                                 opacity: 0.3
                             }
                         },
                         name: '可用数'
                     }
                ]
            }]
        };
        _self.myChart.hideLoading();
        _self.myChart.setOption(option); //先把可选项注入myChart中          
     //   _self.RetrieveData();

    } 
    this.InitEvent = function () {
        $("#proTypeRadarTitle span").click(function (e) {
            _self.option = $(this).attr("rel");
            $("#proTypeRadarTitle span").removeClass("selected");
            $(this).addClass("selected");
            _self.DrawChart();
        })
        $("#proTypeRadarOption li").click(function (e) {
            _self.timeOption = $(this).attr("rel");
            $("#proTypeRadarOption li").removeClass("selected");
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
