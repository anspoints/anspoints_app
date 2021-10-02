Rails.application.routes.draw do
  resources :events, :users, :contacts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'events#index'
end
