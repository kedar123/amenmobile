Friendap::Application.routes.draw do
  match '/api/testuser' => 'api#testuser'
  match '/api/login' => 'api#login'
  match '/api/prayers' => 'api#prayers'
  match '/api/create_prayer' => 'api#create_prayer'
  
 
  resources :api

  resources :prayers

  resources :comments
  match '/homes' => 'users#user_action'
  resources :reject_friends
  resources :homes
  resources :facebooktests
  match '/join_the_network/:id' => 'friend_requests#join_the_network'

  match '/users/code_image/:id' => 'users#code_image'

  match '/users/show_profile/:id' => 'users#show_profile'

  match '/reset/:reset_code' => 'users#reset'

  match '/users/forgot' => 'users#forgot'
  
  match '/users/edit_profile' => 'users#edit_profile'
  
  match '/users/update_profile' => 'users#update_profile'

  match '/users/koalatest' => 'users#koalatest'

  match '/friend_requests/friend_request' => 'friend_requests#friend_request'

  match '/friend_requests/send_friend_request' => 'friend_requests#send_friend_request'

  resources :friend_requests

  match '/friendships/invite_friend' => 'friendships#invite_friend'

  match '/friendships/pending_invitation' => 'friendships#pending_invitation'

  match '/friendships/accept_invitation' => 'friendships#accept_invitation'

  match '/friendships/invitation_by' => 'friendships#invitation_by'

  match '/friendships/invite' => 'friendships#invite'

  match '/friendships/invitation' => 'friendships#invitation'

  match '/friendships/get_all_friend' => 'friendships#get_all_friend'

  match '/users/my_profile' => 'users#my_profile'

  resources :friendships

  resources :users

  resource :session, :only => [:new, :create, :destroy]

  match 'signup' => 'users#new', :as => :signup

  match 'register' => 'users#create', :as => :register

  match 'login' => 'sessions#new', :as => :login

  match 'logout' => 'sessions#destroy', :as => :logout

  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil



  
  root :to => "users#user_action"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
