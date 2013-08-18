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
    @usable_cards = current_user.credit_card_list
    @payment = Payment.new
    @payment.event = Event.friendly.find(params[:event_id])
  end
  def create
    @payment = Payment.create(payment_params) # should include the event id & current user
    # TODO: if we don't have params[:stripe_token] we should error out of this
    # request
    if @payment and @payment.event
      Stripe::Charge.create(
        :amount => @payment.event.cost, # amount in cents, again
        :currency => "usd",
        :customer => current_user.stripe_id,
        :description => "Payment for TMCYF #{@payment.event.title}"
      )
      redirect_to account_payments_path
    else
      flash[:error] = "Event or payment was nil! @payment.event is currently #{payment_params}"
      redirect_to :back
    end
  end
  private
    def payment_params
      params.require(:payment).permit(:event_id, :credit_card)
    end
end
