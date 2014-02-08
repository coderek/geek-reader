class Reader.Views.DisplayManager extends Backbone.View
  el: "div.content_col"

  initialize: ->
    @unread_view = null
    @starred_view = null
    # table storing feed views
    @feeds_view = {}
    @current_view = null

  render_entries: (@source)->
    @current_view?.$el.hide()
    log "current view is :", @current_view

    if @source instanceof Reader.Collections.UnreadEntries
      @current_view = @unread_view ?= new Reader.Views.Entries({collection: @source, title: "Unread"})
    else if @source instanceof Reader.Collections.StarredEntries
      @current_view = @starred_view ?= new Reader.Views.Entries({collection: @source, title: "Starred"})
    else if @source instanceof Reader.Models.Feed
      @source.entries ?= new Reader.Collections.Entries
      @source.entries.feed = @source
      @source.entries.url = @source.url() + "/entries"
      if not @feeds_view["feed_#{@source.id}"]?
        @feeds_view["feed_#{@source.id}"] = new Reader.Views.Entries({collection: @source.entries, title: @source.get("title")})
      @current_view = @feeds_view["feed_#{@source.id}"]

    if not $.contains(@el, @current_view.el)
      @$el.append(@current_view.render().el)
      @current_view.load()

    @current_view.$el.show();
    Reader.menu_manager.hide_menu()
    $(window).resize()
