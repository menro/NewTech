(function() {
  var GMap;

  GMap = (function() {

    function GMap(container) {

      // Load cluster styles
      var nClusters = 0;
      $.getJSON($(container).data("cluster_styles_url"), function(data) {
        var styles = new Array();
        nClusters = 0;
        $.each(data, function(i, result) {
          //console.log("clusterStyle");
          //console.log(result);
          nClusters++;
          styles[i] = result;
        });
        console.log("Loaded styles for clusters: "+nClusters);

        // Initialize Google Map
        var currentMap, defaultOptions;
        defaultOptions = {
          zoom: 7,
          scrollwheel: false,
          mapTypeId: google.maps.MapTypeId.ROADMAP,
          center: new google.maps.LatLng(39.232253, -105.08606)
        };
        currentMap = new google.maps.Map(container, defaultOptions);

        $.getJSON($(container).data("offices_url"), function(data) {

          // Load company offices data
          var markersMatrix = new Array();
          var clusterElementsCount = new Array();
          for (var j=0; j<nClusters; j++) {
            markersMatrix[j] = new Array();
            clusterElementsCount[j] = 0;
          }

          $.each(data, function(i, result) {
            var marker, office;
            office = result.office;
            marker = new google.maps.Marker({
              //map: currentMap,
              position: new google.maps.LatLng(office.latitude, office.longitude),
              draggable: true,
              title: office.company_name
            });
            //console.log("marker");
            //console.log(marker);
            var iCluster = i%nClusters;
            markersMatrix[iCluster][clusterElementsCount[iCluster]++] = marker;
            //return markers += new google.maps.Marker(marker);
          });

          // Create Clusters on map
          var clusters = new Array(nClusters);
          for (var k=0; k<nClusters; k++) {
            console.log("markersMatrix["+k+"]0");
            console.log(markersMatrix[k][0]);
            console.log("styles[k]");
            console.log(styles[k]);
            clusters[k] = new MarkerClusterer(currentMap, markersMatrix[k], {
              maxZoom: 20,
              gridSize: 48,
              styles: styles[k]
            });
          }

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
