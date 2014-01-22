class Reader.Collections.Entries extends Backbone.Collection
  model: Reader.Models.Entry

  refresh: ->
    req = $.get(@url+"/refresh")
    req.done (entries)=>
      @set(entries, {remove: false})
      @trigger("refreshed")

  comparator: (m1, m2) ->
    # newer will be put in front
    if m1.get("published") > m2.get("published") then 1 else -1
