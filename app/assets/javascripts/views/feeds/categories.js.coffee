class Reader.Views.Categories extends Backbone.View
  el: "#categories"
  initialize: ->
    @cat_views = {}
    @listenTo Reader.categories, "reset", @render_cats
    @listenTo Reader.categories, "add", @render_cat

  render_cats: (cats)->
    cats.each @render_cat.bind(@)

  render_cat: (cat)->
    catView = new Reader.Views.Category(model: cat)
    @$el.append catView.render().el
    @cat_views["cat_#{cat.id}"] = catView

  open_feed: (id, fid)->
    the_view = @cat_views["cat_#{id}"]
    the_view.open()
    the_view.open_feed(fid)
