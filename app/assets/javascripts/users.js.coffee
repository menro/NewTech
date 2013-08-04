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

