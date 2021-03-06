TMCYF::Application.routes.draw do

  resources :retreat
  post 'retreat/charge',               to: 'retreat#charge'

  resources :sermons

  resources :odr_registrations
  get '/the-faith-awakens',                  to: 'odr_registrations#form'
  post '/the-faith-awakens/register',        to: 'odr_registrations#create'
  post '/the-faith-awakens/charge',          to: 'odr_registrations#charge'

  resources :featured_events
  resources :payments
  post '/payments/:id/charge', to: 'payments#charge', as: 'charge_payment'

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
  get '/3-on-3',                    to: 'pages#3on3'
  get '/admin',                     to: 'admin#dashboard'
  # not very RESTful; we can tidy that up later
  get '/admin/offline_payments',    to: 'payments#new_offline_charge', as: 'new_offline_charge'
  post '/admin/offline_payments',   to: 'payments#create_offline_charge', as: 'create_offline_charge'
  get '/admin/edit_payments_index', to: 'payments#edit_payments_index', as: 'edit_payments_index'
  get '/account/preferences',       to: 'preferences#edit'
  post '/account/preferences',      to: 'preferences#update'
  get '/privacy_policy',            to: 'pages#privacy_policy'
  get '/admin/new_sms',             to: 'sms#new_sms', as: "send_sms"
  post '/admin/receive_sms',        to: 'sms#receive_sms', as: "receive_sms"
  post '/admin/send_sms',           to: 'sms#send_sms', as: "send_message"
  get ':status', to: 'errors#show', constraints: {status: /\d{3}/}
end
