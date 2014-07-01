class WomensRetreatRegistrationsController < ApplicationController
  def form
    @registration = WomensRetreatRegistration.new
    @ac = [ "Intermediate", "High School", "Undergraduate", "Graduate", "Post-Graduate" ]
    @parish = [  "Horeb Mar Thoma Church, Colorado", "Mar Thoma Church of Oklahoma", "Sehion Mar Thoma Church", "Carrollton Mar Thoma Church", "St. Paul's Mar Thoma Church", "Farmer's Branch Mar Thoma Church", "Austin Mar Thoma Church", "Immanuel Mar Thoma Church", "Trinity Mar Thoma Church" ]
    @pm = [ "Online - $25", "Cash - $25", "Check (made out to TMCYF) - $25" ]
  end

  def create
    @registration = WomensRetreatRegistration.new(womens_retreat_registration_params)
    if @registration.save!
      flash[:success] = "Successfully registered!"
      redirect_to womens_retreat_path
    else
      flash[:error] = "Oops, there was an error creating your registration."
      redirect_to root_url
    end
  end

  def charge
    # Amount in cents
    @amount = 2606
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
    redirect_to womens_retreat_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  private
  def womens_retreat_registration_params
    params.require(:womens_retreat_registration).permit(:email, :fname, :lname, :birthday, :address, :phone, :age, :academic_classification, :parish, :accommodations, :restrictions, :medical_conditions, :insurance_info, :ec_name, :ec_phone, :ec_relationship, :payment_method)
  end
end
