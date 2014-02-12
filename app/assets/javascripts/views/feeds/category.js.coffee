class Reader.Views.Category extends Backbone.View
  template: JST["feeds/category"]
  tagName: "li"
  className: "category"
  initialize: ->
    # now the feeds under this category are already loaded
    @$el.html @template(model: @model)
    @listenTo @model, "destroy", @remove
    @listenTo @model, "change:name", @update_name
    @listenTo @model.feeds, "add", @add_feed
    @listenTo @model.feeds, "reset", @add_feeds

  events:
    "click >div":"toggle"
    "dragover":"dragover"
    "dragleave":"dragleave"
    "drop":"dropped"

  update_name: ->
    @$(".cat_name").text(@model.get("name"))

  dropped: (ev)->
    data = JSON.parse ev.originalEvent.dataTransfer.getData("application/json")
    cat = Reader.categories.get(data.category_id)
    return false unless cat?
    feed = cat.feeds.get(data.feed_id)
    return false unless feed?
    cat.feeds.remove(feed)
    feed.save("category_id", @model.id)
    @model.feeds.add(feed)
    @$el.removeClass("over")
    @open()

  dragleave: ->
    @$el.removeClass("over")

  dragover: ->
    @$el.addClass("over")
    return false

  toggle: (ev)->
    return true if $(ev.target).is("a")
    return @open() unless @$el.is(".open")

    @$el.removeClass("open")
    @$(".feeds").hide()

  open_category_entries: ->
    Backbone.history.navigate("/category/#{@model.id}", trigger: true)

  expand: ->
    return if @$el.hasClass("open")
    @$el.addClass("open")
    if @$(".feeds").children().length isnt @model.feeds.length
      @add_feeds(@model.feeds)
    @$(".feeds").show()

  open: ->
#    @open_category_entries()
    @expand()

  open_feed: (fid)->
    @expand()
    feed = @model.feeds.get(fid)
    if feed?
      feed.trigger("open")
    else
      Backbone.history.navigate("#", trigger:true)

  add_feeds: (feeds)->
    @$(".feeds").empty()
    feeds.each @add_feed, @

  add_feed: (feed)->
    idx = @model.feeds.indexOf(feed)
    view = @$(".feeds >:nth-child(#{idx+1})")
    if view.length>0
      $((new Reader.Views.Feed(model: feed)).render().el).insertBefore view
    else
      @$(".feeds").append (new Reader.Views.Feed(model: feed)).render().el

  render: ->
#    @add_feed(feed) for feed in @model.feeds.models
    @