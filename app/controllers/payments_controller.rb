class PaymentsController < ApplicationController
  def index
    @events = Event.all # test code, TODO: delete l8ter
    # events_requiring_payment = Event.where.not(cost: nil)
    # events_paid_for = current_user.payments.collect { |p| p.event }
    # the set difference of two arrays a & b in ruby is a - b | b - a
    # @unpaid_events = events_requiring_payment - events_paid_for | events_paid_for - events_requiring_payment
  end
  def new
    # in this page, you should only be able to pick credit cards that are valid
    # for current_user
    @usable_cards = current_user.credit_cards
    @payment = Payment.new
    # the user is directed to this page by clicking "Pay Now" on a payment on
    # the payments/index page (at the route /account/payments)
    @payment.event = Event.find(params[:event_id])
  end
  def create
    @payment = Payment.new(payment_params) # should include the event id & current user
    # does this method know that we're paying for the user currently signed in?
    # :stripe_token is set by Stripe.js, which we handle in credit_card.js.coffee
    @payment.credit_card = CreditCard.where(stripe_token: params[:stripe_token]).first_or_create
    begin
      charge = Stripe::Charge.create(
        :amount => @payment.event.cost, # amount in cents, again
        :currency => "usd",
        :card => params[:stripe_token],
        :description => "Payment for TMCYF #{@payment.event.title}"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
    redirect_to account_payments_path
  end
  private
    def payment_params
      params.require(:payment).permit(:event, :credit_card)
    end
end
