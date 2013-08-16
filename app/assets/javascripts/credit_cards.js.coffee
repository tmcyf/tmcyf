# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    credit_card.setupForm()

credit_card =
  setupForm: ->
      # $('#new_credit_card').submit ->
      # $('input[type=submit]').attr('disabled', true)
      # credit_card.processCard()
      # false
    $('#test_credit_card').submit ->
      $('input[type=submit]').attr('disabled', true)
      credit_card.processCard()
      false
  
  testAPIResponse: ->
    testCard =
      number: 4242424242424242
      cvc: 892
      expMonth: 10
      expYear: 2014
    Stripe.createToken(testCard, credit_card.handleStripeResponse)
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, credit_card.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
      alert response

