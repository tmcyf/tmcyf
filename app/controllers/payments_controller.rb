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
    @default_card = current_user.credit_card
    @payment = Payment.new
    @payment.event = Event.friendly.find(params[:event_id])
  end
  def create
    @payment = Payment.create(payment_params) # should include the event id & current user
    begin
      current_user.charge(amount: @payment.event.cost, description: "Payment for TMCYF #{@payment.event.title}")
      redirect_to account_payments_path
    rescue => e
      # TODO: More informative error messages
      redirect_to account_payments_path, error: e
    end
  end
  private
    def payment_params
      params.require(:payment).permit(:event_id, :credit_card)
    end
end
