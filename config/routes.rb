# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :contacts, :points
  resources :events do
    member do
      # FIXME: note that these are "insecure" if (and only if) a member can find the ID,
      # FIXME--since they can then pull up the code or join form from anywhere
      get :qr
      get :join
    end
  end
  post '/events/join', to: 'events#join_by_code'
  post '/checkin', to: 'events_users#create'
  get '/qr/:code', to: 'events#raw_qr'
  get '/users/search'
  get '/users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'events#index'
end
