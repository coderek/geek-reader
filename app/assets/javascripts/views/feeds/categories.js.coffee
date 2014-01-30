class Reader.Views.Categories extends Backbone.View
  el: "#categories"
  initialize: ->
    Reader.categories.on "reset", (cats)=>
      cats.each (cat)=>
        @$el.append (new Reader.Views.Category(model: cat)).render().el

