class Reader.Models.Entry extends Backbone.Model
  initialize: ->
    @feed = Reader.categories.find_feed(@get("feed_id"))