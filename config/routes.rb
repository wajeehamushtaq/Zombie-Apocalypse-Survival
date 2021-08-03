Rails.application.routes.draw do
  get 'survivors/index'
  get 'cards/show'
  get '/search',to: "survivors#search"
  resources :resources
  resources :trades, only:[:index, :show]
  resources :order_items
  resource :cards, only:[:show]
  resources :survivors do
    member do
      put "like" => "survivors#upvote"
      put "unlike" => "survivors#downvote"
    end
  end
  root 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
