Rails.application.routes.draw do
  resources :boards
  resources :board_user_relations
  resources :events
  resources :users

  root 'static_pages#home'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/boards',  to: 'boards#index'
  get    '/events',  to: 'events#index'
  get    '/event',   to: 'events#new'
  post   '/event',   to: 'events#create'
  get    '/detailboard/:id', to: 'boards#detail'
  post   '/detailboard',  to: 'board_user_relations#create'


end
