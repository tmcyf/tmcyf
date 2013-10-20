class RetreatRegistrationsController < ApplicationController
  def create
    @registration = RetreatRegistration.new(registration_params)
    @registration.user_id = current_user.id
    if @registration.save
      flash[:notice] = "See you there!"
      redirect_to account_payments_path
    else
      flash[:error] = "There was a problem registering you for retreat"
      redirect_to :back
    end
  end

  private
  def registration_params
    params.require(:retreat_registration).permit(:fname, :lname, :line1, :city,
                                                 :state, :zip, :phone, :gender,
                                                 :birthday, :shirtsize,
                                                 :emergency_contact,
                                                 :emergency_phone,
                                                 :insurance_provider,
                                                 :emergency_relation,
                                                 :insurance_policy_number,
                                                 :days_attending, :retreat_id)
  end
end
