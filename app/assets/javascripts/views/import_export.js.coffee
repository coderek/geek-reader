class Reader.Views.ImportExport extends Backbone.View
  className: "tab-pane"
  id: "settings_import"
  template: JST["popups/settings/_import"]
  initialize: ->
    @render()

  events:
    "change [type=file]" : "handle_file"

  handle_file: (ev)->
    file_obj = ev.target.files[0]

    if file_obj.name.match(/\.opml$/) is null
      alert "Please choose a correct OPML file."
      return

    $(ev.target).attr("disabled", true)
    reader = new FileReader()
    reader.readAsText(file_obj, "UTF-8")
    reader.onload = (ev)->
      file_content = ev.target.result
      $(ev.target).attr("disabled", false)
      request = $.post "/import_feeds", {file_content: file_content}
      request.done -> window.location.reload()
      @$(ev.target).append("Please wait...")
    reader.onerror = (ev)->
      $(ev.target).attr("disabled", false)

  render: ->
    @$el.html @template()
    @