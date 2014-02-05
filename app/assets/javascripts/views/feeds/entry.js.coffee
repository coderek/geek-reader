class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  template_detail: JST["feeds/entry_detail"]

  tagName: "li"
  className: "entry"
  initialize: (options) ->
    @listenTo @model, "change:is_read", @update_read_status
    @parent = options.parent
    @feed = Reader.categories.find_feed(@model.get("feed_id"))
    if @feed?
      @listenTo @feed, "change:compiled_style", @render_style

  events:
    "click .title": "open"
    "click .close": "close"
    "click .star": "toggle_starred"

  toggle_starred: ->
    @model.urlRoot = "/feeds/#{@model.id}/entries"
    if @model.get("is_starred") == 1
      @model.save({is_starred: 0})
      @$el.removeClass("is_starred")
      Reader.starred_entries.remove(@model)
    else
      @model.save({is_starred: 1})
      @$el.addClass("is_starred")
      Reader.starred_entries.add(@model)

  update_read_status: ->
    @model.urlRoot = "/feeds/#{@model.id}/entries"
    if !!@model.get("is_read")
      @$el.addClass("is_read")
    else
      @$el.removeClass("is_read")

    if @model.previous("is_read") == 0 and @model.get("is_read") == 1
      Reader.update_unread(@model.get("feed_id"), -1)

  close: (ev)->
    if not ev? or $(ev.currentTarget).is(".close")
      @$(".title").show()
      @$(".detail").hide()

  render_style: ->
    log "render style"
    return unless @feed?
    style_id = "style_for_feed_#{@model.id}"
    if $("##{style_id}").length > 0
      $("##{style_id}").text(@feed.get("compiled_style"))
    else
      style = $("<style id='#{style_id}'></style>").text(@feed.get("compiled_style"))
      $("head").append(style)

  open: (ev)->
    @parent.opened_entry?.close()
    @render_style()
    @$(".detail").show()
    @$(".title").hide()

    if /\W/.test(@$(".detail").html())
      @$(".detail").html(@template_detail(entry: @model))
      @$('pre code, .prettyprint').each (i, e)-> hljs.highlightBlock(e)
      @model.save({is_read: 1}, {patch: true})

    scroll_top = _.reduce @$el.prevAll(), (memo, e)->
      memo += $(e).outerHeight(true)
    , 0

    @$el.parent().scrollTop(scroll_top)

    @parent.set_opened_entry(@)

  render: ->
    @$el.html(@template(entry: @model))
    @$(".timeago").timeago()
    @model.trigger("change:is_read")
    if @model.get("is_starred") == 1
      @$el.addClass("is_starred")
    @
