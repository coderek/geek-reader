class Reader.Views.Login extends Backbone.View

  template: JST['sessions/login']

  render: ->
    @$el.html(@template())
    @
