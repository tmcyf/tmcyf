class WomensRetreatRegistrationsController < ApplicationController
  def form
    @registration = WomensRetreatRegistration.new
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

  private
  def womens_retreat_registration_params
    params.require(:womens_retreat_registration).permit(:fname, :lname, :birthday, :address, :phone, :age, :academic_classification, :parish, :accommodations, :restrictions, :medical_conditions, :insurance_info, :ec_name, :ec_phone, :ec_relationship, :payment_method)
  end
end
