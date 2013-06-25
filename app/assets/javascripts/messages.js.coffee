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



# Begin function calls

initial()

window.setInterval( () -> 
  getdata()
, refresh_timer);