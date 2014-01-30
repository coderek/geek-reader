class Reader.Views.Category extends Backbone.View
  template: JST["feeds/category"]
  tagName: "li"
  className: "category"
  initialize: ->
    @$el.html @template(model: @model)
    @listenTo @model.feeds, "add", @add_feed
    @listenTo @model.feeds, "reset", @add_feeds
    @$(".feeds").hide()
    @loaded = $.Deferred()

  events:
    "click >div":"toggle"

  toggle: ->
    if @$el.is(".open")
      @$el.removeClass("open")
      @$(".feeds").hide()
    else
      @open()
  open: ->
    @$el.addClass("open")
    if @loaded.state() is "pending"
      @model.feeds.fetch
        reset: true
        success: =>
          @$(".feeds").show()
          log "feeds show"
          @loaded.resolve()
    else if @loaded.state() is "resolved"
      @$(".feeds").show()

  add_feeds: (feeds)->
    @$(".feeds").empty()
    feeds.each @add_feed, @

  add_feed: (model)->
    @$(".feeds").append (new Reader.Views.Feed(model: model)).render().el

  render: ->
#    @add_feed(feed) for feed in @model.feeds.models
    @