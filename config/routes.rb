Rails.application.routes.draw do
  get 'persons/profile'

  resources :links
  resources :users

  get ':slug' => 'links#show'
  #get  '/signup',  to: 'users#new'

  #get '/all' => 'home#all'
  root 'links#index'
  get 'persons/profile', as: 'user_root'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
