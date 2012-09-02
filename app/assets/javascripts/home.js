(function() {
  var GMap;

  GMap = (function() {

    function GMap(container) {
      var currentMap, defaultOptions, markers;
      defaultOptions = {
        zoom: 7,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: new google.maps.LatLng(39.232253, -105.08606)
      };
      currentMap = new google.maps.Map(container, defaultOptions);
      markers = [];
      $.getJSON($(container).data("offices_url"), function(data) {
        return $.each(data, function(i, result) {
          var marker, office;
          office = result.office;
          marker = {
            map: currentMap,
            position: new google.maps.LatLng(office.latitude, office.longitude),
            title: office.company_name
          };
          return markers += new google.maps.Marker(marker);
        });
      });
    }

    GMap.init = function(container) {
      console.log("Initialize Gmap");
      return new GMap(container);
    };

    return GMap;

  })();

  $(function() {
    return $('.gmap').each(function() {
      return GMap.init(this);
    });
  });

}).call(this);
