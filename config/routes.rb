Static::Application.routes.draw do

  resources :give, only: [:index, :new, :create]

  resources :events

  devise_for :users,
    controllers: { registrations: :registrations, confirmations: :confirmations },
    path: '',
    path_names: {sign_in: 'login',
                 sign_out: 'logout',
                 sign_up: 'register',
                 password: 'reset'}
  get '/users/database.xls' => 'admin#xls'

  devise_scope :user do
    get '/login'                    => 'devise/sessions#new'
    get '/logout'                   => 'devise/sessions#destroy'
    get '/register'                 => 'devise/registrations#new'
    post '/register'                => 'devise/registrations#create'
    get '/reset'                    => 'devise/passwords#new'
    put '/reset'                    => 'devise/passwords#update'
    post '/reset'                   => 'devise/passwords#create'
    get '/reset/change'             => 'devise/passwords#edit'
    get '/account/profile'          => 'devise/registrations#edit'
    patch '/account/profile'        => 'devise/registrations#update'
    put '/account/profile'          => 'devise/registrations#update'
  end

  root to: 'pages#home'
  get '/about'                      => 'pages#about'
    get '/about/biblestudies'       => 'pages#about_biblestudies'
    get '/about/tribes'             => 'pages#about_tribes'
    get '/about/service'            => 'pages#about_service'
    get '/about/socials'            => 'pages#about_socials'
    get '/about/officers'           => 'pages#about_officers'
    get '/about/officers/past'      => 'pages#officers_archive'
    get '/about/contact'            => 'pages#about_contact'
  get '/biblestudy'                 => 'pages#biblestudy'
  get '/account'                    => 'pages#account'
  get '/admin'                      => 'pages#admin'
  get '/account/profile'            => 'pages#profile'
  get '/account/preferences'        => 'pages#preferences'
  post '/account/preferences'       => 'pages#update_preferences'
  get '/privacy_policy'             => 'pages#privacy_policy'
  get '/admin/send_sms'             => 'contact#send_sms', as: "send_sms"
  post '/admin/receive_sms'         => 'contact#receive_sms', as: "receive_sms"
  post '/admin/send_message'        => 'contact#send_all_message', as: "send_message"
  get ':status', to: 'errors#show', constraints: {status: /\d{3}/}
end
