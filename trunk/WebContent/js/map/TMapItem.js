function MapItem(x, y, Col, Row, zoom, centerX, centerY, needTraffic, mapLayer) {
    var _x = x;
    var _y = y;
    var _zoom = zoom;
    var _centerX = centerX;
    var _centerY = centerY;
    var _width = 256;
    var _height = 256;
    var _left = _x * _width;
    var _top = _y * _height;
    var _mapLayer = mapLayer;
    var _needTraffic = needTraffic;
    this.X = _x;
    var self = this;

    this.Y = _y;

    // var _centerX = centerX;
    //var _centerY = centerY;
    this.RetrieveMap = function () {
        fileName = _MapService + zoom + "/" + Col + "_" + Row + ".png";
        strHtml = '<div  style="position:absolute; left:' + _left + 'px; top:' + _top + 'px; width:' + _width + 'px; height:' + _height + 'px; z-index:2;">';

        strHtml = strHtml + '<IMG class="map" src="' + fileName + '?x=180407"  onerror="javascript:this.src=\'../images/nomap.png\';"  ondragstart="return false;"   galleryimg=no></div>'

        self.InsertHtml("afterbegin", _mapLayer, strHtml);
        if (_needTraffic < 0) return;
        //  alert(fileName);
        //self.AfterRetrieveMap(fileName);

        self.RetrieveTraffic();

    }
    this.RetrieveTraffic = function () {
        /*   $.ajax({
        type: "GET",
        url: "../Map/TrafficHandler.ashx",
        data: { zoom: _zoom, centerx: _centerX, centery: _centerY },
        cache: false,
        success: self.AfterRetrieveTraffic
        });*/
        var IsStat = 0;
        if (_MapService.indexOf("8089") > 0)
            IsStat = 1;
        var el = document.getElementById("divTraffic_" + this.X + '_' + this.Y)
        if (el != null)
            el.innerHTML = '<IMG src="../Map/TrafficHandler.ashx?zoom=' + _zoom + '&centerx=' + _centerX + '&centery=' + _centerY + '&type=' + needTraffic + '&IsStat=' + IsStat + '"   galleryimg=no>'
        else {
            strHtml = '<div  id="divTraffic_' + this.X + '_' + this.Y + '" style="position:absolute; left:' + _left + 'px; top:' + _top + 'px; width:' + _width + 'px; height:' + _height + 'px; z-index:3; ">';

            strHtml = strHtml + '<IMG src="../Map/TrafficHandler.ashx?zoom=' + _zoom + '&centerx=' + _centerX + '&centery=' + _centerY + '&type=' + needTraffic + '&IsStat=' + IsStat + '"  ondragstart="return false;"  galleryimg=no></div>'

            self.InsertHtml("afterbegin", _mapLayer, strHtml);
        }

    }
    this.AfterRetrieveTraffic = function (fileName) {
        strHtml = '<div  style="position:absolute; left:' + _left + 'px; top:' + _top + 'px; width:' + _width + 'px; height:' + _height + 'px; z-index:3;">';

        strHtml = strHtml + '<IMG src="' + fileName + '"   ondragstart="return false;" galleryimg=no></div>'

        self.InsertHtml("afterbegin", _mapLayer, strHtml);
    }
    

    ///插入信息到对应层，支持Firefox+IE
    //where 插入位置
    //el 层对象
    //html html内容
    this.InsertHtml = function (where, el, html) {

        where = where.toLowerCase();
        if (el.insertAdjacentHTML) {

            switch (where) {
                case "beforebegin":
                    el.insertAdjacentHTML('BeforeBegin', html);
                    return el.previousSibling;
                case "afterbegin":
                    el.insertAdjacentHTML('AfterBegin', html);
                    return el.firstChild;
                case "beforeend":
                    el.insertAdjacentHTML('BeforeEnd', html);
                    return el.lastChild;
                case "afterend":
                    el.insertAdjacentHTML('AfterEnd', html);
                    return el.nextSibling;
            }
            throw 'Illegal insertion point -> "' + where + '"';
        }

        var range = el.ownerDocument.createRange();
        var frag;
        switch (where) {
            case "beforebegin":
                range.setStartBefore(el);
                frag = range.createContextualFragment(html);
                el.parentNode.insertBefore(frag, el);
                return el.previousSibling;
            case "afterbegin":
                if (el.firstChild) {
                    range.setStartBefore(el.firstChild);
                    frag = range.createContextualFragment(html);
                    el.insertBefore(frag, el.firstChild);
                    return el.firstChild;
                } else {
                    el.innerHTML = html;
                    return el.firstChild;
                }
            case "beforeend":
                if (el.lastChild) {
                    range.setStartAfter(el.lastChild);
                    frag = range.createContextualFragment(html);
                    el.appendChild(frag);
                    return el.lastChild;
                } else {
                    el.innerHTML = html;
                    return el.lastChild;
                }
            case "afterend":
                range.setStartAfter(el);
                frag = range.createContextualFragment(html);
                el.parentNode.insertBefore(frag, el.nextSibling);
                return el.nextSibling;
        }
        throw 'Illegal insertion point -> "' + where + '"';
    }

}