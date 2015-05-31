Rails.application.routes.draw do
  root 'support_duties#index'

  resources :support_duties, only: [:index, :edit, :update]
  resources :users, only: [:show] do
    resources :support_duties, only: [:update]
  end
end
