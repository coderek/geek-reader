class Reader.Views.Entries extends Backbone.View
  tagName: "ul"
  className: "entries"
  initialize: (options) ->
    @feed = options.feed
    @collection.fetch(reset:true)
    @listenTo @collection, "reset", @render_entries

  render_entries: (entries) ->
    entries.each(@render_entry, @)

  render_entry: (entry)->
    entryView = new Reader.Views.Entry({model:entry, feed: @feed})
    @$el.append(entryView.render().el)

  render: ->
    @$el.attr("data-feed", @feed.get("id"))
    @
