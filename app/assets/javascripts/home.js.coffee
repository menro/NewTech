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

  @init: (container) ->
    console.log "Initialize Gmap"
    return new GMap(container);

$ ->
  $('.gmap').each -> GMap.init this


