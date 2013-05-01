Love::Application.routes.draw do

  devise_for :users, :controllers => { 
    :omniauth_callbacks => 'omniauth_callbacks',
    :registrations => 'devise/custom/registrations'
  }
  resources :users, :only => [:show, :update]
  resources :rides
  resources :addresses

  root :to => 'home#index'
end
