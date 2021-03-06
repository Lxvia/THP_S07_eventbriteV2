Rails.application.routes.draw do
  get 'static_pages/index'
  get 'static_pages/secret'
  get 'static_pages/avatar'
  devise_for :users
  root to: 'static_pages#index'
  get '/index/:first_name', to: 'static_pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :event

  resources :event do
    resources :attendances
  end
  
end
