# composite view

# menu view
# display view

class Reader.Views.Main extends Backbone.View
  el: "#main"
  initialize: ->
    @menu = new Reader.Views.Menu
    @display = new Reader.Views.Display
    @router = new Reader.Routers.Feeds