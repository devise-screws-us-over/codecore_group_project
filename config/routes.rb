Rails.application.routes.draw do


  resources :users do
    resources :pins
    resources :invitations, only: [:index]
  end

  resources :profiles

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :teams do
    resources :invitations, only: [:create]
  end
  
  resources :ideas do
    resources :comments
  end

  resources :memberships, only: [:create, :update, :destroy]

  root "ideas#index"

end