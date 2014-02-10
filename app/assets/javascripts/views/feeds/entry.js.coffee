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
    "click .close_entry": "close"
    "click .star_entry": "toggle_starred"
    "click .next_entry":"go_next"
    "click .prev_entry":"go_prev"

  go_next: ->
    @$el.next("li.entry").find(".title").click()

  go_prev: ->
    @$el.prev("li.entry").find(".title").click()

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
    @$el.removeClass("open") if not ev? or $(ev.currentTarget).is(".close_entry")

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
    @parent.close_entry()
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

  get_scroll_params: (ev)->
    p_top = $(ev.target).scrollTop()
    el_top = _.reduce(@$el.prevAll("li"), ((memo, el)-> memo + $(el).outerHeight()), 0)
    el_height = @$el.outerHeight()
    return [p_top, el_top, el_height]

  article_is_fully_displayed: (p_top, el_top)->
    return p_top <= el_top

  article_is_near_to_bottom: (p_top, el_top, el_height)->
    threshold = 50
    return p_top + threshold > el_top + el_height

  toggle_toolbar: (ev)->
    return unless @parent.opened_entry is @
    params = @get_scroll_params(ev)

    if @article_is_fully_displayed.apply(@, params)
      @$(".ops").css("position", "absolute")
      @$(".ops").css({right: "3px", top: "3px"})
    else
      @$(".ops").css("position", "fixed")
      right = $(".content_col").width() - @$el.width() + $(".content_col").parent().width() - ($(".content_col").offset().left + $(".content_col").width()) - 1
      @$(".ops").css({right: (right + 3 )+ "px", top: "30px"})
    if @article_is_near_to_bottom.apply(@, params)
      @$(".ops").fadeOut(100)
    else
      @$(".ops").show() unless @$(".ops").is(":visible")

