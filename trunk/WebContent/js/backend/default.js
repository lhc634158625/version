function AfterInitial() {
    var index = new Index();
    index.Initial();
}
function Index() {

    var _self = this;

    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
    }
    this.InitData = function () {

        $("#divTodo").load("todo.html", function () {
            todo = new Todo();
            todo.Initial();
        });
        $("#divCompanyNews").load("news.html", function () {
            news = new News();
            news.Initial();
        });
        $("#divMessage").load("message.html", function () {
            message = new Message();
            message.Initial();
        });
        if (HaveModule(101)) {
            $("#divClaim").load("claim.html", function () {
                claim = new Claim();
                claim.Initial();
            });
        }
        else {
            $("#divClaim").hide();
        }
       
        if (HaveModule(102)) {
            $("#divClaimChart").load("claimChart.html", function () {
                claimChart = new ClaimChart();
                claimChart.Initial();
            });
        } else {
            $("#divClaimChart").hide();
        }
        if (HaveModule(103)) {
            $("#divDeptClaimChart").load("deptClaimChart.html", function () {
                deptClaimChart = new DeptClaimChart();
                deptClaimChart.Initial();
            });
        } else {
            $("#divDeptClaimChart").hide();
        }
        if (HaveModule(104)) {
            $("#divComClaimChart").load("comClaimChart.html", function () {
                comClaimChart = new ComClaimChart();
                comClaimChart.Initial();
            });
        } else {
            $("#divComClaimChart").hide();
        }

        if (HaveModule(111)) {
            $("#divOrder").load("order.html", function () {
                order = new Order();
                order.Initial();
            });
        }
        else {
            $("#divOrder").hide();
        }
        if (HaveModule(112)) {
            $("#divOrderChart").load("orderChart.html", function () {
                orderChart = new OrderChart();
                orderChart.Initial();
            });
        }
        else
        {
            $("#divOrderChart").hide();
        }
       
    }
    this.InitEvent = function () {


    }
    function Resize() {
        $(".bd-content").height(document.documentElement.clientHeight);
    }
    
}

