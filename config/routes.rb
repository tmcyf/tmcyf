Static::Application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register', :password => 'password'}

  devise_scope :user do
    get "/login"            => "devise/registrations#new"
    get "/logout"           => "devise/sessions#destroy"
    get "/register"         => "devise/registrations#new"
    post "/register"        => "devise/registrations#create"
  end

  root to: 'pages#home'
  match '/about',         to: 'pages#about',        via: 'get'
    match '/about/biblestudies',  to: 'pages#about_biblestudies',     via: 'get'
    match '/about/tribes',        to: 'pages#about_tribes',           via: 'get'
    match '/about/service',       to: 'pages#about_service',          via: 'get'
    match '/about/socials',       to: 'pages#about_socials',          via: 'get'
    match '/about/officers',      to: 'pages#about_officers',         via: 'get'
    match '/about/contact',       to: 'pages#about_contact',          via: 'get'
  match '/events',        to: 'pages#events',       via: 'get'
  match '/biblestudy',    to: 'pages#biblestudy',   via: 'get'
end
