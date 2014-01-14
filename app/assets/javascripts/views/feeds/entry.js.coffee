class Reader.Views.Entry extends Backbone.View

  tagName: "li"
  initialize: (options) ->

  events:
    "click": "open"
  open: ->
    if @articleView
      @articleView.show()
    else
      @articleView = new Reader.Views.Article(model: @model)
      $(".articles").append(@articleView.render().el)
  render: ->
    @$el.html(@model.get("title"))
    @
