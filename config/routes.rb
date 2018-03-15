Rails.application.routes.draw do
  
  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get 'home/show'

	#handles the callback from google omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
	get 'auth/failure', to:redirect('/')
	#signout used when user logs out
	get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'session/create'

  get 'session/destroy'
	
  root 'users#new'
  
  #routing for search
  get 'artists/index'
  match 'artists/index', to: 'artists#index', via: :post
  
  #routing for calendar
  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'
  get '/calendars', to: 'example#calendars', as: 'calendars'
  get '/events/:calendar_id', to: 'example#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'example#new_event', as: 'new_event', calendar_id: /[^\/]+/
  
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
   post '/signup',  to: 'users#create'
   resources :users 
	 resources :google_users 
	 resources :sessions, only:[:create, :destroy]
end
