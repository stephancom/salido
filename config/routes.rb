Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
end
