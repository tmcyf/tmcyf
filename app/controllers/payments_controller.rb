class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:charge]
  before_action :set_payment, only: [:charge]
  # ajax flash handling
  after_filter :prepare_unobtrusive_flash, only: [:charge]

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save!
      flash[:success]= "Payment successfully created."
      redirect_to admin_path
    else
      flash[:error]= "There was an error creating the payment."
      redirect_to new_payment_path
    end
  end

  def index
    payment_history = PaymentHistory.new(current_user)
    @paid = payment_history.paid
    @unpaid = payment_history.unpaid
  end

  def charge
    token = params[:stripeToken]
    compensated_charge = StripeCompensator.compensate(@payment.amount)
    charge_result = StripeService.new(token).charge!(compensated_charge)
    @charge = @payment.charges.build(user: current_user,
                                     amount: compensated_charge,
                                     stripe_id: charge_result.id,
                                     last4: charge_result.card.last4)
    if @charge.save!
      flash[:success] = "Payment successfully made!"
    else
      flash[:error] =  "There was an error submitting your payment."
    end
    redirect_to :back
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :description)
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end
end
