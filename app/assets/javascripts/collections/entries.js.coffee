class Reader.Collections.Entries extends Backbone.Collection
  model: Reader.Models.Entry

  refresh: ->
    req = $.get(@url+"/refresh")
    req.done (entries)=>
      @set(entries, {remove: false})
      @trigger("refreshed")

  comparator: (m1, m2) ->
    if m1.get("published")? and m2.get("published")?
      if m1.get("published") > m2.get("published") then -1 else 1
    else
      if m1.get("created_at") > m2.get("created_at") then -1 else 1

  mark_read: (age) ->
    post_path = @url.slice(0, - "entries".length - 1)+"/mark_read"

    switch age
      when "all"
        req = $.post post_path
      when "1day"
        req = $.post post_path, {age: "1day"}
      when "1week"
        req = $.post post_path, {age: "1week"}

    update_locals = (ids)=>
      _.each ids, (id)=>
        e = @get(id)
        e.set({is_read: 1}) if e?
      return

    update_feed_unread_count = (ids)=>
      decrement_count = _.difference(ids, @pluck("id")).length
      log "update_feed_unread_count #{decrement_count}"
      Reader.update_unread(@feed.id, - decrement_count  ) if @feed?

    req.done(update_locals, update_feed_unread_count)

  destroy: ->
    @feed.destroy() if @feed?


