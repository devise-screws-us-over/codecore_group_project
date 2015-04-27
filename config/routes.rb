Rails.application.routes.draw do

  #resources :user

  resources :users do
    # resources :pins #remove me
    # resources :shares #remove me
    resources :invitations, only: [:index]
  end
  
  resources :pins, only: [:index]

  resources :profiles

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  
  #resources :shares
  
  resources :teams do
    resources :invitations, only: [:create]
    resources :memberships, only: [:destroy]
  end
  
  resources :ideas do
    resources :pins, only: [:create, :destroy]
    resources :comments
    resources :shares
  end

  root "ideas#index"

  resources :memberships, only: [:create, :update]

  get "/shared_ideas" => "shares#shared_ideas"

  get "/forgot_password" => "users#forgot_password"
  post "/forgot_password/:email" => "users#send_password"

end