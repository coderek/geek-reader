class Reader.Routers.Sessions extends Backbone.Router
  routes:
    "login": "login"
    "logout": "logout"
    "register":"register"
    "" : "index"
    "index" : "index"

  initialize: ->
    Reader.session.on "logged_in", =>
      @navigate("index", trigger:true)
    Reader.session.on "destroy", =>
      Reader.session.clear()
      @navigate("index", trigger:true)
    Reader.session.fetch
      success: =>
        if Reader.session.has("id")
          @navigate("index", trigger:true)
        else
          @navigate("login", trigger:true)
        Backbone.history.start()
      error: =>
        @navigate("login", trigger:true)
        Backbone.history.start()

  register: ->
    registerView = new Reader.Views.Register
    $(".content").html(registerView.render().el)

  login: ->
    loginView = new Reader.Views.Login
    $(".content").html(loginView.render().el)

  logout: ->
    Reader.session.destroy({wait:true})

  index: ->
    indexView = new Reader.Views.Index
    $(".content").html(indexView.render().el)
