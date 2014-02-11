
# $(window).load ->
#   $('#company_state_id').on 'change', (e) ->
#     console.log('chaning val...')
#     $.ajax
#       type: 'GET'
#       url: '/get_cities'
#       data: {state_id: $(@).val()}
#       async: false
#       success: (html)->
#         $('#company_city_id').parent().replaceWith(html)


$(window).load ->
  loadLocationData = (data_type, val, element_id, require) ->
    $.ajax
      url: "/api/v1/location_data_as_options/"
      dataType: "JSON"
      data:
        type: data_type
        id: val
        require: require

      beforeSend: ->
        $("#company_" + element_id + "_id_chzn ul.chzn-results").empty()
        $("#company_" + element_id + "_id").empty()
        $("#company_zipcode_id_chzn ul.chzn-results").empty()
        $("#company_" + element_id + "_id").removeClass "chzn-done"
        return

      success: (data) ->
        $("#company_" + element_id + "_id_chzn").remove()
        $("#company_" + element_id + "_id").append "<option value> Select an Option</option>"

        $.map data, (item, index) ->
          
          # $('#company_county_id_chzn ul.chzn-results').append('<li class="active-result">' + item.name + '</li>');
          # $('#company_county_id_chzn ul.chzn-results').append('<li class="active-result" id="company_county_id_chzn_o_'+(index + 1)+'">' + item.name + '</li>');
          $("#company_" + element_id + "_id").append "<option value=\"" + item.id + "\">" + item.name + "</option>"

        $("#company_" + element_id + "_id").outerWidth 274
        $("#company_" + element_id + "_id").chosen width: "270px;"
      
        if data_type == 'state'
          loadLocationData "county", val, "city", "cities"

        if data_type == 'county'
          loadLocationData "city", $("#states").val(), "zipcode", "zipcodes"


    return

  $("select").chosen()
  $("#states").change ->
    loadLocationData "state", $(this).val(), "county", "counties"
    return

  # $("#company_county_id").change ->
  #   loadLocationData "county", $(this).val(), "city", "cities"
  #   return

  # $("#company_city_id").change ->
  #   loadLocationData "city", $("#states").val(), "zipcode", "zipcodes"
  #   return

  return


# $('#company_county_id_chzn input').autocomplete({
#   source: function( request, response ) {
#     $.ajax({
#       url: "/api/v1/location_data_as_options",
#       dataType: "json",
#       data: {type: 'state', id: $('#states').val(), require: 'counties' },
#       beforeSend: function(){$('#company_county_id_chzn ul.chzn-results').empty();$('#company_county_id').empty();$('#company_county_id').removeClass('chzn-done');},
#       success: function( data ) {
#         response( $.map( data, function( item, index ) {
#           // $('#company_county_id_chzn ul.chzn-results').append('<li class="active-result">' + item.name + '</li>');
#           $('#company_county_id_chzn ul.chzn-results').append('<li class="active-result" id="company_county_id_chzn_o_'+(index + 1)+'">' + item.name + '</li>');
#           $('#company_county_id').append('<option value="'+item.id+'">' + item.name + '</option>')
#         }));
#         $('#company_county_id').chosen()
#       }
#     });
#   }
# });