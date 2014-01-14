class Reader.Views.Feed extends Backbone.View
  tagName: "li"
  className: "list-unstyled"
  initialize: ->
    @listenTo @model, "destroy", @remove

  render: ->
    @$el.html "<a href=\"#feeds/#{@model.get("id")}\">#{@model.get("title")}</a>"
    @
