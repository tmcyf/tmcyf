class AdminController < ApplicationController

  def dashboard
    redirect_to :root unless current_user && current_user.admin?
  end

end
