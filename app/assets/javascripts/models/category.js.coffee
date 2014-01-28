class Reader.Models.Category extends Backbone.Model
  parse: (data)->
    @feeds = new Reader.Collections.Feeds(data.feeds)
    data.category