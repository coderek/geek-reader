class Reader.Views.Entry extends Backbone.View

  template: JST['feeds/entry']

  initialize: (options) ->

  events:
    "click": "open"
  open: ->
    $("body").append(JST["feeds/article"](entry: @model))
  render: ->
    @$el.html(@template(entry:@model))
    @
