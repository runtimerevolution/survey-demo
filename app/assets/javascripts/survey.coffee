# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load", ->

  new_user = $('#submit-name-modal').data('new-user')
  modal_options = if new_user then { backdrop: 'static' } else { show: false }

  $('#submit-name-modal').modal(modal_options)

  $('#submit-name-modal').on 'shown.bs.modal', ->
    $('.user-form').enableClientSideValidations();
