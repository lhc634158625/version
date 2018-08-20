function AfterInitial() {
    index = new Index();
    index.Initial();
}
function Resize() {
    $('.IndexRight').width(document.documentElement.clientWidth - 245);
}
var index
function Index() {   
    var _self = this;
    this.Initial = function () {
        _self.InitData();
        _self.InitEvent();
        $('.IndexRight').width(document.documentElement.clientWidth - 225);
        $("#frmChatGroup").height(document.documentElement.clientHeight - 65);
    }
    this.InitData = function () {
        _self.tableTmp = document.getElementById('tmpl').innerHTML;
        var hours = new Date().getHours();
        var timeName = "上午";
        if (hours > 12 && hours <= 14) timeName = "中午";
        if (hours > 14 && hours <= 19) timeName = "下午";
        if (hours > 19 && hours <= 23) timeName = "晚上";
        if (hours > 23 || hours <= 5) timeName = "凌晨";
        if (_LoginUser.companyInfos.length > 1) {
            $("#lnkChange").show();
        }
        $("#lblUserName").text(_LoginUser.name + "," + timeName + "好!");
        if (_LoginUser.companyInfo.PicUrl != null && _LoginUser.companyInfo.picUrl.length>0)
        {
            $("#lnkLogo").css("background-image", "url(" + _LoginUser.companyInfo.picUrl.replace("Attachs","Thumbs") + ")");
        }
        else
        {
            $("#lnkLogo").css("background-image", "url(/images/logo.png)");
        }
        if (!HaveModule(105)) {
            $("#btnChatGroup").hide();
            $("#divChatGroup").html("");
            
        }
        $("#lblRoleName").text(_LoginUser.companyInfo.roleName);
        $("#lblCompanyName").text(_LoginUser.companyInfo.companyName);
        document.title = _LoginUser.companyInfo.companyName.replaceAll("有限公司", "") + _LoginUser.companyInfo.roleName
        _self.smallMenu = document.getElementById('tmpSmallMenu').innerHTML;
        _self.normalMenu = document.getElementById('tmpNormalMenu').innerHTML;

        layui.use(['layer', 'laytpl', 'element'], function () {
          _self.layer = layui.layer
            , _self.laytpl = layui.laytpl
          _self.element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
          _self.GetData();
        //    _self.GetNews();
        });
    }
    this.InitEvent = function () {
       /* setInterval(function () {
            var filter = new Array();
            condition = new Object();
            condition.FieldName = 'ReceiverId';
            condition.Opt = '=';
            condition.Value = _LoginUser.id;
            condition.FieldType = "string";
            filter.push(condition);
            condition = new Object();
            condition.FieldName = 'State';
            condition.Opt = '=';
            condition.Value = "新建";
            condition.FieldType = "string";
            filter.push(condition);
           var  param = new Object();
            param.filter = filter;
            param.tableName = "MessageInfo";
            PostData("GetRecordCount", param, function (result) {
                $("#lblUnReadCount").text(result.Data);

            });
        }, 3000);*/
        $("#iFunc").click(function (e) {
            if ($(this).hasClass('big')) {
                if (_self.MenuItem != null) {
                    _self.MenuItem.hide();
                    //_self.MenuItem.show();
                }

                $(this).removeClass("big");
                $('.IndexRight').width(document.documentElement.clientWidth - 225);
                $("#divMenuSite").removeClass("smallSite");
                $("#divMenuSite").addClass("listSite");
                $("#divMenu").removeClass("SmallMenu");
                $($(".layui-layout-admin")[0]).removeClass("layui-layout-smallmenu");
                //$(this).html("&#xe62d;");
                //$("#divMenuSite ul").addClass('layui-nav');
                //$("#divMenuSite ul").addClass('layui-nav-tree');
                //$("#divMenuSite li").addClass('layui-nav-item');
                //$("#divMenuSite dl").addClass('layui-nav-child');
               
                _self.SetMenu2();
               
            } else {
                $(this).addClass("big");
                $("#divMenuSite").removeClass("listSite");
                $("#divMenuSite").addClass("smallSite");
                $("#divMenu").addClass("SmallMenu");
                $($(".layui-layout-admin")[0]).addClass("layui-layout-smallmenu");
                
                //$(this).html("&#xe616;");
                //$("#divMenuSite ul").removeClass('layui-nav');
                //$("#divMenuSite ul").removeClass('layui-nav-tree');
                //$("#divMenuSite li").removeClass('layui-nav-item');
                //$("#divMenuSite dl").removeClass('layui-nav-child');                
                $('.IndexRight').width(document.documentElement.clientWidth - 65);
                _self.SetMenu1();
            }
        });
        $("#lnkChange").click(function (e) {
            var offset = $(this).offset();
            $("#divCompany").css({ "top": (offset.top + $(this).height()) + "px", "left": +offset.left + "px" });
            $("#divCompany").show();
            e.stopPropagation();
        })
        $("#btnChatGroup").click(function (e) {
            $(".right-content").width(_width - 440);
            ShowPanel("#divChatGroup", 200);
            $("#iChatGroup").css("color", "#fff");
        });
    }
    
    this.SetMenu1 = function () {
        $("#divMenu").html(_self.Menu1);

        $(".SmallMenu li").hover(function () {
            if ($(this).hasClass('layui-nav-item')) {
                return;
            }
            var offset = $(this).offset();
            var _height = document.documentElement.clientHeight;
            var _childHeight = $(this).children("dl").height();
            if (_self.MenuItem != null) _self.MenuItem.hide();
            _self.MenuItem = $(this).children("dl")
            if ((_childHeight + offset.top) > _height)
                _self.MenuItem.css({ "top": (offset.top - _childHeight + 70) + "px" });
            else
                _self.MenuItem.css({ "top": (offset.top - 60) + "px" });
            _self.MenuItem.show();
        },
    function () {
        $(".SmallMenu li dl").hover(function () {
            if ($(this).hasClass('layui-nav-child')) {
                return;
            }
            _self.MenuItem.show();
        },
        function () {
            _self.MenuItem.hide();
        });
    });
    }
    this.SetMenu2 = function () {
        $("#divMenu").html(_self.Menu2);
        _self.element.init();

    }
    this.GetData=function() {

        var param = new Object();
        param.userId = _LoginUser.id;
        param.type =0;
        PostData("GetUserMenu", param, function (result) {
            _self.laytpl(_self.smallMenu).render(result, function (html) {
                _self.Menu1 = html;
               
            });
            _self.laytpl(_self.normalMenu).render(result, function (html) {
                _self.Menu2 = html;
                _self.SetMenu2();
            });          
        });       
        var filter = new Array();
        condition = new Object();
        condition.FieldName = 'ReceiverId';
        condition.Opt = '=';
        condition.Value = _LoginUser.id;
        condition.FieldType = "string";
        filter.push(condition);
        condition = new Object();
        condition.FieldName = 'State';
        condition.Opt = '=';
        condition.Value = "新建";
        condition.FieldType = "string";
        filter.push(condition);
        param = new Object();
        param.filter = filter;
        param.tableName = "MessageInfo";
        PostData("GetRecordCount", param, function (result) {
            $("#lblUnReadCount").text(result.Data);

        });
        //  $("#hd").load("top.html", function () {           
        //  });
    }
    this.ShowNews = function (index) {
        var news = _self.news[index];
        var htmlStr = "<div id='divNewsContent'><h1 style='text-align:center; font-size:16px;font-weight:bold;'>" + news.Title + "</h1>";
        htmlStr += "<p  style='text-align:right; margin-right:20px;font-weight:bold;'>发布时间：" + news.PublishDt + "</p>";
        htmlStr += "<p  style='padding:20px;'>" + news.Contents + "</p></div>";
        _self.layer.open({
            type: 1,
            area: ['800px', '500px']
            ,content: htmlStr //这里content是一个普通的String
        });
    }
    this.GetNews=function() {

       
        var filter = new Array();
        condition = new Object();
        condition.FieldName = 'CompanyId';
        condition.Opt = '=';
        condition.Value = _LoginUser.CompanyId;
        condition.FieldType = "string";
        filter.push(condition);
        condition = new Object();
        condition.FieldName = 'State';
        condition.Opt = '=';
        condition.Value = "发布";
        condition.FieldType = "string";
        filter.push(condition);
        condition = new Object();
        condition.FieldName = 'publishDt';
        condition.Opt = '>=';
        condition.Value = "dateadd(day,-isnull(staydays,0),getdate())";
        condition.FieldType = "number";
        filter.push(condition);
        param = new Object();
        param.filter = filter;
        param.pageSize = 100;
        param.pageIndex = 0;
        param.orderField = "publishDt";
        PostData("GetNews", param, function (result) {
            _self.news = result.Datas;
            _self.laytpl(_self.tableTmp).render(result, function (html) {
                document.getElementById('marquee').innerHTML = html;
                $("#marquee").marquee();              
            });
        });       
    }
    this.Navigate = function (url, pName, name, target) {
        if (target.length > 0) {
            target = encodeURIComponent(target);
            if (url.indexOf("?") >= 0)
                url += "&url=" + target + "&title=" + name;
            else
                url += "?url=" + target + "&title=" + name;
            $("#divModuleName").hide();
        }
        else {

            var htmlStr = ' <a onclick="index.Navigate(\'default.html\',\'\', \'系统总览\', \'\');" href="javascript:void(0);">主页</a> <span lay-separator=""> / </span>';
            
            if (pName.length > 0)
                htmlStr += "<span style='color:#555;'>" + pName + " / </span>";
            htmlStr += "<span style=' '>" + name + "</span>";
            $("#lblModuleName").html(htmlStr);
            $("#divModuleName").show();
        }
        document.getElementById("frmContent").src = url;
    }
    this.FlashObj = function (objId) {
        _self.FlashTime = 0;
        _self.FlashIsShow = true;
        _self.FlashTimer = setInterval(function () {
            if (_self.FlashIsShow) {
                _self.FlashIsShow = false;
                $("#" + objId).css("color", "#f00");
            }
            else {
                _self.FlashIsShow = true;
                $("#" + objId).css("color", "#fff");
            }
            _self.FlashTime++;
            if (_self.FlashTime > 6) {
                clearInterval(_self.FlashTimer);
            }
        }, 500);
    }
    this.ShowChatWindow = function (id, name) {
        _self.layer.open({
            type: 2,
            area: ['1000px', '600px'],
            content: '/brain/sendmessage.html?OwnerId=' + id + "&OwnerType=UserGroup&OwnerName=" + name
        });
    }
}
function ShowChatWindow(id, name) {
    index.ShowChatWindow(id, name);
}
function ShakeChat() {
    index.FlashObj("iChatGroup");
}
function CloseChatGroup() {
    HidePanel("#divChatGroup")
    $(".right-content").width(_width - 240);
}
var preJsFile;
function ChangePage(url, jsFile, className) {
    $("script[src='"+preJsFile+"']").remove();
    $(".bd-content-wrap").load(url, function () {
        LazyLoad.js(jsFile, function () {
            preJsFile = jsFile;
            eval("(new "+className+"()).Initial();")
        });
    });
}
function SelectCompanyInfo(companyInfo) {
    var param = new Object();
    param.userId = _LoginUser.Id;
    param.companyId = companyInfo.Id;   
    PostData("ChangeCompany", param, function (result) {
        localStorage.setItem("LoginUser", JSON.stringify(result.Data));
        self.location="index.html"
    });
}