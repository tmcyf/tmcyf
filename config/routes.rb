TmcyfBackend::Application.routes.draw do
  devise_for :users
  match '/events', to: 'static_pages#events',                               via: 'get'
  match '/about', to: 'static_pages#about',                                 via: 'get'
  match '/about/biblestudy', to: 'static_pages#about_biblestudy',           via: 'get'
  match '/about/tribes', to: 'static_pages#about_tribes',                   via: 'get'
  match '/about/service', to: 'static_pages#about_service',                 via: 'get'
  match '/about/socials', to: 'static_pages#about_socials',                 via: 'get'
  match '/about/officers', to: 'static_pages#about_officers',               via: 'get'
  match '/about/contact', to: 'static_pages#about_contact',                 via: 'get'
  match '/biblestudy', to: 'static_pages#biblestudy',                       via: 'get'

  root :to => "static_pages#home"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
