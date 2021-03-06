# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    delete 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :exit_user_session
    get 'users/sessions/failed'
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :points
  resources :events do
    member do
      get :qr
      get :join
    end
    collection do
      get :join, to: 'events#join_by_code'
      post :join, to: 'events#join_by_code'
    end
  end
  post '/checkin', to: 'events_users#create'
  get '/moon', to: 'application#moon', as: 'moon' # dark mode
  get '/sun', to: 'application#sun', as: 'sun' # light mode
  get '/qr/:code', to: 'events#raw_qr'
  get '/users/search'
  get '/users/show'
  post '/users/import'
  get '/contacts/search'
  get '/contacts', to: 'contacts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'events#index'
end
