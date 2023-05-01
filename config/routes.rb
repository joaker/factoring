Rails.application.routes.draw do

  resources :invoices, only: [:index, :show, :create, :update]
  resources :borrowers, :fees, only: [:show, :create]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html 
end
