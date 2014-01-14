class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  tagName: "li"
  initialize: (options) ->
    @feed = options.feed
    @opened = false
  events:
    "click": "open"
  open: ->
    if @opened
      @$(".detail").removeClass("show")
      @$(".title").show()
    else
      @$(".detail").addClass("show")
      @$(".title").hide()
    @opened = !@opened
  render: ->
    @$el.html(@template(entry: @model, feed: @feed))
    @
