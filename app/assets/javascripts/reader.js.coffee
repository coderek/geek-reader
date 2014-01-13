window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    # check session
    sess = new Reader.Models.Session
    sess.fetch
      success: (model)->
        if model.isNew()
          router = new Reader.Routers.Sessions
          Backbone.history.start()
        else
#          new Reader.Routers.
          alert "show feeds!"
$(document).ready ->
  Reader.initialize()
