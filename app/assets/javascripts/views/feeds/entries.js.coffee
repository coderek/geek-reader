class Reader.Views.Entries extends Backbone.View
  tagName: "ul"
  className: "entries"

  initialize: (options) ->
    @feed = options.feed
    @collection = @feed.entries
    @collection.fetch(reset:true)
    @listenTo @collection, "reset", @render_entries
    @listenTo @collection, "add", @render_entry
    $(".content").append(@el)
    @$el.attr("data-feed", @feed.get("id"))

  render_entries: (entries) ->
    @$(".loader").remove()
    entries.each(@render_entry, @)
    @$el.append("<i class=\"glyphicon glyphicon-refresh\"></i>")

  events:
    "click [class$=refresh]": "refresh_feed"

  refresh_feed: ->
    @collection.refresh()

  render_entry: (entry)->
    entryView = new Reader.Views.Entry({model:entry, feed: @feed})
    @$el.prepend(entryView.render().el)

  render: ->
    $(".feed_title span").text(@feed.get("title"))
    @$el.show()
    @
