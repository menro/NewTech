# $('#freelancer_status').val('aadafasdfadsf')
$('#freelancer_status_text').click ->
  change_status()


change_status = ->
  console.log('changing status...')
  status = $('#freelancer_status').val()
  if status == 'available'
    status = 'shortly'
  else if status == 'shortly'
    status = 'working'
  else
    status = 'available'
  $('#freelancer_status').val(status)

  $.ajax
    type: 'POST'
    url: 'change_status'
    data: {user:{status: status}}
    dataTyoe: 'JSON'
    async: false
    success: (data)->
      $('#freelancer_status').val(status)
      $('#freelancer_status_text').text(status.toUpperCase())

filterFreelancers = ->
  $.ajax
    type: "GET"
    url: "/freelancers"
    data:
      search:
        platforms_in: getPlatformIds()
        languages_in: getLanguageIds()
    dataType: "json"
    beforeSend: ->
      $('#loading').css('display', 'block')
    success: (data) ->
      $("#details-panel").html data
    complete: ->
    error: (error) ->
      $("#details-panel").html error.responseText
      $('#loading').css('display', 'none')

getPlatformIds = ->
  $("#platforms input[type=checkbox]:checked").map(->
    @value
  ).get()

getLanguageIds = ->
  $("#languages input[type=checkbox]:checked").map(->
    @value
  ).get()

$(":checkbox").click ->
  filterFreelancers()