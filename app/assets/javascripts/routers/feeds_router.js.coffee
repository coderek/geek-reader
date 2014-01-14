class Reader.Routers.Feeds extends Backbone.Router
  routes:
    "feeds/:id": "show_feed"

  show_feed: (fid)->
    Reader.menu.show() unless Reader.menu.is_shown()
    feed = Reader.feeds.get(fid)
    return unless feed?
    entries = new Reader.Collections.Entries
    entries.url = "/feeds/#{feed.get("id")}/entries"
    entriesView = new Reader.Views.Entries({collection: entries, feed: feed})
    $(".content").html(entriesView.render().el)
    $(".feed_title span").text(feed.get("title"))

