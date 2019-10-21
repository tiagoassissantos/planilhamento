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
  get 'admin' => 'admin#index'

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
  get 'damage_types/by-hardware-name/:hardware_type_name' => 'damage_types#by_hardware_name'


  resources :keyboard_types, only: [:index, :create, :destroy, :show, :update]
  resources :destinations, only: [:index, :create, :destroy, :show, :update]
  get '/transfer_destinations' => 'destinations#transfer_destinations'
  resources :disk_types, only: [:index, :create, :destroy, :show, :update]
  resources :disk_sizes, only: [:index, :create, :destroy, :show, :update]

  resources :lots, only: [:index, :create, :destroy, :show, :update] do
    resources :lot_items, only: [:index, :create, :destroy] do
    end
    get 'get_all_skus' => 'lot_items#get_all_skus'
    get 'get_sku/:sku_id' => 'lot_items#get_sku'
  end

  resources :lot_items, only: [:show, :update] do
  end

  get 'search_lot/:bar_code/:lot_number/:serial_number/:add_item' => 'lot_items#search_lot'
  get 'get_stock/:h_type_id/:manufacturer_id/:model_id/:lot_id/:destination_id' => 'lot_items#get_stock'
  post 'change_destination' => 'lot_items#change_destination'
  get 'report_xls' => 'lot_items#report_xls'

  resources :sales_orders, only: [:index, :create, :show, :update] do
    resources :sales_orders_items, only: [:index]
    post 'add_item' => 'sales_orders#add_item'
    delete 'item_devolution' => 'sales_orders#item_devolution'
  end

  resources :skus, only: [:index, :update, :show] do
    delete 'delete_archive' => 'skus#delete_archive'
  end

  get 'query_sku/:filter' => 'skus#query_sku'

  resources :customers, only: [:create, :index, :show, :update]
  resources :constructions, only: [:index, :create, :show, :update, :destroy] do
    resources :construction_stages, only: [:index, :create]
  end
  #post 'get_stage_by_construction' => 'construction_stages#get_stage_by_construction'

  resources :construction_stages, only: [:show, :destroy] do
    resources :stage_items, only: [:index, :create, :update]
  end

  resources :stage_items, only: [:show, :destroy] do
    resources :item_elements, only: [:index, :create, :update, :destroy]
  end

  resources :formats, only: [:index, :create]
end
