class Reader.Views.Menu extends Backbone.View
  initialize: ->
    @listenTo Reader.feeds, "add", @add_new_feed

  el: ".menu_col"
  events:
    "click .new_sub": "new_sub"
    "click [role=logout] a":"logout"

  logout: ->
    Reader.session.destroy()

  new_sub: (ev)->
    ev.preventDefault()
    debugger
    form = new Reader.Views.NewFeed
    $("body").append(form.render().el)

  add_new_feed: (feed)->
    @$(".feeds").append((new Reader.Views.Feed(model:feed)).render().el)
    @$(".btn.new").button('reset')

  load_feeds: ->
    @$(".feeds").empty()
    Reader.feeds.each(@add_new_feed)