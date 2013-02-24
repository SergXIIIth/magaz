# Image upload

window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Crop = {}

Crop.update_crop_json = (img, selection) ->
  thumbnail = $(img).closest('[data-id]')
  thumbnail.attr('data-crop', JSON.stringify(selection))
  update_image_ids_field()

Crop.preview = (img, selection) ->
    if (!selection.width || !selection.height)
        return;

    thumbnail = $(img).closest('.thumbnail')
    
    originWidth = $('.origin', thumbnail).width()
    originHeight = $('.origin', thumbnail).height()

    scaleX = 100 / selection.width
    scaleY = 100 / selection.height

    $('.preview', thumbnail).css
        width: Math.round(scaleX * originWidth),
        height: Math.round(scaleY * originHeight),
        marginLeft: -Math.round(scaleX * selection.x1),
        marginTop: -Math.round(scaleY * selection.y1),
        'max-width': 'initial'

Crop.after_select = (img, selection) ->
  Crop.preview(img, selection)
  Crop.update_crop_json(img, selection)

Crop.init = (img) ->
  imgW = $(img).width()
  imgH = $(img).height()

  initCrop = if imgW < imgH then imgW else imgH

  $(img).imgAreaSelect
    handles: true,
    aspectRatio: '1:1'
    onSelectEnd: Crop.after_select
    onInit: Crop.after_select
    x1: 0
    y1: 0 
    x2: initCrop
    y2: initCrop
    fadeSpeed: 200

  imgH = $(img).height()

  initCrop = if imgW < imgH then imgW else imgH

  $(img).imgAreaSelect
    handles: true,
    aspectRatio: '1:1'
    onSelectEnd: Crop.after_select
    onInit: Crop.after_select
    x1: 0
    y1: 0 
    x2: initCrop
    y2: initCrop
    fadeSpeed: 200

update_image_ids_field = ->
  values = []
  for thumbnail in $(".thumbnails [data-id]")
    values.push({
      id: $(thumbnail).data('id'), 
      crop: JSON.parse($(thumbnail).attr('data-crop'))
      })
  field = $("[name='#{ImageUpload.field_image_ids_name}']")
  field.val(JSON.stringify(values))

init_img_events = (imgs) ->
  $('.remove-btn', imgs).click ->
    img = $(@).closest('.thumbnail')
    img_id = img.data('id')
    $.deleteajax "/admin/images/#{img_id}"
    img.slideUp('slow', -> img.remove())
    false
  $('.origin', imgs).each (i, img) -> Crop.init(img)

Magaz.Admin.image_upload = ->
  $('.image-file').fileupload(
    type: 'POST'
    dataType: 'html',
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.progress .bar').css('width', progress + '%')
    done: (e, data) ->
      img_html = data.result
      img = $(img_html).appendTo('.thumbnails')
      init_img_events(img)
      update_image_ids_field()
    start: ->
      $('.progress').slideDown()
    stop: ->
      $('.progress').slideUp()
  )

  #update_image_ids_field()

  $('.show-upload').click ->
    $('.upload-field').slideToggle()
    false

  init_img_events($('.upload .thumbnail'))