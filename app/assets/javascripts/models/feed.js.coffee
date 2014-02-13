class Reader.Models.Feed extends Backbone.Model
  initialize: ->
    @entries = new Reader.Collections.FeedEntries
    @entries.feed = @
    @entries.url = "/feeds/"+@id + "/entries"

    @on "change:id", =>
      @entries.url = "/feeds/"+@id + "/entries"

  urlRoot: "/feeds"
  get_url: ->
    "#feeds/#{@get("category_id")}/#{@id}"
