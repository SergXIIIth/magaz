@Magaz_admin_products = {}
Products = @Magaz_admin_products

Products.index = ->
  Magaz.Common.delete_ajax_btn()
  CategoryContol()

Products['new'] = ->
  Products.edit()

Products.edit = ->
  CategoryChoiceContol()

# API
# .choice-category-btn, .chosen-categories, .chosen-categories-ids
@CategoryChoiceContol = ->
  
  # --- Model

  class Category extends Serenade.Model
    @property 'id', serialize: true
    @property 'name'
    @property 'selected'

  class Model extends Serenade.Model
    @collection 'categories'
    @selection 'chosen', 
      {
        from: 'categories', 
        filter: 'selected',
        changed: -> 
          categoty_ids = (category.id for category in @chosen)
          $('.chosen-category-ids').val(JSON.stringify(categoty_ids))
      }

    constructor: ->
      @categories = new Serenade.Collection()
      @chosen = new Serenade.Collection()

  model = new Model()

  # --- Contorller

  class ChoiceCtrl
    constructor: ->
      $.get '/admin/categories', (categories_json) -> 
        for category_json in categories_json
          model.categories.push(new Category(category_json))

        chosen_category_ids = $('.chosen-category-ids').data('init')

        for categoty_id in chosen_category_ids
          Category.find(categoty_id).selected = true
          
    select: (elem, categoty) -> categoty.selected = !categoty.selected

  class ChosenCtrl
    delete: (elem, category, event) -> category.selected = false


  # --- UI

  cnt = $('.chosen-categories')


  ui = 
    choice_dialog:
      show: ->
        $('.category-choice-dialog', cnt).modal('show')

  $('.choice-category-btn').click ->
    ui.choice_dialog.show()
    false

  $(cnt).prepend(Serenade.render('categories/choice_dialog', model, ChoiceCtrl))
  $(cnt).prepend(Serenade.render('categories/chosen', model, ChosenCtrl))
