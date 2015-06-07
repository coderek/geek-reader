class Reader.Models.Category extends Backbone.Model

  initialize: ->

  parse: (data)->
    @feeds = new Reader.Collections.Feeds(data.feeds)
    @feeds.url = "/categories/#{data.id}/feeds"

    # do not load first
    @entries = new Reader.Collections.CategoryEntries
    @entries.url = "/categories/#{data.id}/entries"
    @entries.title = "Category: #{data.name}"
    data
