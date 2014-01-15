window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    Reader.session = new Reader.Models.Session
    Reader.feeds = new Reader.Collections.Feeds

    new Reader.Routers.Sessions()

$(document).ready ->
  Reader.initialize()
