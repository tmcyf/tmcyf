class PaymentsController < ApplicationController
  def index
    @credit_card = current_user.credit_card
    @paid_events = current_user.paid_events
    @unpaid_events = current_user.unpaid_events
  end
  def new
    @payment = Payment.new
  end
  def create
    unless current_user.credit_card
      flash[:error] = "Please provide a valid credit card"
      redirect_to account_payments_path
    else
      @payment = Payment.create # should include the event id & current user
      @payment.event = Event.friendly.find(params[:event_id])
      @payment.last4 = current_user.credit_card.last4 # TODO: cache this value
      # TODO: I think this is an anti-pattern? Try current_user.payment.build or
      # something to that effect
      @payment.user = current_user
      begin
        @payment.stripe_id = current_user.charge(amount: (@payment.event.cost * 100).to_i,
                            description: "Payment for TMCYF #{@payment.event.title}").id
        flash[:success] = "Payment has been made for #{@payment.event.title}" if @payment.save!
        redirect_to account_payments_path
      rescue Stripe::CardError => e
        # TODO: More informative error messages
        logger.info(e)
        flash[:error] = e.json_body[:message]
        redirect_to account_payments_path
      end
    end
  end

private
    def payment_params
      params.require(:payment).permit(:event_id)
    end
end
