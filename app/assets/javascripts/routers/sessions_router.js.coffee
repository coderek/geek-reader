class Reader.Routers.Sessions extends Backbone.Router
  routes:
    "login": "login"
    "logout": "logout"
    "register":"register"
    "index" : "index"

  initialize: (options) ->
    @session = options.session
    @session.on "logged_in", =>
      @navigate("index", trigger:true)
    @session.on "destroy", =>
      @session.clear()
      @navigate("index", trigger:true)

  register: ->
    registerView = new Reader.Views.Register
    $(".container").html(registerView.render().el)

  login: ->
    loginView = new Reader.Views.Login(model: @session)
    $(".container").html(loginView.render().el)

  logout: ->
    @session.destroy({wait:true})

  index: ->
    indexView = new Reader.Views.Index(model: @session)
    $(".container").html(indexView. render().el)
