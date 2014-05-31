(function() {
  var GMap;
  var GGeocoder;

  var currentMap;
  var currentRequests = [];

  var companyOfficesMarkers = new Array();
  var nOffices = 0;
  var infoWindows;
  var currentInfoWindow;

  var counties;
  var countiesMap;
  var zipcodeCircles = new Array();
  var countyCircles = new Array();
  var countryCircles = new Array();
  var stateCircles = new Array();
  var nCountyCircles = 0;
  var nCountryCircles = 0;
  var nZipcodeCircles = 0;
  var nStateCircles = 0;
  var countyLabels;
  var countyZoomLevel = 11; //PROVVISORIO - dovrei prendere il nro appropriato da county.map_zoom_level
  var stateZoomLevel = 8;
  var zipcodeZoomLevel = 12;
  var currentZoomLevel = stateZoomLevel;
  var oldZoomLevel = stateZoomLevel;

  var zoomLevelMap = {
    2: 'World',
    5: 'Country',
    8: 'State',
    11: 'County',
    12: 'Zipcode'
  }
  var requiredZoomLevels = [2, 5, 8, 11, 12]

  GMap = (function() {

    function GMap(container) {
      // $(window).bind('orientationchange',function(e) {
      //   updateRecentBox();
      // });
      // $(window).bind('resize',function(e) {
      //   updateRecentBox();
      // });
      //        $(window).resize(function(){updateRecentBox();});
      // Initialize Google Map
      var defaultOptions;
      defaultOptions = {
        panControl: false,
        zoomControl: true,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL
        },
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: false,
        minZoom: 2,
        zoom: stateZoomLevel,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles:
          [
                {
                    "stylers": [
                    {
                        "visibility": "on"
                    },
                    {
                        "hue": "#ffc300"
                    },
                    {
                        "saturation": -100
                    }
                    ]
                },{
                    "featureType": "water",
                    "stylers": [
                    {
                        "visibility": "off"
                    }
                    ]
                },{
                    "featureType": "poi",
                    "stylers": [
                    {
                        "visibility": "off"
                    }
                    ]
                },{
                    "featureType": "landscape",
                    "stylers": [
                    {
                        "visibility": "simplified"
                    }
                    ]
                },{
                    "featureType": "administrative.country"
                }
                ],
        center: new google.maps.LatLng(39.7392, -104.9847)
      };
      currentMap = new google.maps.Map(container, defaultOptions);
      google.maps.event.addListener(currentMap, 'zoom_changed', function() {
          refreshMap(container);
      });
      google.maps.event.addListener(currentMap, 'dragend', function() {
          setTimeout(function() { 
            refreshForCurrentCounty();
            console.log('Called from initializer when dragged......');
            // updateCommunityManagerStats(container);
            updateBottomLists(container);
            if(currentZoomLevel == countyZoomLevel){
              // refreshMap(container);
            }

          }, 250);
      });
      drawCountyCircles(container);
      loadRecentBox(8, container);
      refreshFilterMenus(container);
      refreshMap(container);
      // console.log('Called from initializer......');
      // updateCommunityManagerStats(container);

    }

    GMap.init = function(container) {
      followSomething(container);
      return new GMap(container);
    };

    return GMap;

  })();

  function refreshMap(container) {
    console.log('Refreshing mapp....')
    var zoomLevel = currentMap.getZoom();
    currentZoomLevel = zoomLevel;

    for(var i=0; i < requiredZoomLevels.length-1; i++){
      if(zoomLevel > requiredZoomLevels[i] && zoomLevel < requiredZoomLevels[i+1]){
        if (zoomLevel > oldZoomLevel ){
          oldZoomLevel = requiredZoomLevels[i+1];
          currentMap.setZoom(oldZoomLevel);
          console.log('returning from if......');
          return;
        }
        else{
          oldZoomLevel = requiredZoomLevels[i];
          currentMap.setZoom(oldZoomLevel);
          console.log('returning from else......');
          return;
        }
      }
    }
    console.log(zoomLevel);
    if(requiredZoomLevels.indexOf(zoomLevel) > -1 ){
      // updateBottomLists(container);
      console.log('Called from refreshMap.....')
      updateCommunityManagerStats(container);
    }

    for(var i = 0; i < currentRequests.length; i++) {
      if(currentRequests[i])
        currentRequests[i].abort();
    }
    currentRequests = [];

    loadRecentBox(zoomLevel,container);
    drawCircles(container);
    if (zoomLevel <= 8) {
      // clearCompanyOffices();
      // clearCountyCircles();
      // drawCountyCircles(container);
      
      var boxSummaryCounty = $('#box-summary-county');
      boxSummaryCounty.data("current_county_id", null);
      boxSummaryCounty.hide();
    } else {
      // clearCountyCircles();
      // clearCompanyOffices();
      // drawCompanyOffices(container);      
      // drawCountySummaryBox(container);
      drawZipcodeSummaryBox(container);
      // refreshForCurrentCounty();      
    }
    //refreshTags(container);
    refreshForCurrentCounty();
    refreshFilterMenus(container);
  }

  function loadRecentBox(zoomLevel, container){
    if(isMobileDevice()){$('#box-events-list').hide("fast");return;}
    if(zoomLevel <= 8 && $(window).height() > 594){
      $('#company-list').hide();
      $('#companies-header').hide();
      $('#box-events-list').fadeIn(500);
      $('#updates-company-list').html('');

      currentRequests.push($.getJSON($(container).data("recent_updates_url"), searchParams(), function(data) {
        $.each(data, function(i, group) {
          $.each(group, function(key, obj){
            $('#recent_update_tpl').tmpl(obj.recent_update).appendTo( $('#updates-company-list') );
          })
        });
      }));
     }
     else{
       $('#box-events-list').hide("fast");
    }
  }

  function updateRecentBox(){
    if(currentMap.getZoom() <= 8){

      if($(window).height() < 594){
        $('#box-events-list').hide("fast");
      }
      else{
        $('#company-list').hide();
        $('#companies-header').hide();
        $('#box-events-list').fadeIn(500);
      }
    }
  }

  function isMobileDevice(){
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
       return true;
    }
    return false;
  }

  function refreshFilterMenus(container) {
    var srcParams = searchParams();

    currentRequests.push($.getJSON($(container).data("employees_types_url"), srcParams, function(data) {
      var rangeLinks = "";
      $.each(data, function(i, employeeRange) {
        rangeLinks += "<li";
        if (employeeRange.id == srcParams.employee_id)
          rangeLinks += " class='active'";
        rangeLinks += "><a href='#' class='btn-employee' data-employee_id='"+employeeRange.id+"'>"+employeeRange.name+"</a></li>";
      });
      $('#employee-filter-menu').html(rangeLinks);
      setEmployeeMenuListener();
    }));

    currentRequests.push($.getJSON($(container).data("investments_types_url"), srcParams, function(data) {
      var investmentLinks = "";
      $.each(data, function(i, investmentRange) {
        investmentLinks += "<li";
        if (investmentRange.id == srcParams.investment_id)
          investmentLinks += " class='active'";
        investmentLinks += "><a href='#' class='btn-investment' data-investment_id='"+investmentRange.id+"'>"+investmentRange.name+"</a></li>";
      });
      $('#investment-filter-menu').html(investmentLinks);
      setInvestmentMenuListener();
    }));

    currentRequests.push($.getJSON($(container).data("categories_url"), srcParams, function(data) {
        var categoryLinks = "";
        $.each(data, function(i, category) {
          categoryLinks += "<li";
          if (category.id == srcParams.category_id)
            categoryLinks += " class='active'";
          categoryLinks += "><a href='#' class='btn-category' data-category_id='"+category.id+"'>"+category.name+"</a></li>";
        });
        $('#category-filter-menu').html(categoryLinks);
        setCategoryMenuListener();
    }));

    currentRequests.push($.getJSON($(container).data("tags_url"), srcParams, function(data) {
        var tagLinks = "";
        $.each(data, function(i, tag) {
            tagLinks += "<li";
          if (tag.code == srcParams.tag_code)
              tagLinks += " class='active'";
            tagLinks += "><a href='#' class='btn-tag' data-tag_code='"+tag.code+"'>"+tag.code+"</a></li>";
        });
        $('#tags-filter-menu').html(tagLinks);
        setTagMenuListener();
    }));
  }

  function refreshTags(container) {
    var srcParams = searchParams();

    currentRequests.push($.getJSON($(container).data("tags_url"), srcParams, function(data) {
      var tagLinks = "";
      $.each(data, function(i, tag) {
        if (tag.code == srcParams.tag_code) {
          tagLinks += "<a href='#' rel='2' data-tag_code=''><i class='icon-remove-sign'/></a>\n";
          tagLinks += "<a href='#' rel='"+tag.companies_count+"' data-tag_code='"+ tag.code +"' class ='selected-tag'>"+tag.code+"</a>\n";
        } else
          tagLinks += "<a href='#' rel='"+tag.companies_count+"' data-tag_code='"+ tag.code +"' >"+tag.code+"</a>\n";
      });
      $('#tag-cloud').html(tagLinks);
      configureTagCloud();
    }));
  }

  function clearCompanyOffices() {
    for (var i=0; i<nOffices; i++) {
      companyOfficesMarkers[i].setMap(null);
    }
    companyOfficesMarkers = new Array();
    nOffices = 0;
  }
  function clearZipcodeCircles() {
    for (var i=0; i<nZipcodeCircles; i++) {
      zipcodeCircles[i].setMap(null);
    }

    zipcodeCircles = new Array();
    nZipcodeCircles = 0;
  }
  function clearCountyCircles() {
    for (var i=0; i<nCountyCircles; i++) {
      countyCircles[i].setMap(null);
    }

    countyCircles = new Array();
    nCountyCircles = 0;
  }
  function clearCountryCircles() {
    for (var i=0; i<nCountryCircles; i++) {
      countryCircles[i].setMap(null);
    }

    countryCircles = new Array();
    nCountryCircles = 0;
  }
  function clearStatesCircles() {
    for (var i=0; i<nStateCircles; i++) {
      stateCircles[i].setMap(null);
    }

    stateCircles = new Array();
    nStateCircles = 0;
  }

  function closeCurrentInfoWindow() {
    if (currentInfoWindow) {
      currentInfoWindow.close();
    }
  }
  function drawCompanyOffices(container) {   
    currentRequests.push($.getJSON($(container).data("offices_url"), searchParams(), function(data) {
      
      companyOfficesMarkers = new Array();
      infoWindows = new Array();
      nOffices = 0;

      var companyList = $('#company-list');
      companyList.html("");
      $.each(data, function(i, company) {
        if(typeof(company["description"]) != "undefined" && company["description"] != null){
            company["description"] = company["description"].length < 160 ? company["description"]: company["description"].substring(0,157)+"..."
        }
        var content = $( "#gmap_info_window_tpl" ).tmpl( company ).html();
        var infowindow = new google.maps.InfoWindow({
          content: content
        });

        // var imageUrl = '/assets/'+company.category_marker_image;
        var imageUrl = company.category_marker_image;
        var markerImage = new google.maps.MarkerImage(
          imageUrl, new google.maps.Size(31, 42));

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(company.latitude, company.longitude),
          //draggable: false,
          title: company.name,
          icon: markerImage,
          map: currentMap
        });

        google.maps.event.addListener(marker, 'click', function() {
          closeCurrentInfoWindow();
          infowindow.open(currentMap,marker);
          currentInfoWindow = infowindow;
        });

        companyOfficesMarkers[nOffices] = marker;
        infoWindows[nOffices] = infowindow;
        nOffices++;
        company.marker_number = i+1;
        $('#company_tpl').tmpl(company).appendTo( companyList );

      });
      companyList.show();
      $('#companies-header').show();

      //open infowindow when company thumbnail is clicked
      $.each(companyOfficesMarkers, function(i, marker) {
        var thumb = $('#company'+(i+1));
        thumb.click(function() {
          $('#company-list div').removeClass('company-row-selected');
          $(this).addClass('company-row-selected');
          closeCurrentInfoWindow();
          infoWindows[i].open(currentMap,marker);
          currentInfoWindow = infoWindows[i];
        });
      });
    }));
  }

  function drawKickstarterCompanyOffices(container) {
    currentRequests.push($.getJSON($(container).data("offices_url"), searchParams(), function(data) {

      companyOfficesMarkers = new Array();
      infoWindows = new Array();
      nOffices = 0;

      var companyList = $('#company-list');
      companyList.html("");

      $.each(data, function(i, company) {
        if(typeof(company["description"]) != "undefined" && company["description"] != null){
            company["description"] = company["description"].length < 160 ? company["description"]: company.model["description"].substring(0,157)+"..."
        }
        var content = $( "#gmap_info_window_tpl" ).tmpl( company ).html();
        var infowindow = new google.maps.InfoWindow({
          content: content
        });

        var imageUrl = '/assets/kickstarter.png';
        var markerImage = new google.maps.MarkerImage(
          imageUrl, new google.maps.Size(31, 42));

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(company.latitude, company.longitude),
          //draggable: false,
          title: company.name,
          icon: markerImage,
          map: currentMap
        });

        google.maps.event.addListener(marker, 'click', function() {
          closeCurrentInfoWindow();
          infowindow.open(currentMap,marker);
          currentInfoWindow = infowindow;
        });

        companyOfficesMarkers[nOffices] = marker;
        infoWindows[nOffices] = infowindow;
        nOffices++;
        company.marker_number = i+1;
        $('#company_tpl').tmpl(company).appendTo( companyList );
      });
      companyList.show();
      $('#companies-header').show();

      //open infowindow when company thumbnail is clicked
      $.each(companyOfficesMarkers, function(i, marker) {
        var thumb = $('#company'+(i+1));
        thumb.click(function() {
          $('#company-list div').removeClass('company-row-selected');
          $(this).addClass('company-row-selected');
          closeCurrentInfoWindow();
          infoWindows[i].open(currentMap,marker);
          currentInfoWindow = infoWindows[i];
        });
      });
    }));
  }

  function drawCountySummaryBox(container) {
    var current_county_id = $('#search_params').data("current_county_id");
    if(current_county_id != "") {
        setCountySummaryBoxStyle("bottom-left-1");
        currentRequests.push($.getJSON($(container).data("county_url"), searchParams(), function(data) {
          drawRetrievedCountySummaryBox(data.county);
        }));
    }
  }

  function drawZipcodeSummaryBox(container) {
    var current_zipcode = $('#search_params').data("current_zipcode");
    if(current_zipcode != "") {
        setCountySummaryBoxStyle("bottom-left-1");
        currentRequests.push($.getJSON($(container).data("zipcode_url"), searchParams(), function(data) {
          drawRetrievedZipcodeSummaryBox(data.zipcode);
        }));
    }
  }
  function clearAllCircles(){
    clearCompanyOffices();
    clearCountryCircles();
    clearCountyCircles();
    clearStatesCircles();
    clearZipcodeCircles();
  }
  function drawCircles(container){
    clearAllCircles();
    if(zoomLevelMap[currentZoomLevel] == 'Zipcode'){
      drawCompanyOffices(container);
    }
    else if(zoomLevelMap[currentZoomLevel] == 'County'){
      drawZipcodeCircles(container);
    }
    else if(zoomLevelMap[currentZoomLevel] == 'State'){
      drawCountyCircles(container);
    }
    else if(zoomLevelMap[currentZoomLevel] == 'Country') {
      drawStateCircles(container);
    }
    else if (zoomLevelMap[currentZoomLevel] == 'World'){
      drawCountryCircles(container);
    }
  }
  function drawZipcodeCircles(container) {
    //$('h1').html('Tech Companies by County <small>(click, filter or pick to learn more)</small>');
    
    $("#search_params").data("current_zipcode", "");
    // County circles
    zipcodes = {};
    zipcodesMap = {};
    clearAllCircles();
    currentRequests.push($.getJSON($(container).data("zipcodes_url"), searchParams(), function(data) {

      //hide company list and flush companies results
      $('#company-list').hide();
      $('#companies-header').hide();

      //hide county and total boxes
      $('#box-summary-county').hide();
      $('#box-summary-total').hide();

      clearAllCircles();
      zipcodeCircles = new Array();
      nZipcodeCircles = 0;
      zipcodeLabels = new Array();
      var totalCompanies = 0;
      $.each(data, function(i, zipcode) {
        zipcodes[zipcode.id] = zipcode.name;
        zipcodesMap[zipcode.name] = zipcode.id

        if (zipcode.companies_numbers == 0) return;
        totalCompanies += zipcode.companies_numbers;
        var circlePosition = new google.maps.LatLng(zipcode.companies_avg_latitude, zipcode.companies_avg_longitude);
        var multiplier = zipcode.companies_percentage;
        if (multiplier<3.5) {
          multiplier = 3;
        }
        if (multiplier>30) {
          multiplier = 30;
        }
        var radius = 200*multiplier;
        var circleOptions = {
          strokeColor: '#ffffff',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: "#ee8485",
          fillOpacity: 0.6,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };

        zipcodeCircles[nZipcodeCircles] = new google.maps.Circle(circleOptions);

        if('ontouchend' in document) {
          google.maps.event.addListener(zipcodeCircles[nZipcodeCircles], 'click', function(e) {

            // if(bounceToCounty(zipcode.id)) return false;

            // if($("#box-summary-county").data("current_county_id") != zipcode.id) {
            //   setCountySummaryBoxStyle("bottom-left-2");
            //   drawRetrievedZipcodeSummaryBox(zipcode);
            // }
            // else {
            //   onZipcodeSelected(zipcode, circlePosition);
            // }
            
            $("#box-summary-county").data("current_zipcode", zipcode.code);
            onZipcodeSelected(zipcode, circlePosition);
          });
        }
        else {
          google.maps.event.addListener(zipcodeCircles[nZipcodeCircles], 'click', function() {
            $("#box-summary-county").data("current_zipcode", zipcode.code);
            onZipcodeSelected(zipcode, circlePosition);
          });
          google.maps.event.addListener(zipcodeCircles[nZipcodeCircles], 'mouseover', function() {
            setCountySummaryBoxStyle("bottom-left-2");
            drawRetrievedZipcodeSummaryBox(zipcode);
          });
          //remove county box when moouse goes out of the circle
          google.maps.event.addListener(zipcodeCircles[nZipcodeCircles], 'mouseout', function() {
            $('#box-summary-county').hide();
          });
        }
        nZipcodeCircles++;
      });

      // console.log('Called from drawZipcodeCircles.....')
      // updateCommunityManagerStats(container);

      //draw total summary box
      var boxSummaryTotal = $('#box-summary-total');
      boxSummaryTotal.html($('#total-box_tpl').tmpl({totalCompanies: totalCompanies}));
      boxSummaryTotal.addClass('well summary-box shadowed bottom-left-1');
      boxSummaryTotal.show();
    }));
  }
  function drawCountyCircles(container) {
    //$('h1').html('Tech Companies by County <small>(click, filter or pick to learn more)</small>');
    
    $("#search_params").data("current_county_id", "");
    // County circles
    counties = {};
    countiesMap = {};
    clearAllCircles();
    currentRequests.push($.getJSON($(container).data("counties_url"), searchParams(), function(data) {

      //hide company list and flush companies results
      $('#company-list').hide();
      $('#companies-header').hide();

      //hide county and total boxes
      $('#box-summary-county').hide();
      $('#box-summary-total').hide();

      clearAllCircles();
      countyCircles = new Array();
      nCountyCircles = 0;
      countyLabels = new Array();
      var totalCompanies = 0;
      $.each(data, function(i, county) {
        counties[county.id] = county.name;
        countiesMap[county.name] = county.id

        if (county.companies_numbers == 0) return;
        totalCompanies += county.companies_numbers;
        var circlePosition = new google.maps.LatLng(county.companies_avg_latitude, county.companies_avg_longitude);
        //var circlePosition = new google.maps.LatLng(county.latitude, county.longitude);
        var multiplier = county.companies_percentage;
        if (multiplier<3.5) {
          multiplier = 3;
        }
        if (multiplier>30) {
          multiplier = 30;
        }
        var radius = 1500*multiplier;
        var circleOptions = {
          strokeColor: '#ffffff',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: "#ee8485",
          fillOpacity: 0.6,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };

        countyCircles[nCountyCircles] = new google.maps.Circle(circleOptions);

        if('ontouchend' in document) {
          google.maps.event.addListener(countyCircles[nCountyCircles], 'click', function(e) {
            
            $("#box-summary-county").data("current_county_id", county.id);
            onCountySelected(county, circlePosition);
          });
        }
        else {
          google.maps.event.addListener(countyCircles[nCountyCircles], 'click', function() {
            console.log('========'+ county.id);
            $("#box-summary-county").data("current_county_id", county.id);
            onCountySelected(county, circlePosition);
          });
          google.maps.event.addListener(countyCircles[nCountyCircles], 'mouseover', function() {
            setCountySummaryBoxStyle("bottom-left-2");
            drawRetrievedCountySummaryBox(county);
          });
          //remove county box when moouse goes out of the circle
          google.maps.event.addListener(countyCircles[nCountyCircles], 'mouseout', function() {
            $('#box-summary-county').hide();
          });
        }
        nCountyCircles++;
      });
      // console.log('called from drawCountyCircles.......')
      // updateCommunityManagerStats(container);

      //draw total summary box
      var boxSummaryTotal = $('#box-summary-total');
      boxSummaryTotal.html($('#total-box_tpl').tmpl({totalCompanies: totalCompanies}));
      boxSummaryTotal.addClass('well summary-box shadowed bottom-left-1');
      boxSummaryTotal.show();
    }));
  }
  function drawStateCircles(container) {
    //$('h1').html('Tech Companies by County <small>(click, filter or pick to learn more)</small>');
    
    $("#search_params").data("current_county_id", "");
    // County circles
    states = {};
    statesMap = {};
    clearAllCircles();
    currentRequests.push($.getJSON($(container).data("states_url"), searchParams(), function(data) {

      //hide county and total boxes
      $('#box-summary-county').hide();
      $('#box-summary-total').hide();

      clearAllCircles();
      stateCircles = new Array();
      nStateCircles = 0;
      stateLabels = new Array();
      var totalCompanies = 0;
      $.each(data, function(i, state) {
        states[state.id] = state.name;
        statesMap[state.name] = state.id
        if (state.companies_numbers == 0) return;
        totalCompanies += state.companies_numbers;
        var circlePosition = new google.maps.LatLng(state.companies_avg_latitude, state.companies_avg_longitude);
        var multiplier = state.companies_percentage;
        if (multiplier<3.5) {
          multiplier = 3;
        }
        if (multiplier>30) {
          multiplier = 30;
        }
        var radius = 12000*multiplier;
        var circleOptions = {
          strokeColor: '#ffffff',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: "#ee8485",
          fillOpacity: 0.6,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };
        stateCircles[nStateCircles] = new google.maps.Circle(circleOptions);

        if('ontouchend' in document) {
          google.maps.event.addListener(stateCircles[nStateCircles], 'click', function(e) {
            // if($("#box-summary-county").data("state_name") != state.name) {
            //   setCountySummaryBoxStyle("bottom-left-2");
            //   drawRetrievedCountySummaryBox(state);
            // }
            // else {
            $("#search_params").data("current_state_name", state.name);
            onStateSelected(state, circlePosition);
            // }
          });
        }
        else {
          google.maps.event.addListener(stateCircles[nStateCircles], 'click', function() {
            $("#search_params").data("current_state_name", state.name);
            onStateSelected(state, circlePosition);
          });
          google.maps.event.addListener(stateCircles[nStateCircles], 'mouseover', function() {
            setCountySummaryBoxStyle("bottom-left-2");
            drawRetrievedCountySummaryBox(state);
          });
          //remove county box when moouse goes out of the circle
          google.maps.event.addListener(stateCircles[nStateCircles], 'mouseout', function() {
            $('#box-summary-county').hide();
          });
        }
        nStateCircles++;
      });
      // console.log('Called from drawStateCircles.....');
      // updateCommunityManagerStats(container);

      //draw total summary box
      var boxSummaryTotal = $('#box-summary-total');
      boxSummaryTotal.html($('#total-box_tpl').tmpl({totalCompanies: totalCompanies}));
      boxSummaryTotal.addClass('well summary-box shadowed bottom-left-1');
      boxSummaryTotal.show();
    }));
  }
  function drawCountryCircles(container) {
    //$('h1').html('Tech Companies by County <small>(click, filter or pick to learn more)</small>');
    $("#search_params").data("current_county_id", "");
    // County circles
    countries = {};
    countriesMap = {};
    clearAllCircles();
    currentRequests.push($.getJSON($(container).data("countries_url"), searchParams(), function(data) {

      //hide company list and flush companies results
      $('#company-list').hide();
      $('#companies-header').hide();

      //hide county and total boxes
      $('#box-summary-county').hide();
      $('#box-summary-total').hide();

      clearAllCircles();
      countryCircles = new Array();
      nCountryCircles = 0;
      countryLabels = new Array();
      var totalCompanies = 0;
      $.each(data, function(i, county) {
        countries[county.id] = county.name;
        countriesMap[county.name] = county.id

        if (county.companies_numbers == 0) return;
        totalCompanies += county.companies_numbers;
        var circlePosition = new google.maps.LatLng(county.companies_avg_latitude, county.companies_avg_longitude);
        //var circlePosition = new google.maps.LatLng(county.latitude, county.longitude);
        var multiplier = county.companies_percentage;
        if (multiplier<3.5) {
          multiplier = 3;
        }
        if (multiplier>30) {
          multiplier = 30;
        }
        var radius = 30000*multiplier;
        var circleOptions = {
          strokeColor: '#ffffff',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: "#ee8485",
          fillOpacity: 0.6,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };

        countryCircles[nCountryCircles] = new google.maps.Circle(circleOptions);

        // if('ontouchend' in document) {
        //   google.maps.event.addListener(countryCircles[nCountryCircles], 'click', function(e) {

        //     if(bounceToCounty(county.id)) return false;

        //     if($("#box-summary-county").data("current_county_id") != county.id) {
        //       setCountySummaryBoxStyle("bottom-left-2");
        //       drawRetrievedCountySummaryBox(county);
        //     }
        //     else {
        //       onCountySelected(county, circlePosition);
        //     }
        //   });
        // }
        // else {
        //   google.maps.event.addListener(countyCircles[nCountyCircles], 'click', function() {
        //     if(bounceToCounty(county.id)) return false;
        //     onCountySelected(county, circlePosition);
        //   });
        //   google.maps.event.addListener(countyCircles[nCountyCircles], 'mouseover', function() {
        //     setCountySummaryBoxStyle("bottom-left-2");
        //     drawRetrievedCountySummaryBox(county);
        //   });
        //   //remove county box when moouse goes out of the circle
        //   google.maps.event.addListener(countyCircles[nCountyCircles], 'mouseout', function() {
        //     $('#box-summary-county').hide();
        //   });
        // }
        nCountryCircles++;
      });
      // console.log('Called from drawCountryCircles.......');
      // updateCommunityManagerStats(container);

      //draw total summary box
      var boxSummaryTotal = $('#box-summary-total');
      boxSummaryTotal.html($('#total-box_tpl').tmpl({totalCompanies: totalCompanies}));
      boxSummaryTotal.addClass('well summary-box shadowed bottom-left-1');
      boxSummaryTotal.show();
    }));
  }
  /**
   * Hides county info box if current county != selected one.
   */
  function refreshForCurrentCounty() {

    var zoomLevel = currentMap.getZoom();

    // if(zoomLevel <= 8)
      // return;

    if(!counties)
      return;

    var currentCountyId = $("#box-summary-county").data("current_county_id");
    if(!currentCountyId)
      return;

    var currentCounty = counties[currentCountyId];
    if(!currentCounty)
      return;

    if(!GGeocoder)
      GGeocoder = new google.maps.Geocoder();

    var latlng = currentMap.getCenter();
    GGeocoder.geocode({'latLng': latlng}, function(results, status) {

      if (status == google.maps.GeocoderStatus.OK) {
        for(var i = 0, iLimit = results.length; i < iLimit; i++) {
          var result = results[i], types = result.types, iscounty = false;
          for(var j = 0, jLimit = types.length; j < jLimit; j++) {
            if(types[j] == "administrative_area_level_2") {
              iscounty = true;
              break;
            }
          }

          if(iscounty) {
            var boxSummaryCounty = $('#box-summary-county');

            if(result.formatted_address.toLowerCase().indexOf(currentCounty.toLowerCase()) == -1) {
              boxSummaryCounty.hide();
            }
            else {
              boxSummaryCounty.show();
            }

            break;
          }
        }
      }
    });
  }

  /**
   * Returns a random integer between min and max
   * Using Math.round() will give you a non-uniform distribution!
   */
  function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
  
  function onStateSelected(state, circlePosition) {
    //$('h1').html('Tech Companies in '+county.name);
    $("#search_params").data("state_name", state.name);

    $('#box-summary-total').hide();

    $('#tooltip').remove();

    //currentMap.setZoom(currentMap.getZoom()+1);
    currentMap.setCenter(circlePosition);
    currentMap.setZoom(stateZoomLevel);
  }

  function onZipcodeSelected(zipcode, circlePosition) {
    //$('h1').html('Tech Companies in '+county.name);
    $("#search_params").data("current_zipcode", zipcode.code);

    $('#box-summary-total').hide();

    $('#tooltip').remove();

    //currentMap.setZoom(currentMap.getZoom()+1);
    currentMap.setCenter(circlePosition);
    currentMap.setZoom(zipcodeZoomLevel);
  }

  function onCountySelected(county, circlePosition) {
    //$('h1').html('Tech Companies in '+county.name);
    $("#search_params").data("current_county_id", county.id);

    $('#box-summary-total').hide();

    // $('#tooltip').remove();

    //currentMap.setZoom(currentMap.getZoom()+1);
    currentMap.setCenter(circlePosition);
    currentMap.setZoom(countyZoomLevel);
  }

  function bounceToCounty(countyId) {
    if($('#search_params').data("hiring")) {
      window.open("/hiring?current_county_id=" + countyId, '_self');
      return true;
    } else {
      return false;
    }
  }

  function drawRetrievedZipcodeSummaryBox(zipcode, positionStyle) {
    var boxSummaryCounty = $('#box-summary-county');
    boxSummaryCounty.html($('#zipcode-box_tpl').tmpl(zipcode));
    boxSummaryCounty.show();
  }

  function drawRetrievedCountySummaryBox(county, positionStyle) {
    var boxSummaryCounty = $('#box-summary-county');
    boxSummaryCounty.html($('#county-box_tpl').tmpl(county));
    boxSummaryCounty.data("current_county_id", county.id);
    boxSummaryCounty.show();
  }

  function setCountySummaryBoxStyle(positionStyle) {
    $('#box-summary-county').attr("class","well summary-box shadowed "+positionStyle);
  }

  function searchParams() {
    var srcParamsEl = $('#search_params');
    search_params = {
        from_year: srcParamsEl.data("from_year"),
        to_year: srcParamsEl.data("to_year"),
        tag_code: srcParamsEl.data("tag_code"),
        current_county_id: srcParamsEl.data("current_county_id"),
	      kickstarter: srcParamsEl.data("kickstarter") ,
        hiring: srcParamsEl.data("hiring") ,
        raising_money: srcParamsEl.data("raising_money"),
        employee_id: srcParamsEl.data("employee_id"),
        investment_id: srcParamsEl.data("investment_id"),
        category_id: srcParamsEl.data("category_id"),
        company_name: srcParamsEl.data("company_name"),
        country_name: srcParamsEl.data("current_country_name"),
        state_name: srcParamsEl.data("current_state_name"),
        county_name: srcParamsEl.data('current_county_name'),
        zoom_level: zoomLevelMap[currentZoomLevel],
        current_zipcode: srcParamsEl.data('current_zipcode')


    }
    console.log("county name::" + search_params.county_name);
    return search_params;
  }


  function setSlider(){
    var srcParamsEl = $('#search_params');
	  var currentYear = new Date().getFullYear();
	  $( "#years_slider" ).slider({
		  range: true,
		  min: 1950,
		  max: currentYear,
		  values: [ 1950, currentYear ],
          slide: function( event, ui ) {
              $( "#years_range" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );

          },
          stop: function( event, ui ) {
            srcParamsEl.data("from_year", ui.values[ 0 ])
            srcParamsEl.data("to_year", ui.values[ 1])
            return $('.gmap').each(function() {
                return refreshMap(this);
            });
          }
      });
        $( "#years_range" ).html( $( "#years_slider" ).slider( "values", 0 ) +
            " - " + $( "#years_slider" ).slider( "values", 1 ) );
  }

  function setKickstarterListener(){
    var searchParams = $('#search_params');
      $('a.btn-kickstarter').click(function(e){
          e.preventDefault();
          if($(this).is('.active')) {
            $(this).removeClass("active");
            searchParams.data("kickstarter", "");
            $('.gmap').each(function() {
              refreshMap(this);
            });
          } else {
            $(this).addClass("active");
            searchParams.data("kickstarter", true);
          
	    $('.gmap').each(function() {
    	      $('#box-summary-total').hide();
	      $('#tooltip').remove();
	      $('#box-events-list').hide("fast");
          
      	      clearCountyCircles();
              // clearCompanyOffices();
              drawKickstarterCompanyOffices(this);
              refreshFilterMenus(this);
            });
	  }
      });
  }

  function setHiringListener(){
    var searchParams = $('#search_params');
    $('a.btn-hiring').click(function(e){
        e.preventDefault();
        if($(this).is('.active')) {
          $(this).removeClass("active");
          searchParams.data("hiring", "");
        } else {
          $(this).addClass("active");
          searchParams.data("hiring", true);
        }
        $('.gmap').each(function() {
          refreshMap(this);
        });
    });
  }

  function setMoneyRaisingFilter(){
    var searchParams = $('#search_params');
    $('a.btn-raising-money').click(function(e){
        e.preventDefault();
        if($(this).is('.active')) {
          $(this).removeClass("active");
          searchParams.data("raising_money", "");
        } else {
          $(this).addClass("active");
          searchParams.data("raising_money", true);
        }
        $('.gmap').each(function() {
          refreshMap(this);
        });
    });
  }
  
  function setCategoryNameListener() {
      $('#search_form').on('submit', function(e){
          e.preventDefault();
          var searchParams = $('#search_params');
          searchParams.data("company_name", $('#search_query').val());
          $('.gmap').each(function() {
            refreshMap(this);
          });
      });
  }

  function setEmployeeMenuListener() {
    var searchParams = $('#search_params');
    $('#employee-filter-menu a.btn-employee').click(function(e){
      e.preventDefault();
      if($(this).parent().is('.active')) {
        $(this).parent().removeClass("active");
        $('.btn-employee-group a.btn').removeClass("active");
        searchParams.data("employee_id", "");
      } else {
        $('.btn-employee-group a.btn').addClass("active");
        $('#employee-filter-menu li').removeClass("active");
        $(this).parent().addClass("active");
        searchParams.data("employee_id", $(this).data("employee_id"));
      }
      $('.gmap').each(function() {
        refreshMap(this);
      });
    });
  }

  function setInvestmentMenuListener() {
    var searchParams = $('#search_params');
    $('#investment-filter-menu a.btn-investment').click(function(e){
      e.preventDefault();
      if($(this).parent().is('.active')) {
        $(this).parent().removeClass("active");
        $('.btn-investment-group a.btn').removeClass("active");
        searchParams.data("investment_id", "");
      } else {
        $('.btn-investment-group a.btn').addClass("active");
        $('#investment-filter-menu li').removeClass("active");
        $(this).parent().addClass("active");
        searchParams.data("investment_id", $(this).data("investment_id"));
      }
      $('.gmap').each(function() {
        refreshMap(this);
      });
    });
  }

  function setCategoryMenuListener() {
    var searchParams = $('#search_params');
    $('#category-filter-menu a.btn-category').click(function(e){
      e.preventDefault();
      if($(this).parent().is('.active')) {
        $(this).parent().removeClass("active");
        $('.btn-category-group a.btn').removeClass("active");
        searchParams.data("category_id", "");
      } else {
        $('.btn-category-group a.btn').addClass("active");
        $('#category-filter-menu li').removeClass("active");
        $(this).parent().addClass("active");
        searchParams.data("category_id", $(this).data("category_id"));
      }
      $('.gmap').each(function() {
        refreshMap(this);
      });
    });
  }

  function setTagMenuListener() {
      var searchParams = $('#search_params');
      $('#tags-filter-menu a.btn-tag').click(function(e){
        e.preventDefault();
        if($(this).parent().is('.active')) {
          $(this).parent().removeClass("active");
          $('.btn-tags-group a.btn').removeClass("active");
          searchParams.data("tag_code", "");
        } else {
          $('.btn-tags-group a.btn').addClass("active");
          $('#tags-filter-menu li').removeClass("active");
          $(this).parent().addClass("active");
          searchParams.data("tag_code", $(this).data("tag_code"));
        }
        $('.gmap').each(function() {
          refreshMap(this);
        });
      });
    }

  function setEventsBarListener() {
      var accordion = $('#events_bar .events-accordion'), eventList = $('#events_bar ul.event-list');
      var height = eventList.outerHeight(true);
      accordion.css({height: height + "px"});
      eventList.css({height: height + "px"});

      $('.gmap_wrapper, #company-list').css({top: (45 + height) + "px"});

      $('#events_bar .bar_title .title, #events_bar #events_switch').click(function(e){
        e.preventDefault();
        $('#box-events-list').hide("fast");
        if(!accordion.height()) {
          accordion.animate({height: height + "px"}, 250);
          $('.gmap_wrapper, #company-list').animate({top: (45 + height) + "px"}, 250);

          $("#events_bar #events_switch img").attr("src", "assets/close.png");
        }
        else {
          accordion.animate({height: "0px"}, 250);
          $('.gmap_wrapper, #company-list').animate({top: 45 + "px"}, 250);

          $("#events_bar #events_switch img").attr("src", "assets/open.png");
        }
      });
    }

  // This method will update the bottom lists of home page
  // It will fetch the data for all of the lists for a particular county
  function updateBottomLists(container){
    $('.loader-div').show();
    $('.freelancers-list-contents').html("");
    $('.job-list-contents ul').html('');
    $('.events-list-contents ul').html('');
    $('.new-companies-list-contents').html('');
    $('.buttons-list').hide();
    $('#county-info .manager-holder').html('');
    console.log('---');
    console.log($(container).data("bottom_list_url"));
    currentRequests.push($.getJSON($(container).data("bottom_list_url"), searchParams(), function(data) {
      console.log('Got data for bottom lists.....');
      $.each(data, function(i, group) {
        console.log('Checking i::::' + i);
        console.log('Checking...' + group);
        console.log(data);
        switch(i){
          case 'freelancers':
            $('.freelancers-list-contents').html("");
            if(group == null){
              $("<p>Hmmm..., there are no freelancers in the region you are following. Try following more regions.</p>").appendTo( $('.freelancers-list-contents') );
            }
            else{
              $.each(group, function(key, obj){
                $('#freelancer_tpl').tmpl(obj.freelancer).appendTo( $('.freelancers-list-contents') );
              })
            }
            break;
          
          case 'jobs':
            $('.job-list-contents ul').html('');
            if(group == null){
              $("<p>Hmmm..., there are no jobs in the region you are following. Try following more regions.</p>").appendTo( $('.job-list-contents ul') );
            }
            else{
              $.each(group, function(key, obj){
                $('#job_tpl').tmpl(obj.job).appendTo( $('.job-list-contents ul') );  
              })
            }
            break;

          case 'events':
            $('.events-list-contents ul').html('');
            if(group == null || group.length == 0){
              $("<p>Hmmm..., there are no events in the region you are following. Try following more regions.</p>").appendTo( $('.events-list-contents ul') );
            }
            else{
              $.each(group, function(key, obj){
                $('#event_tpl').tmpl(obj.event).appendTo( $('.events-list-contents ul') );
              })
            }
            break;

          case 'companies':
            $('.new-companies-list-contents').html('');
            if(group == null){
              $("<p>Hmmm..., there are no companies in the region you are following. Try following more regions.</p>").appendTo( $('.new-companies-list-contents') );
            }
            else{
              $.each(group, function(key, obj){
                $('#company_bottom_tpl').tmpl(obj.company).appendTo( $('.new-companies-list-contents') );  
              })
            }
            break;
          case 'community_manager':
            if(group == null){break;}
            $('#county-info .manager-holder').html('');
            $('#company_manager_tpl').tmpl(group).appendTo( $('#county-info .manager-holder') );  
            break;
        }
        console.log('Hiding loader div.........' + i);
        $('.loader-div').hide();
        $('.buttons-list').show();
      })
    }))
    console.log('called from updateBottomLists......')
    updateCommunityManagerStats(container);
  }

  // Will update the zoom level, currenty county id etc on map
  function updateCommunityManagerStats(container){
    if(!GGeocoder)
      GGeocoder = new google.maps.Geocoder();

    // Find current county id which is on the center of current map.
    var latlng = currentMap.getCenter();
    $('#county-info .stats').hide();
    // $('#county-info .loader-div').show();
    GGeocoder.geocode({'latLng': latlng}, function(results, status) {
      console.log('Updating community_manager stats...')
      if (status == google.maps.GeocoderStatus.OK) {
        for(var i = 0, iLimit = results.length; i < iLimit; i++) {
          console.log(results);
          var result = results[i], types = result.types, iscounty = false;
          for(var j = 0, jLimit = types.length; j < jLimit; j++) {
            // if county
            if(types[j] == "administrative_area_level_2") {
              iscounty = true;
              //Upate current county id.
              $("#search_params").data("current_county_id", countiesMap[result.address_components[0].long_name])
              $("#search_params").data("current_county_name", result.address_components[0].long_name.replace(" County", ""))
              $('#county-name').text($("#search_params").data("current_county_name"))
              // break;
            }
            // if state
            if(types[j] == "administrative_area_level_1") {
              $("#search_params").data("current_state_name", result.address_components[0].long_name)
              $('#state-name').text($("#search_params").data("current_state_name"))
            }
            // if country
            if(types[j] == "country") {
              $("#search_params").data("current_country_name", result.address_components[0].long_name)
              $('#country-name').text($("#search_params").data("current_country_name"))
            }
            if(types[j] == 'postal_code'){
              $("#search_params").data("current_zipcode", result.address_components[0].long_name) 
              $('#zipcode-name').text($("#search_params").data("current_zipcode"))
            }
          }
        }
        // console.log('Called from update community_manager stats.....')
        // updateBottomLists(container);
        $('#county-info .stats').show();
        $('#county-info .loader-div').hide();
        thingToFollow();
        updateFollowObject(container);
      }
    });
    $('#zoom-level').text(zoomLevelMap[currentZoomLevel])
  }
  function updateFollowObject(container){
    currentRequests.push($.getJSON($(container).data("is_following_url"), searchParams(), function(data) {
      if(data.is_following){
        $('#follow').addClass('followed');
        $('#follow').removeClass('shadowed');
        $('#follow').find('p').text('following');
        $('#follow').unbind('click');
      }
      else{
        $('#follow').addClass('shadowed');
        $('#follow').removeClass('followed');
        $('#follow').find('p').text('follow');
        followSomething(container);
      }
    }));
  }
  function thingToFollow(){
    level = zoomLevelMap[currentZoomLevel];
    switch(level){
      case 'World' : 
        $('#thing-to-follow').find('p').text($("#search_params").data("current_country_name"));
        break;
      case 'Country' :
        $('#thing-to-follow').find('p').text($("#search_params").data("current_state_name"));
        break;
      case 'State' :
        $('#thing-to-follow').find('p').text($("#search_params").data("current_county_name"));
        break;
      case 'County' :
        $('#thing-to-follow').find('p').text($("#search_params").data("current_zipcode"));
        break;
    }
  }
  function followSomething(container){
    $('#follow').click(function(){
      $(this).addClass('followed');
      $(this).removeClass('shadowed');
      $(this).find('p').text('following');
      currentRequests.push($.post($(container).data("follow_url"), searchParams(), function(data){
        console.log('Added to interest Feed.')
      }));
    });
  }
  // Main
  $(function () {

    $('#tooltip').css("left", (document.body.offsetWidth / 2 - 344) + "px");

    return $('.gmap').each(function() {
      setSlider();
      setKickstarterListener();
      setHiringListener();
      setMoneyRaisingFilter();
      setEmployeeMenuListener();
      setInvestmentMenuListener();
      setCategoryMenuListener();
      setCategoryNameListener();
      setTagMenuListener();
      setEventsBarListener();
      return GMap.init(this);
    });
  });

}).call(this);

(function(){
  $('.bottom-boards .header').click(function(){
    console.log('clicked....');
    console.log($(this).parent().find('.list-cntnts'));
    $(this).parent().find('.list-cntnts').slideToggle();
  })
}).call(this);
