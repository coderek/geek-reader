class Reader.Views.Feed extends Backbone.View
  tagName: "li"
  className: "list-unstyled feed"
  template: JST["feeds/feed"]
  initialize: ->
    @listenTo @model, "destroy", @remove
    @listenTo @model, "remove", @remove
    @listenTo @model, "show_entries", @show_entries

  events:
    "click a": "open"

  open: ->
    unless @$el.is(".open")
      $(".feed.open").removeClass("open")
    @$el.addClass("open")

  render: ->
    @$el.html @template(feed: @model)
    @

  show_entries: ->
    Reader.display_manager.render_entries(@model)