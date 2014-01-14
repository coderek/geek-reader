class Reader.Views.Register extends Backbone.View
  template: JST['sessions/register']
  events:
    "click button": "register"
  render: ->
    @$el.html(@template())
    @

  register: (ev)->
    ev.preventDefault()
    username = @$("[name=username]").val()
    password = @$("[name=password]").val()
    password_confirmation = @$("[name=password_confirmation]").val()
    user = new Reader.Models.User
    user.set {username: username, password: password, password_confirmation: password_confirmation}
    user.save()