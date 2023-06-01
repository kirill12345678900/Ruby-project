Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :events
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root "users#index"
end