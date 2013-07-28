class PaymentsController < ApplicationController
  def new
    # in this page, you should only be able to pick credit cards that are valid
    # for current_user
    @payment = Payment.new
  end
  def create
    # does this method know that we're paying for the user currently signed in?
    # :stripe_token is set by Stripe.js, which we handle in credit_card.js.coffee
    @payment.credit_card = CreditCard.find_by(stripe_token: params[:stripe_token])
    @payment.event = params[:event_id]
  end
end
