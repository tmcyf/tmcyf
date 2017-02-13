RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
    unless current_user.try(:admin?)
      flash[:error] = "You are not an admin"
      redirect_to '/'
    end
  end
  config.current_user_method(&:current_user)

  # Include specific models (exclude the others):
  config.included_models = ['User', 'Sermon', 'Retreat', 'OdrRegistration']

  config.model 'User' do
    edit do
      include_fields :email, :fname, :lname, :phone, :gender, :birthday, :line1, :city, :state, :zip, :shirtsize, :email_contact, :facebook_contact, :sms_contact, :admin, :status
    end
  end


  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
