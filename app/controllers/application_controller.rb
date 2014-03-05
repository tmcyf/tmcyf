class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_admin
    current_user && current_user.admin?
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:fname, :lname, :email, :password, :password_confirmation, :current_password, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirtsize) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fname, :lname, :email, :password, :password_confirmation, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirtsize) }
  end
end
