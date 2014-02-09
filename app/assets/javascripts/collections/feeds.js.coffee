class Reader.Collections.Feeds extends Backbone.Collection
  url: "/feeds"
  model: Reader.Models.Feed
  comparator: (f1, f2)->
    if f1.get("title") < f2.get("title") then -1 else 1