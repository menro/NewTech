(function() {
  var GMap;

  var currentMap;

  var companyOfficesMarkers;
  var nOffices = 0;

  var countyCircles;
  var nCountyCircles = 0;
  var countyLabels;
  var countyZoomLevel = 11; //PROVVISORIO - dovrei prendere il nro appropriato da county.map_zoom_level

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
      clearCompanyOffices();
      clearCountyCirclesAndLabels();
      drawCountyCircles(container);
    } else {
      clearCountyCirclesAndLabels();
      clearCompanyOffices();
      drawCompanyOffices(container);
    }
  }

  function clearCompanyOffices() {
    for (var i=0; i<nOffices; i++) {
      companyOfficesMarkers[i].setMap(null);
    }
  }

  function clearCountyCirclesAndLabels() {
    for (var i=0; i<nCountyCircles; i++) {
      countyCircles[i].setMap(null);
      countyLabels[i].setMap(null);
    }
  }

  function drawCompanyOffices(container) {
    $.getJSON($(container).data("offices_url"), searchParams(), function(data) {

      companyOfficesMarkers = new Array();
      nOffices = 0;
      $.each(data, function(i, office) {

        var contentString = '<h1>'+office.company_name+'</h1>'
          +'<p><a href=""'+office.company_homepage_url+'"></a></p>'
          +'<p><b>Year founded: </b>'+office.company_founded_year+'</p>'
          +'<p><b>Number of employees: </b>'+office.company_number_of_employees+'</p>'
          +'<p>'+office.company_overview+'</p>';
        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var imageUrl = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chs=24x32&chld='
          +i+'|c8c626|000000';
        var markerImage = new google.maps.MarkerImage(
          imageUrl, new google.maps.Size(24, 32));

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(office.latitude, office.longitude),
          //draggable: false,
          title: office.company_name,
          icon: markerImage,
          map: currentMap
        });
        //console.log("marker");
        //console.log(marker);
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(currentMap,marker);
        });

        companyOfficesMarkers[nOffices++] = marker;
      });
      //console.log(companyOfficesMarkers);
    });

  }

  function drawCountyCircles(container) {
    $('h1').html('Tech Companies by County');
    // County circles
    $.getJSON($(container).data("counties_url"), searchParams(), function(data) {
      countyCircles = new Array();
      nCountyCircles = 0;
      countyLabels = new Array();
      $.each(data, function(i, county) {
        if (county.offices_numbers == 0) return;
        //var circlePosition = new google.maps.LatLng(county.offices_avg_latitude, county.offices_avg_longitude);
        var circlePosition = new google.maps.LatLng(county.latitude, county.longitude);
        var multiplier = county.offices_percentage;
        if (multiplier<5) {
          multiplier *= 2;
        }
        if (multiplier>20) {
          multiplier /= 1.5;
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
          onCountySelected(county, circlePosition);
        });

        drawCountyLabel(nCountyCircles, county, circlePosition);
        nCountyCircles++;
      });
    });
  }

  function onCountySelected(county, circlePosition) {
    $('h1').html('Tech Companies in '+county.name);
    $("#search_params").data("current_county_name", county.name);
    //currentMap.setZoom(currentMap.getZoom()+1);
    currentMap.setCenter(circlePosition);
    currentMap.setZoom(countyZoomLevel);
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
      onCountySelected(county, position);
    });
  }

  function searchParams() {
      search_params = {
          from_year: $("#search_params").data("from_year"),
          to_year: $("#search_params").data("to_year"),
          tag_code: $("#search_params").data("tag_code"),
          current_county_name: $("#search_params").data("current_county_name")
      }
      return search_params;
  }

  $(function() {
      $( "#years_slider" ).slider({
          range: true,
          min: 1950,
          max: 2012,
          values: [ 1950, 2012 ],
          slide: function( event, ui ) {
              $( "#years_range" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
          },
          stop: function( event, ui ) {
              $("#search_params").data("from_year", ui.values[ 0 ])
              $("#search_params").data("to_year", ui.values[ 1])
              return $('.gmap').each(function() {
                  return refreshMap(this);
              });
          }
      });
      $( "#years_range" ).html( $( "#years_slider" ).slider( "values", 0 ) +
          " - " + $( "#years_slider" ).slider( "values", 1 ) );

      return $('.gmap').each(function() {
          return GMap.init(this);
      });
  });

  $(function () {
    $('#tag-cloud a').tagcloud({
      size: {
        start: 14,
        end: 18,
        unit: 'pt'
      },
      color: {
        start: '#777',
        end: '#222'
      }
    });
    $('#tag-cloud a').click(function() {
      var tag_code = $(this).data("tag_code");
      $("#search_params").data("tag_code", tag_code);
      $('.gmap').each(function() {
        refreshMap(this);
      });
    });
  });

}).call(this);
