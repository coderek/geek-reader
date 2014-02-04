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
    "dragover":"dragover"
    "dragleave":"dragleave"
    "drop":"dropped"

  dropped: (ev)->
    data = JSON.parse ev.originalEvent.dataTransfer.getData("application/json")
    cat = Reader.categories.get(data.category_id)
    return false unless cat?
    feed = cat.feeds.get(data.feed_id)
    return false unless feed?
    cat.feeds.remove(feed)
    feed.save("category_id", @model.id)
    @model.feeds.add(feed)
    @$el.removeClass("over")
    @open()

  dragleave: ->
    @$el.removeClass("over")

  dragover: ->
    @$el.addClass("over")
    return false

  toggle: ->
    return @open() unless @$el.is(".open")

    @$el.removeClass("open")
    @$(".feeds").hide()

  open: ->
    return if @$el.hasClass("open")
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