class ConfirmationsController < Devise::ConfirmationsController
	private

	def after_confirmation_path_for(resource_name, resource)
		account_profile_path(resource)
	end
end