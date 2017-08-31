Rails.application.routes.draw do

  resources :products
  resources :blacklists, only: [ :new, :create, :destroy ]
  resources :users, only: [ :show ]
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings, only: [ :index, :show, :new, :create, :destroy ] do
    resources :meetings, only: [ :create, :show ]
  end

  resources :meetings, only: [ :index ]

  post 'twilio/voice' => 'twilio#voice'

  resources :chat_rooms, only: [ :show ] do
    resources :messages, only: [ :create ]
  end

end
