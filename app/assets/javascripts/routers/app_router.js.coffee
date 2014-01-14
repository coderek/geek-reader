class Reader.Routers.App extends Backbone.Router
  routes :
    "": "index"
    "login": "login"
    "register": "register"
    "logout": "logout"
    "feeds": "feeds"

  initialize: ->
    @session = new Reader.Models.Session
    @session.on "logged_in", => @navigate("feeds", trigger: true)
    @session.on "destroy", => @navigate("index", trigger: true)
    Backbone.history.start()

  index: ->
    $(".container").html(JST["reader_index"]())

  register: ->
    registerView = new Reader.Views.Register
    $(".container").html(registerView.render().el)

  login: ->
    loginView = new Reader.Views.Login(model: @session)
    $(".container").html(loginView.render().el)

  logout: ->
    @session.destroy()

  feeds: ->
    $(".container").html("this is feeds")