Rails.application.routes.draw do
  root 'content#index'

  resources :content
end
