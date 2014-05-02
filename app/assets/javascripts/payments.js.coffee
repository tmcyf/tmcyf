$(document).on 'ready page:load', ->
    # there's a payment button on each payable that sends an ajax request to 
    # our payments controller with the id of the payable and the user, and it's
    # disabled by default for users without cards. after a valid card is added,
    # we want to enable those buttons
    handler = StripeCheckout.configure
        key: $('meta[name=stripe-key]').attr('content')
        token: (token, args) ->
            $.ajax 
                type: 'POST'
                url: 'payments/create'
                data:
                    token: token.id
                    amount: args.amount
                success: ->
                    alert 'success!'
                error: ->
                    alert 'error!'

    $('.payment-button').on 'click', (e) ->
        handler.open
            name: "TMCYF"
            description: e.target.attr('description')
            amount: e.target.attr('amount')
        e.preventDefault()
