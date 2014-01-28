class Reader.Views.Category extends Backbone.View
  template: JST["feeds/category"]
  tagName: "li"
  className: "category"
  initialize: ->
    @listenTo @model.feeds, "add", @add_feed

  events:
    "click >div":"toggle"

  toggle: ->
    @$(">ul").toggle()
    if @$el.is(".open")
      @$el.removeClass("open")
    else
      @$el.addClass("open")

  add_feed: (model)->
    @$("ul").append (new Reader.Views.Feed(model: model)).render().el

  render: ->
    @$el.html @template(model: @model)
    @add_feed(feed) for feed in @model.feeds.models
    @