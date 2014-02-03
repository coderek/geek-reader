class Reader.Collections.Categories extends Backbone.Collection
  url: "/categories"
  model: Reader.Models.Category
  find_feed: (feed_id)->
    for cat in @models
      f = cat.feeds.get(feed_id)
      return f if f?