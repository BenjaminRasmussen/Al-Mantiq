Rails.application.routes.draw do

  root 'static_pages#home'

  resources :users do
    member do
      get :boards
    end
  end

  resources :boards, only: [:create, :destroy]
  resources :board_user_relations, only: [:create, :destroy]


end
