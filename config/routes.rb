Rails.application.routes.draw do
  resources :payments
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'welcome#index'
  resources :employees
  resources :request_feedbacks
  resources :clean_requests
  devise_for :admins
  resources :admins, skip: [:registrations]
  devise_for :users
  resources :users
  resources :payments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
