Rails.application.routes.draw do
  get 'customers/new'
  post 'customers/create' => "customers#create"
  get 'get_companies/get_from_api'
  get 'companies/new'
  get 'companies/search' => "companies#search"
  get 'signup' => "users#new"
  post 'users/create' => "users#create"
  get 'login' => "users#login_form"
  post 'login' => "users#login"
  get 'users/:id' => "users#show"
  get 'users/id/edit' => "users#edit"
  post 'users/:id/update' => "users#update"
  get 'home/top'
  post 'logout' => "users#logout"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
