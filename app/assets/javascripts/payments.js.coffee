# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    # there's a payment button on each payable that sends an ajax request to 
    # our payments controller with the id of the payable and the user, and it's
    # disabled by default for users without cards. after a valid card is added,
    # we want to enable those buttons
    enablePaymentSubmission = ->
        $('.payment-button').attr('disabled', false).removeAttr('data-dropdown')

    getCardInfo = ->
        number: $('#card_number').val()
        cvc: $('#card_code').val()
        expMonth: $('#card_month').val()
        expYear: $('#card_year').val()

    stripeResponseHandler = (status, response) -> 
        $('#spinner').toggle('hide')
        if response.error
            alert "There was a problem submitting your card."
        else
            $('#card-number').attr('text', '************' + response.card.last4)
            enablePaymentSubmission()

    submitCard = (cardInfo) ->
        Stripe.card.createToken(cardInfo, stripeResponseHandler)

    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    $('.card-button').on('click', submitCard(getCardInfo()))

