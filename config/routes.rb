Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  
  resources :fd_types
  
  get 'admin/user' => 'admin#user'
  get 'admin/fooddrink' => 'admin#fooddrink'
  get 'admin/category' => 'admin#category'
  get 'admin/club' => 'admin#club'
  put 'admin/user/:id' => 'admin#update_user'
  patch 'admin/user/:id' => 'admin#update_user'
  # delete 'admin/user/:id' => 'admin#destroy_user'
  match 'admin/user/:id' => 'admin#destroy_user', via: :delete, as: 'delete_user'
  
  get 'static_pages/:foodtype' => 'static_pages#fd_list', as: 'fd_list'
  put 'clubs/join/:id' => 'clubs#join_club'
  patch 'clubs/join/:id' => 'clubs#join_club'
  
  match 'clubs/:id/member/:member_id' => 'clubs#kick_out_user', via: :delete, as: 'kick_out_user'
  # delete 'clubs/:id/member' => 'clubs#kick_out_user'
  # match 'admin/user/:id'

  # get 'admin/update_user'
  resources :fd_types
  resources :fooddrinks
  # get 'users/show'
  resources :clubs do
    
    resources :club_events
    put 'club_events/join/:id' => 'club_events#join_club_event'
    patch 'club_events/join/:id' => 'club_events#join_club_event'
  end
  
  mount Commontator::Engine => '/commontator'

  root 'static_pages#home'
  match 'users/profile/:id' => 'users#show', via: :get, as: 'show_user'

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"}
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
  
  Commontator::Engine.routes.draw do
  # post '/rate' => 'rater#create', :as => 'rate'
  resources :threads, :only => [:show] do
    resources :comments, :except => [:index, :destroy], :shallow => true do
      member do
        delete 'delete'
      end
    end
  end
end
  
end
