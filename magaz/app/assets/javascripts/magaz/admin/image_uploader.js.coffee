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
  $('.remove', imgs).click ->
    img = $(@).closest('.thumbnail')
    img.fadeOut('slow', -> img.remove(); update_image_ids_field();)
    false

  $('.crop, .origin', imgs).click ->
    # open dialog for cropping
    image_id = $(@).closest('.thumbnail').data('id')
    modal = $('<div class="modal fade">Загрузка...</div>').appendTo('body')
    modal.load("/admin/images/#{image_id}/edit")
    modal.modal('show')
    false


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

  $('.show-upload').click ->
    $('.upload-field').slideToggle()
    false

  init_img_events($('.upload .thumbnail'))
  update_image_ids_field()