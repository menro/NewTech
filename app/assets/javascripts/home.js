(function() {
  var GMap;

  var currentMap;

  var categoryMarkerClusters;
  var nCategories;

  var countyCircles;
  var nCountyCircles;
  var countyLabels;

  GMap = (function() {

    function GMap(container) {

      // Initialize Google Map
      var defaultOptions;
      defaultOptions = {
          minZoom: 7,
          zoom: 8,
          scrollwheel: false,
          mapTypeId: google.maps.MapTypeId.ROADMAP,
          center: new google.maps.LatLng(39.232253, -105.08606)
      };
      currentMap = new google.maps.Map(container, defaultOptions);
      google.maps.event.addListener(currentMap, 'zoom_changed', function() {
          refreshMap(container)
      });
      drawCountyCircles(container);
    }

    GMap.init = function(container) {
      console.log("Initialize Gmap");
      return new GMap(container);
    };

    return GMap;

  })();

  function refreshMap(container) {
    var zoomLevel = currentMap.getZoom();
    if (zoomLevel <= 8) {
      clearCategoryMarkerClusters();
      clearCountyCirclesAndLabels();
      drawCountyCircles(container);
    } else {
      clearCountyCirclesAndLabels();
      clearCategoryMarkerClusters();
      drawCategoryClusters(container);
    }
  }

  function clearCategoryMarkerClusters() {
    for (var i=0; i<nCategories; i++) {
      categoryMarkerClusters[i].clearMarkers();
    }
  }

  function clearCountyCirclesAndLabels() {
    for (var i=0; i<nCountyCircles; i++) {
      countyCircles[i].setMap(null);
      countyLabels[i].setMap(null);
    }
  }

  function drawCategoryClusters(container) {
    // Category clusters
    $.getJSON($(container).data("categories_url"), function(data) {

      var styles = new Array();
      var markerImages = new Array();
      nCategories = 0;
      $.each(data, function(i, category) {
        styles[i] = category.cluster_styles;
        var imageUrl = 'http://chart.apis.google.com/chart?cht=mm&chs=24x32&chco=FFFFFF,'
          + category.marker_color + ',000000&ext=.png';
        var markerImage = new google.maps.MarkerImage(
          imageUrl, new google.maps.Size(24, 32));
        markerImages[nCategories++] = markerImage;
      });
      console.log("Loaded styles for clusters: "+nCategories);

      $.getJSON($(container).data("offices_url"), function(data) {

        // Load company offices data
        var markersMatrix = new Array();
        var clusterElementsCount = new Array();
        for (var j=0; j<nCategories; j++) {
          markersMatrix[j] = new Array();
          clusterElementsCount[j] = 0;
        }

        $.each(data, function(i, office) {
          var iCluster = i%nCategories;

          var contentString = '<h1>'+office.company_name+'</h1>'
            +'<p><a href=""'+office.company_homepage_url+'"></a></p>'
            +'<p><b>Year founded: </b>'+office.company_founded_year+'</p>'
            +'<p><b>Number of employees: </b>'+office.company_number_of_employees+'</p>'
            +'<p>'+office.company_overview+'</p>';
          var infowindow = new google.maps.InfoWindow({
            content: contentString
          });

          var marker;
          marker = new google.maps.Marker({
            position: new google.maps.LatLng(office.latitude, office.longitude),
            draggable: true,
            title: office.company_name,
            icon: markerImages[iCluster],
          });
          //console.log("marker");
          //console.log(marker);
          google.maps.event.addListener(marker, 'click', function() {
            infowindow.open(currentMap,marker);
          });
          markersMatrix[iCluster][clusterElementsCount[iCluster]++] = marker;
        });

        // Create Category Clusters on map
        categoryMarkerClusters = new Array(nCategories);
        for (var k=0; k<nCategories; k++) {
          console.log("markersMatrix["+k+"]0");
          console.log(markersMatrix[k][0]);
          console.log("styles[k]");
          console.log(styles[k]);
          categoryMarkerClusters[k] = new MarkerClusterer(currentMap, markersMatrix[k], {
            maxZoom: 20,
            gridSize: 48,
            styles: styles[k]
          });
        }
      });

    });
  }

  function drawCountyCircles(container) {
    // County circles
    $.getJSON($(container).data("counties_url"), function(data) {
      countyCircles = new Array();
      nCountyCircles = 0;
      countyLabels = new Array();
      $.each(data, function(i, county) {
        if (county.offices_numbers == 0) return;
        var circlePosition = new google.maps.LatLng(county.offices_avg_latitude, county.offices_avg_longitude);
        var multiplier = county.offices_percentage;
        if (multiplier<5) {
          multiplier *= 2;
        }
        var radius = 1500*multiplier;
        var circleOptions = {
          strokeColor: '#efeff2',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: '#aaaab4',
          fillOpacity: 0.45,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };
        countyCircles[nCountyCircles] = new google.maps.Circle(circleOptions);
        google.maps.event.addListener(countyCircles[nCountyCircles], 'click', function() {
          currentMap.setZoom(currentMap.getZoom()+1);
        });

        drawCountyLabel(nCountyCircles, county, circlePosition);
        nCountyCircles++;
      });
    });
  }

  function drawCountyLabel(i, county, position) {
    var dummyMarkerImage = new google.maps.MarkerImage(
      '/assets/transparent.gif', new google.maps.Size(1, 1));
    var percentage = Math.round(county.offices_percentage*100)/100;
    countyLabels[i] = new MarkerWithLabel({
      icon: dummyMarkerImage,
      position: position,
      map: currentMap,
      labelContent: county.name+'<br/>'+county.offices_numbers+' ('+percentage+'%)',
      labelAnchor: new google.maps.Point(40, 0),
      labelClass: "labels"
    });
    google.maps.event.addListener(countyLabels[i], 'click', function() {
      currentMap.setZoom(currentMap.getZoom()+1);
    });
  }

  $(function() {
      $( "#slider-range" ).slider({
          range: true,
          min: 1950,
          max: 2012,
          values: [ 1950, 2012 ],
          slide: function( event, ui ) {
              $( "#years-range" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
          }
      });
      $( "#years-range" ).html( $( "#slider-range" ).slider( "values", 0 ) +
          " - " + $( "#slider-range" ).slider( "values", 1 ) );

      return $('.gmap').each(function() {
          return GMap.init(this);
      });
  });

}).call(this);
