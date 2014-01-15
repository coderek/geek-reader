class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  tagName: "li"
  initialize: (options) ->
    @feed = options.feed
  events:
    "click .title": "open"
    "click .close": "close"

  close: ->
    @$(".detail").removeClass("show")
    @$(".title").show()
  open: ->
    @$(".detail").addClass("show")
    @$(".title").hide()
  render: ->
    @$el.html(@template(entry: @model, feed: @feed))
    @
