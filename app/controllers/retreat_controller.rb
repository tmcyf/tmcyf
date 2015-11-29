class RetreatController < ApplicationController

  def index
    @retreat = Retreat.new
  end

  def create
    @retreat = Retreat.create(retreat_params)
    if @retreat.save!
      flash[:success] = "You're registered!"
      RetreatMailer.registration_confirmation(@retreat).deliver
      redirect_to retreat_index_path
    else
      flash[:error] = "Oops, something went wrong while registering you. Try again?"
      redirect_to retreat_index_path
    end
  end

  def charge
    # Amount in cents
    amount = 9000
    compensated_charge = StripeCompensator.compensate(amount)
    email = params[:stripeEmail]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => compensated_charge,
      :description => email,
      :currency    => 'usd'
    )
    flash[:success] = "Thanks for your payment!"
    RetreatMailer.payment_confirmation(email).deliver
    redirect_to retreat_index_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to retreat_index_path
  end

  private

    def retreat_params
      params.require(:retreat).permit(:fname, :lname, :email, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirt_size, :transportation, :emergency_contact, :emergency_contact_relation, :emergency_contact_number, :insurance_provider, :insurance_policy_number, :allergy_information)
    end
end