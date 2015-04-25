Rails.application.routes.draw do


  resources :users do
    resources :profiles
    resources :pins
    resources :shares
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :teams
  resources :ideas do
    resources :comments
  end

  root "ideas#index"

end
