Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
  resources :rooms, only: [:create, :show]
  resources :chats, only: [:create]
end