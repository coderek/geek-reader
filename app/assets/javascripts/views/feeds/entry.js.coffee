class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  tagName: "li"
  className: "entry"
  initialize: (options) ->
    @feed = options.feed
  events:
    "click .title": "open"
    "click .ops": "close"

  close: (ev)->
    if $(ev.target).is(".ops")
      @$(".detail").removeClass("show")
      @$(".title").show()

  open: ->
    @$(".detail").addClass("show")
    @$(".title").hide()
  render: ->
    @$el.html(@template(entry: @model, feed: @feed))
    @
