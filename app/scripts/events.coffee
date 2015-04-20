PF_Events = ( ( $ ) ->
  'use strict'

  $mobileBtn = $ '.mobile-menu-btn'
  $header = $ '.header-wrapper'
  $menu = $header.find '.header__navigation'

  # open/hide menu
  toggleMenu = ->
    $this = $ @
    $this.toggleClass('active').siblings('.header__navigation').slideToggle()

  # when scrolling
  doStuffOnScroll = ->
    $scroll = $(@).scrollTop()

  # when resizing
  doStuffOnResize = ->
    viewport = $(window).width() + 15

    # @todo: investigate and refactor
    # eliminate bug with menu on resize
    if $menu.css('display') == 'none' and viewport > 991
      $menu.css 'display', 'block'
    else if $menu.css('display') == 'block' and viewport <= 991 and !$mobileBtn.hasClass('active')
      $menu.css 'display', 'none'
      $mobileBtn.removeClass 'active'

  #return public api
  events =

    # init function
    init: ->
      $mobileBtn.on 'click', toggleMenu
      $(window).on 'scroll', doStuffOnScroll
      $(window).on 'resize', doStuffOnResize

) jQuery

document.addEventListener 'DOMContentLoaded', ->
  PF_Events.init()
