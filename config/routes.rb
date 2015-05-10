Rails.application.routes.draw do
  
  devise_for :users

  root 'home#index'

  resources :users, only: [:index, :show, :destroy] do
    resources :dogs, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      resources :registrations, only: [:new, :create] do
        put 'paid'
      end
    end
  end
end