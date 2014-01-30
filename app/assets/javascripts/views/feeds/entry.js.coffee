class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  template_detail: JST["feeds/entry_detail"]

  tagName: "li"
  className: "entry"
  initialize: (options) ->
    @listenTo @model, "change:is_read", @update_read_status

  events:
    "click .title": "open"
    "click .ops": "close"
    "click .star": "toggle_starred"

  toggle_starred: ->
    @model.urlRoot = "/feeds/#{@model.id}/entries"
    if @model.get("is_starred") == 1
      @model.save({is_starred: 0})
      @$el.removeClass("is_starred")
    else
      @model.save({is_starred: 1})
      @$el.addClass("is_starred")

  update_read_status: ->
    @model.urlRoot = "/feeds/#{@model.id}/entries"
    if !!@model.get("is_read")
      @$el.addClass("is_read")
    else
      @$el.removeClass("is_read")

  close: (ev)->
    if $(ev.target).is(".ops")
      @$(".detail").removeClass("show")
      @$(".title").show()

  open: ->
    @$(".detail").addClass("show")
    @$(".detail").html(@template_detail(entry: @model)) if /\W/.test(@$(".detail").html())
    @$(".title").hide()
    @model.save({is_read: 1}, {patch: true})
    scroll_top = _.reduce @$el.prevAll(), (memo, e)->
      memo += $(e).outerHeight(true)
    , 0
    @$el.parent().scrollTop(scroll_top)
    @$('pre, code').each (i, e)-> hljs.highlightBlock(e)


  render: ->
    @$el.html(@template(entry: @model))
    @$(".timeago").timeago()
    @model.trigger("change:is_read")
    if @model.get("is_starred") == 1
      @$el.addClass("is_starred")
    @
