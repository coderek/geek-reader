class Reader.Views.Menu extends Backbone.View
  initialize: ->
    @feeds_menu = new Reader.Views.Categories

    $(".empty").click @new_sub
  el: "#menu"
  events:
    "click .new_sub": "new_sub"
    "click [class$=refresh]": "refresh_feeds"

  refresh_feeds: ->
    Reader.feeds.refresh()

  new_sub: (ev)->
    ev.preventDefault()
    form = new Reader.Views.NewFeed
    $("body").append(form.render().el)
    $("[name=feed_source]").focus()

  add_new_feed: (feed)->
    @$(".feeds").append((new Reader.Views.Feed(model:feed)).render().el)
    @$(".btn.new").button('reset')

  load_feeds: ->
    @$(".feeds").empty()
    Reader.feeds.each(@add_new_feed)