DateTime = function () {
    var _self = this;
    // 格式化日期的表示
    this.FormatDate=function(date, str) {
        if (date == null) return "";

        if ((typeof date) == 'string') {
            if (date.indexOf("Date") > 0) //处理json日期
                date = new Date(parseInt(date.replace("/Date(", "").replace(")/", "").split("+")[0]));
            else
                date = new Date(date);
        }
        // try {
        str = _self.Replace(str, "yyyy", date.getFullYear());
        str = _self.Replace(str, "MM", _self.GetFullMonth(date));
        str = _self.Replace(str, "dd", _self.GetFullDate(date));
        str = _self.Replace(str, "yy", _self.GetHarfYear(date));
        str = _self.Replace(str, "HH", _self.GetFullHour(date));
        str = _self.Replace(str, "mm", _self.GetFullMinute(date));
        str = _self.Replace(str, "SS", _self.GetFullSecond(date));
        str = _self.Replace(str, "M", date.getMonth() + 1);
        str = _self.Replace(str, "d", date.getDate());
        //    }
        //    catch (e) {
        //        
        //      
        //    }
        return str;
    }
    // 返回两位数的年份 
    this.GetHarfYear=function(date) {
        var v = date.getYear();
        if (v > 9) return v.toString();
        return "0" + v;
    }

    // 返回月份（修正为两位数） 
    this.GetFullMonth=function(date) {
        var v = date.getMonth() + 1;
        if (v > 9) return v.toString();
        return "0" + v;
    }
    // 返回小时（修正为两位数） 
    this.GetFullHour=function(date) {
        var v = date.getHours();
        if (v > 9) return v.toString();
        return "0" + v;
    }
    // 返回分钟（修正为两位数） 
    this.GetFullMinute=function(date) {
        var v = date.getMinutes();
        if (v > 9) return v.toString();
        return "0" + v;
    }
    // 返回分钟（修正为两位数） 
    this.GetFullSecond=function(date) {
        var v = date.getSeconds();
        if (v > 9) return v.toString();
        return "0" + v;
    }

    // 返回日 （修正为两位数） 
    this.GetFullDate=function(date) {
        var v = date.getDate();
        if (v > 9) return v.toString();
        return "0" + v;
    }
    this.WeekStartDate = function (currentDate) {
      
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
       
        //返回date是一周中的某一天
        var week = currentDate.getDay(); 
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
        //获得当前周的第一天    
        var currentWeekFirstDay = new Date(currentDate.getTime() - (millisecond * minusDay)); 
        return currentWeekFirstDay;
    }
    this.MonthEndDate=function(currentDate) {  
       
      
        //获得当前月份0-11    
        var currentMonth = currentDate.getMonth();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        //获得上一个月的第一天    
        var currentMonthFirstDay = new Date(currentYear, currentMonth,1);  
        //获得上一月的最后一天    
        var currentMonthLastDay = new Date(currentYear, currentMonth+1, 0);       
        //返回    
        return currentMonthLastDay;  
    }
    // 替换字符串 
    this.Replace=function(str, from, to) {
        return str.split(from).join(to);
    }
    this.ParseDate=function(str) {
        var year = parseInt(str.substr(0, 4));
        var month = parseInt(str.substr(5, 2)) - 1;
        var day = parseInt(str.substr(8, 2)) - 1;

        return new Date(year, month, day, 0, 0, 0);
    }
    this.ParseDateTime=function(str) {
        var year = parseInt(str.substr(0, 4));
        var month = parseInt(str.substr(5, 2)) - 1;
        var day = parseInt(str.substr(8, 2)) - 1;
        var hour = parseInt(str.substr(11, 2)) - 1;
        var minute = parseInt(str.substr(14, 2)) - 1;
        var second = parseInt(str.substr(17, 2)) - 1;
        return new Date(year, month, day, hour, minute, second);
    }
    this.stringToTime=function(string) {
        var f = string.split(' ', 2);
        var d = (f[0] ? f[0] : '').split('-', 3);
        var t = (f[1] ? f[1] : '').split(':', 3);
        return (new Date(
        parseInt(d[0], 10) || null,
        (parseInt(d[1], 10) || 1) - 1,
        parseInt(d[2], 10) || null,
        parseInt(t[0], 10) || null,
        parseInt(t[1], 10) || null,
        parseInt(t[2], 10) || null
        )).getTime();
    }
    this.renderTime=function(date) {
        var da = new Date(parseInt(date.replace("/Date(", "").replace(")/", "").split("+")[0]));

        return da.getFullYear() + "-" + (da.getMonth() + 1) + "-" + da.getDate() + " " + da.getHours() + ":" + da.getMinutes() + ":" + da.getSeconds();
    }
    //日期比较，返回第一个日期减第二日期秒数
    this.dateDiff=function(date1, date2) {
        var type1 = typeof date1, type2 = typeof date2;
        if (type1 == 'string')
            date1 = stringToTime(date1);
        else if (date1.getTime)
            date1 = date1.getTime();
        if (type2 == 'string')
            date2 = stringToTime(date2);
        else if (date2.getTime)
            date2 = date2.getTime();
        //alert((date1 - date2) / (1000*60*60));
        return (date1 - date2) / (1000);
    }
    //日期计算,返回计算后的日期
    this.AddDate = function (date, interval, amount) {
        var tmpdate = new Date();
        if (date == undefined) {
            this.debug('输入的时间不能为空!');
            return new Date();
        } else if ((typeof date) == 'string') {
            if (date.indexOf("Date") > 0)
                tmpdate = new Date(parseInt(date.replace("/Date(", "").replace(")/", "").split("+")[0]));
            else
                tmpdate = new Date(date);

        } else if (date instanceof Date) {
            tmpdate = date;
        }

        var field = (typeof interval == 'string') ? interval.toUpperCase() : 'DATE';

        try {
            amount = parseInt(amount + '', 10);
            if (isNaN(amount)) {
                amount = 0;
            }
        } catch (e) {
            this.debug('你输入的[amount=' + amount + ']不能转换为整数');
            amount = 0;
        }
        switch (field) {
            case "YEAR":
                tmpdate.setFullYear(tmpdate.getFullYear() + amount);
                break;
            case "MONTH":
                tmpdate.setMonth(tmpdate.getMonth() + amount);
                break;
            case "DAY":
                tmpdate.setDate(tmpdate.getDate() + amount);
                break;
            case "HOUR":
                tmpdate.setHours(tmpdate.getHours() + amount);
                break;
            case "MINUTE":
                tmpdate.setMinutes(tmpdate.getMinutes() + amount);
                break;
            case "SECOND":
                tmpdate.setSeconds(tmpdate.getSeconds() + amount);
                break;
            default:
                this.debug('你输入的[interval:' + field + '] 不符合条件!');
        }
        return tmpdate;

    }
}