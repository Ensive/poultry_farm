PF_Validation = ( ( $ ) ->
  'use strict'

  $form = $ '.cf'

  # fields
  $name = $ '.cf__name'
  $email = $ '.cf__email'
  $tel = $ '.cf__tel'
  $message = $ '.cf__message'

  # errors
  errors = false

  methods =

    init: ->
      $form.on 'submit', @validateForm
      return

    validateForm: ( e ) ->

      fields = [$name, $email, $tel]
      fields.forEach ( field ) ->
        if field.val()?
          errors = true
          field.after '<div class="cf__error">Please, fill the field</div>'

      # last check
      if errors
        e.preventDefault()
        return false


) jQuery

$(document).ready ->
  PF_Validation.init()
  return

