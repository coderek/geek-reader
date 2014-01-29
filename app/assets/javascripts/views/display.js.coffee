class Reader.Views.Display extends Backbone.View
  el: ".content_col"
  events:
    "click .feed_title i": "toggle_menu"

  toggle_menu: ->
    $("body>.container").toggleClass("show_menu")