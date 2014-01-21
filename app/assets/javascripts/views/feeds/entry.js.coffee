class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  template_detail: JST["feeds/entry_detail"]

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
    @$(".detail").html(@template_detail(entry: @model, feed: @feed)) if /\W/.test(@$(".detail").html())
    @$(".detail").addClass("show")
    @$(".title").hide()

  render: ->
    @$el.html(@template(entry: @model, feed: @feed))
    @
