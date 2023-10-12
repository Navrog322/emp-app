Rails.application.routes.draw do
  resources :employment_statuses
  resources :positions
  resources :employees

  root "employees#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
