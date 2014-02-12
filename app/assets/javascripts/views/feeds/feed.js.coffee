class Reader.Views.Feed extends Backbone.View
  tagName: "li"
  className: "list-unstyled feed"
  attributes:
    draggable:true
  template: JST["feeds/feed"]
  initialize: ->
    @listenTo @model, "remove destroy", @remove_feed
    @listenTo @model, "update_unread", @update_unread
    @listenTo @model, "change:title", @render
    @listenTo @model, "open", @open
    @$el.attr("data-id", @model.id)

  remove_feed: ->
    @remove()

  events:
    "click": "delegate_open"
    "dragstart": "dragstart"
    "dragend":"dragend"

  dragstart: (ev)->
    @$el.css("opacity", 0.1)
    data =
      feed_id: @model.id
      category_id: @model.get("category_id")

    ev.originalEvent.dataTransfer.setData("application/json", JSON.stringify(data))

  dragend: ->
    @$el.css("opacity", 1)

  delegate_open: (ev)->
    unless $(ev.target).is("a")
      Backbone.history.navigate @$("a").attr("href"), trigger: true

  open: ->
    log "called open feed"
    @show_entries()
    $("li.feed.selected").removeClass(("selected"))
    @$el.addClass("selected")

  render: ->
    @$el.html @template(feed: @model)
    @

  show_entries: ->
    Reader.display_manager.render_entries(@model.entries)

  update_unread: (change)->
    @model.set "unread_count", Math.max(parseInt(@model.get("unread_count"), 10) + change, 0)
    @$(".unread").text(@model.get("unread_count"))
