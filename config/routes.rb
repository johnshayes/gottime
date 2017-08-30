Rails.application.routes.draw do

  resources :products

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings, only: [ :index, :show, :new, :create ] do
    resources :meetings, only: [ :create, :show ]
  end

  resources :meetings, only: [ :index ]
end
