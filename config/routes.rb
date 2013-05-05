Love::Application.routes.draw do

  devise_for :users, :controllers => { 
    :omniauth_callbacks => 'omniauth_callbacks',
    :registrations => 'devise/custom/registrations'
  }
  put '/users/setup_paypal', to: 'users#setup_paypal', as: 'setup_paypal_users'
  resources :users, :only => [:show, :update]
  put '/rides/booked/', to: 'rides#booked', as: 'booked_ride'
  put '/rides/responded/', to: 'rides#responded', as: 'responded_to_ride'
  resources :rides
  get '/rides/booking/:id', to: 'rides#booking', as: 'booking_ride'
  get '/rides/responding/:id', to: 'rides#responding', as: 'responding_to_ride'

  resources :addresses

  root :to => 'home#index'
end
