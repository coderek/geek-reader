class Reader.Routers.Feeds extends Backbone.Router
  routes:
    "": "index"
    "logout":"logout"

  logout: ->
    $(".container").html("logout")
  index: ->
    $(".container").html("<a href=\"#logout\">logout</a>")