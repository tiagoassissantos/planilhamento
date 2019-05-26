Rails.application.routes.draw do
  root to: 'main#index'
  devise_for :users, controllers: { sessions: 'user/sessions' }

  devise_scope :user do
    get 'logged', to: 'user/sessions#logged'
    #get 'current_user', to: 'user/sessions#current_user'
  end

  get 'user-area' => 'user_area#index'
end
