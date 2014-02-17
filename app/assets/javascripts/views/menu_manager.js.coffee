class Reader.Views.MenuManager extends Backbone.View
  el: "div.menu_col"

  initialize: ->
    @cats_menu = new Reader.Views.Categories(collection: Reader.categories)

  events:
    "click #menu .new_sub": "new_sub"
    "click .head .settings": "show_settings"
    "click .head .import": "show_import"
    "click .head .toggle_fullscreen": "toggle_fullscreen"
    "click #menu .unread" : "show_unread"
    "click #menu .starred" : "show_starred"

  toggle_fullscreen: ->
    $("body").toggleClass("fullscreen")

  show_unread: ->
    Backbone.history.navigate("unread", trigger: true)
    return false

  show_starred: ->
    Backbone.history.navigate("starred", trigger: true)
    return false

  new_sub: (ev)->
    ev.preventDefault()
    form = new Reader.Views.NewFeed
    $("body").append(form.render().el)
    $("[name=feed_source]").focus()

  show_menu: ->
    $("body>.container").addClass("show_menu")

  hide_menu: ->
    $("body>.container").removeClass("show_menu")

  show_settings: (tab)->
    @hide_menu()
    settings = new Reader.Views.Settings
    $("body").append(settings.render(tab).el)
    @$(".dropdown").removeClass("open")
    return false

  show_import: ->
    @show_settings("import")
