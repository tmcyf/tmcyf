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
    charge_params = StripeService.new(token).submit_payment_for!(@payment)
    charge_params.merge(user_id: current_user.id)
    if Charge.new(charge_params).save!
      render json: {success: "Payment successfully made!"}.to_json
    else
      render json: {error: "There was an error submitting your payment."}.to_json
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :description)
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end
end
