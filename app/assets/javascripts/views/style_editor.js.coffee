class Reader.Views.StyleEditor extends Backbone.View
  id: "style_editor"
  template: JST["feeds/editor"]

  initialize: ->
    @render()
    $("body").append(@$el)
    @editor = ace.edit("editor");
    @editor.setTheme("ace/theme/twilight");
    @editor.getSession().setMode("ace/mode/scss");

  render: ->
    @$el.html @template()
    @$el.hide()
    @

  events:
    "click .btn-primary": "save"
    "click .btn": "close"

  save: ->
    style = @editor.getValue()
    @feed.save({style: style}, {patch: true})
    return false

  close: ->
    @$el.fadeOut()

  show: (@feed)->
    if @feed.get("style")? and not @feed.get("style").match /(^$)|(^\W+$)/
      @editor.setValue(feed.get("style"))
    else
      @editor.setValue(@$("#template").text())
    @$el.fadeIn()

