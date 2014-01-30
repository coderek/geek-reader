class Reader.Collections.UnreadEntries extends Backbone.Collection
  model: Reader.Models.Entry
  url: "/entries/unread"

  comparator: (m1, m2) ->
    # newer will be put in front
    if m1.get("published") > m2.get("published") then 1 else -1
