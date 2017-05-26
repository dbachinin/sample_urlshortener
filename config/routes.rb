Rails.application.routes.draw do
  #get 'omniauth_callbacks/vkontakte'

  resources :inboxes
  #devise_for :users
  #resources :users
  devise_for :users, :controllers => { omniauth_callbacks: 'authentication' }

  get 'persons/profile'
  
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end
  resources :links
  

  get ':slug' => 'links#show'
  #get  '/signup',  to: 'users#new'

  #get '/all' => 'home#all'
  root 'links#index'
  get 'persons/profile', as: 'user_root'

# delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
# get '/sign_in', to: 'user_sessions#new', as: :sign_in
# resources :password_resets, only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
