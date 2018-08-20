function MapZoom(zoomIndex, zoombar) {
    var _barHeight = new Array(140, 152, 164, 176, 188, 200, 212, 224, 236);
    var _zoomScale = new Array(200, 300, 500, 800, 1500, 3000, 5000, 12000, 25000);
    var _deltaX = new Array(0.0019759871233162585, 0.0029639806849814931, 0.0049399678082977516, 0.0079039484932792448, 0.014819903424893255, 0.029639806849814931, 0.049399678083020149, 0.1185592273992313, 0.24699839041505811);
   // var _deltaX = new Array(0.001100, 0.001600, 0.001600, 0.001600, 0.001600, 0.001600, 0.001600, 0.001600, 0.001600);
    var _deltaY = new Array(-0.0000107, -0.0000107, -0.0000307, -0.0000307, -0.0000307, -0.0000307, -0.0000307, -0.0000307, -0.0000307);
   
    var _zoom;
    var _zoomIndex = zoomIndex;
    var _barObj = zoombar;
    var _maxZoomIndex = 8;
    this.Zoom = _zoomScale[_zoomIndex];
    var self = this;
    this.ZoomIndex = _zoomIndex;
    this.BarHeight = _barHeight[_zoomIndex];
    this.DeltaX = _deltaX[self.ZoomIndex];
    this.DeltaY = _deltaY[self.ZoomIndex];
    _barObj.style.top = this.BarHeight + "px";
    this.SetZoom = function (zoomIndex) {
        if (zoomIndex > _zoomScale.length - 1) zoomIndex = _zoomScale.length - 1;
        if (zoomIndex < 0) zoomIndex = 0;
        if (zoomIndex > _maxZoomIndex) zoomIndex = _maxZoomIndex;
        _zoomIndex = zoomIndex;
        this.ZoomIndex = zoomIndex;
        this.Zoom = _zoomScale[zoomIndex]
        this.BarHeight = _barHeight[zoomIndex];
        _barObj.style.top = mapZoom.BarHeight + "px";
        this.DeltaX = _deltaX[zoomIndex];
        this.DeltaY = _deltaY[zoomIndex];
    }
    this.SetZoomByPosition = function (zoomIndex) {
        for (var i = 0; i < _zoomScale.length; i++) {
            if (_barHeight[i] > i) {
                _zoomIndex = i;
                this.ZoomIndex = zoomIndex;
                this.Zoom = _zoomScale[zoomIndex]
                this.BarHeight = _barHeight[zoomIndex];
                this.DeltaX = _deltaX[zoomIndex];
                this.DeltaY = _deltaY[zoomIndex];
            }
        }
        _barObj.style.top = mapZoom.BarHeight + "px";
    }
    this.SetZoomScale = function (scale) {
        for (var i = 0; i < _zoomScale.length; i++) {
            if (_zoomScale[i] > scale) {
                _zoomIndex = i;
                this.ZoomIndex = zoomIndex;
                this.Zoom = _zoomScale[zoomIndex]
                this.DeltaX = _deltaX[zoomIndex];
                this.DeltaY = _deltaY[zoomIndex];
                this.BarHeight = _barHeight[zoomIndex];
                break;
            }
        }
        _barObj.style.top = mapZoom.BarHeight + "px";
    }

}