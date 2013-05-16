$ ->
  $('div.ride_for_which_child').css 'display', 'none'
  #$('div.ride_time1').css 'display', 'none'

  #$('input.rideTime').parent('div').addClass 'bootstrap-timepicker'
  #$('input.rideTime').timepicker minuteStep: 5

  today = new Date()
  t = (today.getMonth()+1) + '\/' + today.getDate() + '\/' + today.getFullYear()
  $('input.rideDateFrom').val(t).datepicker todayBtn: true

  $('input.rideDateTo').val('6/19/2013').datepicker()

  # weekday exclusion
  #$("select[id*='excluding_day']").on 'change', ->
    #switch @value
      #when 'None'
        #$('div.ride_time1').css 'display', 'none'
      #else
        #$('div.ride_time1').css 'display', ''

  # ride type radio button selection
  #$("input[type=radio][id*='ride_type']").on 'change', ->
    #if @value is 'Afternoon Pick-up'
      #$("select[id*='excluding_day']").val 'Wednesday'
      #$("label[for*='ride_time']").text('Leaving at')
        #.eq(1)
        #.parent('div')
        #.css 'display', ''
      #$('input.rideTime').eq(0).val '02:25 PM'
      #$('input.rideTime').eq(1).val '12:05 PM'
    #else
      #$("select[id*='excluding_day']").val 'None'
      #$("label[for*='ride_time']").text('Arriving at')
        #.eq(1)
        #.parent('div')
        #.css 'display', 'none'
      #$('input.rideTime').eq(0).val '07:55 PM'

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
      lat = $(@).data('lat')
      lng = $(@).data('lng')
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

  # rides/show view
  $('button.book-it').click ->
    child_name = $('select.which-child').val()
    window.location.href = '/rides/booking/' + $(this).data('ride-id') + '?' + $.param({ child_name: child_name })

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
