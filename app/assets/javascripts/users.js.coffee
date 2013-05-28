$ ->

  #---------------------------------------------------------------------------------#
  # countdown stuff
  $countdown = $('div.countdown')
  if $countdown.length > 0
    exp = new Date(parseInt($countdown.data('expiration'), 10) * 1000)
    $countdown.countdown {
      until: exp,
      compact: true,
      layout: "<h3 class='text-error'>{hnn}{sep}{mnn}{sep}{snn}</h3>"
    }


  #---------------------------------------------------------------------------------#
  # remember tab position via cookie
  $('a[data-toggle="tab"]').on 'shown', (e) ->
    $.cookie 'last_tab', $(e.target).attr 'href'

  lastTab = $.cookie('last_tab')
  if lastTab
    $('a[href=' + lastTab + ']').tab 'show'


  #---------------------------------------------------------------------------------#
  # x-editable stuff
  $.fn.editable.defaults.mode = 'inline'

  ## address model specific
  $('table.address a').editable
    url: '/users/' + $(@).closest('table').data('cuid'),
    ajaxOptions: { type: 'put' },
    params: { model: 'address' },
    validate: (v) -> if !v
      return 'This field is required'

  $('table.address.new a').on 'save.newaddress', ->
    that = @
    callback = -> $(that).closest('tr').next().find('a').editable('show')
    setTimeout callback, 200

  $('#save-addr-btn').click ->
    $('table.address.new a').editable 'submit', {
      url: '/users/' + $(@).closest('table').data('cuid'),
      ajaxOptions: { type: 'put' },
      success: (data, config) ->
        if data && data.id
          $(@).editable 'option', 'pk', data.id
          $(@).removeClass 'editable-unsaved'
          msg = 'New address created!'
          $('#msg-addr').addClass('alert-success').removeClass('alert-error').html(msg).show()
          $('#save-addr-btn').hide()
          $(@).off 'save.newaddress'
          callback = -> location.reload(true)
          setTimeout callback, 1000
        else if data && data.errors
          config.error.call @, data.errors
      error: (errors) ->
        msg = ''
        if errors && errors.responseText
          msg = errors.responseText
        else
          $.each errors, (k, v) -> msg += k+': '+v+'<br>'
        $('#msg-addr').removeClass('alert-success').addClass('alert-error').html(msg).show()
      data: { model: 'address' }
    }

  ## child model specific
  $('table.child a').editable
    url: '/users/' + $(@).closest('table').data('cuid'),
    ajaxOptions: { type: 'put' },
    params: { model: 'child' },
    validate: (v) -> if !v
      return 'This field is required'

  $('table.child.new a').on 'save.newchild', ->
    that = @
    callback = -> $(that).closest('tr').next().find('a').editable('show')
    setTimeout callback, 200

  $('#save-child-btn').click ->
    $('table.child.new a').editable 'submit', {
      url: '/users/' + $(@).closest('table').data('cuid'),
      ajaxOptions: { type: 'put' },
      success: (data, config) ->
        if data && data.id
          $(@).editable 'option', 'pk', data.id
          $(@).removeClass 'editable-unsaved'
          msg = 'New child added!'
          $('#msg-child').addClass('alert-success').removeClass('alert-error').html(msg).show()
          $('#save-child-btn').hide()
          $(@).off 'save.newchild'
          callback = -> location.reload(true)
          setTimeout callback, 1000
        else if data && data.errors
          config.error.call @, data.errors
      error: (errors) ->
        msg = ''
        if errors && errors.responseText
          msg = errors.responseText
        else
          $.each errors, (k, v) -> msg += k+': '+v+'<br>'
        $('#msg-child').removeClass('alert-success').addClass('alert-error').html(msg).show()
      data: { model: 'child' }
    }

  ## user model specific
  $('table.user a').editable
    url: '/users/' + $(@).closest('table').data('cuid'),
    ajaxOptions: { type: 'put' },
    params: { model: 'user' },
    validate: (v) -> if !v
      return 'This field is required'

  ## applies to all
  $('button.toggle-edit').click ->
    model = $(@).data 'model'
    id = $(@).data 'id'
    $('table.'+model+' a[data-pk='+id+']').editable 'toggleDisabled'

  $('.editable').editable 'disable'
  $('table.new a').editable 'enable'


  #---------------------------------------------------------------------------------#
  # picture upload stuff
  #$('picture_upload').fileupload()

  #---------------------------------------------------------------------------------#
  # tooltip
  $("[data-toggle='tooltip']").tooltip()
