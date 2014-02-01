class Reader.Views.Feed extends Backbone.View
  tagName: "li"
  className: "list-unstyled feed"
  template: JST["feeds/feed"]
  initialize: ->
    @listenTo @model, "destroy", @remove
    @$el.attr("data-id", @model.id)

  events:
    "click a": "open"

  open: ->
    log "called open feed"
    @show_entries()

  render: ->
    @$el.html @template(feed: @model)
    @

  show_entries: ->
    Reader.display_manager.render_entries(@model)