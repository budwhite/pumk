$ ->
  $('#custom_button').click ->
    $form = $('form#charge')
    $inputAmount = $form.find("input[name|='amount']")
    amount = $inputAmount.val()

    if amount == ''
      alert 'Please enter an amount'
      $inputAmount.focus()
      return false

    token = (res) ->
      $tokenInput = $('<input type=hidden name=stripeToken />').val(res.id)
      $form.append($tokenInput).submit()

    StripeCheckout.open({
      key: $('meta[name="stripe-key"]').attr('content'),
      amount: amount,
      currency: 'usd',
      token: token
    })

    return false

#$ ->
  #Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  ## without the unbind the submit callback would execute twice; not sure why
  #$('#creditcard_form').unbind('submit').submit ->
    #if $('#credit_card').is(':visible')
      #$(this).find('button').prop('disabled', true)
      #card =
        #number: $('#card_number').val()
        #cvc: $('#card_code').val()
        #expMonth: $('#card_month').val()
        #expYear: $('#card_year').val()
      #Stripe.createToken(card, stripeResponseHandler)
      #false
    #else
      #true

  #stripeResponseHandler = (status, response) ->
    #if status == 200
      #$('#user_stripe_token').val(response.id)
      #$('#creditcard_form')[0].submit()
    #else
      #$('#stripe_error_message').text(response.error.message)
      #$('#credit_card_errors').show()
      #$(this).find('button').prop('disabled', true)

  #$('#change_card a').click ->
    #$('#change_card').hide()
    #$('#credit_card').show()
    #$('#card_number').focus()
    #false

  #true
