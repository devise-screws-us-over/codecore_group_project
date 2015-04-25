Rails.application.routes.draw do

  resources :users
  resources :teams
  resources :ideas do
    resources :comments
  end
  
  root "ideas#index"

end
