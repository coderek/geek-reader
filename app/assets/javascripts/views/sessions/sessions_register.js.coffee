class Reader.Views.Register extends Backbone.View

  template: JST['sessions/register']
  render: ->
    @$el.html(@template())
    @
