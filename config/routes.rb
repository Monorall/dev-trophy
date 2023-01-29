require 'sidekiq/web'

Rails.application.routes.draw do
  resources :ecosystems, only: [:index, :show]
  resources :projects, only: :show
  resources :documents, only: :show
  resources :issues, only: :show
  resources :scores, only: :index
  root 'ecosystems#index'
end
