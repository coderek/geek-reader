class Reader.Routers.Sessions extends Backbone.Router
  routes:
    "login"     : "login"
    "logout"    : "logout"
    "register"  : "register"
    ""          : "index"
    "index"     : "index"
    "feeds/:id" : "show_feed"

  initialize: ->
    Reader.session.on "logged_in", =>
      load_user_ui()
      load_feeds()
      @navigate("index", trigger:true)
    Reader.session.on "destroy", =>
      Reader.session.clear()
      Reader.feeds.remove(Reader.feeds.models)
      @navigate("login", trigger:true)

    load_session = ->
      def = new $.Deferred()
      Reader.session.fetch
        success: -> def.resolve()
        error: -> def.reject()
      return def.promise()

    load_feeds = ->
      def = new $.Deferred()
      Reader.feeds.fetch
        success: -> def.resolve()
        error: -> def.reject()
      return def.promise()

    load_user_ui = ->
      $(".main.container").html(JST["index"]())
      Reader.menu = new Reader.Views.Menu
      Reader.menu.load_feeds()
      $(".session a").html("Welcome #{Reader.session.get("username")}!")

    $.when(load_session(), load_feeds()).then(
      =>
        load_user_ui()
        @navigate("index", trigger:true)
      ,
      =>
        @navigate("login", trigger:true) if Backbone.history.fragment isnt "register"
    ).always -> Backbone.history.start()

    #    $.ajaxSend ->
    $(document).ajaxComplete (ev, req, options)=>
      if req.status is 401
        @navigate("login", trigger:true)  if Backbone.history.fragment isnt "register"

  register: ->
    registerView = new Reader.Views.Register
    $("body").append(registerView.render().el)

  login: ->
    loginView = new Reader.Views.Login
    $("body").append(loginView.render().el)

  logout: ->
    Reader.session.destroy({wait:true})

  index: ->
    $(".content").html("Please add subscription from left menu")

  show_feed: (fid)->
    feed = Reader.feeds.get(fid)
    return unless feed?
    entries = new Reader.Collections.Entries
    entries.url = "/feeds/#{feed.get("id")}/entries"
    entriesView = new Reader.Views.Entries({collection: entries, feed: feed})
    $(".content").html(entriesView.render().el)
    $(".feed_title span").text(feed.get("title"))