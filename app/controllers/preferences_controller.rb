class PreferencesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end
  def update
    @user = current_user
    params['Facebook'] ? @user.facebook_contact=true : @user.facebook_contact=false
    params['Email'] ? Mailman.new.subscribe(@user) : Mailman.new.unsubscribe(@user)
    if params["SMS"]
      error_msg = "There was a problem subscribing you to our text alerts. Is there a valid phone number in your Profile?"
      flash[:error] = error_msg unless @user.sms_subscribe
    else
      @user.sms_unsubscribe
    end
    @user.save!
    flash[:notice] = "Preferences saved!"
    redirect_to account_preferences_path
  end
end
