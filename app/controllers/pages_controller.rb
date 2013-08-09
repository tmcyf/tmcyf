class PagesController < ApplicationController
	before_filter :authenticate_user!, :except => [:home, :about, :about_biblestudies, :about_tribes, :about_service, :about_socials, :about_officers, :about_contact, :events, :biblestudy, :account]

	def home
    url = 'http://www.heartlight.org/cgi-shl/todaysverse.cgi'
    data = Nokogiri::HTML(open(url))
    @votd = data.at_css(".todays-verse-verse").text
    @votdref = data.at_css(".todays-verse-ref").text
	end

  def about
  end

  def biblestudy
  end

  def account
  end

  def admin
  end

  def preferences
    @user = current_user
  end
  def update_preferences
    @user = current_user
    if params['Facebook']
      @user.facebook_contact=true
    else
      @user.facebook_contact=false
    end
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    if params["email"]
      @user.email_contact=true 
      if gibbon.lists.members(id: "4c04c52ede", email: @user.email)
        gibbon.lists.subscribe({:id => "4c04c52ede", :email => {:email => @user.email}, :merge_vars => {:FNAME => @user.fname, :LNAME => @user.lname}, :double_optin => false})
      end
    else
      @user.email_contact=false 
      if gibbon.lists.members(id: "4c04c52ede", email: @user.email)
        gibbon.lists.unsubscribe({:id => "4c04c52ede", :email => {:email => @user.email}, :merge_vars => {:FNAME => @user.fname, :LNAME => @user.lname}, :double_optin => false})
      end
    end
    if params["SMS"]
      if @user.phone?
        @user.sms_contact=true 
      else
        # need to flash an error notifying the user that they don't have
        # a valid phone number
        flash[:error] = "Please enter a valid phone number in your Profile."
      end
    else
      @user.sms_contact=false
    end
    @user.save!
    redirect_to account_preferences_path
  end
end