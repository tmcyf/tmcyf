class User::ParameterSanitizer < Devise::ParameterSanitizer
	private
    def account_update
      default_params.permit(:fname, :lname, :email, :password, :password_confirmation, :current_password, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirtsize)
    end
    def sign_up
      default_params.permit(:fname, :lname, :email, :password, :password_confirmation)
    end
end
