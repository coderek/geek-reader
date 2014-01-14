window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    $(".container").html(JST["index"]())
    session = new Reader.Models.Session
    session.fetch
      success: =>
        new Reader.Routers.Sessions({session: session})
        Backbone.history.start()
      error: =>
        $(".container").html("error with server, please try again later")

$(document).ready ->
  Reader.initialize()
