Love::Application.routes.draw do

  get 'home/about'

  devise_for :users, :controllers => { 
    :omniauth_callbacks => 'omniauth_callbacks',
    :registrations => 'devise/custom/registrations'
  }

  put '/users/setup_paypal', to: 'users#setup_paypal', as: 'setup_paypal_users'
  put '/rides/booked/', to: 'rides#booked', as: 'booked_ride'
  put '/rides/responded/', to: 'rides#responded', as: 'responded_to_ride'
  get '/rides/confirm/:ride_id', to: 'rides#confirm', as: 'confirm_ride'
  resources :rides
  get '/rides/booking/:id', to: 'rides#booking', as: 'booking_ride'
  get '/rides/responding/:id', to: 'rides#responding', as: 'responding_to_ride'
  put '/users/pay', to: 'users#pay', as: 'pay_users'

  resources :users, :only => [:create, :show, :update]
  resources :addresses
  resources :children, only: [:destroy]
  resources :charges

  root :to => 'home#index'
end
