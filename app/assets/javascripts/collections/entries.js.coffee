class Reader.Collections.Entries extends Backbone.Collection
  model: Reader.Models.Entry

  refresh: ->
    req = $.get(@url+"/refresh")
    req.done (entries)=>
      @set(entries, {remove: false})
      @trigger("refreshed")
