class Reader.Models.Feed extends Backbone.Model
  urlRoot: "/feeds"
  get_url: ->
    "#feeds/#{@get("category_id")}/#{@id}"
