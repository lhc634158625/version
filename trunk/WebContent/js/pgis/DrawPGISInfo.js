var DrawPGISInfo= {
    Data: {},
    Points: [],
    Lines: [],
    _PgisHelper:null,
    Init: function (PGISHelper) {
    	_PgisHelper=PGISHelper;
    	return DrawPGISInfo;
    },
    onClickPointInfo:function(marker){
    	if(marker.type=="135" || marker.type=="keyDefense"|| marker.type=="encrypt"){
	    	if(typeof showAll !="undefined"){
	    		var obj=document.getElementById("station_"+marker.lineid);
	    		showAll(obj);
	    	}
	       if(typeof showMess !="undefined"){
	    	   showMess(marker.lineid,marker.ID,"启用");
	       }
    	}
    },
}
