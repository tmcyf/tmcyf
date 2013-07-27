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
    @user = current_user
  end
  def update_preferences
    @user = current_user
    @user.facebook_contact=true if params["Facebook"]
    gibbon = Gibbon::API.new
    if params["email"]
      @user.email_contact=true 
      gibbon.lists.subscribe({:id => "c0e58367c5", :email => {:email => @user.email}, :merge_vars => {:FNAME => @user.fname, :LNAME => @user.lname}, :double_optin => false})
    else
      @user.email_contact=false 
      if gibbon.lists.members(id: "c0e58367c5", email: @user.email)
        gibbon.lists.unsubscribe({:id => "c0e58367c5", :email => {:email => @user.email}, :merge_vars => {:FNAME => @user.fname, :LNAME => @user.lname}, :double_optin => false})
      end
    end
    if params["SMS"]
      @user.sms_contact=true 
    else
      @user.sms_contact=false
    end
    @user.save!
    redirect_to account_preferences_path
  end
end
