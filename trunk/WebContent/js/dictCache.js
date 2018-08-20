function DictCache() {
    var _self = this;   
    this.GetValue = function (dictCode, code, callback) {
        if (_self.allbaseDict == null) {
            RetrieveLocalData("AllBaseDict", function (data) {
                _self.allbaseDict = data;
                if (_self.allbaseDict == null) {
                    _self.allbaseDict = new Array();
                    _self.pageIndex = 0; vfgrf
                    _self.RetrieveBaseDictData(function () {
                        var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                        if (baseDicts.length == 0)
                            callback("");
                        else
                            callback(baseDicts[0].name);                       
                    });
                    return;
                }
                var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                if (baseDicts.length == 0)
                    callback("");
                else
                    callback(baseDicts[0].name);
            });
        }else
        {
            var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
            if (baseDicts.length == 0)
                callback("");
            else
                callback(baseDicts[0].name);
        }
    }
    this.GetBaseDict = function (dictCode, code, callback) {
        if (_self.allbaseDict == null) {
            RetrieveLocalData("AllBaseDict", function (data) {
                _self.allbaseDict = data;
                if (_self.allbaseDict == null) {
                    _self.allbaseDict = new Array();
                    _self.pageIndex = 0; 
                    _self.RetrieveBaseDictData(function () {
                        var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                        if (baseDicts.length == 0)
                            callback();
                        else
                            callback(baseDicts[0]);
                       
                    });
                    return;
                }
                var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                if (baseDicts.length == 0)
                    callback();
                else
                    callback(baseDicts[0]);
            });
        } else {
            var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
            if (baseDicts.length == 0)
                callback("");
            else
                callback(baseDicts[0]);
        }
    }
    this.GetDefaultValue = function (dictCode, callback) {
        if (_self.allbaseDict == null) {
            RetrieveLocalData("AllBaseDict", function (data) {
                _self.allbaseDict = data;
                if (_self.allbaseDict == null) {
                    _self.allbaseDict = new Array();
                    _self.pageIndex = 0;
                    _self.RetrieveBaseDictData(function () {
                        var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                        if (baseDicts.length == 0)
                            callback();
                        else
                            callback(baseDicts[0]);
                      
                    });
                    return;
                }
                var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
                if (baseDicts.length == 0)
                    callback();
                else
                    callback(baseDicts[0]);
            });
        } else {
            var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && x.code == code }).ToArray();
            if (baseDicts.length == 0)
                callback();
            else
                callback(baseDicts[0]);
        }
        
    }
    this.GetColTranslation = function (tableName, callback, param) {
        if (_self.colTranslations == null) {
            RetrieveLocalData("AllColTranslation", function (data) {
                _self.colTranslations = data;
                if (_self.colTranslations == null) {
                    _self.RetrieveColTranslate(function () {
                        var datas = Enumerable.From(_self.colTranslations).Where(function (x) { return x.tableName.toUpperCase() == tableName.toUpperCase() }).ToArray();

                        callback(datas);
                      
                    });
                    return;
                }
                var datas = Enumerable.From(_self.colTranslations).Where(function (x) { return x.tableName.toUpperCase() == tableName.toUpperCase() }).ToArray();

                callback(datas);
            });
        } else
        {
            var datas = Enumerable.From(_self.colTranslations).Where(function (x) { return x.tableName.toUpperCase() == tableName.toUpperCase() }).ToArray();

            callback(datas);
        }
       
    }
    this.GetDept = function (code, callback) {
        if (_self.allDeptDict == null) {
            RetrieveLocalData("AllDeptDict", function (data) {
                _self.allDeptDict = data;
                if (_self.allDeptDict == null) {
                    _self.allDeptDict = new Array();
                    _self.pageIndex = 0;
                    _self.RetrieveDept(function () {
                        var deptDicts = Enumerable.From(_self.allDeptDict).Where(function (x) { return x.code == code }).ToArray();
                        if(deptDicts.length>0)
                            callback(deptDicts[0]);
                        else
                            callback();                        
                    });
                    return;
                }
               
                var deptDicts = Enumerable.From(_self.allDeptDict).Where(function (x) { return x.code == code }).ToArray();
                if(deptDicts.length>0)
                    callback(deptDicts[0]);
                else
                    callback();
            });
        }
        else {
            var deptDicts = Enumerable.From(_self.allDeptDict).Where(function (x) { return x.code == code }).ToArray();
            if(deptDicts.length>0)
                callback(deptDicts[0]);
            else
                callback();
        }
    }
    this.RetrieveDept = function () {
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = 100;
        param.pageIndex = _self.pageIndex;
        param.orderField = "Id";
        PostData("GetDeptDict", param, function (result) {
            if (result.Datas.length > 0) {             
                _self.allDeptDict = _self.allDeptDict.concat(result.Datas);
                _self.pageIndex++;
                _self.RetrieveDept();
            }
            else {
                SaveLocalData("AllDeptDict", _self.allDeptDict);
            }
        });
    }
    this.GetDicts = function (dictCode, callback, param) {
        if (_self.allbaseDict == null) {
            RetrieveLocalData("AllBaseDict", function (data) {
                _self.allbaseDict = data;
                if (_self.allbaseDict == null) {
                    _self.allbaseDict = new Array();
                    _self.pageIndex = 0;
                    _self.RetrieveBaseDictData(function () {
                        var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && (param == null ? true : x.custom1 == param) }).ToArray();

                        callback(baseDicts);
                        return;
                    });
                }
                var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && (param == null ? true : x.custom1 == param) }).ToArray();

                callback(baseDicts);
            });
        }
        else {
            var baseDicts = Enumerable.From(_self.allbaseDict).Where(function (x) { return x.dictCode.toUpperCase() == dictCode.toUpperCase() && (param == null ? true : x.custom1 == param) }).ToArray();

            callback(baseDicts);
        }
    }
    this.GetFilter = function () {
        _self.filter = new Array();
        var condition = new Object();
        condition = new Object();
        condition.FieldName = 'orgCode';
        condition.Opt = '=';
        condition.Value = _LoginUser.orgCode;
        condition.FieldType = "string";
        _self.filter.push(condition);
        condition = new Object();
        condition.FieldName = 'validFlag';
        condition.Opt = '=';
        condition.Value = "1";
        condition.FieldType = "string";
        _self.filter.push(condition);
    }
    this.RetrieveBaseDictData = function (callback) {
        _self.GetFilter();
        var param = new Object();
        param.filter = _self.filter;
        param.pageSize = 100;
        param.pageIndex = _self.pageIndex;
        param.orderField = "Id";
        PostData("GetBaseDict", param, function (result) {
            if (result.Datas.length > 0) {
                for (var i = 0; i < result.Datas.length; i++)
                    _self.allbaseDict.push(result.Datas[i]);
                _self.pageIndex++;
                _self.RetrieveBaseDictData(callback);
            }
            else {                
                SaveLocalData("AllBaseDict", _self.allbaseDict);
                callback
            }
        });
    }
    this.RetrieveColTranslate = function (callback) {      
        var param = new Object();
        param.orgCode = _LoginUser.orgCode;
        PostData("GetAllColTranslation", param, function (result) {
            _self.colTranslations = result.Datas;           
            SaveLocalData("AllColTranslation", _self.colTranslations);
            callback();
        });
    }
}