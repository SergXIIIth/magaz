window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Crop = {}
Magaz.Admin.Crop = Crop

crop_private =->
  crop = {}

  crop.container = $('.image-container')
  crop.img = $('.origin', crop.container)
  crop.preview_img = $('.preview', crop.container)

  crop.init_coords = (->
    coords = JSON.parse(crop.container.attr('data-crop'))

    unless coords
      imgW = $(crop.img).width()
      imgH = $(crop.img).height()
      xy2 = if imgW < imgH then imgW else imgH
      coords = { x1:0, y1:0, x2: xy2, y2: xy2}

    coords
  )()

  crop.update_crop_json = (img, selection) ->
    crop.container.attr('data-crop', JSON.stringify(selection))

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

  crop.after_select = (img, selection) ->
    crop.preview(img, selection)
    crop.update_crop_json(img, selection)

  crop

Crop.init = () ->
  crop = crop_private()

  $(crop.img).imgAreaSelect
    handles: true,
    aspectRatio: '1:1'
    onSelectEnd: crop.after_select
    onInit: crop.after_select
    x1: crop.init_coords.x1
    y1: crop.init_coords.y1
    x2: crop.init_coords.x2
    y2: crop.init_coords.y2
    fadeSpeed: 200
