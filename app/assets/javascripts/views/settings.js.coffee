class Reader.Views.SettingsCategories extends Backbone.View
  tagName: "div"
  className: "tab-pane active"
  id: "settings_categories"
  template: JST["popups/settings/_categories"]
  initialize: ->
    @render()
    @listenTo Reader.categories, "add", @render
    @listenTo Reader.categories, "destroy", @render

  events:
    "click .add": "add_category"
    "click .edit" : "edit_category"
    "click .delete" : "delete_category"

  edit_form :
    """
    <div class='form-inline edit_name'>
      <div class='form-group'>
        <input type='text' class='form-control' placeholder='new name'/>
        <button class='btn btn-primary save'>save</button>
        <button class='btn cancel'>cancel</button>
      </div>
    </div>
    """

  edit_category: (ev)->
    cat_li = @$(ev.target).closest("li")
    cat = Reader.categories.get(cat_li.data("id"))
    return if cat_li.find(".edit_name").length > 0

    cat_li.append(@edit_form)

    cat_li.find(".save").click =>
      cat.save({name: cat_li.find("input").val()}, {patch: true, success:=> cat_li.find("span").text(cat.get("name"))})
      cat_li.find(".edit_name").remove()

    cat_li.find(".cancel").click =>
      cat_li.find(".edit_name").remove()


  delete_category: (ev)->
    id = $(ev.target).parent().data("id")
    cat = Reader.categories.get(id)
    if cat?
      cat.destroy()
      Reader.flash_message("Feeds under #{cat.get("name")} are moved to Deafult")

  add_category: ->
    Reader.categories.create({name: @$("input").val()}, {wait: true})

  render: ->
    @$el.html @template(cats: Reader.categories)
    @

class Reader.Views.SettingsFeeds extends Backbone.View
  tagName: "div"
  className: "tab-pane"
  id: "settings_feeds"
  template: JST["popups/settings/_feeds"]
  initialize: ->
    @render()

  events:
    "click .edit" : "edit_feed"
    "click .delete" : "delete_feed"

  edit_form :
    """
      <div class='form-inline edit_name'>
        <div class='form-group'>
          <input type='text' class='form-control' placeholder='new name'/>
          <button class='btn btn-primary save'>save</button>
          <button class='btn cancel'>cancel</button>
        </div>
      </div>
      """

  edit_feed: (ev)->
    feed_li = $(ev.target).closest("li")
    id = feed_li.data("id")
    feed = @collection.get(id)
    return if feed_li.find(".edit_name").length > 0
    feed_li.append(@edit_form)
    feed_li.find(".save").click =>
      feed.save({title: feed_li.find("input").val()}, {patch: true, success:=> feed_li.find("span").text(feed.get("title"))})
      feed_li.find(".edit_name").remove()

    feed_li.find(".cancel").click =>
      feed_li.find(".edit_name").remove()


  delete_feed: (ev)->
    feed_li = $(ev.target).closest("li")
    id = feed_li.data("id")
    feed = @collection.get(id)
    if feed?
      feed.destroy({wait: true, success: => feed_li.remove()})
      Reader.flash_message("Feed #{feed.get("title")} is removed")

  render: ->
    @$el.html @template(feeds: @collection.models)
    @

class Reader.Views.Settings extends Backbone.View
  tagName: "div"

  id: "settings"

  template: JST["popups/settings/settings"]

  events:
    "click .nav-tabs a": "toggle_tabs"
    "click .close" : "close"
    "click" : "close"

  close: (ev)->
    @remove() if ev.target is ev.currentTarget

  initialize: ->
    @$el.html @template()
    @feeds = []
    Reader.categories.load_all_feed().done =>
      Reader.categories.each (cat)=>
        models = cat.feeds.models
        @feeds = @feeds.concat models
      @render()

  toggle_tabs: (ev)->
    $(ev.target).tab('show')

  render: ->
    @$(".tab-content").empty()
    settings_categories = new Reader.Views.SettingsCategories
    @$(".tab-content").append(settings_categories.el)
    settings_feeds = new Reader.Views.SettingsFeeds(collection: new Backbone.Collection @feeds)
    @$(".tab-content").append(settings_feeds.el)
    @
