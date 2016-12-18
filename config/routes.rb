Rails.application.routes.draw do
  resources :brands, only: [:index, :show]
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
end
