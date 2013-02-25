window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Crop = {}
Magaz.Admin.Crop = Crop

crop_private =->
  crop = {}

  crop.modal = $('.modal')
  crop.container = $('.image-container')
  crop.img = $('.origin', crop.modal)
  crop.preview_img = $('.preview', crop.modal)

  crop.init_coords = (->
    coords = JSON.parse(crop.container.attr('data-crop'))

    unless coords
      imgW = $(crop.img).width()
      imgH = $(crop.img).height()
      xy2 = if imgW < imgH then imgW else imgH
      coords = { x1:0, y1:0, x2:xy2, y2:xy2}

    coords
  )()

  crop.preview = (img, selection) ->
    if (!selection.width || !selection.height)
        return;

    scaleX = 100 / selection.width
    scaleY = 100 / selection.height

    crop.preview_img.css
        width: Math.round(scaleX * crop.img.width()),
        height: Math.round(scaleY * crop.img.height()),
        marginLeft: -Math.round(scaleX * selection.x1),
        marginTop: -Math.round(scaleY * selection.y1),
        'max-width': 'initial'

  crop

Crop.init = () ->
  crop = crop_private()

  crop.modal.on 'shown', -> 
    crop.plugin = $(crop.img).imgAreaSelect
      handles: true
      aspectRatio: '1:1'
      onSelectEnd: crop.preview
      onInit: crop.preview
      x1: crop.init_coords.x1
      y1: crop.init_coords.y1
      x2: crop.init_coords.x2
      y2: crop.init_coords.y2
      fadeSpeed: 200
      instance: true

  crop.modal.on 'hidden', -> 
    $(crop.img).imgAreaSelect
      remove: true
    $(@).remove()

  $('.save-btn', crop.modal).click ->
    crop.modal.triggerHandler('crop-save', crop.plugin.getSelection())
    crop.modal.modal('hide')
    false