Category = Backbone.Model.extend
  urlRoot: "/categories"

Categories = Backbone.Collection.extend
  model: Category

CategoryView = Backbone.View.extend
  tagName: "li"
  className: ""
  template: _.template(
    """
    <h3 class='name'><%=model.get("name")%></h3>
    <a data-method="delete" href="/categories/<%=model.get("id")%>"><i class='glyphicon glyphicon-remove-circle'></i>delete</a>
    """)

  events:
    "click h3.name" : "edit"

  edit_template : _.template(
    """
    <h3>
      <form class='form-inline'>
        <input value="<%=model.get("name")%>" class="form-control" />
        <a class='save btn btn-primary' class="form-control" href="#">save</a>
        <a class='cancel btn'  class="form-control" href="#">cancel</a>
      </form>
    </h3>
    """
  )
  edit: ->
    @$("h3.name").hide()
    @$el.prepend(@edit_template(model: @model))
    @$("form input").keypress (ev)=>
      @$(".save").click() if ev.keyCode is 13

    @$("form").submit -> false

    @$(".cancel").click =>
      @$("form").parent().remove()
      @$("h3.name").show()
      return false
    @$(".save").click =>
      @model.save({name: @$("input").val()}, {patch: true, wait: true, error: => @$("form").append("<span class='alert alert-danger'>Duplicate names</span>")})
      return false
    @model.on "change:name", =>
      @$("form").parent().remove()
      @$("h3.name").text(@model.get("name"))
      @$("h3.name").show()

  render: ->
    @$el.html @template(model: @model)
    @

CategoriesView = Backbone.View.extend
  el: "ol.categories"
  initialize: ->
    @collection.each (cat)=>
      if cat.get("name") isnt "Default"
        @$el.append (new CategoryView(model:cat)).render().el
$ ->
  categories = new Categories cat_json
  new CategoriesView(collection: categories)
