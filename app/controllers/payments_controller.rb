class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:charge]
  before_action :set_payment, only: [:charge]

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
    charge_result = StripeService.new(token).charge!(@payment.amount)
    @charge = @payment.charges.build
    @charge.user = current_user
    @charge.amount = @payment.amount
    @charge.stripe_id = charge_result.id
    @charge.last4 = charge_result.card.last4
    if @charge.save!
      flash[:success] = "Payment successfully made!"
      # render json: {success: "Payment successfully made!"}.to_json
    else
      flash[:error] =  "There was an error submitting your payment."
      # render json: {error: "There was an error submitting your payment."}.to_json
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
