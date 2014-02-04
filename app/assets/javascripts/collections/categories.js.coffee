class Reader.Collections.Categories extends Backbone.Collection
  url: "/categories"
  model: Reader.Models.Category
  find_feed: (feed_id)->
    for cat in @models
      f = cat.feeds.get(feed_id)
      return f if f?

  initialize: ->
    @all_feeds_are_loaded = $.Deferred()
    @on "destroy", @move_feeds

  move_feeds: (cat)->
    default_cat = @where({name: "Default"}, true)
    return unless default_cat?
    cat.feeds.each (feed)=>
      feed.set("category_id", default_cat.id)
      default_cat.feeds.add(feed)

  load_all_feed: ->
    count = @length
    @each (cat)=>
      cat.load_feeds()
      cat.feeds_are_loaded.done =>
        count = count - 1
        @all_feeds_are_loaded.resolve() if count is 0
    return @all_feeds_are_loaded