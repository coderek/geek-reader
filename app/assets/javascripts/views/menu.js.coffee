class Reader.Views.Menu extends Backbone.View
  initialize: ->
    @listenTo Reader.feeds, "add", @add_new_feed
    @feeds_folder_closed = true

  el: ".menu_col"
  events:
    "click .new_sub": "new_sub"
    "click [role=logout] a":"logout"
    "click .all":"toggle_subs"

  toggle_subs: (ev)->
    @$(".feeds").toggle()
    $(ev.currentTarget).find("i").toggleClass("glyphicon-folder-close")
    $(ev.currentTarget).find("i").toggleClass("glyphicon-folder-open")
    @feeds_folder_closed = !@feeds_folder_closed

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