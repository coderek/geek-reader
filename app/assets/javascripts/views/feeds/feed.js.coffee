class Reader.Views.Feed extends Backbone.View
  tagName: "li"
  className: "list-unstyled"
  template: JST["feeds/index"]
  initialize: ->
    @listenTo @model, "destroy", @remove

  render: ->
    @$el.html @template(feed: @model)
    @
