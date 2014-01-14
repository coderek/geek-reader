class Reader.Views.Article extends Backbone.View

  template: JST["feeds/article"]
  tagName: "div"
  className: "article"
  events:
    "click .close": "close"
  close: -> @hide()
  render: ->
    @$el.html @template(entry: @model)
    @show()
    @
  show: ->
    $(".article.show").removeClass("show")
    @$el.addClass("show")
  hide: ->
    @$el.removeClass("show")