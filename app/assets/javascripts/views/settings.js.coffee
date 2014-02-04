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
    "click button": "add_category"
    "click .edit" : "edit_category"
    "click .delete" : "delete_category"

  edit_category: ->

  delete_category: (ev)->
    id = $(ev.target).parent().data("id")
    cat = Reader.categories.get(id)
    if cat?
      cat.destroy()
      Reader.flashMessage("Feeds under #{cat.get("name")} are moved to Deafult")

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

  render: ->
    @$el.html "loading"
    Reader.categories.load_all_feed().done =>
      @$el.html @template(cats: Reader.categories)
    @

class Reader.Views.Settings extends Backbone.View
  tagName: "div"

  id: "settings"

  template: JST["popups/settings/settings"]

  events:
    "click .nav-tabs a": "toggle_tabs"
    "click .close" : "close"

  close: ->
    @remove()

  initialize: ->
    @render()

  toggle_tabs: (ev)->
    $(ev.target).tab('show')

  render: ->
    @$el.html @template()
    settings_categories = new Reader.Views.SettingsCategories
    @$(".tab-content").append(settings_categories.el)
    settings_feeds = new Reader.Views.SettingsFeeds
    @$(".tab-content").append(settings_feeds.el)
    @
