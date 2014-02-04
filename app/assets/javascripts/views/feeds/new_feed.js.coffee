class Reader.Views.NewFeed extends Backbone.View
  template: JST["feeds/new_feed"]
  tagName: "form"
  className: "new_feed popup"
  attributes:
    role : "form"

  events:
    "click .btn.new": "new_feed"
    "click .btn.cancel":"close"

  render: ->
    @$el.html @template()
    @

  close: (ev)->
    ev.preventDefault() if ev?
    @remove()

  new_feed: (ev)->
    @$(".btn.new").button('loading')
    ev.preventDefault()

    cat_id = @$("[name=feed_category]").val()
    cat = Reader.categories.get(cat_id)
    cat.feeds.create(
      {url: @$("[name=feed_source]").val(), category: cat_id},
      {
        wait:true
        success: => @close()
        error: (model, resp) => @error_add_feed(resp.status)
      }
    )

  error_add_feed: (status)->
    if status is 422
      alert("already added")
    else if status is 404
      alert("feed is not found")
    @$(".btn.new").button('reset')

