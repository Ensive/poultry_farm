PF_Slider = ( ( $ ) ->
  'use strict'

  Slider = ( container, item, nav, auto, time, speed, pauseHover ) ->
    # options
    @container = $ container
    @item = $ item
    @nav = $ nav
    @auto = auto
    @pauseHover = pauseHover
    @time = time || 5000
    @speed = speed || 1000

    # stuff
    @slides = @item
    @slideWidth = @item.first().width()
    @slidesLen = @slides.length

    # call methods
    @init()
    @prevSlide()
    @nextSlide()
    return

  # do the basic slider stuff
  Slider.prototype.init = ->
    _this = @
    # get width
    width = @slidesLen * @slideWidth

    # set width of container
    @container.css 'width', width + 'px'
    @item.css 'width', @slideWidth + 'px'

    # set default item to correct position
    @container.css 'left', -_this.slideWidth + 'px'

    # move the last item before first item
    # just in case if user clicks prev button
    @item.first().before @item.last()

    @container.parents('.slider-wrapper').on 'mouseenter', @stop.bind @
    @container.parents('.slider-wrapper').on 'mouseleave', @play.bind @

    # if slider was initialized with option 'auto' = true
    # @todo: investigate and refactor
    if @auto == true
      @timeout = setTimeout _this.play.bind(_this), 500
      return

  Slider.prototype.setCurrentSlide = ( dir ) ->
    pos = @current
    pos += ( dir == 'next' ) || -1

    if pos < 0
      @current = @slidesLen - 1
    else
      @current = pos % @slidesLen

  Slider.prototype.rotateSlider = ->
    @nav.find('.slider__arrow--right').click()
    return

  Slider.prototype.play = ->
    _this = @
    @interval = setInterval _this.rotateSlider.bind(_this), @time
    return

  # @todo: investigate and refactor
  Slider.prototype.stop = ->
    _this = @
    clearInterval _this.interval if _this.interval
    clearTimeout _this.timeout if _this.timeout

  # @todo: refactor
  Slider.prototype.prevSlide = ->
    _this = @

    # @todo: refactor
    _this.nav.find('.slider__arrow--left').on 'click', (e) ->
      e.preventDefault()
      _this.setCurrentSlide $(this).data 'dir'

      # count current indent
      indent = parseInt(_this.container.css('left'), 10) + _this.slideWidth

      # slide the item
      # @todo: refactor
      _this.container.animate
        left: indent
        _this.speed
        ->
          # DOM change
          _this
            .container.find '.slider-item:first'
            .before _this.container.find '.slider-item:last'

          _this.container.css 'left', _this.slideWidth * -1
          return

  # @todo: refactor
  Slider.prototype.nextSlide = ->
    _this = @

    _this.nav.find('.slider__arrow--right').on 'click', (e) ->
      e.preventDefault()
      _this.setCurrentSlide $(this).data 'dir'

      # count current indent
      indent = parseInt(_this.container.css('left'), 10) - _this.slideWidth
      # @todo: refactor
      _this.container.animate
        left: indent
        _this.speed
        ->
          # DOM change
          _this
            .container.find('.slider-item:last')
            .after _this.container.find '.slider-item:first'

            _this.container.css 'left', _this.slideWidth * -1
            return


  return Slider

) jQuery

document.addEventListener 'DOMContentLoaded', ->

  # init the slider
  new PF_Slider '.slider-container', '.slider-item', '.slider__nav', true, 10000, 3000, true
