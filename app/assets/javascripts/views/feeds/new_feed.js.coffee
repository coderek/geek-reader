class Reader.Views.NewFeed extends Backbone.View
  template: JST["popups/new_feed"]
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

    cat_id = @$("#feed_category").val()
    cat = Reader.categories.get(cat_id)
    cat.feeds.create(
      {
        feed_url: @$("#feed_source").val()
        category_id: cat_id
        secondary_fetch: ~~@$("#secondary_fetch").is(":checked")
      },
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

