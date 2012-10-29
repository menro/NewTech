(function() {
  var GMap;

  var currentMap;

  var companyOfficesMarkers;
  var nOffices = 0;
  var infoWindows;
  var currentInfoWindow;

  var countyCircles;
  var nCountyCircles = 0;
  var countyLabels;
  var countyZoomLevel = 11; //PROVVISORIO - dovrei prendere il nro appropriato da county.map_zoom_level

  GMap = (function() {

    function GMap(container) {

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
        minZoom: 7,
        zoom: 8,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles:
          [
            {
              "elementType": "geometry.fill",
              "stylers": [
                { "color": "#ffffff" },
                { "visibility": "on" }
              ]
            },{
            "featureType": "road.highway",
            "elementType": "geometry.stroke",
            "stylers": [
              { "visibility": "on" }
            ]
          },{
            "featureType": "road.highway",
            "elementType": "geometry.fill",
            "stylers": [
              { "color": "#ffffff" }
            ]
          },{
          }
          ],
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
      clearCountyCircles();
      drawCountyCircles(container);
    } else {
      clearCountyCircles();
      clearCompanyOffices();
      drawCompanyOffices(container);
      drawCountySummaryBox(container)
    }
    //refreshTags(container);
    refreshFilterMenus(container);
  }

  function refreshFilterMenus(container) {
    var srcParams = searchParams();
    $.getJSON($(container).data("employees_types_url"), srcParams, function(data) {
      var rangeLinks = "";
      $.each(data, function(i, employeeRange) {
        rangeLinks += "<li";
        if (employeeRange.id == srcParams.employee_id)
          rangeLinks += " class='active'";
        rangeLinks += "><a href='#' class='btn-employee' data-employee_id='"+employeeRange.id+"'>"+employeeRange.name+"</a></li>";
      });
      $('#employee-filter-menu').html(rangeLinks);
      setEmployeeMenuListener();
    });
    $.getJSON($(container).data("investments_types_url"), srcParams, function(data) {
      var investmentLinks = "";
      $.each(data, function(i, investmentRange) {
        investmentLinks += "<li";
        if (investmentRange.id == srcParams.investment_id)
          investmentLinks += " class='active'";
        investmentLinks += "><a href='#' class='btn-investment' data-investment_id='"+investmentRange.id+"'>"+investmentRange.name+"</a></li>";
      });
      $('#investment-filter-menu').html(investmentLinks);
      setInvestmentMenuListener();
    });
    $.getJSON($(container).data("categories_url"), srcParams, function(data) {
        var categoryLinks = "";
        $.each(data, function(i, category) {
          categoryLinks += "<li";
          if (category.id == srcParams.category_id)
            categoryLinks += " class='active'";
          categoryLinks += "><a href='#' class='btn-category' data-category_id='"+category.id+"'>"+category.name+"</a></li>";
        });
        $('#category-filter-menu').html(categoryLinks);
        setCategoryMenuListener();
    });
    $.getJSON($(container).data("tags_url"), srcParams, function(data) {
        var tagLinks = "";
        $.each(data, function(i, tag) {
            tagLinks += "<li";
          if (tag.code == srcParams.tag_code)
              tagLinks += " class='active'";
            tagLinks += "><a href='#' class='btn-tag' data-tag_code='"+tag.code+"'>"+tag.code+"</a></li>";
        });
        $('#tags-filter-menu').html(tagLinks);
        setTagMenuListener();
    });
  }

  function refreshTags(container) {
    var srcParams = searchParams();
    $.getJSON($(container).data("tags_url"), srcParams, function(data) {
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
    });
  }

  function configureTagCloud() {
    var tagCloudLink = $('#tag-cloud a');
    tagCloudLink.tagcloud({
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
    tagCloudLink.click(function() {
      //highlight
      tagCloudLink.removeClass('selected-tag');
      $(this).addClass('selected-tag');

      var tag_code = $(this).data("tag_code");
      $('#search_params').data("tag_code", tag_code);
      $('.gmap').each(function() {
        refreshMap(this);
      });
    });
  }

  function clearCompanyOffices() {
    for (var i=0; i<nOffices; i++) {
      companyOfficesMarkers[i].setMap(null);
    }
  }

  function clearCountyCircles() {
    for (var i=0; i<nCountyCircles; i++) {
      countyCircles[i].setMap(null);
    }
  }

  function closeCurrentInfoWindow() {
    if (currentInfoWindow) {
      currentInfoWindow.close();
    }
  }

  function drawCompanyOffices(container) {
    $.getJSON($(container).data("offices_url"), searchParams(), function(data) {
      companyOfficesMarkers = new Array();
      infoWindows = new Array();
      nOffices = 0;

      $('#company-list').html("");
      $.each(data, function(i, company) {
        var html = ''
          +'<div class="content well">'
          //+'<img src="'+office.image_url+'" alt="" />'
          +'<h1>'+company.name+'</h1>'
          +'<p><a href="'+company.homepage_url+'" target="_blank">'+company.homepage_url+'</a></p>';
        var field = company.facebook;
        if (field != null) html += '<p><b>Facebook: </b><a href="'+field+'" target="_blank">'+field+'</a></p>'
        field = company.twitter;
        if (field != null) html += '<p><b>Twitter: </b><a href="'+field+'" target="_blank">'+field+'</a></p>'
        field = company.founded_year;
        if (field != null) html += '<p><b>Year founded: </b>'+field+'</p>';
        field = company.number_of_employees;
        if (field != null) html += '<p><b>Number of employees: </b>'+field+'</p>';
        field = company.tags_list;
        if (field != null && field != '') html += '<p><b>Tags: </b>'+field+'</p>';
        field = company.description;
        if (field != null) html += '<p>'+field+'</p>';
        html += '</div>';
        var infowindow = new google.maps.InfoWindow({
          content: html
        });

        var imageUrl = '/assets/'+company.category_marker_image;
        var markerImage = new google.maps.MarkerImage(
          imageUrl, new google.maps.Size(31, 42));

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(company.latitude, company.longitude),
          //draggable: false,
          title: company.name,
          icon: markerImage,
          map: currentMap
        });
        //console.log("marker");
        //console.log(marker);
        google.maps.event.addListener(marker, 'click', function() {
          closeCurrentInfoWindow();
          infowindow.open(currentMap,marker);
          currentInfoWindow = infowindow;
        });

        companyOfficesMarkers[nOffices] = marker;
        infoWindows[nOffices] = infowindow;
        nOffices++;
        company.marker_number = i+1;
        $('#company_tpl').tmpl(company).appendTo( $('#company-list') );

      });
      var companyList = $('#company-list');
      companyList.show();

      //open infowindow when company thumbnail is clicked
      $.each(companyOfficesMarkers, function(i, marker) {
        var thumb = $('#company'+(i+1));
        thumb.click(function() {
          $('#company-list div').removeClass('company-row-selected');
          $(this).addClass('company-row-selected');
          //console.log(i);
          closeCurrentInfoWindow();
          infoWindows[i].open(currentMap,marker);
          currentInfoWindow = infoWindows[i];
        });
      });
    });

  }

  function drawCountySummaryBox(container) {
    setCountySummaryBoxStyle("bottom-left-1");
    $.getJSON($(container).data("county_url"), searchParams(), function(data) {
      drawRetrievedCountySummaryBox(data.county);
    });
  }

  function drawCountyCircles(container) {
    //$('h1').html('Tech Companies by County <small>(click, filter or pick to learn more)</small>');
    $("#search_params").data("current_county_id", "");
    // County circles
    $.getJSON($(container).data("counties_url"), searchParams(), function(data) {

      //hide company list and flush companies results
      $('#company-list').hide();
      //$('.gmap').each(function() {
      //  $(this).css('width', '100%');
      //});

      //hide county and total boxes
      $('#box-summary-county').hide();
      $('#box-summary-total').hide();

      countyCircles = new Array();
      nCountyCircles = 0;
      countyLabels = new Array();
      var colors = ["#bdc4ca", "#9da9a0", "#cdc9b6", "#8ca5b6", "#e7db59", "#fbd5b5", "#eeb949", "#b8b8d3"];
      var totalCompanies = 0;
      $.each(data, function(i, county) {
        if (county.offices_numbers == 0) return;
        totalCompanies += county.offices_numbers;
        var circlePosition = new google.maps.LatLng(county.companies_avg_latitude, county.companies_avg_longitude);
        //var circlePosition = new google.maps.LatLng(county.latitude, county.longitude);
        var multiplier = county.offices_percentage;
        if (multiplier<5) {
          multiplier *= 2;
        }
        if (multiplier>20) {
          multiplier /= 1.5;
        }
        var radius = 1500*multiplier;
        var color = colors[getRandomInt(1,8)-1];
        var circleOptions = {
          strokeColor: '#ffffff',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: color,
          fillOpacity: 0.6,
          map: currentMap,
          center: circlePosition,
          radius: radius
        };
        countyCircles[nCountyCircles] = new google.maps.Circle(circleOptions);
        google.maps.event.addListener(countyCircles[nCountyCircles], 'click', function() {
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
        nCountyCircles++;
      });

      //draw total summary box
      var boxSummaryTotal = $('#box-summary-total');
      boxSummaryTotal.html($('#total-box_tpl').tmpl({totalCompanies: totalCompanies}));
      boxSummaryTotal.addClass('well summary-box shadowed bottom-left-1');
      boxSummaryTotal.show();
    });
  }

  /**
   * Returns a random integer between min and max
   * Using Math.round() will give you a non-uniform distribution!
   */
  function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  function onCountySelected(county, circlePosition) {
    //$('h1').html('Tech Companies in '+county.name);
    $("#search_params").data("current_county_id", county.id);

    $('#box-summary-total').hide();

    //currentMap.setZoom(currentMap.getZoom()+1);
    currentMap.setCenter(circlePosition);
    currentMap.setZoom(countyZoomLevel);
  }

  function drawRetrievedCountySummaryBox(county, positionStyle) {
    var boxSummaryCounty = $('#box-summary-county');
    boxSummaryCounty.html($('#county-box_tpl').tmpl(county));
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
        hiring: srcParamsEl.data("hiring") ,
        employee_id: srcParamsEl.data("employee_id"),
        investment_id: srcParamsEl.data("investment_id"),
        category_id: srcParamsEl.data("category_id"),
        company_name: srcParamsEl.data("company_name")
    }
    return search_params;
  }

  $(function() {
    var srcParamsEl = $('#search_params');
    $( "#years_slider" ).slider({
        range: true,
        min: 1950,
        max: 2012,
        values: [ 1950, 2012 ],
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

    return $('.gmap').each(function() {
        return GMap.init(this);
    });
  });

  $(function () {
    configureTagCloud();

    var searchParams = $('#search_params');
    $('.bottom_filters a.btn-hiring').click(function(e){
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

    setEmployeeMenuListener();
    setInvestmentMenuListener();
    setCategoryMenuListener();
    setcategoryNameListener();
    setTagMenuListener();
  });

  function setcategoryNameListener() {
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
        $('.bottom_filters .btn-employee-group a.btn').removeClass("active");
        searchParams.data("employee_id", "");
      } else {
        $('.bottom_filters .btn-employee-group a.btn').addClass("active");
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
        $('.bottom_filters .btn-investment-group a.btn').removeClass("active");
        searchParams.data("investment_id", "");
      } else {
        $('.bottom_filters .btn-investment-group a.btn').addClass("active");
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
        $('.bottom_filters .btn-category-group a.btn').removeClass("active");
        searchParams.data("category_id", "");
      } else {
        $('.bottom_filters .btn-category-group a.btn').addClass("active");
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
          $('.bottom_filters .btn-tags-group a.btn').removeClass("active");
          searchParams.data("tag_code", "");
        } else {
          $('.bottom_filters .btn-tags-group a.btn').addClass("active");
          $('#tags-filter-menu li').removeClass("active");
          $(this).parent().addClass("active");
          searchParams.data("tag_code", $(this).data("tag_code"));
        }
        $('.gmap').each(function() {
          refreshMap(this);
        });
      });
    }
}).call(this);
