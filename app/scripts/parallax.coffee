PF_Parallax = ( ( $ ) ->
  'use strict'

  # blocks with numbers
  firstNumber = $ '.section-number--slider'
  secondNumber = $ '.section-number--welcome'
  thirdNumber = $ '.section-number--events'
  fourthNumber = $ '.section-number--wwd'

  doTranslate = ( decreaseNumber, vScroll ) ->
    divider = 5
    return 'translate( 0px, -' + ( vScroll - decreaseNumber ) / divider + '% )'

  # implement parallax effect
  parallaxScrolling = ->
    vScroll = $(this).scrollTop()

    if vScroll > 120 and vScroll <= 1037
      firstNumber.css
        transform: doTranslate 120, vScroll

    else if vScroll >= 1037 and vScroll <= 1920
      secondNumber.css
        transform: doTranslate 1037, vScroll

    else if vScroll >= 1920 and vScroll <= 2803
      thirdNumber.css
        transform: doTranslate 1920, vScroll

    else if vScroll >= 2803 and vScroll <= 3686
      fourthNumber.css
        transform: doTranslate 2803, vScroll

  parallax =
    init: ->
      $(window).on 'scroll', parallaxScrolling

) jQuery

$(document).ready ->
  PF_Parallax.init()
