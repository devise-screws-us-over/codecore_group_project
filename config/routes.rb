Rails.application.routes.draw do

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :teams
  resources :ideas do
    resources :comments
  end
  
  root "sessions#new"

end
