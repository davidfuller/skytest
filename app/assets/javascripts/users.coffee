# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  console.log "Users has loaded on turbolinks load!"
  navbar = $('#bs-example-navbar-collapse-1')
  console.log "XXXXXX"
  navbarHeight = navbar.height()
  console.log navbarHeight
  bodyTopPadding = navbarHeight + 20
  console.log "body top padding " + bodyTopPadding + "px"
  $('body').css "paddingTop" : bodyTopPadding + "px"
  console.log $('body').css "paddingTop"

  $(window).resize ->
    console.log "Window Width: " + $(window).width()
    navbarHeight = navbar.height()
    bodyTopPadding = navbarHeight + 20
    $('body').css "paddingTop" : bodyTopPadding + "px"
    console.log $('body').css "paddingTop"
