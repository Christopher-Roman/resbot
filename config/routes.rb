Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'reservations#index', as: 'home'
  resources :tabletops, only: [:index, :new, :create, :edit] 

  resources :reservations, only: [:new, :index, :create, :edit, :destroy]
  	
end
