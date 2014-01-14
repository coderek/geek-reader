window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    $(".content").html(JST["index"]())
    Reader.session = new Reader.Models.Session
    Reader.feeds = new Reader.Collections.Feeds
    Reader.menu = new Reader.Views.Menu

    new Reader.Routers.Feeds()
    new Reader.Routers.Menu()
    new Reader.Routers.Sessions()


$(document).ready ->
  Reader.initialize()
