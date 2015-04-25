Rails.application.routes.draw do


  resources :users
  
  resources :pins, only: [:index]

  resources :profiles

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :shares

  resources :teams
  
  resources :ideas do
    resources :pins, only: [:create, :destroy]
    resources :comments
  end

  root "sessions#new"

end
