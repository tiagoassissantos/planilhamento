Rails.application.routes.draw do
  root to: 'main#index'
  devise_for :users, controllers: { sessions: 'user/sessions' }

  devise_scope :user do
    get 'logged', to: 'user/sessions#logged'
    #get 'current_user', to: 'user/sessions#current_user'
  end

  get 'user-area' => 'user_area#index'

  get 'hardware_types' => 'hardware_types#index'
  post 'hardware_types' => 'hardware_types#create'
  get 'hardware_types/:id' => 'hardware_types#show'
end
