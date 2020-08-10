Rails.application.routes.draw do
  root to: 'goods#index'
  resources :users
end
