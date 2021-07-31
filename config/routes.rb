Rails.application.routes.draw do
  get 'cards/show'
  resources :resources
  resources :trades, only:[:index, :show]
  resources :order_items
  resource :cards, only:[:show]
  root 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
