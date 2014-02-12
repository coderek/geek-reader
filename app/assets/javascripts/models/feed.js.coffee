class Reader.Models.Feed extends Backbone.Model
  initialize: ->
    @entries = new Reader.Collections.FeedEntries
    @entries.feed = @
    @entries.url = @url() + "/entries"

  urlRoot: "/feeds"
  get_url: ->
    "#feeds/#{@get("category_id")}/#{@id}"
