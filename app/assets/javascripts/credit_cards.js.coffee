# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  credit_card.setupForm()

credit_card = 
  setupForm: ->
    alert "Hello!"
    card = 
        number: 4242424242424242
        cvc: 898
        expMonth: 10
        expYear: 2014
    $('#new_credit_card').on 'click', ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.createToken(card, credit_card.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    alert("Token is " + response.id)

