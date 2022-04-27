# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees
  devise_for :admin_users,
             ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#index'

  resources :emp_leave_infos
  resources :wfhs
  resources :today_leaves
  resources :addresses
  resources :employees, only: %i[index show]
  resources :birthdays, only: :index
  resource :kyc
  resources :leave_infos, only: :index
end
