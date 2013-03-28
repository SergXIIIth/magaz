window.Magaz = window.Magaz || {}
window.Magaz.Common = {}
Common = window.Magaz.Common

# usage send AJAX and delete html element on page
#   a data-delete="td, tr - mean .closest(tr)" href='url to delete'
Common.delete_ajax_btn = (cnt) ->
  cnt = document if cnt == undefined

  delete_btn = $("[data-delete]", cnt)

  delete_btn.attr('data-toggle', 'tooltip').tooltip
    title: 'Удалить'
    placement: 'bottom'
    delay: 1000

  delete_btn.click ->
    url = $(@).attr('href')
    delete_it = $(@).closest($(@).data('delete'))

    modal_html = "<div class='modal fade'>
        <div class='modal-header'>
          <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
          <h3>Внимание удаление!</h3>
        </div>
        <div class='modal-body'>
          <p>Вы уверены, что хотите продолжить удаление?</p>
        </div>
        <div class='modal-footer'>
          <a href='#' class='btn' data-dismiss='modal'>Отменить</a>
          <a href='#' class='btn btn-primary'>Удалить</a>
        </div>
      </div>"

    modal = $(modal_html).appendTo('body')

    modal.modal('show')

    $('.btn-primary', modal).click ->
      $.deleteajax url
      modal.modal('hide')
      modal.on 'hidden', ->
        modal.remove()
        delete_it.fadeOut('slow', -> delete_it.remove())
      false

    false

Common.delete_confirm_dialog = (on_delete) ->
  cnt = document if cnt == undefined

  modal_html = "<div class='modal fade'>
    <div class='modal-header'>
      <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
      <h3>Внимание удаление!</h3>
    </div>
    <div class='modal-body'>
      <p>Вы уверены, что хотите продолжить удаление?</p>
    </div>
    <div class='modal-footer'>
      <a href='#' class='btn' data-dismiss='modal'>Отменить</a>
      <a href='#' class='btn btn-primary delete-confirm-btn'>Удалить</a>
    </div>
  </div>"

  modal = $(modal_html).appendTo('body')
  modal.on('hidden', -> modal.remove())
  modal.modal('show')

  $('.delete-confirm-btn', modal).click ->
    modal.modal('hide')
    on_delete()
    false

  false
