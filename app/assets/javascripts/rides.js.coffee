$ ->
  $("label[for='ride_time1']").parent('div').css 'display', 'none'

  $('input.rideTime').parent('div').addClass 'bootstrap-timepicker'
  $('input.rideTime').timepicker minuteStep: 5

  today = new Date()
  t = (today.getMonth()+1) + '\/' + today.getDate() + '\/' + today.getFullYear()
  $('input.rideDateFrom').val(t).datepicker todayBtn: true

  $('input.rideDateTo').val('6/19/2013').datepicker

  # weekday exclusion
  $("select[id*='excluding_day']").on 'change', ->
    switch @value
      when 'None'
        $("label[for='ride_time1']").parent('div').css 'display', 'none'
      else
        $("label[for='ride_time1']").parent('div').css 'display', ''

  # ride type radio button selection
  $("input[type=radio][id*='ride_type']").on 'change', ->
    if @value is 'Pick-up'
      $("select[id*='excluding_day']").val 'Wednesday'
      $("label[for*='ride_time']").text('Leaving at')
        .eq(1)
        .parent('div')
        .css 'display', ''
      $('input.rideTime').eq(0).val '02:25 PM'
      $('input.rideTime').eq(1).val '12:05 PM'
    else
      $("select[id*='excluding_day']").val 'None'
      $("label[for*='ride_time']").text('Arriving at')
        .eq(1)
        .parent('div')
        .css 'display', 'none'
      $('input.rideTime').eq(0).val '07:55 PM'

  # creator type selection, i.e. driver or rider
  $("input[type=radio][id*='creator_type']").on 'change', ->
    if @value.indexOf('looking') isnt -1
      $('h4.ride-type-question').text 'What kind of ride do you need help with?'
      $('h4.ride-fare-question').text 'How much do you want to contribute to the parent driver, per ride?'
      $('div.ride_seats_total').css('display', 'none')
    else
      $('h4.ride-type-question').text 'What kind of ride are you offering?'
      $('h4.ride-fare-question').text 'How much do you want each of your little riders to contribute, per ride?'
      $('div.ride_seats_total').css('display', '')

  true
