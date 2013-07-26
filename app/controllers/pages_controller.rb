class PagesController < ApplicationController
	before_filter :authenticate_user!, :except => [:home, :about, :about_biblestudies, :about_tribes, :about_service, :about_socials, :about_officers, :about_contact, :events, :biblestudy, :account]

	def home		
	end

  def about
  end

  def biblestudy
  end

  def account
  end

  def preferences
    current_user.facebook_contact=true if params["Facebook"]
    current_user.email_contact=true if params["email"]
    current_user.sms_contact=true if params["SMS"]
  end
end
