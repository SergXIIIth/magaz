# Image upload

window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Magaz.Admin.image_upload = ->
  update_image_ids_field = ->
    values = []
    for image in $(".thumbnails [data-id]")
      values.push($(image).data('id'))

    field = $("[name='#{ImageUpload.field_image_ids_name}']")
    field.val(values)

  crop_preview = (img, selection) ->
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

  init_img_events = (imgs) ->
    $('.remove-btn', imgs).click ->
      img = $(@).closest('.thumbnail')
      img_id = img.data('id')

      $.deleteajax "/admin/images/#{img_id}"

      img.slideUp('slow', -> img.remove())

      false

    croper = $('.origin', imgs).imgAreaSelect
                handles: true,
                aspectRatio: '1:1'
                onSelectEnd: crop_preview
                onInit: crop_preview
                x1: 0
                y1: 0 
                x2: 100
                y2: 100
                fadeSpeed: 200
                instance: true

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

  update_image_ids_field()

  $('.show-upload').click ->
    $('.upload-field').slideToggle()
    false

  init_img_events($('.upload .thumbnail'))


