Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  root 'homes#index'

  resources :gamers do
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
