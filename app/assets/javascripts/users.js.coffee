$ ->
  # countdown stuff
  $countdown = $('div.countdown')
  if $countdown.length > 0
    exp = new Date(parseInt($countdown.data('expiration'), 10) * 1000)
    $countdown.countdown {
      until: exp,
      compact: true,
      layout: "<h3 class='text-error'>{hnn}{sep}{mnn}{sep}{snn}</h3>"
    }

  # x-editable stuff
  #$.fn.editable.defaults.mode = 'inline'
  #$('table.nested-addr a').editable
    #url: '/users/' + $(@).data('cuid'),
    #ajaxOptions: { type: 'put', dataType: 'json' },
    #validate: (v) -> if !v
