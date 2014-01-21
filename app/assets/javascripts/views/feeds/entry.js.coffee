class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  template_detail: JST["feeds/entry_detail"]

  tagName: "li"
  className: "entry"
  initialize: (options) ->
    @feed = options.feed
    @listenTo @model, "change:is_read", @update_read_status
  events:
    "click .title": "open"
    "click .ops": "close"

  update_read_status: ->
    if !!@model.get("is_read")
      @$el.addClass("is_read")
    else
      @$el.removeClass("is_read")

  close: (ev)->
    if $(ev.target).is(".ops")
      @$(".detail").removeClass("show")
      @$(".title").show()

  open: ->
    @$(".detail").html(@template_detail(entry: @model, feed: @feed)) if /\W/.test(@$(".detail").html())
    @$(".detail").addClass("show")
    @$(".title").hide()
    @model.save({is_read: 1}, {patch: true})

  render: ->
    @$el.html(@template(entry: @model, feed: @feed))
    @$(".timeago").timeago()
    @model.trigger("change:is_read")
    @
