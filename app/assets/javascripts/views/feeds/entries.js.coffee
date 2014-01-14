class Reader.Views.Entries extends Backbone.View

  template: JST['feeds/entries']

  initialize: (options) ->
    @feed = options.feed
    @collection.fetch(reset:true)
    @listenTo @collection, "reset", @render_entries

  render_entries: (entries) ->
    entries.each(@render_entry, @)

  render_entry: (entry)->
    entryView = new Reader.Views.Entry(model:entry)
    @$el.append(entryView.render().el)

  render: ->
    @$el.html @template(feed_id: @feed.get("id"))
    @
