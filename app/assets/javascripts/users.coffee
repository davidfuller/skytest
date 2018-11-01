# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  console.log "Users has loaded on turbolinks load!"
  navbar = $('#bs-example-navbar-collapse-1')
  console.log "XXXXXX"
  console.log navbar.height()
  console.log $(document).body.paddingTop
