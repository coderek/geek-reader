class Reader.Views.Entry extends Backbone.View
  template: JST["feeds/entry"]
  template_detail: JST["feeds/entry_detail"]

  tagName: "li"
  className: "entry"
  initialize: (options) ->
    @listenTo @model, "change:is_read", @update_read_status
    @parent = options.parent
    @feed = Reader.categories.find_feed(@model.get("feed_id"))

    @listenTo( @feed, "change:compiled_style", @render_style) if @feed?

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
    @$el.removeClass("open") if not ev? or $(ev.currentTarget).is(".close")

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
    return if $(ev.target).is("a")
    @parent.opened_entry?.close()
    @render_style()
    @$el.addClass("open")

    if /\W/.test(@$(".detail").html())
      @$(".detail").html(@template_detail(entry: @model))
      @$('pre code, .prettyprint').each (i, e)-> hljs.highlightBlock(e)
      @model.save({is_read: 1}, {patch: true})

    scroll_top = _.reduce @$el.prevAll(), (memo, e)->
      memo += $(e).outerHeight(true)
    , 0

    @$el.parent().scrollTop(scroll_top)

    @ops_width = @$(".ops").width()
    @parent.set_opened_entry(@)

  render: ->
    @$el.html(@template(entry: @model))
    @$(".timeago").timeago()
    @model.trigger("change:is_read")
    if @model.get("is_starred") == 1
      @$el.addClass("is_starred")
    @
  article_is_fully_displayed: (ev)->
    p_top = $(ev.target).scrollTop()
    el_top = _.reduce(@$el.prevAll("li"), ((memo, el)-> memo + $(el).outerHeight()), 0)
    el_height = @$el.outerHeight()
    log p_top, el_top, el_height
    return p_top <= el_top

  article_is_near_to_bottom: (ev)->
    p_top = $(ev.target).scrollTop()
    el_top = _.reduce(@$el.prevAll("li"), ((memo, el)-> memo + $(el).outerHeight()), 0)
    el_height = @$el.outerHeight()
    threshold = 40
    return p_top + threshold > el_top + el_height

  toggle_toolbar: (ev)->
    return unless @parent.opened_entry is @
    @$(".ops").width(@ops_width)

    if @article_is_fully_displayed(ev)
      @$(".ops").css("position", "static")
    else
      @$(".ops").css("position", "fixed")
    if @article_is_near_to_bottom(ev)
      @$(".ops").hide()
    else
      @$(".ops").show() unless @$(".ops").is(":visible")

