Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions' }

  devise_scope :user do
    get 'logged', to: 'user/sessions#logged'
    #get 'current_user', to: 'user/sessions#current_user'
  end
  
  root to: 'main#index'
end
