$ ->
  $('div.ride_for_which_child').css 'display', 'none' unless $("input[type=radio][id*='creator_type_looking']").attr('checked') is 'checked'

  $('input.rideTime').parent('div').addClass 'bootstrap-timepicker'
  $('input.rideTime').timepicker minuteStep: 5

  today = new Date()
  #t = (today.getMonth()+1) + '\/' + today.getDate() + '\/' + today.getFullYear()
  $('input.rideDateFrom').datepicker todayBtn: true

  $('input.rideDateTo').datepicker()

  # ride type radio button selection
  $("label[for*='ride_time']").text('Leaving at') if $("input[type=radio][id*='ride_type_pick-up']").attr('checked') is 'checked'
  $("input[type=radio][id*='ride_type']").on 'change', ->
    if @value is 'Pick-up'
      $("label[for*='ride_time']").text('Leaving at')
      $('input.rideTime').eq(0).val '02:25 PM'
    else
      $("label[for*='ride_time']").text('Arriving at')
      $('input.rideTime').eq(0).val '07:55 PM'

  # creator type selection, i.e. driver or rider
  $("input[type=radio][id*='creator_type']").on 'change', ->
    if @value.indexOf('looking') isnt -1
      $('h4.ride-type-question').text 'What kind of ride do you need help with?'
      $('h4.ride-fare-question').text 'How much do you want to contribute to the parent driver, per ride?'
      $('div.ride_seats_total').css('display', 'none')
      $('div.ride_for_which_child').css 'display', ''
    else
      $('h4.ride-type-question').text 'What kind of ride are you offering?'
      $('h4.ride-fare-question').text 'How much do you want each of your little riders to contribute, per ride?'
      $('div.ride_seats_total').css('display', '')
      $('div.ride_for_which_child').css 'display', 'none'

  # map stuff
  $map = $('.map-canvas')
  if $map.length > 0
    $map.each ->
      lat = $(@).data('orig-lat')
      lng = $(@).data('orig-lng')
      options = {
        zoom: 15,
        center: new google.maps.LatLng(lat, lng),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map @, options
      marker = new google.maps.Marker {
        position: options.center,
        map: map,
        # icons obtained here: http://stackoverflow.com/a/7179941
        icon: '/assets/darkgreen_MarkerA.png'
      }
      marker = new google.maps.Marker {
        position: new google.maps.LatLng($(@).data('dest-lat'), $(@).data('dest-lng')),
        map: map,
        icon: '/assets/red_MarkerA.png'
      }
      bounds = new google.maps.LatLngBounds()
      bounds.extend options.center
      bounds.extend marker.position
      map.fitBounds bounds

  # rides/show view
  $('button.book-it').click ->
    $child = $('select.which-child')
    url = '/rides/booking/' + $(this).data('ride-id')
    # if there's child on page, assume it is potentially rider booking a driver's ride
    # and vice versa
    if $child.length > 0
      child_name = $('select.which-child').val()
      window.location.href =  url + '?' + $.param({ child_name: child_name })
    else
      window.location.href = url

  # form submit on booking view
  $('button.submit').click -> $('form.user_phone').submit()

  # respond view, accept and decline
  $button_accept = $('button.accept')
  $button_decline = $('button.decline')

  $button_accept.click ->
    if $(@).hasClass 'active'
      $('div.accept_form').addClass 'hidden'
    else
      $('div.accept_form').removeClass 'hidden'

  $button_decline.click ->
    if $(@).hasClass 'active'
      $('div.decline_form').addClass 'hidden'
    else
      $('div.decline_form').removeClass 'hidden'

  true
