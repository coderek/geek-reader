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
    Reader.feed_shown?.hide_entries()
    Reader.feed_shown = @

    @model.entries = @model.entries || new Reader.Collections.Entries
    @model.entries.url = "/feeds/#{@model.get("id")}/entries"
    @entriesView = @entriesView || new Reader.Views.Entries({feed: @model})
    @entriesView.render()


  hide_entries: ->
    @entriesView.$el.hide() if @entriesView?