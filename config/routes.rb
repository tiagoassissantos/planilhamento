Rails.application.routes.draw do
  root to: 'main#index'
  devise_for :users,
    controllers: {
      sessions: 'user/sessions',
      registrations: 'user/registrations'
    }

  devise_scope :user do
    get 'logged', to: 'user/sessions#logged'
    get 'users', to: 'user/registrations#index'
    get 'users/:id', to: 'user/registrations#edit'
    put 'users/:id', to: 'user/registrations#update'
    patch 'update_password', to: 'user/registrations#update_password'
    get 'get_user', to: 'user/sessions#get_user'
  end


  get 'user-area' => 'user_area#index'

  get 'hardware_types' => 'hardware_types#index'
  post 'hardware_types' => 'hardware_types#create'
  get 'hardware_types/:id' => 'hardware_types#show'
  put 'hardware_types/:id' => 'hardware_types#update'
  delete 'hardware_types/:id' => 'hardware_types#destroy'

  resources :manufacturers, only: [:index, :create, :destroy, :show, :update]

  resources :models, only: [:index, :create, :destroy, :show, :update]
  get 'models/by-manufacturer/:manufacturer_id' => 'models#by_manufacturer'

  resources :categories, only: [:index, :create, :destroy, :show, :update]
  resources :processors, only: [:index, :create, :destroy, :show, :update]

  resources :damage_types, only: [:index, :create, :destroy, :show, :update]
  get 'damage_types/by-hardware-type/:hardware_type_id' => 'damage_types#by_hardware_type'

  resources :keyboard_types, only: [:index, :create, :destroy, :show, :update]
  resources :destinations, only: [:index, :create, :destroy, :show, :update]
  resources :disk_types, only: [:index, :create, :destroy, :show, :update]
  resources :disk_sizes, only: [:index, :create, :destroy, :show, :update]

  resources :lots, only: [:index, :create, :destroy, :show, :update] do
    resources :lot_items, only: [:index, :create, :destroy, :show, :update] do
    end
    get 'get_all_skus' => 'lot_items#get_all_skus'
    get 'get_sku/:sku_id' => 'lot_items#get_sku'
  end
  get 'search_lot/:bar_code/:lot_number/:serial_number/:add_item' => 'lot_items#search_lot'
  post 'change_destination' => 'lot_items#change_destination'

  resources :sales_orders, only: [:index, :create, :show, :update] do
    resources :sales_orders_items, only: [:index]
    post 'add_item' => 'sales_orders#add_item'
    delete 'item_devolution' => 'sales_orders#item_devolution'
  end


end
