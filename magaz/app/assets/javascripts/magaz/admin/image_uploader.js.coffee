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

  init_img_events = (imgs) ->
    $('.remove-btn', imgs).click ->
      img = $(@).closest('.thumbnail')
      img_id = img.data('id')

      $.deleteajax "/admin/images/#{img_id}"

      img.slideUp('slow', -> img.remove())

      false 

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
