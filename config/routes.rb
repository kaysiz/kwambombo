Rails.application.routes.draw do
  root 'welcome#index'
  resources :employees
  resources :request_feedbacks
  resources :clean_requests
  devise_for :admins
  resources :admins
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
