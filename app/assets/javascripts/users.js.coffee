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
    # dataType: 'JSON'
    async: false
    success: (data)->
      $('#freelancer_status').val(status)
      $('#freelancer_status_text').text(status.toUpperCase())

endorseUser = (skill_type, skill_id)->
  $.ajax
    type: 'PUT'
    url: '/freelancers/endorse/skill'
    data:
      skill_type: skill_type
      skill_id: skill_id
      username: $('#freelancer').val()
    success: (data) ->
    error: (data) ->
      id = "#recommender_"+ skill_type + "_" + skill_id
      $(id).append(data.responseText)

$('.likebtn').click ->
  console.log(this.id)
  endorseUser(this.id.split(/_/)[0], this.id.split(/_/)[1])


filterFreelancers = (platforms_in, languages_in)->
  $.ajax
    type: "GET"
    url: "/freelancers"
    data:
      search:
        platforms_in: platforms_in
        languages_in: languages_in
        developer: $('#developer').val()
    dataType: "json"
    beforeSend: ->
      $('#loading').css('display', 'block')
    success: (data) ->
      $("#details-panel").html data
    complete: ->
    error: (error) ->
      $("#details-panel").html error.responseText
      $('#loading').css('display', 'none')

getIds = (div) ->
  if div == '#dialogP' || div == '#platforms'
    div1 = '#dialogP'
    div2 = '#platforms'
  else
    div1 = '#dialogL'
    div2 = '#languages'
  ids(div1).concat(ids(div2))

ids = (div) ->
  $(div + " input[type=checkbox]:checked").map(->
    @value
  ).get()

$("#search-panel :checkbox").click ->
  filterFreelancers(getIds('#platforms'), getIds('#languages'))

filterFreelancersPopup = (div) ->
  platforms_in = getIds('#platforms')
  languages_in = getIds('#languages')
  filterFreelancers(platforms_in, languages_in)

window.onload = ->
  $("#dialogP").dialog
    resizable: false
    height: 240
    width: 600
    modal: true
    buttons:
      Filter: ->
        filterFreelancersPopup("#dialogP")
        $(this).dialog "close"
      Cancel: ->
        $(this).dialog "close"
  $("#dialogP").dialog "close"

  $("#dialogL").dialog
    resizable: false
    height: 240
    width: 600
    modal: true
    buttons:
      Filter: ->
        filterFreelancersPopup("#dialogL")
        $(this).dialog "close"
      Cancel: ->
        $(this).dialog "close"
  $("#dialogL").dialog "close"

  $("#all-plat").click ->
    # $('#dialogP :checkbox').removeAttr('checked')
    $("#dialogP").dialog "open"

  $("#all-lang").click ->
    # $('#dialogL :checkbox').removeAttr('checked')
    $("#dialogL").dialog "open"

  $('#developer').change ->
    filterFreelancers(getIds('#platforms'), getIds('#languages'))
