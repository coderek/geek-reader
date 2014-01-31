# understanding backbone 3

1. In Backbone App, Router should not be over-used to navigate across different pages. If two pages does not belong
to the same application, for instance, login page and the app itself, a separate page load should be load for
that page.

2. Manage session in backbone app, don't try to manage the session entirely by backbone, that will be painful and
messy. Use cookie to do that automatically for you, if the app is hosted in-bound.

3. Use deferred objects to control asynchronous states
  I want to load hierachical models lazily. Category(loaded initially) -> Feed(loaded when category menu expand)

  now I want to load a page that contains both feeds and category, for instance, a user left out on a page /category/1/feeds/3 and
  come back later to refresh the page.

  Use deferred objects can accomplish this.

  in the category object, I have a state instance variable which is type defered object.

  cat view -----asynchronous---> fetch data --> @loaded.resolve()
     |     \
     |      \
     | @loaded = new $.Deferred()
     |                 \
   router               \
     |                   \
     |                    \
     V                     \
 show cat-- but not ready--- @loaded.done -> show it then