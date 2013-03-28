# API html
# - #categories .list
# - .new-category-btn

@CategoryContol = ->
  # --- Model
  class Category extends Serenade.Model
    @property 'id', serialize: true
    @property 'name', serialize: true
    @property 'selected'
    save: -> $.post '/admin/categories', @.toJSON(), (id) => @id = id


  class Model extends Serenade.Model
    @property 'categories', 'editor'

    constructor: ->
      @categories = new Serenade.Collection()
      @editor = new Category(name: 'new') # will be instance of editing category
    

  model = new Model()

  # --- Contorller
  class EditorCtrl
    save: ->
      $('.category-editor', cnt).modal('hide')
      model.editor.name = $('.category-editor .name', cnt).val()
      model.categories.push(model.editor) unless model.editor.id
      model.editor.save()

  class CategoriesCtrl
    edit: (elem, category) ->
      ui.editor.show(category)
    select: (elem, category) ->
      for cat in model.categories
        cat.selected = false
      category.selected = true
    delete: (elem, category) ->
      ui.delete_confirm ->
        $.deleteajax('/admin/categories/' + category.id)
        model.categories.delete(category)


  # -- UI
  cnt = $('#categories')

  ui = 
    editor:
      _init_auto_focus: true
      show: (category) ->
        model.editor = category

        if @_init_auto_focus
          $('.category-editor', cnt).on('shown', -> $('.category-editor .name', cnt).focus())
          _init_auto_focus = false

        $('.category-editor', cnt).modal('show')


    delete_confirm: Magaz.Common.delete_confirm_dialog

  $.get '/admin/categories', (categories_json) -> 
    for category_json in categories_json
      model.categories.push(new Category(category_json))

  $('.list', cnt).prepend(Serenade.render('categories/list', model, CategoriesCtrl))
  $('.list', cnt).prepend(Serenade.render('categories/edit', model, EditorCtrl))

  $('.new-category-btn', cnt).click ->
    ui.editor.show(new Category())
    return false
