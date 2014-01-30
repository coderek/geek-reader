class Reader.Routers.Main extends Backbone.Router
  routes:
    "" : "home"
    "feeds/:cid/:id" : "show_feed"
    "unread" : "show_unread"
    "starred" : "show_starred"

  initialize: ->

    resize_height = ->
      h = $(".content:visible .head").outerHeight(true)
      $(".content:visible .body").height($(window).outerHeight(true) - h)
      log "resize: #{h}, #{$(window).outerHeight(true)}"
    $(window).resize (ev) -> resize_height()

    got_categories = ->
      d = $.Deferred()
      Reader.categories.fetch {reset: true, parse: true, success: -> d.resolve()}
      d.promise()

    $.when(got_categories()).done ->
      Backbone.history.start()

  show_feed: (cid, fid)->
    cat = Reader.categories.get(cid)
    feed = cat.feeds.get(fid)
    feed.trigger("show_entries")

  show_unread: ->
#    Reader.unread_entries.fetch(reset: true)
    Reader.display_manager.render_entries(Reader.unread_entries)

  show_starred: ->
#    Reader.starred_entries.fetch(reset: true)
    Reader.display_manager.render_entries(Reader.starred_entries)

  home: ->
    # for mobile
    Reader.menu_manager.show_menu()

