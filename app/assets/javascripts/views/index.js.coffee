class Reader.Views.Index extends Backbone.View
  initialize: ->
    @session = @model

  template: JST['index']

  render: ->
    @$el.html(@template({session: @session.toJSON()}))
    @
