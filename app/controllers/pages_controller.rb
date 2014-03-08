class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:home, :about, :about_biblestudies, :about_tribes, :about_service, :about_socials, :about_officers, :officers_archive, :about_contact, :events, :biblestudy, :privacy_policy]

  def database
    redirect_to :root unless current_user && current_user.admin?
    @users = User.order(:city, :birthday)
    respond_to do |format|
      format.xls
    end
  end

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

  def admin
    redirect_to :root unless current_user && current_user.admin?
    @fb_users = User.prefers_fb.collect { |user| user.fullname }
    @email_users = User.prefers_emails.collect { |user| user.fullname }
    @sms_users = User.prefers_sms.collect { |user| user.fullname }
    @allusers = User.all.collect { |user| user.fullname }
  end

  def preferences
    @user = current_user
  end

  def privacy_policy
  end

  def update_preferences
    @user = current_user
    params['Facebook'] ? @user.facebook_contact=true : @user.facebook_contact=false
    params['Email'] ? @user.email_subscribe : @user.email_unsubscribe
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
