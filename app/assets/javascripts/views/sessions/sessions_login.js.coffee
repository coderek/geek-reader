class Reader.Views.Login extends Backbone.View
  initialize: ->
  template: JST['sessions/login']
  events:
    "click button" : "login"
    "click form a" : "close"

  tagName: "div"
  className: "login container"
  close: ->
    @remove()
  login: (ev)->
    ev.preventDefault()
    username = @$("[name=username]").val()
    password = @$("[name=password]").val()
    remember = @$("[name=remember]").is(":checked")
    Reader.session.clear()
    Reader.session.save {username: username, password: password, remember: remember},
      success: =>
        Reader.session.trigger("logged_in")
        @remove()
      error: ->
        alert "Username or password is wrong."
  render: ->
    @$el.html(@template())
    @
