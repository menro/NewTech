(function() {
    var GMap;

    GMap = (function() {

        function GMap(container) {

          // Initialize Google Map
          var currentMap, defaultOptions;
          defaultOptions = {
            minZoom: 7,
            zoom: 8,
            scrollwheel: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: new google.maps.LatLng(39.232253, -105.08606)
          };
          currentMap = new google.maps.Map(container, defaultOptions);

          var nClusters = 0
            $.getJSON($(container).data("categories_url"), function(data) {

                var styles = new Array();
                nClusters = 0;
                $.each(data, function(i, category) {
                    nClusters++;
                    styles[i] = category.cluster_styles;
                });
                console.log("Loaded styles for clusters: "+nClusters);

                var markerColors = ['119605','4681ea','da4747', 'ffc100']; //PROVVISORIO
                var markerImages = new Array();
                for (var i1=0; i1<nClusters; i1++) {
                    var imageUrl = 'http://chart.apis.google.com/chart?cht=mm&chs=24x32&chco=FFFFFF,'
                        + markerColors[i1] + ',000000&ext=.png';
                    var markerImage = new google.maps.MarkerImage(
                        imageUrl, new google.maps.Size(24, 32));
                    markerImages[i1] = markerImage;
                }

                $.getJSON($(container).data("offices_url"), function(data) {

                    // Load company offices data
                    var markersMatrix = new Array();
                    var clusterElementsCount = new Array();
                    for (var j=0; j<nClusters; j++) {
                        markersMatrix[j] = new Array();
                        clusterElementsCount[j] = 0;
                    }

                    $.each(data, function(i, office) {
                        var iCluster = i%nClusters;

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
                            //map: currentMap,
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

                    //County clusters
                    $.getJSON($(container).data("counties_url"), function(data) {
                      var circle;
                      $.each(data, function(i, county) {
                        if (county.offices_numbers == 0) return;
                        var circlePosition = new google.maps.LatLng(county.latitude, county.longitude);

                        var circleOptions = {
                          strokeColor: '#efeff2',
                          strokeOpacity: 0.6,
                          strokeWeight: 2,
                          fillColor: '#aaaab4',
                          fillOpacity: 0.45,
                          map: currentMap,
                          center: circlePosition,
                          radius: 1500*county.offices_percentage
                        };
                        circle = new google.maps.Circle(circleOptions);

                        var dummyMarkerImage = new google.maps.MarkerImage(
                          '/assets/transparent.gif', new google.maps.Size(1, 1));
                        var percentage = Math.round(county.offices_percentage*100)/100;
                        var countyLabel = new MarkerWithLabel({
                          icon: dummyMarkerImage,
                          position: circlePosition,
                          map: currentMap,
                          labelContent: county.name+'<br/>'+county.offices_numbers+' ('+percentage+'%)',
                          labelAnchor: new google.maps.Point(40, 0),
                          labelClass: "labels"
                        });
                      });
                  });

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
