Rails.application.routes.draw do
  resources :brands, only: [:index, :show] do
	  resources :locations, only: [:index, :show]
  end
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
end
