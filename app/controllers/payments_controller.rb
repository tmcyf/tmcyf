class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:charge]
  before_action :set_payment, only: [:charge, :edit, :update]
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

  def edit
    
  end

  def update
    if @payment.update(edit_payment_params)
      flash[:success]= "Payment successfully updated"
      redirect_to admin_path
    else
      flash[:error]= "There was an error updating the payment"
      redirect_to edit_payment_path
    end
  end

  def index
    payment_history = PaymentHistory.new(current_user)
    @paid = payment_history.paid
    @unpaid = payment_history.unpaid
  end

  def new_offline_charge
    @charge = Charge.new
  end

  def create_offline_charge
    @charge = Charge.new(offline_charge_params)
    @charge.amount = @charge.payment.amount
    if @charge.save!
      flash[:success] = "Recorded payment made offline by #{@charge.user.fullname} for #{@charge.payment.description}."
    else
      flash[:error] = "An error occurred."
    end
    redirect_to :back
  end

  def charge
    token = params[:stripeToken]
    compensated_charge = StripeCompensator.compensate(@payment.amount)
    description = "#{current_user.fullname}'s payment for #{@payment.description}."
    charge_result = StripeService.new(token).charge!(compensated_charge,
                                                     description)
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
    params.require(:payment).permit(:ids, :amount, :description)
  end

  def edit_payment_params
    params.require(:payment).permit(:active, :description)
  end

  def offline_charge_params
    params.require(:charge).permit(:user_id, :payment_id)
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end
end
