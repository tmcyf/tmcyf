# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    credit_card.setupForm()

credit_card =
  setupForm: ->
    $('#new_credit_card').submit ->
      $('input[type=submit]').attr('disabled', true)
      credit_card.processCard()
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, credit_card.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
      alert(response)

Window.credit_card = credit_card
