class Reader.Routers.Sessions extends Backbone.Router
  routes:
    "" : "login"
    "register": "register"
    "login": "login"

  initialize: ->
    @model = new Reader.Models.Session

  register: ->
    registerView = new Reader.Views.Register
    $(".container").html(registerView.render().el)

  login: ->
    loginView = new Reader.Views.Login(model: @model)
    $(".container").html(loginView.render().el)
