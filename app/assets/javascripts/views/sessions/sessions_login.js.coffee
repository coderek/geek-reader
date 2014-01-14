class Reader.Views.Login extends Backbone.View
  initialize: ->
  template: JST['sessions/login']
  events:
    "click button" : "login"

  login: (ev)->
    ev.preventDefault()
    username = @$("[name=username]").val()
    password = @$("[name=password]").val()
    Reader.session.clear()
    Reader.session.set {username: username, password: password}
    Reader.session.save {},
      success: =>
        Reader.session.trigger("logged_in")
      error: ->
  render: ->
    @$el.html(@template())
    @
