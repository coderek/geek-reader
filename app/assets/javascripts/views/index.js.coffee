class Reader.Views.Index extends Backbone.View
  initialize: ->
    @session = @model
    @feeds = new Reader.Collections.Feeds
    @feeds.fetch() if @session.has("id")
    @listenTo @feeds, "add", @add_new_feed

  template: JST['index']
  events:
    "click .btn.new": "new_feed"

  new_feed: (ev)->
    @$(".btn.new").button('loading')
    ev.preventDefault()
    feed = new Reader.Models.Feed
    @feeds.create({url: @$("[name=feed_source]").val()}, {wait:true, error: (model, resp) => @error_add_feed(resp.status)})

  error_add_feed: (status)->
    if status is 422
      alert("already added")
    else if status is 404
      alert("feed is not found")
    @$(".btn.new").button('reset')

  add_new_feed: (feed)->
    @$(".feeds").append((new Reader.Views.Feed(model:feed)).render().el)
    @$(".btn.new").button('reset')
  render: ->
    @$el.html(@template({session: @session.toJSON()}))
    @

