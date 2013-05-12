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
