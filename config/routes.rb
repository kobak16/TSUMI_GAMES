Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  root 'homes#index'

  resources :gamers

  resources :games do
    collection do
      get :mygames
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
