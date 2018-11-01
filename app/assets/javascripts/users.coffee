# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

adjustPadding = ->
  navbar = $('#bs-example-navbar-collapse-1')
  console.log navbar.height()
  header = $('.navbar-header')
  aria = navbar.attr 'aria-expanded'
  console.log aria
  if aria
    bodyTopPadding = header.height() + 20
    console.log "header"
  else
    bodyTopPadding = navbar.height() + 20

  $('body').css "paddingTop" : bodyTopPadding + "px"
  console.log $('body').css "paddingTop"


$(document).on "turbolinks:load", ->
  console.log "Users has loaded on turbolinks load!"
  adjustPadding()

  $(window).resize ->
    console.log "Window Width: " + $(window).width()
    adjustPadding()