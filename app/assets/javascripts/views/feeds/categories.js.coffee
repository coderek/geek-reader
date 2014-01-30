class Reader.Views.Categories extends Backbone.View
  el: "#categories"
  initialize: ->
    @cat_views = {}
    Reader.categories.on "reset", (cats)=>
      cats.each (cat)=>
        catView = new Reader.Views.Category(model: cat)
        @$el.append catView.render().el
        @cat_views["cat_#{cat.id}"] = catView

  open_feed: (id, fid)->
    log "setting defered object"
    @cat_views["cat_#{id}"].loaded.done ->
      log "category is loaded"
      $(".feed[data-id=#{fid}] a").click()
    # need to open it first
    @cat_views["cat_#{id}"].open()
