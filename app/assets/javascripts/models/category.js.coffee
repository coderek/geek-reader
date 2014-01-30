class Reader.Models.Category extends Backbone.Model
  parse: (data)->
    @feeds = new Reader.Collections.Feeds
    @feeds.url = "/categories/#{data.id}/feeds"
    data