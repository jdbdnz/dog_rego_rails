Rails.application.routes.draw do
  
  devise_for :users

  root 'home#index'

  resources :users, only: [:index, :show] do
    resources :dogs do
      resources :registrations, only: [:new, :create]
    end
  end
end