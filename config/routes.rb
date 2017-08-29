Rails.application.routes.draw do
  resources :products
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :listings, only: [ :index, :show, :new, :create ]

end
