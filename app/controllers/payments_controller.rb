class PaymentsController < ApplicationController
  def index
    events_requiring_payment = Event.where.not(cost: nil)
    events_paid_for = current_user.payments.collect { |p| p.event }
    # the set difference of two arrays a & b in ruby is a - b | b - a
    @unpaid_events = events_requiring_payment - events_paid_for | events_paid_for - events_requiring_payment
  end
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
