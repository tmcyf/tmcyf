class RegistrationsController < Devise::RegistrationsController
  protected
    def after_update_path_for(resource)
      account_path(resource)
    end
end