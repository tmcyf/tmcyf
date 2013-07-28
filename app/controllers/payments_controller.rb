class PaymentsController < ApplicationController
  def new
    # in this page, you should only be able to pick credit cards that are valid
    # for current_user
    @usable_cards = current_user.credit_cards
    @payment = Payment.new
    # the user is directed to this page by clicking "Pay Now" on a payment on
    # the payments/index page (at the route /account/payments)
    @payment.event = params[:event_id]
  end
  def create
    # does this method know that we're paying for the user currently signed in?
    # :stripe_token is set by Stripe.js, which we handle in credit_card.js.coffee
    @payment.credit_card = CreditCard.find_by(stripe_token: params[:stripe_token])
  end
end
