Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#show'
  # match "/websocket", :to => ActionCable.server, via: [:get, :post]
  match '(:anything)' => 'application#nothing', via: [:options]
  resources :users, only: [] do
    collection do
      get 'activation'
    end
 end
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      devise_for :users
      resources :posts
      resources :tags
      resources :comments
      resources :likes
      resources :followers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
