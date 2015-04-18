PF_Map = (() ->
  'use strict'

  # html stuff
  mapContainer = document.getElementById 'pf-map'

  # info window
  infoBox = document.createElement 'div'
  infoBox.className = 'map-info-box'
  infoBox.innerHTML = 'Poultry farm - you\'ll love our chicken'

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

  # object
  googleMap =

    init: ->
      @mapInit()

      window.addEventListener 'resize', @onResize

      # on click open info
      google.maps.event.addListener marker, 'click', ->
        infowindow.open map, marker

      google.maps.event.addListener marker, 'click', @toggleBounce

    mapInit: ->
      # options
      mapOptions =
        center: latitudeLongitude
        zoom: 10
        disableDefaultUI: true
        scrollwheel: false

      # info window
      infowindow = new google.maps.InfoWindow
        content: infoBox

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

)()

document.addEventListener 'DOMContentLoaded', ->
  PF_Map.init()
