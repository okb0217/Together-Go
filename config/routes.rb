Rails.application.routes.draw do

	root "users#top"
	devise_for :users
	resources :users, only: [:show, :edit, :update]
  	get "about" => "users#about"

  	resources :parties

  	resources :requests, only: [:create, :destroy, :index, :show, :new]

  	get "search" => "searches#search"

  	get "chat/:id" => "chats#show", as: "chat"
  	get "chat" => "chats#index"
end
