class Reader.Views.Login extends Backbone.View
  initialize: ->
    @session = @model

  template: JST['sessions/login']
  events:
    "click button" : "login"

  login: (ev)->
    ev.preventDefault()
    username = @$("[name=username]").val()
    password = @$("[name=password]").val()
    @session.set {username: username, password: password}
    @session.save {},
      success: =>
        @session.trigger("logged_in")
      error: ->
  render: ->
    @$el.html(@template())
    @
