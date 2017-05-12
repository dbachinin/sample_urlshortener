Rails.application.routes.draw do
  devise_for :users
  get 'persons/profile'

  resources :links
  resources :users

  get ':slug' => 'links#show'
  #get  '/signup',  to: 'users#new'

  #get '/all' => 'home#all'
  root 'links#index'
  get 'persons/profile', as: 'user_root'

delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
get '/sign_in', to: 'user_sessions#new', as: :sign_in
resources :password_resets, only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
