class Reader.Views.MenuManager extends Backbone.View
  el: "#menu"

  initialize: ->
    @feeds_menu = new Reader.Views.Categories

  events:
    "click .new_sub": "new_sub"
    "click .feed, .unread, .starred": "toggle_menu"
    "click .unread":"show_unread"

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

  toggle_menu: ->
    $("body>.container").toggleClass("show_menu")

  show_menu: ->
    $("body>.container").addClass("show_menu")

  hide_menu: ->
    $("body>.container").removeClass("show_menu")

  show_unread: ->

