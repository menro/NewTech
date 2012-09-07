(function() {
    var GMap;

    GMap = (function() {

        function GMap(container) {
            var nClusters = 0
            $.getJSON($(container).data("categories_url"), function(data) {
                var styles = new Array();
                nClusters = 0;
                $.each(data, function(i, category) {
                    nClusters++;
                    styles[i] = category.cluster_styles;
                });
                console.log("Loaded styles for clusters: "+nClusters);

                var markerColors = ['4681ea','da4747','119605', 'ffc100']; //PROVVISORIO
                var markerImages = new Array();
                for (var i1=0; i1<nClusters; i1++) {
                    var imageUrl = 'http://chart.apis.google.com/chart?cht=mm&chs=24x32&chco=FFFFFF,'
                        + markerColors[i1] + ',000000&ext=.png';
                    var markerImage = new google.maps.MarkerImage(
                        imageUrl, new google.maps.Size(24, 32));
                    markerImages[i1] = markerImage;
                }

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

                    $.each(data, function(i, office) {
                        var iCluster = i%nClusters;
                        var marker;
                        marker = new google.maps.Marker({
                            //map: currentMap,
                            position: new google.maps.LatLng(office.latitude, office.longitude),
                            draggable: true,
                            title: office.company_name,
                            icon: markerImages[iCluster]
                        });
                        //console.log("marker");
                        //console.log(marker);
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
