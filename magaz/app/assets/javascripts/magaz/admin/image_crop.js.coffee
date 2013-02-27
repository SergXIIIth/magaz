window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Magaz.Admin.Crop = (container, init_crop) ->
  crop = {}

  origin_img    = $('.origin', container)
  preview_img   = $('.preview', container)
  preview_size = preview_img.width()

  priview_init = ( ->
    preview_img.closest('.thumbnail').css
      width: preview_size
      height: preview_size
      overflow: 'hidden'
  )()

  init_crop = (->
    coords = init_crop

    unless coords
      imgW = $(origin_img).width()
      imgH = $(origin_img).height()

      xy2 = if imgW < imgH then imgW else imgH
      
      coords = { x1:0, y1:0, x2:xy2, y2:xy2}

    coords
  )()

  preview = (img, selection) ->
    if (!selection.width || !selection.height)
        return;

    selection = plugin.getSelection(true)

    scaleX = preview_size / selection.width
    scaleY = preview_size / selection.height

    preview_img.css
      width: Math.round(scaleX * origin_img.width()),
      height: Math.round(scaleY * origin_img.height()),
      marginLeft: -Math.round(scaleX * selection.x1),
      marginTop: -Math.round(scaleY * selection.y1),
      'max-width': 'initial'

  plugin = null

  load_plugin_with_true_origin_size = ->
    #Build a new Image Object outside the DOM
    #that way, CSS won't affect it size
    img = new Image()
    img.onload = ->
      plugin = $(origin_img).imgAreaSelect
        handles: true
        aspectRatio: '1:1'
        onSelectEnd: preview
        onInit: preview
        x1: init_crop.x1
        y1: init_crop.y1
        x2: init_crop.x2
        y2: init_crop.y2
        fadeSpeed: 200
        instance: true
        imageHeight: img.height
        imageWidth: img.width
    img.src = preview_img.attr('src')
  load_plugin_with_true_origin_size()

  crop.remove = ->
    $(origin_img).imgAreaSelect
      remove: true

  crop.selection = ->
    plugin.getSelection()

  crop