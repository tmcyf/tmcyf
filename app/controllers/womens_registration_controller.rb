class WomensRetreatRegistrationController < ApplicationController
  def form
    @registration = WomensRetreatRegistration.new
  end

  def register
    @registration = WomensRetreatRegistration.create(params[:registration])
    if @registration.save!
      flash[:success] = "Successfully registered!"
    else
      flash[:error] = "Oops, there was an error creating your registration."
    end
  end
end
