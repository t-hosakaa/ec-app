Rails.application.routes.draw do
  root to: 'goods#index'
  resources :users
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  get 'logout' => 'users#logout_form'
  post 'logout' => 'users#logout'
  resources :goods do
    member do
      post 'purchase'
    end

    collection do
      get 'search'
    end
  end
end
