Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :events
  get '/search', to: 'events#search', as: 'search_events'
  get '/search_by_category', to: 'events#search_by_category', as: 'search_by_category_events'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root "users#index"
end