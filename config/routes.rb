Rails.application.routes.draw do

	root "users#top"
	devise_for :users
	resources :users, only: [:show, :edit, :update]
  	get "about" => "users#about"

  	resources :parties
end
