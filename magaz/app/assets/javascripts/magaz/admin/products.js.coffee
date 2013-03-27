@Magaz_admin_products = {}
Products = @Magaz_admin_products

Products.index = ->
  Magaz.Common.delete_ajax_btn()

  CategoryContol()

CategoryContol = ->
  # --- Model
  class Category extends Serenade.Model
    @property "id", serialize: true
    @property "name", serialize: true
    save: -> $.post '/admin/categories', @.toJSON(), (id) => @id = id


  class Model extends Serenade.Model
    @property "categories", "editor"

    constructor: ->
      @categories = new Serenade.Collection()
      @editor = new Category(name: 'new') # will be instance of editing category
    

  model = new Model()
  window.model = model

  # --- Contorller
  class EditorCtrl
    save: ->
      $('.category-editor', cnt).modal('hide')
      model.editor.name = $('.category-editor .name', cnt).val()
      model.categories.push(model.editor) if !model.editor.id
      model.editor.save()

  class CategoriesCtrl
    edit: (elem, category) ->
      ui.editor.show(category)

  # -- UI
  ui = 
    editor:
      show: (category) ->
        model.editor = category
        $('.category-editor', cnt).modal('show')

  # --- init
  $.get '/admin/categories', (categories_json) -> 
    for category_json in categories_json
      model.categories.push(new Category(category_json))

  cnt = $('#categories')

  $('.list', cnt).prepend(Serenade.render('categories/list', model, CategoriesCtrl))
  $('.list', cnt).prepend(Serenade.render('categories/edit', model, EditorCtrl))

  $('.new-category-btn', cnt).click ->
    ui.editor.show(new Category())
    return false
