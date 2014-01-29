# understanding backbone 3

1. In Backbone App, Router should not be over-used to navigate across different pages. If two pages does not belong
to the same application, for instance, login page and the app itself, a separate page load should be load for
that page.

2. Manage session in backbone app, don't try to manage the session entirely by backbone, that will be painful and
messy. Use cookie to do that automatically for you, if the app is hosted in-bound.

