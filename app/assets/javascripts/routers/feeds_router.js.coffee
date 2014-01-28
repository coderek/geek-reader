class Reader.Routers.Feeds extends Backbone.Router
  routes:
    "feeds/:cid/:id" : "show_feed"

  initialize: ->
    resize_height = ->
      $("#menu").height($(window).height() - 70)
      $(".content").height($(window).height() - 70)

    $(window).resize (ev) -> resize_height()

    Backbone.history.start()
    $(window).resize()

  show_feed: (cid, fid)->
    $(".empty").remove()
    cat = Reader.categories.get(cid)
    feed = cat.feeds.get(fid)
    return unless feed?
    feed.trigger("show_entries")
