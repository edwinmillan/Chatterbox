# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

refreshpage = -> 
  $.getJSON('/messages', (data) -> 
    results = data
    analyzeresults(results)
  )

analyzeresults = (results) ->
  $('.messages').children().remove()
  for result in results
    response = '<div class="message">' + result["username"] + ": " + result["content"] + "</div>"
    $('.messages').append(response)



window.setInterval( ()-> 
  refreshpage()
, 5000);