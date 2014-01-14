class Reader.Views.Index extends Backbone.View
  initialize: ->

  template: JST['index']

  render: ->
    @$el.html(@template({session: Reader.session.toJSON()}))

    if Reader.session and Reader.session.has("username")
      $(".session").html("Welcome #{Reader.session.get("username")}! <a href=\"#logout\">logout</a>")
      Reader.menu.show()
    else
      $(".session").empty()
      Reader.menu.hide()
    @

