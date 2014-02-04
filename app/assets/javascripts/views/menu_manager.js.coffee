class Reader.Views.MenuManager extends Backbone.View
  el: "div.menu_col"

  initialize: ->
    @cats_menu = new Reader.Views.Categories(collection: Reader.categories)

  events:
    "click #menu .new_sub": "new_sub"
    "click #menu .feed, .unread, .starred": "hide_menu"
    "click .head .settings": "settings"

  new_sub: (ev)->
    ev.preventDefault()
    form = new Reader.Views.NewFeed
    $("body").append(form.render().el)
    $("[name=feed_source]").focus()

  show_menu: ->
    $("body>.container").addClass("show_menu")

  hide_menu: ->
    $("body>.container").removeClass("show_menu")

  settings: ->
    Reader.settings = new Reader.Views.Settings
    if not $.contains($("body"), Reader.settings.el)
      $("body").append(Reader.settings.el)
    @$("dropdown").removeClass("open")
    return false
