class Reader.Models.Category extends Backbone.Model

  initialize: ->

  parse: (data)->
    @feeds = new Reader.Collections.Feeds(data.feeds)
    @feeds.url = "/categories/#{data.id}/feeds"
    data
