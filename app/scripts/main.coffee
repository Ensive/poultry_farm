PF_Events = (() ->

  mobileMenuBtn = document.getElementsByClassName('mobile-menu-btn')[0]

  # return public api
  events =
    init: ->
      mobileMenuBtn.addEventListener 'click', @toggleMenu

    toggleMenu: ->
      _this = @
      toggleClass = 'active'

      current = _this.className.split(/\s+/g)
      nativeClass = current[0]
      exist = ~current.indexOf(toggleClass)

      if exist
        _this.className = nativeClass
      else
        _this.className += ' ' + toggleClass

      # console.log exist

      # get siblings elements
      siblings = _this.parentNode.childNodes

      for item in siblings
        if item.className == 'header__navigation'
          item.style.display = 'none'
)()

document.addEventListener 'DOMContentLoaded', ->
  PF_Events.init()

  # get all imgs
  # imgs = document.querySelectorAll('img')
  # img.style.display = 'none' for img in imgs
