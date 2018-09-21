# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




$(document).ready ->
  console.log "page has loaded on ready!"
  
$(document).on "page:change", ->
  console.log "page has loaded on change!"

$(document).on "page:load", ->
  console.log "page has loaded on load!"

$(document).on "turbolinks:load", ->
  console.log "page has loaded on turbolinks load!"
  $('#myButton').on 'click', (event) ->
    event.preventDefault()
    $('.channel-display').toggle()
    console.log('clicked')
  $('#myLink').on 'click', (event) ->
    console.log('Link clicked')
    event.preventDefault()
    $('.channel-display').toggle()
