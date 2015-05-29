Rails.application.routes.draw do
  root 'support_duties#index'

  resources :users, only: [:edit, :update]
end
