Static::Application.routes.draw do
  resources :events
    get '/events/new' => 'events#new'
    get '/events/edit' => 'events#edit'
  devise_for :users, :controllers => { :registrations => :registrations }, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register', :password => 'reset'}

  devise_scope :user do
    get "/login"                    => "devise/sessions#new"
    get "/logout"                   => "devise/sessions#destroy"
    get "/register"                 => "devise/registrations#new"
    post "/register"                => "devise/registrations#create"
    get "/reset"                    => "devise/passwords#new"
    put "/reset"                    => "devise/passwords#update"
    post "/reset"                   => "devise/passwords#create"
    get "/reset/change"             => "devise/passwords#edit"
    get "/account/profile"        => "devise/registrations#edit"
    patch "/account/profile"      => "devise/registrations#update"
    put "/account/profile"        => "devise/registrations#update"
  end

  root to: 'pages#home'
  match '/about',         to: 'pages#about',        via: 'get'
    match '/about/biblestudies',  to: 'pages#about_biblestudies',     via: 'get'
    match '/about/tribes',        to: 'pages#about_tribes',           via: 'get'
    match '/about/service',       to: 'pages#about_service',          via: 'get'
    match '/about/socials',       to: 'pages#about_socials',          via: 'get'
    match '/about/officers',      to: 'pages#about_officers',         via: 'get'
    match '/about/contact',       to: 'pages#about_contact',          via: 'get'
  match '/biblestudy',    to: 'pages#biblestudy',   via: 'get'
  match '/account',    to: 'pages#account',   via: 'get'
    match '/account/profile',    to: 'pages#profile',   via: 'get'
    match '/account/preferences',    to: 'pages#preferences',   via: 'get'
    match '/account/payments',    to: 'pages#payments',   via: 'get'
end
