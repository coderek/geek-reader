class Reader.Models.Category extends Backbone.Model

  initialize: ->
    @feeds_are_loaded = $.Deferred()

  parse: (data)->
    @feeds = new Reader.Collections.Feeds
    @feeds.url = "/categories/#{data.id}/feeds"
    @feeds.once "reset", => @feeds_are_loaded.resolve()
    data

  load_feeds: ->
    if @feeds_are_loaded.state() isnt "resolved"
      log "loading feeds for category: #{@get("name")}"
      @feeds.fetch reset: true
