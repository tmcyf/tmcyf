class AdminController < ApplicationController

  def dashboard
    redirect_to :root unless current_user && current_user.admin?
    @fb_users = User.prefers_fb.collect { |user| user.fullname }
    @email_users = User.prefers_emails.collect { |user| user.fullname }
    @sms_users = User.prefers_sms.collect { |user| user.fullname }
    @allusers = User.all.collect { |user| user.fullname }
  end
  
  def database
    redirect_to :root unless current_user && current_user.admin?
    @users = User.order(:city, :birthday)
    respond_to do |format|
      format.xls
    end
  end
end
