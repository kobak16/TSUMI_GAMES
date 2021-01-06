Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'homes#index'

  resources :users do
    member do
      get :mygames
      get :followings
      get :followers
      get :likes
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :games do
    resources :likes, only: [:create, :destroy]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
