function esiGeo(){}
(function(){
     var THIS = this;
    this.loc_x = 0.00;
    this.loc_y = 0.00;
    var swfObject = null; 
        
    this.getGeolocation=function(){
      if (!navigator || !navigator.geolocation){
        fallback();
        return;
      }
      var pos = navigator.geolocation.getCurrentPosition(locationFound,locationNotFound,{timeout:10000});
       
    }
    function getSWFObject(){
            swfObject = swfObject || document.getElementById("index");
    };
    function locationFound(location){
      console.log("location got");
      var loc_x = location.coords.longitude;
      var loc_y = location.coords.latitude;
      getSWFObject();
      swfObject.handleLocationFound(loc_x, loc_y);      
    }
    function locationNotFound(){
        fallback();
    }
    function fallback(){
        getSWFObject();
        swfObject.handleLocationFound(geoip_longitude(), geoip_latitude());
    }

}).apply(esiGeo);
