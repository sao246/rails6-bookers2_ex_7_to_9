Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"
  devise_for :users
  resources :books, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :followers
      get :following
      post :follow
      delete :unfollow
    end
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  get "/search", to: "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
