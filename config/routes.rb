TMCYF::Application.routes.draw do

  resources :featured_events

  mount RailsAdmin::Engine => '/admin2', :as => 'rails_admin'
  resources :give, only: [:index, :new, :create]

  resources :events

  devise_for :users,
    controllers: { registrations: :registrations },
    path: '',
    path_names: { sign_in: 'login',
                  sign_out: 'logout',
                  sign_up: 'register',
                  password: 'reset' }

  devise_scope :user do
    get '/login',                   to: 'devise/sessions#new'
    get '/logout',                  to: 'devise/sessions#destroy'
    get '/register',                to: 'devise/registrations#new'
    post '/register',               to: 'devise/registrations#create'
    get '/reset',                   to: 'devise/passwords#new'
    put '/reset',                   to: 'devise/passwords#update'
    post '/reset',                  to: 'devise/passwords#create'
    get '/reset/change',            to: 'devise/passwords#edit'
    get '/account',                 to: 'devise/registrations#edit'
    patch '/account',               to: 'devise/registrations#update'
    put '/account',                 to: 'devise/registrations#update'
  end

  root to: 'pages#home'
  get '/about',                     to: 'pages#about'
    get '/about/biblestudies',      to: 'pages#about_biblestudies'
    get '/about/tribes',            to: 'pages#about_tribes'
    get '/about/service',           to: 'pages#about_service'
    get '/about/socials',           to: 'pages#about_socials'
    get '/about/officers',          to: 'pages#about_officers'
    get '/about/officers/past',     to: 'pages#officers_archive'
    get '/about/contact',           to: 'pages#about_contact'
  get '/biblestudy',                to: 'pages#biblestudy'
  get '/admin',                     to: 'admin#dashboard'
  get '/admin/database',            to: 'admin#database', as: 'database'
  get '/account/preferences',       to: 'preferences#edit'
  post '/account/preferences',      to: 'preferences#update'
  get '/privacy_policy',            to: 'pages#privacy_policy'
  get '/admin/new_sms',            to: 'sms#new_sms', as: "send_sms"
  post '/admin/receive_sms',        to: 'sms#receive_sms', as: "receive_sms"
  post '/admin/send_sms',       to: 'sms#send_sms', as: "send_message"
  get ':status', to: 'errors#show', constraints: {status: /\d{3}/}
end
