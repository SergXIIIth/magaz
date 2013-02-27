update_thumbnail_img = (thumbnail) ->
  size = thumbnail.innerWidth()
  img = $('.origin', thumbnail)
  src = Magaz.Thumbnail.url(
    thumbnail.attr('data-cloudinary-identifier'), 
    JSON.parse(thumbnail.attr('data-crop')),
    size
    )
  img.attr('src', src)

open_crop_modal = (thumbnail) ->
  crop = null

  modal = $('<div class="modal fade">Загрузка...</div>').appendTo('body')
  modal.load "/admin/images/#{thumbnail.data('id')}/edit", ->
    $('.save-btn', modal).click ->
      thumbnail.attr('data-crop', JSON.stringify(crop.selection()))

      update_thumbnail_img(thumbnail)
      update_image_ids_field()

      crop.remove()
      modal.modal('hide')
     
      false      
      
    $('[data-dismiss]', modal).click ->
      crop.remove()

  modal.on 'hidden', -> 
    crop.remove()
    $(@).remove()

  modal.on 'shown', ->
     crop = Magaz.Admin.Crop(modal, JSON.parse(thumbnail.attr('data-crop')))

  modal.modal('show')

update_image_ids_field = ->
  values = []
  for thumbnail in $(".thumbnails [data-id]")
    values.push({
      id: $(thumbnail).data('id'), 
      crop: JSON.parse($(thumbnail).attr('data-crop'))
      })
  field = $("[name='#{ImageUpload.field_image_ids_name}']")
  field.val(JSON.stringify(values))

init_img_events = (thumbnails) ->
  $('.remove', thumbnails).click ->
    img = $(@).closest('.thumbnail')
    img.fadeOut('slow', -> img.remove(); update_image_ids_field();)
    false

  $('.crop, .origin', thumbnails).click ->
    open_crop_modal($(@).closest('.thumbnail'))
    false

  $(thumbnails).each ->
    update_thumbnail_img($(@))

window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

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