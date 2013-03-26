@Magaz_admin_products = {}
Products = @Magaz_admin_products

Products.index = ->
  Magaz.Common.delete_ajax_btn()

  CategoryContol()

CategoryContol = ->

  model =  {}
  model.categories = new Serenade.Collection( [{ name: "c1" }, { name: "c2" }] )
  window.model = model

  $('#categories').prepend(Serenade.render('categories/list', model))


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