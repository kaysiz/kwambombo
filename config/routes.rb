Rails.application.routes.draw do
  resources :payments
  mount RailsAdmin::Engine => '/dashboard', as: 'rails_admin'
  root 'welcome#index'
  resources :employees
  resources :request_feedbacks
  resources :clean_requests
  devise_for :admins
  resources :admins, skip: [:registrations]
  devise_for :users
  resources :users
  resources :payments
  get 'order/:id' => 'payments#order'
  post 'payments/update_payment/:id' => 'payments#update_payment'
  get '/masks' => 'welcome#masks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
