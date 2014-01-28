window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    Reader.categories = new Reader.Collections.Categories
    Reader.feeds = new Reader.Collections.Feeds

    got_categories = ->
      d = $.Deferred()
      Reader.categories.fetch {parse: true, success: -> d.resolve()}
      d.promise()

    $.when(got_categories()).done ->
      console.log Reader.categories
      Reader.reader = new Reader.Views.Main

$(document).ready ->
  Reader.initialize()