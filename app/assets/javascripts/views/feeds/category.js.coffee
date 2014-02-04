class Reader.Views.Category extends Backbone.View
  template: JST["feeds/category"]
  tagName: "li"
  className: "category"
  initialize: ->
    @$el.html @template(model: @model)
    @listenTo @model, "destroy", @remove
    @listenTo @model.feeds, "add", @add_feed
    @listenTo @model.feeds, "reset", @add_feeds
    @$(".feeds").hide()
    @rendered = $.Deferred()

  events:
    "click >div":"toggle"

  toggle: ->
    return @open() unless @$el.is(".open")

    @$el.removeClass("open")
    @$(".feeds").hide()

  open: ->
    @$el.addClass("open")
    @model.load_feeds() if @model.feeds_are_loaded.state() isnt "resolved"
    @model.feeds_are_loaded.done => @$(".feeds").show()


  add_feeds: (feeds)->
    @$(".feeds").empty()
    feeds.each @add_feed, @
    @rendered.resolve()

  add_feed: (model)->
    @$(".feeds").append (new Reader.Views.Feed(model: model)).render().el

  render: ->
#    @add_feed(feed) for feed in @model.feeds.models
    @