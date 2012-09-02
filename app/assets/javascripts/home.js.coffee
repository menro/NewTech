# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class GMap
  constructor: (container) ->
    defaultOptions =
      zoom:        7
      scrollwheel: false
      mapTypeId:   google.maps.MapTypeId.ROADMAP
      center:      new google.maps.LatLng(39.232253,-105.08606)

    currentMap = new google.maps.Map(container, defaultOptions)

    markers = []

    $.getJSON $(container).data("offices_url"), (data) ->
      $.each data, (i, result) ->
        office = result.office

        marker =
          map: currentMap
          position: new google.maps.LatLng(office.latitude, office.longitude)
          title: office.company_name

        markers += new google.maps.Marker(marker)


  @init: (container) ->
    console.log "Initialize Gmap"
    return new GMap(container);

$ ->
  $('.gmap').each -> GMap.init this


