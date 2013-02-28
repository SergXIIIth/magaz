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

init_img_events = (thumbnail) ->
  $('.remove', thumbnail).click ->
    thumbnail = $(@).closest('.thumbnail')
    thumbnail.removeAttr('data-id')
    update_image_ids_field()
    thumbnail.fadeOut('slow', -> thumbnail.remove())
    false

  $('.crop, .origin', thumbnail).click ->
    open_crop_modal($(@).closest('.thumbnail'))
    false

  update_thumbnail_img(thumbnail)

upload_popover_html = "<div class='alert.alert-info' style='margin-bottom: 5px'>
    <p>
      Вы можете просто перетаскивать картинки на сайт.
      Даже без нажатия \"Добавить картинки\"
    <hr />
    <p>
      Или выберите картинки.
      Для выбеления нескольких файлов удерживайте Ctrl или Shift
    </p>
    <p class='text-center'>
      <button class='btn btn-primary select-image'>Выбрать картинки</button>
    </p>
  </div>
"

window.Magaz = window.Magaz || {}
Magaz = window.Magaz
Magaz.Admin = Magaz.Admin || {}

Magaz.Admin.image_upload = ->
  $('.show-upload')
    .popover
      html: true
      title: "Перетащите или выберите картинки <a class='close popover-close'>&times;</a>"
      content: upload_popover_html
      placement: 'bottom'
      trigger: 'manual'
    .click ->
      self = $(@)
      self.popover('toggle')

      $('.select-image').click ->
        $('#image').click()
        false

      $('.popover-close').click ->
        $(self).popover('toggle')
        false

      false

  $('#image').fileupload(
    type: 'POST'
    dataType: 'html',
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.progress .bar').css('width', progress + '%')
    done: (e, data) ->
      html = $(data.result).appendTo('.thumbnails')
      init_img_events($('.thumbnail', html))
      update_image_ids_field()
    start: ->
      $('.progress').show()
      $('.show-upload').popover('hide')
    stop: ->
      $('.progress').hide()
  )

  $('.thumbnails')
    .sortable(items: '.thumbnail')
    .bind('sortupdate', update_image_ids_field) 

  $('.upload .thumbnail').each -> init_img_events($(@))
  update_image_ids_field()

