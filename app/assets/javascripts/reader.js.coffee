window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    $(".container").html(JST["index"]())
    session = new Reader.Models.Session

    new Reader.Routers.Feeds(session: session)
    new Reader.Routers.Sessions(session: session)


$(document).ready ->
  Reader.initialize()
