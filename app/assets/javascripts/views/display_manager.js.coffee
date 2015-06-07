class Reader.Views.DisplayManager extends Backbone.View
  el: "div.content_col"

  initialize: ->
    @unread_view = null
    @starred_view = null
    # table storing feed views
    @feeds_view = {}
    @categories_view = {}
    @current_view = null

  render_entries: (@source_entries)->
    @current_view?.$el.hide()
    title =   @source_entries.title \
          ||  @source_entries.get("title") \
          || (@source_entries.feed? and @source_entries.feed.get("title")) \
          || "Unnamed"

    if @source_entries instanceof Reader.Collections.UnreadEntries
      @current_view = @unread_view ?= new Reader.Views.Entries({collection: @source_entries, title: title})

    else if @source_entries instanceof Reader.Collections.StarredEntries
      @current_view = @starred_view ?= new Reader.Views.Entries({collection: @source_entries, title: title})

    else if @source_entries instanceof Reader.Collections.CategoryEntries
      @categories_view[title] ?= new Reader.Views.Entries({collection: @source_entries, title: title})
      @current_view = @categories_view[title]

    else if @source_entries instanceof Reader.Collections.FeedEntries
      @feeds_view[title] ?= new Reader.Views.Entries({collection: @source_entries, title: title})
      @current_view = @feeds_view[title]

    if not $.contains(@el, @current_view.el)
      @$el.append(@current_view.render().el)
      @current_view.load()

    @current_view.$el.show();
    Reader.menu_manager.hide_menu()
    $(window).resize()
