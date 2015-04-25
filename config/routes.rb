Rails.application.routes.draw do


  resources :users do
    resources :pins
  end

  resources :profiles

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :teams
  
  resources :ideas do
    resources :comments
  end

  resources :memberships, only: [:create, :update, :destroy]

  root "ideas#index"

end
