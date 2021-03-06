PF_Map = ( ( $ ) ->
  'use strict'

  # html stuff
  mapContainer = document.getElementsByClassName('pf-map')[0]

  # info window
  infoBox = document.createElement 'div'
  infoBox.className = 'map-info-box'
  infoBoxText = '<b>Poultry farm</b>'
  infoBoxText += '<br />'
  infoBoxText += '8901 Marmora Road,<br />'
  infoBoxText += 'Glasgow, D04 89GR.'
  infoBox.innerHTML = infoBoxText

  # coordinates
  latitudeLongitude = new google.maps.LatLng 35.403816, -119.112834

  #marker
  marker = new google.maps.Marker
    position: latitudeLongitude
    animation: google.maps.Animation.DROP
    title: 'Poultry farm'
    icon: 'images/map-marker.png'

  # map
  map = undefined

  # options
  isDraggable = ->
    viewport = $(window).width() + 15
    return if viewport <= 768 then false else true

  # object
  googleMap =

    init: ->
      @mapInit()
      window.addEventListener 'resize', @onResize

    mapInit: ->
      # options
      mapOptions =
        center: latitudeLongitude
        zoom: 10
        disableDefaultUI: true
        scrollwheel: false
        draggable: isDraggable()

      # info window
      infowindow = new google.maps.InfoWindow
        content: infoBox

      # on click open info
      google.maps.event.addListener marker, 'click', ->
        infowindow.open map, marker

      google.maps.event.addListener marker, 'click', @toggleBounce

      # initialize
      map = new google.maps.Map mapContainer, mapOptions
      marker.setMap( map )

    toggleBounce: ->
      if marker.getAnimation()?
        marker.setAnimation(null)
      else
        marker.setAnimation(google.maps.Animation.BOUNCE)

    onResize: ->
      center = map.getCenter()
      google.maps.event.trigger map, 'resize'
      map.setCenter center

  # return map object
  googleMap

) jQuery

document.addEventListener 'DOMContentLoaded', ->
  PF_Map.init()
