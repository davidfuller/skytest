Rails.application.routes.draw do
  
  devise_for :users, controllers: {registrations:'registrations'}

  resources :clips
  resources :statuses
  resources :folders
  resources :clip_types
  resources :device_types
  resources :channels
  resources :channel_types
  resources :bss_title_ids

  resources :homes
  resources :episodes
  resources :titles
  resources :users
  
  resources :titles do
  	member do
  		get 'add_episode'
  	end
  end

  resources :clips do
    member do 
      get 'remove_device_type'
      get 'add_device_type'
      get 'remove_tx_channel'
      get 'remove_promo_channel'
      get 'add_tx_channel'
      get 'add_promo_channel'
      get 'remove_bss'
      get 'add_bss'
    end
  end

  resources :folders do
    member do
      get 'duplicate'
      get 'add_clip_type'
      get 'remove_clip_type'
    end
  end

  resources :clip_types do
    member do
      get 'remove_device_type'
      get 'add_device_type'
      get 'remove_tx_channel'
      get 'remove_promo_channel'
      get 'add_tx_channel'
      get 'add_promo_channel'
    end
  end

  resources :episodes do
  	member do
  		get 'add_bss_title_id'
  	end
  end

  resource :bss_title_id do
    member do
      get 'remove_channel'
      get 'add_channel'
      get 'remove_clip'
      get 'add_clip'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: 'titles#index'

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
