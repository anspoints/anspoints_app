Rails.application.routes.draw do
  resources :events, :users, :contacts, :points
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'events#index'
  get '/points', to: 'points#index'
end
