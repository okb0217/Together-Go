Rails.application.routes.draw do

	root "users#top"
	devise_for :users
	resources :users, only: [:show, :edit, :update]
  	get "about" => "users#about"
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
