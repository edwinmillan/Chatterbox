# Set initial Variables
currentids = []
refresh_timer = 5000

# Fills currentids array with the currently loaded ids
initial = ->
  $.getJSON('/messages', (data) -> 
    for result in data
      id = result["id"]
      currentids.push(id)
    )

# Gets the JSON data and sends it to be analyzed
getdata = -> 
  $.getJSON('/messages', (data) -> 
    analyzeresults(data)
  )

# Checks if the message is already listed, if not, it appends it.
analyzeresults = (results) ->
  for result in results
    id = result["id"]
    if $.inArray(id,currentids) is -1 # -1 means not found.
      currentids.push(id)
      response = '<div class="message">' + result["username"] + ": " + result["content"] + "</div>"
      $('.messages').append(response)

submitform = ->
  $('form#new_message').submit()
  $('form#new_message')[0].reset()
  $(".messages").animate({ scrollTop: $('.messages')[0].scrollHeight}, 1000);
  getdata()
  return false

# Begin function calls and event listeners
initial()

$ ->
  faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/messages', (data) ->
    alert data
    )

  $('#submitbutton').click( ->
      submitform()
      )
  $('#message_content').keypress((e) ->
    if e.which is 13
      submitform()
    )
  $('abbr').remove()
  $(".messages").animate({ scrollTop: $('.messages')[0].scrollHeight}, 1000);
  
#window.setInterval( -> 
#  getdata()
#, refresh_timer);