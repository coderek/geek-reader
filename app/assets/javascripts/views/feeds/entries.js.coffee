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
    @page = 0 # page start from 0
    @head = null
    @$el.append("<div class='loader'>loading content...</div>")

  render_entries: (entries) ->
    @$(".loader").remove()
    models = entries.models.reverse()
    @head = models[0]
    _.each(models, (e)=> @render_entry(e))
    @$el.append("<i class=\"glyphicon glyphicon-refresh refresh\"></i>")

  events:
    "click [class$=refresh]": "refresh_feed"
    "scroll": "scroll"

  scroll: (ev)->
    clearTimeout(@scroll_detector) if @scroll_detector?
    @scroll_detector = setTimeout (=> @check_scroll()), 500

  check_scroll: ->
    scroll_bottom = @$el.scrollTop() + @$el.height()
    actual_height = @el.scrollHeight
    if actual_height - scroll_bottom  < 10 and @state isnt "loading"
      @state = "loading"
      @$el.append("<li class='more'>loading more</li>")
      @page += 1
      req = $.getJSON(@collection.url+"?page="+@page)
      req.done (entries)=>
        @collection.add(entries)
        @state = "loaded"
        @$("li.more").remove()
      req.fail (jXhr, text, status)=>
        @$("li.more").html("No more") if status is "Not Found"

  refreshed: ->
    @$(".refresh").removeClass("loading")
    flash = $("<div class='flash alert alert-success'>feed is updated successfully! </div>")
    flash.appendTo(@$el)
    setTimeout ( -> flash.fadeOut()), 4000

  refresh_feed: ->
    @collection.refresh()
    @$(".refresh").addClass("loading")

  render_entry: (entry)->
    entryView = new Reader.Views.Entry({model:entry, feed: @feed})
    if @head and entry.get("published") >= @head.get("published")
      @$el.prepend(entryView.render().el)
      @head = entry
    else
      @$el.append(entryView.render().el)

  render: ->
    $(".feed_title span").text(@feed.get("title"))
    @$el.show()
    @
