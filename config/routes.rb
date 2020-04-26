Rails.application.routes.draw do

	root "users#top"
	devise_for :users
	resources :users, only: [:show, :edit, :update]
  	get "about" => "users#about"

  	resources :parties

  	resources :requests, only: [:create, :destroy, :index, :show, :new]

  	resources :chats, only: [:create, :destroy, :index, :show]

  	get "search" => "searches#search"

end
