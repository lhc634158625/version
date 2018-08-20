function AfterInitial() {
    console = new Console();
    console.Initial();

}
var console

function Console() {

    var _self = this;

    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
        Resize();
    }
    var dragCounter = 0;
    var grid;
    var docElem = document.documentElement;
    var defaultMenuIndex;
    this.InitData = function () {

        //$("#divSaleMap .item-content").load("saleMap.html", function () {
        //    saleMapChart = new SaleMapChart();
        //    saleMapChart.Initial();
        //});
        $("#divProductType .item-content").load("proTypeRadar.html", function () {
            proTypeRadar = new ProTypeRadar();
            proTypeRadar.Initial();
        });
        $("#divSalerRank .item-content").load("salerRank.html", function () {

        });
        $("#divRegionSale .item-content").load("regionSale.html", function () {
            regionSale = new RegionSale();
            regionSale.Initial();
        });
        //$("#divDaySaleReport .item-content").load("daySaleReport.html", function () {
        //    daySaleReport = new DaySaleReport();
        //    daySaleReport.Initial();
        //});
        $(".marquee").marquee();
        grid = new Muuri(".grid", {
            items: ".item",
            layoutDuration: 400,
            layoutEasing: 'ease',
            dragEnabled: true,
            dragSortInterval: 50,
            dragContainer: document.body,
            dragStartPredicate: function (item, event) {
                var isDraggable = true;
                var isRemoveAction = elementMatches(event.target, '.IgnoreDrag');
                return isDraggable && !isRemoveAction ? Muuri.ItemDrag.defaultStartPredicate(item, event) : false;
            },
            dragReleaseDuration: 400,
            dragReleseEasing: 'ease'
        })
       .on('dragStart', function () {
           ++dragCounter;
           docElem.classList.add('dragging');
       })
       .on('dragEnd', function () {
           if (--dragCounter < 1) {
               docElem.classList.remove('dragging');
           }
       })
       .on('move', updateIndices)
       .on('sort', updateIndices);

        var items = RetrieveLocalData("DefaultMenu");
        if (items != null) {
            for (var i = 0; i < items.length; i++) {
                document.getElementById(items[i].id).setAttribute('data-id', items[i].index);
            }
            grid.sort(compareId);
        }
        setTimeout(function () {
            _self.ShowData(234, 10, "lblNewOrderAmount");
            
        }, 50);
        setTimeout(function () {
            _self.ShowData(232, 10, "lblNewOrderCount");

        }, 50);
        setTimeout(function () {
            _self.ShowData(5332, 100, "lblCarIn");

        }, 50);
         setTimeout(function () {
            _self.ShowData(5172, 10, "lblCarOut");

        }, 50);
      
        
      
    }
    var _count = 0; gtimer = 0;
    _self.ShowData = function (totalCount, index, ownerName) {
        if (_count < totalCount)
            _count += index;      
        if (_count > totalCount) _count = totalCount;
        $("#" + ownerName).text(_count);
        if (_count < totalCount) {
            setTimeout(function () {
                _self.ShowData(totalCount, index, ownerName);

            }, 50);
        }
    }

    function compareId(a, b) {

        var aVal = parseInt(a.getElement().getAttribute('data-id'));
        var bVal = parseInt(b.getElement().getAttribute('data-id'));
        return aVal < bVal ? -1 : aVal > bVal ? 1 : 0;

    }
    this.InitEvent = function () {
        $("#btnApplyClaim").click(function (e) {
            ChangePage("/claim/claimItem.html")
        });
        $("#btnCheckClaim").click(function (e) {
            ChangePage("/claim/claimcheck.html?state=审批")
        });
        $("#btnOrder").click(function (e) {
            ChangePage("/order/detailList.html?state=待送")
        });
        $("#btnCase").click(function (e) {
            ChangePage("/brain/caselistshow.html?state=已归档")
        });
        //$(".item").dblclick(function(e){
        //    $(this).hide();
        //})
    }
    function updateIndices() {
        defaultMenuIndex = new Array();
        var itemObj;
        grid.getItems().forEach(function (item, i) {
            item.getElement().setAttribute('data-id', i + 1);
            itemObj = new Object();
            itemObj.id = item.getElement().id;
            itemObj.index = i + 1;
            defaultMenuIndex.push(itemObj);
            //   item.getElement().querySelector('.card-id').innerHTML = i + 1;
        });
        SaveLocalData("DefaultMenu", defaultMenuIndex);

    }

    function elementMatches(element, selector) {

        var p = Element.prototype;
        return (p.matches || p.matchesSelector || p.webkitMatchesSelector || p.mozMatchesSelector || p.msMatchesSelector || p.oMatchesSelector).call(element, selector);

    }

    function elementClosest(element, selector) {

        if (window.Element && !Element.prototype.closest) {
            var isMatch = elementMatches(element, selector);
            while (!isMatch && element && element !== document) {
                element = element.parentNode;
                isMatch = element && element !== document && elementMatches(element, selector);
            }
            return element && element !== document ? element : null;
        }
        else {
            return element.closest(selector);
        }

    }

    function Resize() {
        $(".bd-content").height(document.documentElement.clientHeight);
    }

}
function SaveLocalData(key, obj) {
    if (obj == null)
        window.localStorage.removeItem(_LoginUser.Id + "_" + key);
    else {

        window.localStorage.setItem(key, JSON.stringify(obj));
    }

}
function RetrieveLocalData(key) {

    if ((window.localStorage.getItem(key) == null) || (window.localStorage.getItem(key).length == 0)) return null;
    return JSON.parse(window.localStorage.getItem(key));



}
