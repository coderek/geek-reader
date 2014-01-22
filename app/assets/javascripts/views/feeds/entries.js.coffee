class Reader.Views.Entries extends Backbone.View
  tagName: "ul"
  className: "entries"

  initialize: (options) ->
    @feed = options.feed
    @collection = @feed.entries
    @collection.fetch(reset:true)
    @listenTo @collection, "reset", @render_entries
    @listenTo @collection, "add", @render_entry
    @listenTo @collection, "refreshed", @refreshed
    $(".content").append(@el)
    @$el.attr("data-feed", @feed.get("id"))

  render_entries: (entries) ->
    @$(".loader").remove()
    entries.each(@render_entry, @)
    @$el.append("<i class=\"glyphicon glyphicon-refresh refresh\"></i>")

  events:
    "click [class$=refresh]": "refresh_feed"
    "scroll": "scroll"

  scroll: (ev)->
    clearTimeout(@scroll_detector) if @scroll_detector?
    @scroll_detector = setTimeout (=> @checkScroll()), 500

  checkScroll: ->
    scroll_bottom = @$el.scrollTop() + @$el.height()
    actual_height = @el.scrollHeight
    if actual_height - scroll_bottom  < 10 and @state isnt "loading"
      @state = "loading"
      @$el.append("<li class='more'>loading more</li>")

  refreshed: ->
    @$(".refresh").removeClass("loading")
    flash = $("<div class='flash alert alert-success'>feed is updated successfully! </div>")
    flash.appendTo(@$el)
    setTimeout(
      -> flash.fadeOut()
      4000
    )

  refresh_feed: ->
    @collection.refresh()
    @$(".refresh").addClass("loading")

  render_entry: (entry)->
    entryView = new Reader.Views.Entry({model:entry, feed: @feed})
    @$el.prepend(entryView.render().el)

  render: ->
    $(".feed_title span").text(@feed.get("title"))
    @$el.show()
    @
