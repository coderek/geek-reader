class Reader.Views.Menu extends Backbone.View
  initialize: ->
    @listenTo Reader.feeds, "add", @add_new_feed
    @shown = false

  el: ".menu"
  events:
    "click .new_sub": "new_sub"
  new_sub: (ev)->
    ev.preventDefault()
    form = new Reader.Views.NewFeed
    $("body").append(form.render().el)

  add_new_feed: (feed)->
    @$(".feeds").append((new Reader.Views.Feed(model:feed)).render().el)
    @$(".btn.new").button('reset')

  show: ->
    Reader.feeds.fetch()
    @$el.show()
    @shown = true
  hide: ->
    @$el.hide()
    @shown = false

  is_shown: -> @shown
