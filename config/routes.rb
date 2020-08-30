Rails.application.routes.draw do
  devise_for :installs
  devise_for :users
  root 'books#top'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users

  get  "home/about" => "books#about"

  #get "users/books" => "users#books"
  #post "users/books" => "users#books"
  #get "users" => "users#users"
  #get "users/:id" => "users#home"
  #get "users/:id/edit" => "users#edit"



  #post 'users' => 'users#home'
  #get 'users'  => 'users#home'
  #post 'users' => 'users#users'
  #get 'users' => 'users#users'
  #post 'users' => 'users#books'
  #get 'users' => 'users#books'
  #get "users/:id" => "users#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
