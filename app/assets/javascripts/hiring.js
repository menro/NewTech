(function() {

  function refreshTable(container) {
    // Retrieve and draw the data
    $.getJSON($(container).data("jobs_url"), searchParams(), function(data) {
      var jobList = $('#jobs_list tbody');
      jobList.html("");
      if(data.length) {
        $.each(data, function(i, job) {
          $('#jobs-list-item_tpl').tmpl(job).appendTo( jobList );
        });
      } else {
        $('#jobs-list-empty_tpl').tmpl({}).appendTo( jobList );
      }
    });
  }

  function searchParams() {
    var srcParamsEl = $('#search_params');
    return {
        hiring:             true,
        from_year:          srcParamsEl.data("from_year"),
        to_year:            srcParamsEl.data("to_year"),
        title:              srcParamsEl.data("title"),
        skill_name:         srcParamsEl.data("skill_name"),
        employee_id:        srcParamsEl.data("employee_id"),
        investment_id:      srcParamsEl.data("investment_id"),
        category_id:        srcParamsEl.data("category_id"),
        kind:               srcParamsEl.data("kind"),
        role:               srcParamsEl.data("role"),
        current_county_id:  srcParamsEl.data("current_county_id")
    };
  }

  function setYearsSlider(){
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
            $('.jobs-table').each(function() {
              refreshTable(this);
            });
          }
      });
        $( "#years_range" ).html( $( "#years_slider" ).slider( "values", 0 ) +
            " - " + $( "#years_slider" ).slider( "values", 1 ) );
  }

  function setSearchListener() {
      $('#search_form').on('submit', function(e){
          e.preventDefault();
          var searchParams = $('#search_params');
          searchParams.data("title", $('#search_query').val());
          $('.jobs-table').each(function() {
            refreshTable(this);
          });
      });
  }

  function setEmployeeMenuListener() {
    var searchParams = $('#search_params');
    $('#employee-filter-menu a.btn-employee').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-employee-group a.btn').removeClass("active");
        searchParams.data("employee_id", "");
      } else {
        $('.btn-employee-group a.btn').addClass("active");
        $('#employee-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("employee_id", $(this).data("employee_id"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

  function setInvestmentMenuListener() {
    var searchParams = $('#search_params');
    $('#investment-filter-menu a.btn-investment').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-investment-group a.btn').removeClass("active");
        searchParams.data("investment_id", "");
      } else {
        $('.btn-investment-group a.btn').addClass("active");
        $('#investment-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("investment_id", $(this).data("investment_id"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

  function setCategoryMenuListener() {
    var searchParams = $('#search_params');
    $('#category-filter-menu a.btn-category').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-category-group a.btn').removeClass("active");
        searchParams.data("category_id", "");
      } else {
        $('.btn-category-group a.btn').addClass("active");
        $('#category-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("category_id", $(this).data("category_id"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

  function setSkillMenuListener() {
      var searchParams = $('#search_params');
      $('#skills-filter-menu a.btn-skill').click(function(e){
        e.preventDefault();
        if($(this).closest('li').hasClass('active')) {
          $(this).closest('li').removeClass("active");
          $('.btn-skill-group a.btn').removeClass("active");
          searchParams.data("skill_name", "");
        } else {
          $('.btn-skill-group a.btn').addClass("active");
          $('#skills-filter-menu li').removeClass("active");
          $(this).closest('li').addClass("active");
          searchParams.data("skill_name", $(this).data("skill_name"));
        }
        $('.jobs-table').each(function() {
          refreshTable(this);
        });
      });
    }

  function setKindMenuListener() {
    var searchParams = $('#search_params');
    $('#kind-filter-menu a.btn-kind').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-kind-group a.btn').removeClass("active");
        searchParams.data("kind", "");
      } else {
        $('.btn-kind-group a.btn').addClass("active");
        $('#kind-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("kind", $(this).data("kind"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

  function setRoleMenuListener() {
    var searchParams = $('#search_params');
    $('#role-filter-menu a.btn-role').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-role-group a.btn').removeClass("active");
        searchParams.data("role", "");
      } else {
        $('.btn-role-group a.btn').addClass("active");
        $('#role-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("role", $(this).data("role"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

  function setCountyMenuListener() {
    var searchParams = $('#search_params');
    $('#county-filter-menu a.btn-county').click(function(e){
      e.preventDefault();
      if($(this).closest('li').hasClass('active')) {
        $(this).closest('li').removeClass("active");
        $('.btn-county-group a.btn').removeClass("active");
        searchParams.data("current_county_id", "");
      } else {
        $('.btn-county-group a.btn').addClass("active");
        $('#county-filter-menu li').removeClass("active");
        $(this).closest('li').addClass("active");
        searchParams.data("current_county_id", $(this).data("county_id"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

    // Main
    $(function () {
      return $('.jobs-table').each(function() {
        setYearsSlider();
        setEmployeeMenuListener();
        setInvestmentMenuListener();
        setCategoryMenuListener();
        setSearchListener();
        setSkillMenuListener();
        setRoleMenuListener();
        setKindMenuListener();
        setCountyMenuListener();
        refreshTable(this);
      });
    });

}).call(this);
