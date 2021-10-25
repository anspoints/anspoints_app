# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
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
