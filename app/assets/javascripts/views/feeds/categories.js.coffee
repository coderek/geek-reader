# manage a folder of feeds
# organized in categories


class Reader.Views.Categories extends Backbone.View
  el: "#categories"
  initialize: ->
    Reader.categories.each (cat)=>
      @$el.append (new Reader.Views.Category(model: cat)).render().el

