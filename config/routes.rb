Love::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }
  resources :users, :only => :show

  root :to => 'home#index'
end
