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
  class EditCtrl
    save: ->
      model.editor.name = $('.category-editor .name', cnt).val()
      model.editor.save()
      model.categories.push(model.editor)
      $('.category-editor', cnt).modal('hide')


  # --- init
  cnt = $('#categories')

  $('.list', cnt).prepend(Serenade.render('categories/list', model))
  $('.list', cnt).prepend(Serenade.render('categories/edit', model, EditCtrl))


  # event outside contollers
  $('.new-category-btn', cnt).click ->
    model.editor = new Category()
    $('.category-editor', cnt).modal('show')
    return false


  # model
  # model = {}
  # model.categories = []

  # ui = {}
  # ui.editor = $('#category-editor')
  # ui.categories = $('#categories')
  # ui.edit_category = null
  # ui.init_events = ->
  #   $('.new-category-btn').click ->
  #     # show add dialog
  #     ui.edit_category = {}
  #     $('.name', ui.editor).val(ui.edit_category.name)
  #     ui.editor.modal('show')
  #     false

  #   ui.editor.on 'shown', ->
  #     $('.name', ui.editor).focus()

  #   $('.save-btn', ui.editor).click ->
  #     ui.edit_category.name = $('.name', ui.editor).val()
  #     ui.editor.modal('hide')
  #     model.categories.push(ui.edit_category)
  #     ui.display_categories()
  #     false

  # ui.display_categories = ->
  #   ui.categories.html('')
  #   for categoty in model.categories
  #     category_html = $ "<div class='categoty'>#{categoty.name}</div>"
  #     category_html.appendTo(ui.categories)

  # ui.init_events()