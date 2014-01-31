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

  mark_read: (age) ->
    post_path = @url.slice(0, - "entries".length - 1)+"/mark_read"
    update_locals = (ids)=>
      _.each ids, (id)=>
        e = @get(id)
        e.set({is_read: 1}) if e?

    switch age
      when "all"
        $.post post_path, => @each (e)-> e.set({is_read: 1})
      when "1day"
        $.post post_path, {age: "1day"}, update_locals
      when "1week"
        $.post post_path, {age: "1week"}, update_locals
