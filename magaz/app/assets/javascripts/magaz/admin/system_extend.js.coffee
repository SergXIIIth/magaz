$ ->
  $(document).ajaxSend (e, xhr, options) ->
    token = $("meta[name='csrf-token']").attr('content')
    xhr.setRequestHeader('X-CSRF-Token', token)


window.p = (mes) ->
  if (console && console.log)
    console.log(mes)

_ajax_request = (url, data, callback, type, method) ->
  if (jQuery.isFunction(data)) 
    callback = data
    data = {}

  return jQuery.ajax
    type: method,
    url: url,
    data: data,
    success: callback,
    error: -> p '_ajax_request ajax error',
    dataType: type

jQuery.put = (url, data, callback, type) ->
  return _ajax_request(url, data, callback, type, 'PUT');

jQuery.deleteajax = (url, data, callback, type) ->
  return _ajax_request(url, data, callback, type, 'DELETE');
