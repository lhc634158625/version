function IndexDB() {
    var self = this;
    const DB_NAME = 'SystemCache';
    const DB_VERSION = 2; // Use a long long for this value (don't use a float)
    const DB_STORE_NAME = 'Dict';
    var db;
    this.OpenDB = function (key,callback) {    
        var indexDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB || window.msIndexedDB;
        if (!indexDB) {
            alert("浏览器不支持IndexDB的存储方式，请采用最新浏览器");
            return false;
        }
      
        var req = indexDB.open(DB_NAME, DB_VERSION);
        req.onsuccess = function (evt) {
            // Better use "this" than "req" to get the result to avoid problems with
            // garbage collection.
            // db = req.result;
            db = this.result;
            console.debug("initDb DONE");
            callback();
        };
        req.onerror = function (evt) {
            console.error("initDb:", evt.target.errorCode);
        };

        req.onupgradeneeded = function (evt) {
            console.debug("initDb.onupgradeneeded");
            var store = evt.currentTarget.result.createObjectStore(
              DB_STORE_NAME, { keyPath: 'id' });
            //store.createIndex('biblioid', 'biblioid', { unique: true });
            //store.createIndex('title', 'title', { unique: false });
            //store.createIndex('year', 'year', { unique: false });
        };
        
    }
    this.GetData = function (key, success_callback) {
        self.OpenDB(key, function () {
            var tx = db.transaction(DB_STORE_NAME, 'readonly');
            var store = tx.objectStore(DB_STORE_NAME);
            var req = store.get(key);
            req.onsuccess = function (evt) {
                var param = evt.target.result;
                if (param)
                    success_callback(param.obj);
                else
                    success_callback();
            };
            req.onerror = function (evt) {
                console.error("GetData:", evt.target.errorCode);
            };
        })        
    }
    

  
    this.SaveData = function (key, obj) {
        self.OpenDB(key, function () {
            var tx = db.transaction(DB_STORE_NAME, 'readwrite');
            var store = tx.objectStore(DB_STORE_NAME);
            var param = new Object();
            param.id = key;
            param.obj = obj;
            var req = store.get(key);
            if (req == null) {
                store.add(param)
            }
            else
                store.put(param)
        });
    }
    
}