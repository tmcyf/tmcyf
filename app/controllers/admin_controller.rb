class AdminController < ApplicationController
  def xls
    send_data(User.to_xls)
  end
end
