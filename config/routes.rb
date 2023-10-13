Rails.application.routes.draw do
  resources :projects
  resources :employment_statuses
  resources :positions
  resources :employees

  get '/position/ghost', to: 'positions#ghost'
  get 'employment_status/ghost', to: 'employment_statuses#ghost'
  get 'employee/ghost', to:'employees#ghost'
  get 'project/ghost', to:'projects#ghost'

  get 'position/:id/restore', to:'positions#restore', as: 'position_restore'
  get 'employment_status/:id/restore', to:'employment_statuses#restore', as: 'employment_status_restore'
  get 'employee/:id/restore/', to:'employees#restore', as: 'employee_restore'
  get 'project/:id/restore/', to:'projects#restore', as: 'project_restore'

  root "employees#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
