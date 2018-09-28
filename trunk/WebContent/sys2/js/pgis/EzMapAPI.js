/*
|------------------------------------------------------------------------------
|                                   EzMapAPI.js
|
|@author: qianleyi
|@date: 2015-11-27
|@descript: 基础地图初始化配置设置
|------------------------------------------------------------------------------
*/

var ezMap = {
    /**
     * 二维数组：可以插入多个图层对象
     * 参数说明：[]表示图层组,数组中[i][0]表示图层名,[i][1]表示图层的URL,[i][2]表示图层的参数设置
     * 参数类型：Array
     * 取值范围：无限制
     * 默认值：无
     */
    MapSrcURL: [
       //http://10.10.10.100:8080/EzServer7/Maps/sl2015
        ["矢量", "http://218.5.80.6:6600/EzServer7/tiles/pgis", {
            crs: '4326',
            wrapX: false,
            //crossOrigin: 'Anonymous',
            imageSRC: 'http://10.130.145.164:8080/PGIS_S_TileMap7/images/shiliang.png',
            key: 'one'
        }],



        
        ["影像", "http://10.130.145.164:8080/PGIS_S_TileMapServer/Maps/yx2015", {
            crs: '4326',
            wrapX: false,
            imageSRC: 'http://10.130.145.164:8080/PGIS_S_TileMap7/images/yingxiang.png',
            key: 'rrrrrrrrr'
        }],
        
        ["地形", "http://10.130.145.164:8080/PGIS_S_TileMapServer/Maps/dx2015", {
            crs: '4326',
            wrapX: false,
            imageSRC: 'http://10.130.145.164:8080/PGIS_S_TileMap7/images/dixing.bmp',
            key: 'rrrrrrrrrk'
        }]
        
        
        
        /** ... */
    ],

    /**
     * 参数说明：设置地图初始化中心位置
     * 参数类型：Array<Float,Float>
     * 取值范围：无限制
     * 默认值：无
     */
    //CenterPoint: [104.114129,37.550339],
    CenterPoint: [118.08517,24.38961],
    // CenterPoint: [492567.23876, 326339.30273],

    /**
     * 参数说明：设置全图显示时地图显示范围
     * 参数类型：[minx,miny,maxx,maxy]
     * 取值范围：无限制
     * 默认值：无
     */
    MapFullExtent: undefined,
    //MapFullExtent: [116.264129,39.590339,116.564129,39.79],

    /**
     * 参数说明：设置地图初始显示级别
     * 参数类型：Int
     * 取值范围：无限制
     * 默认值：无
     */
    MapInitLevel: 11,

    /**
     * 参数说明：设置地图显示的最大级别
     * 参数类型：Int
     * 取值范围：无限制
     * 默认值：无
     */
    MapMaxLevel: 20,

    /**
     * 参数说明：设置地图显示的最小级别
     * 参数类型：Int
     * 取值范围：无限制
     * 默认值：无
     */
    MapMinLevel: 2,

    /**
     * 参数说明：是否添加地图级别控制条hover样式
     * 参数类型：Boolean
     * 取值范围：无限制
     * 默认值：无
     */
    isTitleArea: true,

    /**
     * 参数说明：Animation 瓦片是否提前加载
     * 参数类型：Boolean
     * 取值范围：无限制
     * 默认值：false
     */
    loadTilesWhileAnimating: false
};
