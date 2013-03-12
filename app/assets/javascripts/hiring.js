(function() {

  function refreshTable(container) {
    drawTable(container);
    //refreshTags(container);
    refreshFilterMenus(container);
  }

  function drawTable(container) {
    // Retrieve and draw the data
    $.getJSON($(container).data("jobs_url"), searchParams(), function(data) {
      var jobList = $('#jobs_list tbody');
      jobList.html("");
      $.each(data, function(i, job) {
        $('#jobs-list-item_tpl').tmpl(job).appendTo( jobList );
      });
    });
  }

  function refreshFilterMenus(container) {
    var srcParams = searchParams();
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
    $.getJSON($(container).data("job_kinds_url"), srcParams, function(data) {
      var kindLinks = "";
      $.each(data, function(i, kind) {
        kindLinks += "<li";
        if (kind.id == srcParams.kind)
          kindLinks += " class='active'";
        kindLinks += "><a href='#' class='btn-kind' data-kind_id='"+kind.id+"'>"+kind.name+"</a></li>";
      });
      $('#kind-filter-menu').html(kindLinks);
      setKindMenuListener();
    });
    $.getJSON($(container).data("job_roles_url"), srcParams, function(data) {
      var roleLinks = "";
      $.each(data, function(i, role) {
        roleLinks += "<li";
        if (role.id == srcParams.role)
          roleLinks += " class='active'";
        roleLinks += "><a href='#' class='btn-kind' data-kind_id='"+role.id+"'>"+role.name+"</a></li>";
      });
      $('#role-filter-menu').html(roleLinks);
      setRoleMenuListener();
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

  function searchParams() {
    var srcParamsEl = $('#search_params');
    search_params = {
        tag_code: srcParamsEl.data("tag_code"),
        employee_id: srcParamsEl.data("employee_id"),
        investment_id: srcParamsEl.data("investment_id"),
        category_id: srcParamsEl.data("category_id"),
        job_kind: srcParamsEl.data("job_kind"),
        job_role: srcParamsEl.data("job_role")
    }
    return search_params;
  }

  function setCategoryNameListener() {
      $('#search_form').on('submit', function(e){
          e.preventDefault();
          var searchParams = $('#search_params');
          searchParams.data("company_name", $('#search_query').val());
          $('.jobs-table').each(function() {
            refreshTable(this);
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
      $('.jobs-table').each(function() {
        refreshTable(this);
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
      $('.jobs-table').each(function() {
        refreshTable(this);
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
      $('.jobs-table').each(function() {
        refreshTable(this);
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
        $('.jobs-table').each(function() {
          refreshTable(this);
        });
      });
    }

  function setKindMenuListener() {
    var searchParams = $('#search_params');
    $('#kind-filter-menu a.btn-kind').click(function(e){
      e.preventDefault();
      if($(this).parent().is('.active')) {
        $(this).parent().removeClass("active");
        $('.btn-kind a.btn').removeClass("active");
        searchParams.data("job_kind", "");
      } else {
        $('.btn-kind a.btn').addClass("active");
        $('#kind-filter-menu li').removeClass("active");
        $(this).parent().addClass("active");
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
      if($(this).parent().is('.active')) {
        $(this).parent().removeClass("active");
        $('.btn-role a.btn').removeClass("active");
        searchParams.data("job_role", "");
      } else {
        $('.btn-role a.btn').addClass("active");
        $('#role-filter-menu li').removeClass("active");
        $(this).parent().addClass("active");
        searchParams.data("role", $(this).data("role"));
      }
      $('.jobs-table').each(function() {
        refreshTable(this);
      });
    });
  }

    // Main
    $(function () {
      setEmployeeMenuListener();
      setInvestmentMenuListener();
      setCategoryMenuListener();
      setCategoryNameListener();
      setTagMenuListener();

      return $('.jobs-table').each(function() {
          refreshTable(this);
      });
    });

}).call(this);
