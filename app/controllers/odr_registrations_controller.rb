class OdrRegistrationsController < ApplicationController

  def form
    @registration = OdrRegistration.new
    @pm = [ "Online - $15", "Cash - $15", "Check (made out to TMCYF) - $15" ]
  end

  def create
    @registration = OdrRegistration.new(odr_registration_params)
    if @registration.save!
      flash[:success] = "Successfully registered!"
      OdrMailer.registration_confirmation(@registration).deliver
      redirect_to the_faith_awakens_path
    else
      flash[:error] = "Oops, there was an error registering you for One Day Retreat."
      redirect_to the_faith_awakens_path
    end
  end

  def charge
    # Amount in cents
    @amount = 1576
    @email = params[:stripeEmail]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @email,
      :currency    => 'usd'
    )
    flash[:success] = "Thanks for your payment!"
    OdrMailer.payment_confirmation(@email).deliver
    redirect_to the_faith_awakens_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to the_faith_awakens_path
  end

  private
  def odr_registration_params
    params.require(:odr_registration).permit(:email, :fname, :lname, :age, :parish, :shirt_size, :payment_method, :diet)
  end
end