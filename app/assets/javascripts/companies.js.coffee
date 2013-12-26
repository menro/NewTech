->
  $(window).ready ->
    $('#company_state_id').on 'change', (e) ->
      console.log('chaning val...')
      $.ajax
        type: 'GET'
        url: 'get_cities'
        data: {state_id: $(@).val()}
        async: false
        success: (html)->
          $('#company_city_id').parent().replaceWith(html)

