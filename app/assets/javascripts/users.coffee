# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

adjustPadding = ->
  navbar = $('#bs-example-navbar-collapse-1')
  header = $('.navbar-header')
  aria = navbar.attr 'aria-expanded'
  if aria is "true"
    bodyTopPadding = header.height() + 20
  else
    bodyTopPadding = navbar.height() +20
  $('body').css "paddingTop" : bodyTopPadding + "px"
  console.log $('body').css "paddingTop"


$(document).on "turbolinks:load", ->
  console.log "Users has loaded on turbolinks load!"
  adjustPadding()

  $(window).resize ->
    console.log "Window Width: " + $(window).width()
    adjustPadding()