/*function AfterInitial() {
    var left = new Left();
    left.Initial();
}*/
function Left() {
   
    var _self = this;
    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
    }
    this.InitData = function () {        

        GetData();
    }
    this.InitEvent = function () {

        
    }


    function Resize() {
       
    }   

    function GetData() {     
        var param = new Object();   
        param.userId = _LoginUser.Id;       
        PostData("GetUserMenu", param, function (result) {           
            $(".sider-nav").html(result.Data);
            
        });
    }
   

}